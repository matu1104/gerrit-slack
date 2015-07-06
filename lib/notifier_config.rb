class NotifierConfig
  def initialize(input = 'config/notifications.yml')
    @config = YAML.load(File.read(input))
  end

  def notifications_for(project, event)
    if @config[project] && @config[project][event.to_s]
      @config[project][event.to_s].to_sym
    else
      :group
    end
  end
end
