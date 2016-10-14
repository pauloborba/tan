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
    matchdata.join("\n")
  end
end
