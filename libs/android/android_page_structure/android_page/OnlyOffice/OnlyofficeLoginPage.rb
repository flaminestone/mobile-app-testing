# class with all onlyoffice main page (login page) elements
require_relative '../../../../../libs/android/android_page_structure/common_parser/common_data/Coordinates'
require_relative '../../../../../libs/android/android_page_structure/common_parser/common_data/Element'
require_relative '../../../../../libs/helpers/adb/adb_helper'
module OnlyofficeLoginPage

  def get_portal_address_field
    coord_array = @xmlobj.xpath('//*[@resource-id="com.onlyoffice.documents:id/portal"]').css('node')[0]['bounds'].split(/\D/)
    [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])]
  end

  def get_email_field
    coord_array = @xmlobj.xpath('//*[@resource-id="com.onlyoffice.documents:id/email"]').css('node')[0]['bounds'].split(/\D/)
    [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])]
  end

  def get_password_field
    coord_array = @xmlobj.xpath('//*[@resource-id="com.onlyoffice.documents:id/password"]').css('node')[0]['bounds'].split(/\D/)
    [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])]
  end

  def get_login_button
    coord_array = @xmlobj.xpath('//*[@resource-id="com.onlyoffice.documents:id/email_sign_in_button"]').css('node')[0]['bounds'].split(/\D/)
    [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])]
  end

  def login(*args)
    AdbHelper.click(@ip, get_portal_address_field.first)
    AdbHelper.hide_keyboard(@ip)
    AdbHelper.input_text(@ip, args.first[:portal_name] )
    AdbHelper.click(@ip, get_email_field.first)
    AdbHelper.hide_keyboard(@ip)
    AdbHelper.input_text(@ip, args.first[:email] )
    AdbHelper.click(@ip, get_password_field.first)
    AdbHelper.hide_keyboard(@ip)
    AdbHelper.input_text(@ip, args.first[:password])
    AdbHelper.click(@ip, get_login_button.first)
    AdbHelper.click(@ip, get_login_button.first)
    sleep 3
    get_dump('main_page')
  end
end