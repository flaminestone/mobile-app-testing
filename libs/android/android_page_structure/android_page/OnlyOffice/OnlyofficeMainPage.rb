# class with all onlyoffice main page (login page) elements
require_relative '../../../../../libs/android/android_page_structure/common_parser/common_data/Coordinates'
require_relative '../../../../../libs/android/android_page_structure/common_parser/common_data/Element'
require_relative '../../../../../libs/helpers/adb/adb_helper'
require_relative '../../../../android/android_page_structure/android_page/OnlyOffice/Objects/OnlyofficeFIle'
module OnlyofficeMainPage
  def get_file_list_object
    coord_array = @xmlobj.xpath('//*[@resource-id="com.onlyoffice.documents:id/frameLayout"]').css('node')[0]['bounds'].split(/\D/)
    [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])]
  end

  def get_files
    coord_array = @xmlobj.xpath('//*[@resource-id="android:id/list"]/node/node[2]')
    coord_array.map do |current_file|
      OnlyofficeFile.new(filename: create_filename_element(current_file),
                         fileowner: create_fileowner_element(current_file),
                         filesize: create_elements_filesize(current_file),
                         filedate: create_elements_filedate(current_file))
    end
  end

  def get_file_by_name(name)
    coord_array = @xmlobj.xpath('//*[@resource-id="android:id/list"]/node/node[2]')
    result = nil
    coord_array.each do |current_file|
      next unless name == create_filename_element(current_file).value
      result = OnlyofficeFile.new(filename: create_filename_element(current_file),
                                  fileowner: create_fileowner_element(current_file),
                                  filesize: create_elements_filesize(current_file),
                                  filedate: create_elements_filedate(current_file))
    end
    result
  end

  def create_filename_element(xml)
    coord_array = xml.css('node')[0]['bounds'].split(/\D/)
    Element.new(value: xml.css('node')[0]['text'], coordinats: [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])])
  end

  def create_fileowner_element(xml)
    coord_array = xml.css('node')[1]['bounds'].split(/\D/)
    Element.new(value: xml.css('node')[1]['text'], coordinats: [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])])
  end

  def create_elements_filedate(xml)
    coord_array = xml.css('node')[2]['bounds'].split(/\D/)
    Element.new(value: xml.css('node')[2]['text'].split('|').first, coordinats: [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])])
  end

  def create_elements_filesize(xml)
    coord_array = xml.css('node')[2]['bounds'].split(/\D/)
    Element.new(value: xml.css('node')[2]['text'].split('|').last.scan(/\d+/), coordinats: [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])])
  end

  # ---------- Actions ------------

  def update_file_list
    coordinates = get_file_list_object
    coord_swipe_x = coordinates.last.x.to_i / 2
    coord_swipe_y1 = (coordinates.last.y.to_i - coordinates.first.y.to_i) / 3
    coord_swipe_y2 = coord_swipe_y1 * 2
    AdbHelper.screen_swipe(@ip, Coordinates.new(coord_swipe_x, coord_swipe_y1), Coordinates.new(coord_swipe_x, coord_swipe_y2))
    sleep 3
    get_dump('main_page')
  end

  def open_file_by_name(file_name, timeout = 50)
    files = get_file_by_name(file_name)
    AdbHelper.click(@ip, files.name.coordinate.first)
    wait_for_file_open(timeout)
  end

  def wait_for_file_open(timeout = 50)
    timeout.times do
      break if AdbHelper.get_active_windows_data(@ip) == :doc_viewer
      sleep 5
    end
    return false unless AdbHelper.get_active_windows_data(@ip) == :doc_viewer
    true
  end
end
