# class has methods for use adb utylit. Need to connect android devise for use
require_relative '../../libs/helpers/adb'
require_relative '../../libs/helpers/device'
class AdbHelper
  class << self
    def get_devises_id
      Adb.get_devises.scan(/^\w*\t/).map { |i| i.delete("\t") }
    end

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

    def get_all_devices
      get_devises_id.map do |current_serial|
        devise = Device.new(current_serial)
        devise.status = get_status(current_serial)
        devise
      end
    end
  end
end