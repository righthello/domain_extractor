module DomainExtractor
  module TLDUpdater
    class ListSaver
      FILE_NAME = "effective_tld_names.dat"
      DATA_ROOT_PATH = File.expand_path("../../../data", __FILE__)

      def call(list)
        file_path = File.join(DATA_ROOT_PATH, FILE_NAME)
        File.write(file_path, list)
      end
    end
  end
end
