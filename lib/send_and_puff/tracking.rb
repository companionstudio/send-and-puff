module SendAndPuff
  class Tracking < Array
    # Alias latest to Array#first
    alias :latest :first

    # Alias oldest to Array#last
    alias :oldest :last

    # The raw HTML returned from AusPost.
    #
    # @attr_reader String
    attr_reader :raw

    # Overwrite the constructor so that we can accept the raw response and make
    # it accessible to API consumers.
    #
    # @param String raw
    # @param Array<Hash> results
    def initialize(raw, results)
      @raw = raw
      super(results)
    end

    # Indicates that the look up is successful. In the Failure class this is
    # correspondingly false.
    #
    # @return true
    def successful?
      true
    end

    # Indicates the that the lookup has not been a failure.
    #
    # @return false
    def failed?
      false
    end
  end
end

