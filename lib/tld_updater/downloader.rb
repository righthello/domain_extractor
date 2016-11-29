require "http"

module DomainExtractor
  module TLDUpdater
    class Downloader
      BASE_URL = "https://publicsuffix.org"
      def initialize(http_client: HTTP.persistent(BASE_URL))
        @http_client = http_client
      end

      def get_list
        @http_client.get("/list/public_suffix_list.dat").to_s
      end
    end
  end
end
