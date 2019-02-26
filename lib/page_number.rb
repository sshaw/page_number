# === Usage
#
#  require "page_number"
#
#  class BaseController
#    include PageNumber
#
#    protected
#
#    def page_sizes
#      [ 25, 50, 100 ]
#    end
#  end
#
#  class SubController < BaseController
#    def action
#      User.all(:page => page(params[:page]), :per_page => per_page(params[:per_page]))
#    end
#  end
#

module PageNumber
  VERSION = "0.2.0".freeze

  class PageInvalid < StandardError
    attr_reader :page

    def initialize(message, page)
      super message
      @page = page
    end
  end

  def page!(page)
    n = __int(page)
    raise PageInvalid.new("page must be > 0", page) if n < 1
    raise PageInvalid.new("page must be <= #{max_page_number}", page) if max_page_number && n > max_page_number

    n
  end

  alias :__page__! :page!

  def page(n)
    n = __int(n)
    return default_page if n < 1

    max_page_number && n > max_page_number ? max_page_number : n
  end

  alias :__page__ :page

  def per_page(n)
    n = __int(n)
    return default_per_page if n < 1

    page_sizes && !page_sizes.include?(n) ? default_per_page : n
  end

  alias :__per_page__ :per_page

  protected

  def default_per_page
    10
  end

  def default_page
    1
  end

  def max_page_number
  end

  def page_sizes
  end

  private

  def __int(n)
    case
    when n.respond_to?(:to_i)
      n.to_i
    when n.respond_to?(:to_int)
      n.to_int
    else
      -1
    end
  end
end
