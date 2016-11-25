
class Haml_parser

  def parse(text)
    all_tagged_chunks = text.scan(/(?<=\=)(.*)|(?<=\- )(.*)/)
    all_tagged_chunks.each do |tagged_chunks|
      tagged_chunks.each do |tagged_chunk|
        if tagged_chunk.class != NilClass
          tagged_chunks - [tagged_chunk]
        end
      end
    end
    all_tagged_chunks.join("\n")
  end
end