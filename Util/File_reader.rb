class FileReader

  def read_file(path)
    string = File.open(path, 'rb') { |file| file.read }
  end
end