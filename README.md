# SimpleTest
SimpleTest is generic testing utility written in ruby. 

## Using it
The SimpleTest utility would load any ruby files beggining with `test_` in specified dir. So in order to run your tests you simply write:
```
ruby test.rb /path/to/tests
```

The file with tests should contain module `Tests` each test function should beging from `test_` return `true` if test pass or `false` otherwise. An example of tests:
```ruby
# File: tests/test_main.rb
module Tests
  def self.divide_by_zero # Auxilary function: will not be called directly 
      1/0
  end

  def self.test_pass # Always passing test
      true
  end
  
  def self.test_fail # Always failing test
      false
  end
  
  def self.test_division_by_zero # Always fails and prints exception trace
      self.divide_by_zero == 42
  end
end
```

Also the test loaded in a way that function of `module Tests` are shared between files, so auxilary function would be available across files, but also in different files the could not be two functions named identically.

## APIs
Also there are some APIs which are developed along-side with my other project: MeowMeow web-server. 
### HTTP API
HTTP API provides basic capbilites of making HTTP request with use of `httparty` as backend. 
#### `TestHTTP::Response`
Class of HTTP response. Contains:
* Read-only:
	* code -- HTTP status code of response
	* data -- HTTP body string recieved from servver
	* headers -- a `Hash` with HTTP headers
#### `TestHTTP::get(url, headers = {}, params = {})`
* url -- address of webpage to request
* headers -- a `Hash` with headers
* param -- a `Hash` with GET params of request
Returns `TestHTTP::Response`
<br>
An example of using it:

```ruby
require "testapi/http.rb"

module Tests
  def self.test_internet 
      TestHTTP::get("http://captive.kuketz.de").code == 204
  end
end
```
