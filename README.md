# PageNumber

[![Build Status](https://travis-ci.org/sshaw/page_number.svg?branch=master)](https://travis-ci.org/sshaw/page_number)

Utility methods for pagination page and per page that make sure you'll
always have a valid number.

Use them your controllers (recommended) or model or anywhere where you process page
info.

## Usage

`PageNumber` provides 3 methods:

* `page(n)`/`__page__(n)` (defaults to `1`)
* `page!(n)`/`__page__!(n)` (raises `PageNumber::PageInvalid` instead of returning default)
* `per_page(n)`/`__per_page__(n)` (defaults to `10`)

To use, `include` or `extend` the `PageNumber` module:

```rb
require "page_number"

class BaseController
  include PageNumber
end

class SubController < BaseController
  def index
    User.all(:page => page(params[:page]), :per_page => per_page(params[:per_page]))
  end
end

```

To have better control over how `page` and `per_page` work you can
define one or more of the following methods:

```rb
class BaseController
  include PageNumber

  # These are all optional
  protected

  def page_sizes
    [ 25, 50, 100 ]
  end

  def default_per_page
    20
  end

  def default_page
    2
  end

  def max_page_number
    # who knows!?
  end
```

### will_paginate & ActiveRecord Subclasses

If you use `PageNumber` in a class context in model that uses will_paginate _and you subclasses_ that model you may receive the following error:
```
ArgumentError: wrong number of arguments (given 0, expected 1)
	from /Users/sshaw/code/ruby/page_number/lib/page_number.rb:53:in `per_page'
   	from /Users/sshaw/.rvm/gems/ruby-2.3.7/gems/will_paginate-3.1.6/lib/will_paginate/per_page.rb:18:in `inherited'
    ...
```

This is because will_paginate is expecting its `per_page` method.

One way to avoid this:
```rb
class YourModel < ApplicationRecord
  Pager = Class.new { extend PageNumber }
end
```
Now instead of calling `PageNumber`'s `per_page` as is you call via the `Pager` class: `Pager.per_page`

## Author

Skye Shaw [skye.shaw AT gmail.com]

## License

Released under the MIT License: http://www.opensource.org/licenses/MIT
