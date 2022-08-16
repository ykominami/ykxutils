# frozen_string_literal: true

RSpec.describe Ykxutils do
  let(:test_file_path) { Ykxutils::TEST_DATA_DIR.join("test.yaml") }

  it "has a version number" do
    expect(Ykxutils::VERSION).not_to be nil
  end

  it "does something useful" do
    setting = described_class.yaml_load_file_compati(test_file_path)
    expect(setting).not_to eq(nil)
  end
end
