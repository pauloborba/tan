require '../Util/File_reader'

class ErbTagsRemover

  def remove_erb_tags(text)
    matchdata = text.scan(/(?<=\<%)(.*?)(?=\%>)/)
    matchdata.each do |tagged_code|
      tagged_code.each do |code_with_tags|
        #removing opening tag
        if code_with_tags[0] == '='
         code_with_tags.slice!(0)
        end
      end
    end
    code = matchdata.join("\n")
  end
end

#ErbTagsRemover.new.remove_erb_tags(FileReader.new.read_file("C:/Users/jpms2/Desktop/TAn/sample.html.erb"))