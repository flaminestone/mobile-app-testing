# class has methods for use adb utylit. Need to connect android devise for use
require_relative '../../../libs/helpers/adb/adb'
require_relative '../../../libs/helpers/device/device'
require_relative '../../../libs/helpers/device/app_requests'
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
        devise = Device.new(serial_number: current_serial)
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
      device.status = if result == 'unable'
                        :offline
                      else
                        :online
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

    # @param ip [String] is a ip for device
    def click(ip, coordinats)
      Adb.click(ip, coordinats.x, coordinats.y)
    end

    # @param ip [String] is a ip for device
    # method will hide keyboard if it visible. Do nothing if keyboard is hided
    def hide_keyboard(ip)
      Adb.hide_keyboard(ip) if get_keyboard_status(ip)
    end

    # @param ip [String] is a ip for device
    # @param text [String] is a text for printing
    def input_text(ip, text)
      Adb.input_text(ip, text)
    end

    # @param ip [String] is a ip for device
    # @param app_name [String] is name of app for data deleting
    def delete_app_data(ip, app_name)
      package_name = AppRequests::APP[app_name][:package]
      Adb.delete_app_data(ip, package_name)
    end

    # @param ip [String] is a ip for device
    # @param coord1 [Coordinates] is start point for swipe
    # @param coord2 [Coordinates] is finish point for swipe
    def screen_swipe(ip, coord1, coord2)
      Adb.screen_swipe(ip, coord1.x, coord1.y, coord2.x, coord2.y)
    end

    # @param ip [String] is a ip for device
    # this method will check keyboard status. Return true is it is open, false if it hidden
    def get_keyboard_status(ip)
      Adb.set_shell_commands(ip, 'dumpsys input_method | grep mInputShown').split('mInputShown=').last.strip == 'true'
    end

    # @param ip [String] is a ip for device
    # @param key [Symbol] is a name of key for pushing.
    # this method will check keyboard status. Return true is it is open, false if it hidden
    # Active button for used:
    # :escape || :esc
    def push_button(ip, key)
      case key
      when :esc || :escape
        Adb.push_button(ip, 4)
      end
    end

    # @param ip [String] is a ip for device
    # get current window data. Return activity name. All names you can see in it AppRequests::PAGE_ACTIVITY
    def get_active_windows_data(ip)
      log = Adb.get_active_windows_data(ip).split('mCurrentFocus=Window{').last.split('}').first
      result = nil
      AppRequests::PAGE_ACTIVITY.each_pair do |current_key, current_value|
        unless log.slice(current_value).nil?
          result = current_key
          break
        end
      end
      result
    end

    # @param ip [String] is a ip for device
    # @param path [String] is a path for file save
    def get_screenshot(ip, path)
      Adb.get_screenshot(ip, path)
    end
  end
end
