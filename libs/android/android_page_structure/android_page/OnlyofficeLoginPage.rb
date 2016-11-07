# class with all onlyoffice main page (login page) elements
require_relative '../../../../libs/android/android_page_structure/common_parser/common_data/Coordinates'
require_relative '../../../../libs/android/android_page_structure/common_parser/common_data/Element'
class OnlyofficeLoginPage

  attr_accessor :portal_address_field, :email_field
  def initialize(xml)
    @portal_address_field = Element.new(:coordinats => get_portal_address_field(xml))
    @email_field = Element.new(:coordinats => get_email_field(xml))
    @password_field = Element.new(:coordinats => get_password_field(xml))
    @login_button = Element.new(:coordinats => get_login_button(xml))
  end

  def get_portal_address_field(xml)
    coord_array = xml.xpath('//*[@resource-id="com.onlyoffice.documents:id/portal"]').css('node')[0]['bounds'].split(/\D/)
    [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])]
  end

  def get_email_field(xml)
    coord_array = xml.xpath('//*[@resource-id="com.onlyoffice.documents:id/email"]').css('node')[0]['bounds'].split(/\D/)
    [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])]
  end

  def get_password_field(xml)
    coord_array = xml.xpath('//*[@resource-id="com.onlyoffice.documents:id/password"]').css('node')[0]['bounds'].split(/\D/)
    [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])]
  end

  def get_login_button(xml)
    coord_array = xml.xpath('//*[@resource-id="com.onlyoffice.documents:id/email_sign_in_button"]').css('node')[0]['bounds'].split(/\D/)
    [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])]
  end
end