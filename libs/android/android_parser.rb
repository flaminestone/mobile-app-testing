require_relative '../../libs/android/android_page_structure/common_parser/common_data/AndroidPageObject'
require_relative '../../libs/android/android_page_structure/Page'
module AndroidParser
  class AndroidPageStructure < AndroidPageObject
    attr_accessor :page
    def parse(path)
      raise "File #{path} is not found" unless File.exist?(path)
      xmlobj = Nokogiri::XML(open("#{path}.xml"))
      set_common_data(xmlobj)
      @page = Page.new(xmlobj)
      self
    end
  end

  def self.parse(filepath)
    AndroidPageStructure.new.parse(filepath.path)
  end
end
