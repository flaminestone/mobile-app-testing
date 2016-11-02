# class has methods for use adb utylit. Need to connect android devise for use
require_relative '../../libs/helpers/adb'
require_relative '../../libs/helpers/device'
class AdbHelper
  class << self
    #get serial number  for all devices
    def get_devises_id
      Adb.get_devises.scan(/^\w*\t/).map { |i| i.delete("\t") }
    end

    # get status of connection device
    # @param id [String] is a serial number of device
    # return :offline (cant find device), :loading (device is booting) or :online (ready to work)
    def get_status(id)
      case Adb.get_state(id).chomp
        when 'offline'
          return :offline
        when 'bootloader'
          :loading
        when 'device'
          :online
      end
    end

    # create Device obj. for save serial number and status in one place
    def get_all_devices
      get_devises_id.map do |current_serial|
        devise = Device.new(current_serial)
        devise.status = get_status(current_serial)
        devise
      end
    end

    # get ip address by device
    def get_wifi_ip(device)
      Adb.get_wlan_data(device.serial_number)[/(inet )[0-9.]+/].delete('inet ')
    end

    # Connect adb to device by wifi(shell method)
    def connect(device, ip)
      Adb.connect(ip, device.serial_number)
    end

    # Connect adb to device by wifi
    def checkout_to_wifi(device)
      ip = get_wifi_ip(device)
      connect(device, ip)
    end
  end
end