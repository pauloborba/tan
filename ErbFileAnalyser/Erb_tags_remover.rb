#Remove tags from erb file and output only an array of pure ruby code

class ErbTagsRemover

  def remove_erb_tags(text)
    all_tagged_chunks = text.scan(/(?<=\<%)(.*?)(?=\%>)/)
    all_tagged_chunks.each do |tagged_chunks|
      tagged_chunks.each do |tagged_chunk|
        if tagged_chunk[0] == '='
         tagged_chunk.slice!(0)
        end
      end
    end
    all_tagged_chunks.join("\n")
  end
end