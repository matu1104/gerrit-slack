require 'rubygems'
require 'bundler/setup'

Bundler.require

require 'yaml'
require 'json'

require_relative 'lib/alias'
require_relative 'lib/update'
require_relative 'lib/channel_config'
require_relative 'lib/gerrit_notifier'
require_relative 'lib/notifier_config'
require_relative 'lib/application.rb'

require 'active_record'
require 'mysql2'

ActiveRecord::Base.establish_connection(Application.instance.database_configuration)

require_relative 'lib/models/project.rb'
require_relative 'lib/models/user_mapping.rb'
