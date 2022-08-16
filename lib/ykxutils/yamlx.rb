require "yaml"

module Ykxutils
  module_function

  def yaml_load_file_compati(yaml_file_path)
    begin
      setting = YAML.load_file(yaml_file_path, aliases: true)
    rescue ArgumentError
      setting = YAML.load_file(yaml_file_path)
    end
    setting
  end
end
