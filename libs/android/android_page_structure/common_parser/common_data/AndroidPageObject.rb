require 'nokogiri'
require 'onlyoffice_logger_helper/logger_helper'
require_relative '../../../../../libs/android/android_page_structure/common_parser/common_data/Coordinates'
require_relative '../../../../../libs/android/android_page_structure/android_page/OnlyOffice/OnlyofficeLoginPage'
require_relative '../../../../../libs/helpers/device/device_actions'
require_relative '../../../../../libs/android/android_page_structure/android_page/OnlyOffice/OnlyofficeMainPage'
require_relative '../../../../../libs/android/android_page_structure/android_page/OnlyOffice/OnlyofficeDocumentPage'
class AndroidPageObject
  include DeviceActions
  attr_accessor :elem_class, :elem_package, :checkable, :enabled, :coordinats
  alias bounds coordinats
  # set common data for page: orientation, base class and package, enabled and display size.
  # Display size can has different with your device documentation, because somethink devices has not physical home, back and view buttons.
  # It buttons in place in bottom of display
  def set_common_data(obj)
    @elem_class = obj.css('node')[0]['class']
    @elem_package = obj.css('node')[0]['package']
    @enabled = obj.css('node')[0]['enabled']
    coord_array = obj.css('node')[0]['bounds'].split(/\D/)
    @coordinats = [Coordinates.new(coord_array[1], coord_array[2]), Coordinates.new(coord_array[4], coord_array[5])]
  end

  # This method will detect page by main elements.
  def detect_page(xml)
    OnlyofficeLoggerHelper.log("Detecting page:")
     unless xml.to_s.slice('com.onlyoffice.documents:id/login_form').nil?
       OnlyofficeLoggerHelper.log("Login page detected")
       extend OnlyofficeLoginPage
       OnlyofficeLoggerHelper.log("Module was extend")
     end
    unless xml.to_s.slice('com.onlyoffice.documents:id/container').nil?
      OnlyofficeLoggerHelper.log("Main page detected")
      extend OnlyofficeMainPage
      OnlyofficeLoggerHelper.log("Module was extend")
      sleep 1
    end
  end
end
