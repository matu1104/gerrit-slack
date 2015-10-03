class ChannelConfig
  def initialize(input = 'config/channels.yml')
    @config = YAML.load(File.read(input)) unless Application.instance.use_database?
  end

  def all_channels
    if Application.instance.use_database?
      Project.all.map(&:channel_name)
    else
      @config.keys
    end
  end

  def channels_to_notify(project, owner)
    if Application.instance.use_database?
      Project.where(name: project).map(&:channel_name)
    else
      @config.select { |channel, opts|
        opts['project'].include?("#{project}*") ||
        (opts['project'].include?(project) && opts['owner'].include?(owner))
      }.keys
    end
  end

  def format_message(channel, msg, emoji)
    if Application.instance.use_database?
      emoji.present? ? "#{msg} #{emoji}" : msg
    else
      channel = @config[channel] || {}
      if !emoji.empty? && channel.fetch('emoji', true)
        "#{msg} #{emoji}"
      else
        msg
      end
    end
  end
end
