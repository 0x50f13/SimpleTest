## HTTP API for tests
#  Uses httparty backend

require "httparty"

module TestHTTP
  class Response
    attr_reader :code
    attr_reader :headers
    attr_reader :data
    attr_reader :duration
    def initialize(code, headers, data, duration)
        @code = code
        @data = data
        @headers = headers
        @duration = duration
    end
  end

  def self.get(url, headers = {}, params = {}) 
    s = ""
    if params.length > 0 then
       s="?"
       params.each do |key, value|
         if s == "?" then
            s+="#{key}=#{value}"
         else
            s+="&#{key}=#{value}"
         end
       end
    end
    start = Time.now
    r = HTTParty::get(url+s, :headers => headers)
    _end = Time.now
    Response.new(r.code, r.headers, r.body, _end - start)
  end
end
