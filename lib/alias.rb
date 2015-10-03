module Alias
  def slack_name_for(user)
    if Application.instance.use_database?
      user_mapping = UserMapping.where(gerrit_name: user).first
      user_mapping ? user_mapping.slack_name : user
    else
      @@aliases ||= YAML.load(File.read('config/aliases.yml'))['aliases']
      @@aliases[user] || user
    end
  end
end
