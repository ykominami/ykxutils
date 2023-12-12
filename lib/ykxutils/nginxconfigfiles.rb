require "find"
require_relative "nginxconfig"

module Ykxutils
  class Nginxconfigfiles
    def get_file_list(start_dir, rex)
      @file_list = []

      Find.find(start_dir) do |x|
        if x =~ rex
          @file_list << x
          Find.prune
        end
      end
      @file_list
    end

    def output(file_list)
      file_list.map do |fname|
        parent_dir_pn = Pathname.new(fname).cleanpath.parent
        vdomain = parent_dir_pn.basename
        output_fname = "#{vdomain}.conf"
        cli = ::Ykxutils::Nginxconfig.new(fname)
        scope = nil
        File.open(output_fname, "w") do |f|
          x = cli.extract(scope)
          f.write(x)
        end
      end
    end
  end
end
