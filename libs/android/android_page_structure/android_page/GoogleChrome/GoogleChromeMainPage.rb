require_relative '../../../../../libs/android/android_page_structure/common_parser/common_data/Coordinates'
require_relative '../../../../../libs/android/android_page_structure/common_parser/common_data/Element'
require_relative '../../../../../libs/helpers/adb/adb_helper'
module GoogleChromeMainPage
  def get_address_field
    coord_array = @xmlobj.xpath('//*[@resource-id="com.android.chrome:id/url_bar"]/@bounds').to_s.split(/\D/)
    Element.new(value: @xmlobj.xpath('//*[@resource-id="com.android.chrome:id/url_bar"]/@text').to_s, coordinats: [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])])
  end

  def set_data_to_address_field(data)
    get_address_field.coordinate
    AdbHelper.click(@ip, get_address_field.coordinate.first)
    AdbHelper.hide_keyboard(@ip)
    AdbHelper.input_text(@ip, data)
    AdbHelper.hide_keyboard(@ip)
    sleep 5
  end

  def go_to(data)
    set_data_to_address_field(data)
    AdbHelper.push_button(@ip, :enter)
    sleep 5
    @xmlobj = get_dump('main_page').xmlobj
  end

  def next_on_welcome_page
    accept_button_coord = @xmlobj.xpath('//*[@resource-id="com.android.chrome:id/terms_accept"]/@bounds').to_s.split(/\D/)
    accept_button = Element.new(coordinats: [Coordinates.new(accept_button_coord[1], accept_button_coord[2]), Coordinates.new(accept_button_coord[4], accept_button_coord[5])])
    AdbHelper.click(@ip, accept_button.coordinate.first)
    sleep 3
  end

  def close_welcome_page
    accept_button_coord = @xmlobj.xpath('//*[@resource-id="com.android.chrome:id/negative_button"]/@bounds').to_s.split(/\D/)
    accept_button = Element.new(coordinats: [Coordinates.new(accept_button_coord[1], accept_button_coord[2]), Coordinates.new(accept_button_coord[4], accept_button_coord[5])])
    AdbHelper.click(@ip, accept_button.coordinate.first)
    sleep 3
  end
  #---------Actions----------#
end
