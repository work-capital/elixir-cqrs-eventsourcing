# Original Work: Copyright (c) 2016 Ben Smith (ben@10consulting.com)
# Modified Work: Copyright (c) 2016 Work Capital (henry@work.capital)
defmodule Engine.Command.Handler do
  @type aggregate_root :: struct()
  @type command :: struct()
  @type reason :: term()

  @doc """
  Apply the given command to the event-sourced aggregate root.

  You must return `{:ok, aggregate}` with the updated aggregate root on success. This is the struct containing the aggregate's uuid, pending events, and current version.

  You should return `{:error, reason}` on failure.
  """
  @callback handle(aggregate_root, command) :: {:ok, aggregate_root} | {:error, reason}
end
