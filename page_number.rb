
#
# Utility methods for pagination page, and per page values.
# https://gist.github.com/sshaw/83f7ad7ce9c8f92a833f6d6530a2495c
#
# By: Skye Shaw (https://github.com/sshaw)
# Date: 2016-06-20
#
# === Usage
#
# require "page_number"
#
# class BaseController
#   include PageNumber
#
#   protected
#
#   def page_sizes
#     [ 25, 50, 100 ]
#   end
# end
#
# class SubController < BaseController
#   def action
#     User.all(:page => page(params[:page]), :per_page => per_page(params[:per_page]))
#   end
# end
#

module PageNumber
  def page(n)
    n = __int(n)
    return default_page if n < 1

    max_page_number && n > max_page_number ? max_page_number : n
  end

  def per_page(n)
    n = __int(n)
    return default_per_page if n < 1

    page_sizes && !page_sizes.include?(n) ? default_per_page : n
  end


  # Override these as you see fit.
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
