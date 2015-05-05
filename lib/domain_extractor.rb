require "singleton"
require "addressable/uri"

module DomainExtractor
  class CantExtractDomain < StandardError
  end

  class DomainTLD
    def initialize(tld)
      @tld = tld
      @suffix = ".#{@tld}"
    end

    def matches?(domain)
      domain.end_with?(@suffix) && domain != @tld
    end
  end

  class Extractor
    include Singleton

    def initialize
      source_file = File.join("data", "effective_tld_names.dat")
      @known_domain_suffixes = []
      File.open(source_file, "r") do |file|
        @known_domain_suffixes = file.each_line.map do |line|
          DomainTLD.new(line.strip)
        end
      end
    end

    def extract(url)
      fail_if_empty(url)

      host = fetch_host(url)

      fail_if_empty(host)

      domain = clear_hostname(host)

      fail_if_empty(domain)

      fail_if_incorrect_tld(domain)

      domain
    rescue URI::InvalidURIError
      raise CantExtractDomain.new
    end


    private
      def fail_if_empty(string)
        raise CantExtractDomain.new if string.nil? || string.empty?
      end

      def fetch_host(url)
        if url =~ /http(s)?:\/\//
          uri = Addressable::URI.parse(clear_url(url))
          uri.host
        else
          clear_url(url)
        end
      end

      def clear_hostname(host)
        domain = host.gsub(/^www\./, "")
      end

      def fail_if_incorrect_tld(domain)
        raise CantExtractDomain.new if @known_domain_suffixes.find{|x| x.matches?(domain)}.nil?
      end

      def clear_url(url)
        url.downcase.gsub(/http(:)+\/(\/)+/, "http://").gsub(/https(:)+\/(\/)+/, "https://").gsub(/\/$/, '')
      end
  end
end
