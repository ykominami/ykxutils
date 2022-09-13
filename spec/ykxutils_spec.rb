# frozen_string_literal: true

RSpec.describe Ykxutils do
  let(:test_file_path) { Ykxutils::TEST_DATA_DIR.join("test.yaml") }

  describe "Yamlx" do
    it "has a version number" do
      expect(Ykxutils::VERSION).not_to be_nil
    end

    it "yamlx load yaml file" do
      setting = described_class.yaml_load_file_compati(test_file_path)
      expect(setting).not_to be_nil
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
      value = [1, 2, 3]
      default_value = []
      pstorex.store(key, value)

      value2 = pstorex.fetch(key, default_value)
      expect(value2).to eq(value)
    end
  end
end
