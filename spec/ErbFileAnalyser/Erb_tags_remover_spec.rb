require 'rspec'
require_relative '../../lib/ErbFileAnalyser/Erb_tags_remover'
require_relative '../../lib/Util/ruby_parser'

describe 'Erb tags removal function' do
    it 'does not break for the files in the samples directory' do
      $a = true
      hard_path = __FILE__
      path = hard_path.scan(/.*(?=\/)/)
      i = 1
      erb_tags_remover = ErbTagsRemover.new
      while i < 20 do
        untagged_code = erb_tags_remover.remove_erb_tags("#{path}/samples/sample#{i}.html.erb")
        i += 1
        begin
          ruby_parser = Ruby_parser.new
          ruby_parser.parse_code(untagged_code)
        rescue
          $a = false
        end
      end
      expect($a).to eq true
    end
end