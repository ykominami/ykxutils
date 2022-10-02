# frozen_string_literal: true

require "ykxutils"
require "pathname"
require "fileutils"

module Ykxutils
  TEST_DATA_DIR = Pathname.new(__dir__).join("../test_data")
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

class TestConf
  def self.setup(key, pstorex)
    value = [1, 2, 3]
    default_value = []
    pstorex.store(key, value)
    [value, default_value]
  end
end
