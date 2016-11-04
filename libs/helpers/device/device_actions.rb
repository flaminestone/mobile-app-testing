require_relative '../../../libs/helpers/adb/adb_helper'
require_relative '../../../libs/helpers/device/app_requests'
module DeviceActions

  # @params app_name [Symbol].
  # there are list of valit application name:
  # :google_play
   def run_app(app_name)
     AdbHelper.run_command_on_device(@ip, AppRequests::APP[app_name][:command], 'n')
  end
end