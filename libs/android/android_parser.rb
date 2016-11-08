require_relative '../../libs/android/android_page_structure/common_parser/common_data/AndroidPageObject'
require_relative '../../libs/android/android_page_structure/Page'
module AndroidParser
  class AndroidPageStructure < AndroidPageObject
    attr_accessor :ip, :page, :structure
    def parse(path, ip)
      raise "File #{path} is not found" unless File.exist?(path)
      @ip = ip
      xmlobj = Nokogiri::XML(open("#{path}.xml"))
      set_common_data(xmlobj)
      @page = Page.new(xmlobj)
      @structure = detect_page(xmlobj)
      self
    end
  end

  def self.parse(filepath, ip)
    AndroidPageStructure.new.parse(filepath.path, ip)
  end
end
