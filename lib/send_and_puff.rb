require "httparty"
require "nokogiri"
require "send_and_puff/version"
require "send_and_puff/tracking"

module SendAndPuff
  # The URL fragment used when constructing a request for tracking details.
  URL = "http://auspost.com.au/track/track.html?exp=b&id=".freeze

  # Retrieves the details associated with a tracking code. When successful it 
  # will return an Array subclass called Tracking, populated with the details
  # associated with a package.
  #
  # In the case of errors, it will return a Failure instance. This 
  # encapsulates all the details associated with the failure — class of error 
  # etc. — and provides access to the raw HTTP response for debugging.
  #
  # @param String code
  # @return [Tracking, Failure]
  # @todo Actually implement error handling
  def self.retrieve(code)
    result = HTTParty.get(URL + code)
    extract(result)
  end

  private

  # Extracts the tracking details from the raw HTML.
  #
  # @param String raw
  # @return Tracking
  # @todo Handle Time extraction properly
  def self.extract(raw)
    doc = Nokogiri::HTML(raw)
    results = doc.css('#more-details-content .ed-details-row').map do |r|
      time      = Time.parse(r.at_css('.ed-date p').inner_text.strip)
      activity  = r.at_css('.ed-activity p').inner_text.strip
      location  = r.at_css('.ed-location p').inner_text.strip
      state     = location.match(/\s+(\w{2,3})$/)[1]
      suburb    = location.gsub(state, '').strip

      {
        :time => time,
        :activity => activity,
        :state =>  state,
        :suburb => suburb
      }
    end

    SendAndPuff::Tracking.new(raw, results)
  end
end

