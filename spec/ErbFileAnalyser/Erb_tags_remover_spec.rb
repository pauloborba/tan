require 'rspec'
require_relative '../../ErbFileAnalyser/Erb_tags_remover'
require_relative '../../Util/ruby_parser'

describe 'Get ruby code' do
  context "by transforming erb tagged code into pure ruby" do
    it 'so it should make the code possible to parse' do
      $a = true
      hard_path = __FILE__
      path = hard_path.scan(/.*(?=\/)/)
      i = 1
      erb_tags_remover = ErbTagsRemover.new
      while i < 20 do
        untagged_code = erb_tags_remover.remove_erb_tags("#{path}/samples/sample#{i}.html.erb")
        i = i + 1
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
end