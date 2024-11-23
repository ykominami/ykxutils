# frozen_string_literal: true

RSpec.describe Ykxutils do
  let(:test_dir_pn) { Pathname.new(Ykxutils::TEST_DATA_DIR) }
  let(:test_file_path) { Ykxutils::TEST_DATA_DIR.join("test.yaml") }

  describe "Yamlx" do
    let(:content) { %( klass: Xenop ) }

    it "has a version number" do
      expect(Ykxutils::VERSION).not_to be_nil
    end

    it "yamlx load yaml file" do
      setting = described_class.yaml_load_file_compati(test_file_path)
      expect(setting).not_to be_nil
    end

    it "func_get_files_from_commit", cmd: :gitcmd do
      target = 3
      files = described_class.func_get_files_from_commit(target)
      expect(files.instance_of?(Array)).to be(true)
    end

    it "yamlx load yaml" do
      setting = described_class.yaml_load_compati(content)
      expect(setting).not_to be_nil
    end
  end

  describe "Erubyx" do
    let(:base_dir_pn) { Pathname.new(v103-3-189-127") }

    it "make_grid_list", :version do
      expect(Ykxutils::VERSION).not_to be_nil
    end

    it "make_grid", :grid do
      min_row = 1
      max_row = 2
      min_colum = 1
      max_colum = 5
      expect(Ykxutils::Gridlist.make_grid_list(min_row, max_row, min_colum, max_colum).instance_of?(Array)).to be true
    end

    def make_path_complement(path)
<<<<<<< HEAD
       (test_dir_pn + base_dir_pn + path).to_s
||||||| 6d084fa
       (test_dir_pn + base_dir + path).to_s
=======
      (test_dir_pn + base_dir_pn + path).to_s
>>>>>>> 7309a5220dad5a70dae43d42f8d8d3441b8464e1
    end

    it "Ykxutils::Nginxconfigfiles", :nginx do
      ncf = Ykxutils::Nginxconfigfiles.new
      re = /base.yml$/
      dir = "a.northern-cross.net"
      start_dir = make_path_complement(dir).to_s
      file_list = ncf.get_file_list(start_dir, re)
      ncf.output(file_list)

      expect(file_list).not_to be_nil
    end

    it "Erubyx::erubi_render_with_file", :rubyx do
      template_file_path = make_path_complement("template_ssl_www.erb")

      scope = nil
      ary = ["a.northern-cross.net/value_host.yml", "value_ssl.yml"]
      value_file_path_array = ary.each_with_object([]) do |path, list|
        list << make_path_complement(path)
      end

      content = Ykxutils::Erubyx.erubi_render_with_file(template_file_path, scope, value_file_path_array)
      expect(content).not_to be_nil
    end
  end

  describe "Pstorex" do
    let(:output_dir) { "output" }
    let(:store_fname) { "pstore.dump" }
    let(:pstorex) { Ykxutils::Pstorex.new(output_dir, store_fname) }
    let(:key) { :top }

    it "fetch", cmd: :fetch do
      store_file_path = "#{output_dir}/#{store_fname}"
      FileUtils.rm_f(store_file_path)
      default_value = {}
      value = pstorex.fetch(key, default_value)
      expect(value).to eq(default_value)
    end

    it "store", cmd: :store do
      value, default_value = TestConf.setup(key, pstorex)

      value2 = pstorex.fetch(key, default_value)
      expect(value2).to eq(value)
    end

    it "delete", cmd: :delete do
      key = :TOP2
      _value, default_value = TestConf.setup(key, pstorex)
      pstorex.delete(key)
      value3 = pstorex.fetch(key, default_value)
      expect(value3).to eq([])
    end
  end

  describe "Fileop", :fileop do
    describe "make_output_path" do
      context "when input file only" do
        it "input file is in current directory" do
          value = "a.txt"
          value2 = described_class.make_output_path(input_path: value)
          expect(value2).to be_nil
        end
      end
      context "when input file and output dir" do
        it "output_dir is data" do
          value_out_dir = "data"
          # value_output = "data/a.txt"
          value_output = nil
          value2 = described_class.make_output_path(input_path: "data/a.txt", out_dir: value_out_dir)
          expect(value2).to eq(value_output)
        end
        it "output_dir is :SAME" do
          value_output = "data/o_a.txt"
          value_out_dir = :SAME
          value_prefix = "o_"
          value2 = described_class.make_output_path(input_path: "data/a.txt", out_dir: value_out_dir,
                                                    prefix: value_prefix)
          expect(value2).to eq(value_output)
        end
      end
    end
    describe "when file_convert", :file_convert do
      context "when infile and outfile" do
        it "dt tag" do
          test_data_dir = "test_data/fileop"
          test_data_pn = Pathname.new(test_data_dir)
          infilename = test_data_pn + "in.html"
          outfilename = test_data_pn + "out.html"
          infile = File.open(infilename)
          outfile = File.open(outfilename, "w")
          described_class.file_convert(infile, outfile) do |infile2, outfile2|
            while (line = infile2.gets)
              line.chomp!
              oline = described_class.complemente_dt_tag(line)
              outfile2.write(oline + "\n")
            end
            expect(true).to be_truthy
          end
        end
      end
    end
  end
end
