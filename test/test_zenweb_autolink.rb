require "test/unit"
require "zenweb-autolink"

class TestZenwebAutolink < Test::Unit::TestCase

  attr_accessor :site, :page

  def setup
    @old_working_dir = Dir.pwd
    Dir.chdir(File.join(File.dirname(__FILE__),'..','test_site'))
    self.site = Zenweb::Site.new
    site.scan
    site.wire
    self.page = site.html_pages.find { |p| p.title == 'Example Page 3' }
  end

  def teardown
    Dir.chdir(@old_working_dir)
  end

  def test_pages_with_titles
    assert_equal 3, site.pages_with_titles.size
  end

  def test_pages_with_titles_as_sorted_regular_expressions
    regular_expresions = site.pages_with_titles_as_sorted_regular_expressions
    assert_equal '/\bExample\\ Page\\ 2\b/i', regular_expresions.first.first.inspect
    assert_kind_of Zenweb::Page, regular_expresions.first.last
    assert_equal '/\bZenweb\b/i', regular_expresions.last.first.inspect
  end

  def test_autolinked_html_fragment
    actual = page.autolinked_html_fragment("zenweb")
    expected = "<a href='/zenweb.html'>zenweb</a>"
    assert_equal expected, actual
  end

  def test_autolinked_html
    actual = page.autolinked_html("<h1>zenweb</h1><p>zenweb</p>")
    expected = '<h1>zenweb</h1><p><a href="/zenweb.html">zenweb</a></p>'
    assert_equal expected, actual
  end

  def test_render_autolink
    actual = page.render
    expected = %r|<p>Not really much here to see except a link to <a href="/page2\.html">example page 2</a>\.</p>|
    assert actual =~ expected
  end

end
