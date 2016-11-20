defmodule Engine.Middleware.Logger do
  @behaviour Engine.Middleware

  alias Engine.Middleware.Pipeline
  import Pipeline
  require Logger

  def before_dispatch(%Pipeline{} = pipeline) do
    Logger.info(fn -> "#{log_context(pipeline)} dispatch start" end)
    assign(pipeline, :started_at, DateTime.utc_now)
  end

  def after_dispatch(%Pipeline{} = pipeline) do
    Logger.info(fn -> "#{log_context(pipeline)} succeeded in #{formatted_diff(delta(pipeline))}" end)
    pipeline
  end

  def after_failure(%Pipeline{assigns: %{error: error, error_reason: error_reason}} = pipeline) do
    Logger.info(fn -> "#{log_context(pipeline)} failed #{inspect error} in #{formatted_diff(delta(pipeline))}" end)
    Logger.info(fn -> inspect(error_reason) end)
    pipeline
  end

  def after_failure(%Pipeline{assigns: %{error: error}} = pipeline) do
    Logger.info(fn -> "#{log_context(pipeline)} failed #{inspect error} in #{formatted_diff(delta(pipeline))}" end)
    pipeline
  end

  defp delta(%Pipeline{assigns: %{started_at: started_at}}) do
    now_usecs = DateTime.utc_now |> DateTime.to_unix(:microseconds)
    started_usecs = started_at |> DateTime.to_unix(:microseconds)
    now_usecs - started_usecs
  end

  defp log_context(%Pipeline{command: command}) do
    "#{inspect command.__struct__}"
  end

  defp formatted_diff(diff) when diff > 1_000_000, do: [diff |> div(1_000_000) |> Integer.to_string, "s"]
  defp formatted_diff(diff) when diff > 1_000, do: [diff |> div(1_000) |> Integer.to_string, "ms"]
  defp formatted_diff(diff), do: [diff |> Integer.to_string, "µs"]
end



# Original Work: Copyright (c) 2016 Ben Smith (ben@10consulting.com)
# Modified Work: Copyright (c) 2016 Work Capital (henry@work.capital)
