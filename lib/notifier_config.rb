class NotifierConfig
  def initialize(input = 'config/notifications.yml')
    @config = YAML.load(File.read(input)) unless Application.instance.use_database?
  end

  def notifications_for(project, event)
    if Application.instance.use_database?
      proj = Project.where(name: project).first
      puts proj.inspect
      proj && proj.send(event) ? number_to_notification_type(proj.send(event)) : :group
    else
      @config[project] && @config[project][event.to_s] ? @config[project][event.to_s].to_sym : :group
    end
  end

  private

  def number_to_notification_type(number)
    case number
    when 0
      :none
    when 1
      :individual
    when 2
      :group
    end
  end
end
