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
    outfile = File.open(outfilename, 'w')

    Ykxutils::file_convert(infile, outfile){ |infile, outfile|
      while line = infile.gets
        line.chomp!
        oline = Ykxutils.complemente_dt_tag(line)
        outfile.write( oline + "\n" ) 
      end
    }
  end
end
