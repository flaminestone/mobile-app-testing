require_relative '../../libs/android/android_page_structure/common_parser/common_data/AndroidPageObject'
require_relative '../../libs/android/android_page_structure/Page'
module AndroidParser
  class AndroidPageStructure < AndroidPageObject
    attr_accessor :page
    def parse(path)
      xmlobj = Nokogiri::HTML(open(path))
      set_common_data(xmlobj)
      @page = Page.new(xmlobj)
      self
    end
  end

  def self.parse(path)
    AndroidPageStructure.new.parse(path)
  end
end
