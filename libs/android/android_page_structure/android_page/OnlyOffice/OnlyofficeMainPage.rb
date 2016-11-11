# class with all onlyoffice main page (login page) elements
require_relative '../../../../libs/android/android_page_structure/common_parser/common_data/Coordinates'
require_relative '../../../../libs/android/android_page_structure/common_parser/common_data/Element'
class OnlyofficeLoginPage
  attr_accessor :file_list_object,
  def initialize(xml)
    @file_list_object = Element.new(:coordinats => get_file_list_object(xml))
  end

  def get_file_list_object(xml)
    coord_array = xml.xpath('//*[@resource-id="com.onlyoffice.documents:id/frameLayout"]').css('node')[0]['bounds'].split(/\D/)
    [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])]
  end
end