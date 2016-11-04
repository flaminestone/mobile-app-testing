# class has methods for use adb utylit. Need to connect android devise for use
require_relative '../../../libs/helpers/adb/adb'
require_relative '../../../libs/helpers/device/device'
require 'tempfile'
class AdbHelper
  class << self
    # get serial number  for all devices
    def get_devises_id
      Adb.get_devises.scan(/^\w*\t/).map { |i| i.delete("\t") }
    end

    # get status of connection device
    # @param id [String] is a serial number of device
    # return :offline (cant find device), :loading (device is booting) or :online (ready to work)
    def get_status(id)
      case Adb.get_state(id).chomp
      when 'offline'
        :offline
      when 'bootloader'
        :loading
      when 'device'
        :online
      else
        :none
      end
    end

    # create Device obj. for save serial number and status in one place
    def get_all_devices
      get_devises_id.map do |current_serial|
        devise = Device.new(:serial_number => current_serial)
        devise.status = get_status(current_serial)
        devise
      end
    end

    # get ip address by device
    # @param device [Device] is a object os Device class
    def get_wifi_ip(device)
      Adb.get_wlan_data(device.serial_number)[/(inet )[0-9.]+/].delete('inet ')
    end

    # Connect adb to device by wifi(shell method)
    # @param device [Device] is a object os Device class
    def connect(device)
      sleep 0.5
      result = Adb.connect(device.serial_number, device.ip).split(' ').first
      if result == 'unable'
        device.status = :offline
      else
        device.status = :online
      end
      device
    end

    # Disconnect adb to device
    # @param device [Device] is a object os Device class
    def disconnect(device)
      Adb.disconnect(device.serial_number)
    end

    # disconnect all devices
    def disconnect_all
      Adb.disconnect_all
    end

    # Connect adb to device by wifi
    # @param device [Device] is a object os Device class
    def checkout_to_wifi(device)
      Adb.set_port(device.serial_number)
      ip = get_wifi_ip(device)
      device.ip = ip
      connect(device)
    end

    # ---------------------------------------------------------------------------------------------
    # Methods for device used

    # @param ip [String]
    # @params command [String] like this: 'android.intent.action.VIEW -d "market://details?id=com.onlyoffice.documents"'
    # @params key [String] is a key for start command. Use 'n' if you run MainActivity
    def run_command_on_device(ip, command, key = nil)
      Adb.shell_start_by_ip(ip, command, key)
    end

    # @param pull_from [String] is a path to file to pull on device
    def pull(ip, pull_from)
      output_file = Tempfile.new(File.basename(pull_from))
      Adb.pull(ip, pull_from, output_file.path)
      output_file
    end

    # @param ip [String] is a ip for device
    # @param path [String] is a path for xml save
    def get_dump(ip, path)
      output_file = Tempfile.new(File.basename(path))
      Adb.dump(ip, output_file.path)
      output_file
    end
  end
end