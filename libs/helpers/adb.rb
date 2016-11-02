# class has methods for use adb utilit. Need to connect android devise for use
class Adb
  class << self
    def get_devises
      `adb devices 2<&1`
    end

    def get_state(id)
      `adb -s #{id} get-state 2<&1`
    end

    def get_wlan_data(id)
      `adb -s #{id} shell ip -f inet addr show wlan0 2<&1`
    end

    def connect(id, ip)
      `adb -s #{id} connect #{ip}`
    end
  end
end