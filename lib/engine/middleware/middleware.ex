defmodule Engine.Middleware do
  @moduledoc """
  Middleware provides an extension point to add functions that you want to be called for every command the router dispatches.

  Examples include command validation, authorization, and logging.

  Implement the `Commanded.Middleware` behaviour in your module and define the `before_dispatch`, `after_dispatch`, and `after_failure` callback functions.

  ## Example middleware

      defmodule NoOpMiddleware do
        @behaviour Commanded.Middleware

        alias Commanded.Middleware.Pipeline
        import Pipeline

        def before_dispatch(%Pipeline{command: command} = pipeline) do
          pipeline
        end

        def after_dispatch(%Pipeline{command: command} = pipeline) do
          pipeline
        end

        def after_failure(%Pipeline{command: command} = pipeline) do
          pipeline
        end
      end

  Import the `Commanded.Middleware.Pipeline` module to access convenience functions.

    * `assign/3` - puts a key and value into the `assigns` map
    * `halt/1` - stops execution of further middleware downstream and prevents dispatch of the command when used in a `before_dispatch` callback

  """

  alias Engine.Middleware.Pipeline

  @type pipeline :: %Pipeline{}

  @callback before_dispatch(pipeline) :: pipeline
  @callback after_dispatch(pipeline) :: pipeline
  @callback after_failure(pipeline) :: pipeline
end




# Original Work: Copyright (c) 2016 Ben Smith (ben@10consulting.com)
# Modified Work: Copyright (c) 2016 Work Capital (henry@work.capital)
