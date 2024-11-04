require "yaml"
require "pathname"

module Ykxutils
  module_function

  def make_output_filename(prefix, basename, postfix, extname, extname_pn)
    if extname.nil?
      extname = if extname_pn.size <= 1
                  ""
                else
                  extname_pn.to_s
                end
    end
    "#{prefix}#{basename}#{postfix}#{extname}"
  end

  def make_output_file_pn(out_dir, ofname, input_pn)
    case out_dir
    when nil
      Pathname.new(ofname)
    when :SAME
      parent = input_pn.parent
      parent + ofname
    else
      out_dir_pn = Pathname.new(out_dir)
      out_dir_pn + ofname
    end
  end

  def make_output_path(input_path:, out_dir: nil, prefix: "", postfix: "", extname: nil)
    input_pn = Pathname.new(input_path)
    basename = input_pn.basename(".*")
    extname_pn = input_pn.extname
    ofname = make_output_filename(prefix, basename, postfix, extname, extname_pn)
    output_pn = make_output_file_pn(out_dir, ofname, input_pn)
    if input_pn.expand_path("/") == output_pn.expand_path("/")
      nil
    else
      output_pn.to_s
    end
  end

  def file_convert(infile, outfile, &block)
    if block
      block.call(infile, outfile)
    else
      false
    end
  end
end
