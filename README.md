# PageNumber

[![Build Status](https://travis-ci.org/sshaw/page_number.svg?branch=master)](https://travis-ci.org/sshaw/page_number)

Utility methods for pagination page and per page that make sure you'll
always have a valid number.

Use them your controllers (recommended) or model or anywhere where you process page
info.

## Usage

`PageNumber` provides two methods:

* `page(n)`/`__page__(n)`
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

  def max_page_number
    # who knows!?
  end
```

## Author

Skye Shaw [skye.shaw AT gmail.com]

## License

Released under the MIT License: http://www.opensource.org/licenses/MIT
