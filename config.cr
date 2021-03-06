require "lucky_migrator"

database = "authentic_test"

LuckyRecord::Repo.configure do
  if ENV["DATABASE_URL"]?
    settings.url = ENV["DATABASE_URL"]
  else
    settings.url = LuckyRecord::PostgresURL.build(
      database: database,
      hostname: "localhost"
    )
  end
end

LuckyMigrator::Runner.configure do
  settings.database = database
end

Lucky::StaticFileHandler.configure do
  settings.hide_from_logs = true
end

Lucky::Session::Store.configure do
  settings.key = "anything"
  settings.secret = "so secret"
end

Lucky::ErrorHandler.configure do
  settings.show_debug_output = true
end

Lucky::LogHandler.configure do
  settings.show_timestamps = false
end

Lucky::RouteHelper.configure do
  settings.domain = "example.com"
end

Lucky::Server.configure do
  settings.secret_key_base = Lucky::Session::Store.settings.secret
end

Lucky::Server.configure do
  settings.host = "localhost"
  settings.port = 3000
end

Authentic.configure do
  settings.secret_key = "1" * 32
  settings.encryption_cost = 4
end

Habitat.raise_if_missing_settings!
