require_relative '../../../libs/helpers/adb/adb_helper'
require_relative '../../../libs/helpers/device/app_requests'
module DeviceActions

  # @params app_name [Symbol]
  # there are list of valit application name:
  # :google_play
  # :onlyoffice
   def run_app(app_name)
     AdbHelper.run_command_on_device(@ip, AppRequests::APP[app_name][:command], 'n')
     sleep 5 # no app to open it moment, need to sleep
     wait_for_app_is_runing(app_name)
     if app_name == :google_chrome
       google_chrome = get_dump('app_dump')
       google_chrome.next_on_welcome_page
       google_chrome = get_dump('app_dump')
       google_chrome.close_welcome_page
     end
     get_dump('app_dump')
   end

   def wait_for_app_is_runing(waiting_page_activity, timeout = 5)
     timeout.times do
       break if AppRequests::ONLYOFFICE_PAGES_ACTIVITY.keys.include? AdbHelper.get_active_windows_data(@ip)
       sleep 5
     end
   end

   # @param link [String] is a link to application in google play market
   # return google_play page like android_parser objest
  def install_app_from_google_play(link)
    AdbHelper.run_command_on_device(@ip, AppRequests::APP[:app_install][:command] + ' ' + link, 'a')
    sleep 3 # no app to open it moment, need to sleep
    get_dump('install_app_from_google_play')
  end

   # pull_file_from_device
   # @param filepath [String] is a path to file on device
  def pull(filepath)
    AdbHelper.pull(@ip, filepath)
    end

   # get dump of interface like xml
   # @param filepath [String] is a path for save dump file
   def get_dump(filepath)
    path_to_file = AdbHelper.get_dump(@ip, filepath)
    parse_android_xml(path_to_file)
   end

   # Parse xml interface file
   # @param path [String] is a path to dump file
  def parse_android_xml(path)
    AndroidParser.parse(path, self.ip)
  end
end