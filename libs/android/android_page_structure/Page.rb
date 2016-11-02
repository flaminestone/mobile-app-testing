module AndroidParser
  class Page
    attr_accessor :rotation
    def initialize(obj)
      @rotation = obj.css('hierarchy')[0]['rotation'].to_i
    end
  end
end
