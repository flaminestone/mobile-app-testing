require_relative '../../../libs/helpers/adb/adb_helper'
require_relative '../../../libs/helpers/device/app_requests'
module DeviceActions

  # @params app_name [Symbol].
  # there are list of valit application name:
  # :google_play
   def run_app(app_name)
     AdbHelper.run_command_on_device(@ip, AppRequests::APP[app_name][:command], 'n')
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

   def get_dump(filepath)
    path_to_file = AdbHelper.get_dump(@ip, filepath)
    parse_android_xml(path_to_file)
   end

  def parse_android_xml(path)
    AndroidParser.parse(path)
  end
end