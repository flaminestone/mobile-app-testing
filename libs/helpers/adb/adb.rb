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
      `adb -s #{id} connect #{ip} 2<&1`
    end

    def disconnect(id)
      `adb disconnect #{id} 2<&1`
    end

    def disconnect_all
      `adb disconnect 2<&1`
    end

    def set_port(id, port = '5555')
      `adb -s #{id} tcpip #{port} 2<&1`
      sleep 3 # need to reboot tcp
    end

    def shell_start_by_ip(ip, command, key = 'a')
      if command == 'com.onlyoffice.documents/.activities.MainActivity'
          command = '"com.onlyoffice.documents/com.onlyoffice.documents.activities.MainActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER'
      end
      `adb -s #{ip} shell am start -#{key} #{command} 2<&1`
    end

    def pull(ip, pull_from, pull_to)
      `adb -s #{ip} pull #{pull_from} #{pull_to} 2<&1`
    end

    def dump(ip, save_to)
    `adb -s #{ip} pull $(adb -s #{ip}  shell uiautomator dump | grep -oP '[^ ]+.xml') #{save_to}.xml 2<&1`
    end

    def click(ip, x, y)
      `adb -s #{ip} shell input tap #{x} #{y}`
    end

    def input_text(ip, text)
      `adb -s #{ip} shell input text #{text}`
    end

    def hide_keyboard(ip)
      `adb -s #{ip} shell input keyevent 111`
    end

    def delete_app_data(ip, package_name)
      `adb -s #{ip} shell pm clear #{package_name}`
    end

    def screen_swipe(ip, x1, y1, x2, y2)
      `adb -s #{ip} shell input touchscreen swipe #{x1} #{y1} #{x2} #{y2}`
    end
  end
end
