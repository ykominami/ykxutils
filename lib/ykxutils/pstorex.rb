require "pstore"
require "fileutils"

module Ykxutils
  class Pstorex
    def initialize(store_dir, dump_file = "pstore.dump")
      FileUtils.mkdir_p(store_dir)
      @store_db = PStore.new(Pathname.new(store_dir).join(dump_file))
    end

    def fetch(key, default_value)
      value = default_value
      @store_db.transaction do
        value = @store_db.fetch(key, default_value)
      end
      value
    end

    def store(key, value)
      @store_db.transaction do
        @store_db[key] = value
      end
    end

    def delete(key)
      @store_db.transaction do
        @store_db.delete(key)
      end
    end
  end
end
