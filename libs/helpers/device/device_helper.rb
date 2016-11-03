require_relative '../../../libs/helpers/device/device'
require_relative '../../../libs/helpers/adb/adb_helper'
class DeviceHelper
  def self.create_devices_by_config(data)
    data.map do |current_data|
      Device.new(name: current_data.first, serial_number: current_data[1]['serial_number'], ip: current_data[1]['ip'], status: AdbHelper.get_status(current_data[1]['serial_number']))
    end
  end
end
