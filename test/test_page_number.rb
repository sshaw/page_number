require "minitest/autorun"
require "page_number"

class TestPageNumber < Minitest::Test
  def setup
    @p = Object.new
    @p.extend PageNumber
  end

  def test_page_invalid_arg_returns_default_page
    [-1, 0, {}].each { |n| assert_equal 1, @p.page(n) }

    def @p.default_page
      100
    end

    assert_equal 100, @p.page(-1)
  end

  def test_page_valid_arg_returns_arg
    [1, 100, 500].each { |n| assert_equal n, @p.page(n) }
  end

  def test_page_converts_arg_to_fixnum
    assert_equal 2, @p.page("2")

    o = Object.new
    def o.to_i
      2
    end

    assert_equal 2, @p.page(o)

    o = Object.new
    def o.to_int
      2
    end

    assert_equal 2, @p.page(o)
  end

  def test_page_exception_invalid_arg_raises_exception
    [-1, 0, {}].each do |n|
      ex = assert_raises PageNumber::PageInvalid do
        @p.page!(n)
      end

      assert_equal n, ex.page
    end

    def @p.max_page_number
      10
    end

    ex = assert_raises PageNumber::PageInvalid do
      @p.page!(11)
    end

    assert_equal 11, ex.page
  end

  def test_page_exception_valid_arg_does_not_raise_exception
    [1, 100, 500].each { |n| assert_equal n, @p.page!(n) }
  end

  def test_page_exception_converts_arg_to_fixnum
    assert_equal 2, @p.page("2")
  end

  def test_page_limits_arg_to_max_page_number
    # No max by default
    assert_equal 1_000, @p.page(1_000)

    def @p.max_page_number
      999
    end

    assert_equal 999, @p.page(1_000)
  end

  def test_per_page_invalid_arg_returns_default
    [-1, 0, {}].each { |n| assert_equal 10, @p.per_page(n) }

    def @p.default_per_page
      100
    end

    assert_equal 100, @p.per_page(-1)
  end

  def test_per_page_valid_arg_returns_arg
    assert_equal 2, @p.per_page(2)
  end

  def test_per_page_converts_arg_to_fixnum
    assert_equal 2, @p.per_page("2")

    o = Object.new
    def o.to_i
      2
    end

    assert_equal 2, @p.per_page(o)

    o = Object.new
    def o.to_int
      2
    end

    assert_equal 2, @p.per_page(o)
  end

  def test_per_page_enforces_defined_page_sizes
    def @p.page_sizes
      [3, 8]
    end

    def @p.default_per_page
      5
    end

    assert_equal 3, @p.per_page(3)
    assert_equal 8, @p.per_page(8)
    assert_equal 5, @p.per_page(100)
  end
end
