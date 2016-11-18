require_relative '../../libs/android/android_page_structure/common_parser/common_data/AndroidPageObject'
require_relative '../../libs/android/android_page_structure/Page'
module AndroidParser
  class AndroidPageStructure < AndroidPageObject
    attr_accessor :ip, :page, :structure
    def parse(path, ip = nil)
      raise "File #{path} is not found" unless File.exist?(path)
      @ip = ip
      @xmlobj = Nokogiri::XML(open(path))
      set_common_data(@xmlobj)
      @page = Page.new(@xmlobj)
      detect_page(@xmlobj)
      self
    end
  end

  def self.parse(filepath, ip = nil)
    filepath = "#{filepath.path}.xml" unless filepath.is_a?(String)
    AndroidPageStructure.new.parse(filepath, ip)
  end
end
