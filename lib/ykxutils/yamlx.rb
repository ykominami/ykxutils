require "yaml"

module Ykxutils
  module_function

  def yaml_load_file_compati(yaml_file_path)
  	setting = {}
  	valid = false
    begin
      setting = YAML.load_file(yaml_file_path, aliases: true)
      valid = true
    rescue ArgumentError => ex
      #p "yaml_load_file_compat 1"
      #p ex.class
      #p ex.inspect
      #p ex.message
      #p ex.backtrace
      #exit#
    rescue StandardError => ex
      #p "yaml_load_file_compat 1-2"
      #p ex.class
      #p ex.inspect
      #p ex.message
      #p ex.backtrace
    end
  
    if valid != true
      begin
        setting = YAML.load_file(yaml_file_path)
        valid = true
      rescue ArgumentError
        #p "yaml_load_file_compat 2"
        #p ex.class
        #p ex.inspect
        #p ex.message
        #p ex.backtrace
        #
      rescue StandardError => ex
        #p "yaml_load_file_compat 2-2"
        #p ex.class
        #p ex.inspect
        #p ex.message
        #p ex.backtrace
      end
    end
    setting
  end
end
