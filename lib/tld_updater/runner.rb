require 'tld_updater/downloader'
require 'tld_updater/list_parser'
require 'tld_updater/list_saver'

module DomainExtractor
  module TLDUpdater
    class Runner
      def initialize(downloader: Downloader.new, list_parser: ListParser.new, file_saver: ListSaver.new)
        @downloader = downloader
        @list_parser = list_parser
        @file_saver = file_saver
      end

      def call
        list = @downloader.get_list
        cleaned_list = @list_parser.call(list)
        @file_saver.call(cleaned_list)
      end
    end
  end
end
