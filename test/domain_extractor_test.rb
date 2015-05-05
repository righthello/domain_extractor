require 'minitest/autorun'
require 'domain_extractor'

module DomainExtractor
  class DomainExtractorTest < Minitest::Test
    def setup
      @extractor = DomainExtractor::Extractor.instance
    end

    def test_remove_ending_forward_slash_if
      assert_equal(@extractor.extract("http://facebook.com/"), "facebook.com")
    end

    def test_automatically_fix_scheme_typos
      assert_equal(@extractor.extract("http:////facebook.com/"), "facebook.com")
      assert_equal(@extractor.extract("https:////facebook.com/"), "facebook.com")
    end

    def test_should_remove_www_from_the_beginning
      assert_equal(@extractor.extract("http://www.facebook.com/"), "facebook.com")
      assert_equal(@extractor.extract("http://coolwww.com/"), "coolwww.com")
    end

    def test_should_accept_urls_without_scheme
      assert_equal(@extractor.extract("facebook.com"), "facebook.com")
      assert_equal(@extractor.extract("facebook.com/"), "facebook.com")
    end

    def test_cant_extract_domain_from_nil_or_empty_domain
      assert_raises(CantExtractDomain) {@extractor.extract(nil)}
      assert_raises(CantExtractDomain) {@extractor.extract("")}
    end

    def test_throw_error_when_domain_hasnt_tld
      assert_raises(CantExtractDomain) {@extractor.extract("http://google/")}
    end

    def test_throw_error_when_domain_has_incorrect_tld
      assert_raises(CantExtractDomain) {@extractor.extract("http://google.kaka/")}
    end

    def test_throw_error_when_url_has_at_sign
      assert_raises(CantExtractDomain) {@extractor.extract("http://dada@google.com/")}
      assert_raises(CantExtractDomain) {@extractor.extract("dada@google.com")}
    end
  end
end
