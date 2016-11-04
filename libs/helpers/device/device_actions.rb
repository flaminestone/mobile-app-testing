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
  def install_app_from_google_play(link)
    AdbHelper.run_command_on_device(@ip, AppRequests::APP[:app_install][:command] + ' ' + link, 'a')
    sleep 1 # no app to open it moment, need to sleep
  end
   # pull_file_from_device
   # @param filepath [String] is a path to file on device
  def pull(filepath)
    AdbHelper.pull(@ip, filepath)
  end

   def get_dump(filepath)
    AdbHelper.get_dump(@ip, filepath)
  end
end
# adb -s 172.50.0.14:5555 shell am start -a android.intent.action.VIEW -d 'market://details?id=com.onlyoffice.documents'