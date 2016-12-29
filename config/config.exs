use Mix.Config
import_config "#{Mix.env}.exs"

#-------------------------------
#  WORKFLOW
#-------------------------------


config :workflow,
  storage: Engine.Storage.Eventstore

#-------------------------------
#  EXTREME [Eventstore Driver]
#-------------------------------


config :extreme, :event_store,
  db_type: :node,
  host: "localhost",
  port: 1113,
  username: "admin",
  password: "changeit",
  reconnect_delay: 2_000,
  max_attempts: :infinity


#-------------------------------
#  LOGGER
#-------------------------------


