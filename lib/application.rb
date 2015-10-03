require 'singleton'

class Application
  include Singleton

  def initialize
    @app ||= YAML.load(File.read('config/app.yml'))['app']
  end

  def use_database?
    @app['database']['enable']
  end

  def database_configuration
    @app['database']['configuration']
  end
end
