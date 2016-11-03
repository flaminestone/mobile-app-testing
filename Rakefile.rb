require_relative 'libs/app_manager'
task :add_device do
  AdbHelper.get_all_devices.each do |device|
    AdbHelper.checkout_to_wifi(device)
  end
end