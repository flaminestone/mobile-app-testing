class FileHelper
  class << self
    def delete_all_files(ip_obj)
      LoggerHelper.print_to_log 'Try to delete all files from portal'
      files = ip_obj.files.get_my_docs.body['response']['files']
      return if files.empty?
      files.each do |current_file|
        ip_obj.files.delete_file(current_file['id'])
        LoggerHelper.print_to_log "Delete file with name: #{current_file['title']}"
      end
    end
  end
end