require "yaml"

module Ykxutils
  module_function

  def yaml_load_file_aliases(yaml_file_path, use_aliases: true)
    use_aliases ? YAML.load_file(yaml_file_path, aliases: true) : YAML.load_file(yaml_file_path)
    value = 0
  rescue ArgumentError => e
    # puts e.message
    value = 1
  rescue StandardError => e
    # puts e.message
    value = 2
  end

  def yaml_load_file_compati(yaml_file_path)
    setting = yaml_load_file_aliases(yaml_file_path, use_aliases: true)
    setting = yaml_load_file_aliases(yaml_file_path, use_aliases: false) if setting.nil?
    setting
  end

  def yaml_load_aliases(content, use_aliases: true)
    use_aliases ? YAML.safe_load(content, aliases: true) : YAML.safe_load(content)
    value = 0
  rescue ArgumentError => e
    # puts e.message
    value = 1
  rescue StandardError => e
    # puts e.message
    value = 2
  end

  def yaml_load_compati(content)
    setting = yaml_load_aliases(content, use_aliases: true)
    setting = yaml_load_aliases(content, use_aliases: false) if setting.nil?
    setting
  end
end
