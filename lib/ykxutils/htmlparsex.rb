require "yaml"

module Ykxutils
  module_function

  def complemente_dt_tag(line)
    if line =~ /<DT>/
      # p "complemente_dt_tag T"
      line + "</DT>"
    elsif line =~ /<dt>/
      line + "</dt>"
    else
      # p "complemente_dt_tag F"
      line
    end
  end

  def reform_dt_tag(infilename, outfilename)
    infile = File.open(infilename)
    outfile = File.open(outfilename, "w")

    Ykxutils.file_convert(infile, outfile) do |infile2, outfile2|
      while (line = infile2.gets)
        line.chomp!
        oline = Ykxutils.complemente_dt_tag(line)
        outfile2.write(oline + "\n")
      end
    end
  end
end
