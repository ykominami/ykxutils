require "yaml"

module Ykxutils
  SUCCESS = 0
  ARGUMENT_ERROR = 1
  STANDARD_ERROR = 2
  
  module_function

  def yaml_load_file_aliases(yaml_file_path, use_aliases: true)
    converted = nil
    begin
      converted = use_aliases ? YAML.load_file(yaml_file_path, aliases: true) : YAML.load_file(yaml_file_path)
      value = SUCCESS
    rescue ArgumentError
      # puts e.message
      value = ARGUMENT_ERROR
    rescue StandardError
      # puts e.message8
      value = STANDARD_ERROR
    end
    [converted, value]
  end

  def yaml_load_file_compati(yaml_file_path)
    setting = yaml_load_file_aliases(yaml_file_path, use_aliases: true)
    setting = yaml_load_file_aliases(yaml_file_path, use_aliases: false) if setting.nil?
    setting
  end

  def yaml_load_aliases(content, use_aliases: true)
    converted = nil
    begin
      converted = use_aliases ? YAML.safe_load(content, use_aliases) : YAML.safe_load(content)
      result = SUCCESS
    rescue ArgumentError
      # puts e.message
      result = ARGUMENT_ERROR
    rescue StandardError
      # puts e.message
      result = STANDARD_ERROR
    end
    [converted, result]
  end

  def yaml_load_compati(content)
    ret_array = yaml_load_aliases(content, use_aliases: true)
    ret_array = yaml_load_aliases(content, use_aliases: false) if ret_array[1] != 0
    ret_array[0]
  end
end
