require 'nokogiri'
require_relative '../../../../../libs/android/android_page_structure/common_parser/common_data/Coordinates'
require_relative '../../../../../libs/android/android_page_structure/android_page/OnlyofficeLoginPage'
class AndroidPageObject
  attr_accessor :elem_class, :elem_package, :checkable, :enabled, :coordinats
  alias bounds coordinats

  def set_common_data(obj)
    @elem_class = obj.css('node')[0]['class']
    @elem_package = obj.css('node')[0]['package']
    @enabled = obj.css('node')[0]['enabled']
    coord_array = obj.css('node')[0]['bounds'].split(/\D/)
    @coordinats = [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])]
  end

  def detect_page(xml)
    OnlyofficeLoginPage.new(xml) unless xml.to_s.slice('com.onlyoffice.documents:id/login_form').nil?
  end
end
