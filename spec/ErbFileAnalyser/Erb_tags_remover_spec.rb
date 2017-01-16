require 'rspec'
require_relative '../../lib/ErbFileAnalyser/Erb_tags_remover'
require_relative '../../lib/Util/ruby_parser'

describe 'Erb tags removal function' do
    it 'does not break for the files in the samples directory' do
      $a = true
      hard_path = __dir__
      path = (hard_path.scan(/.*(?=\/)/)[0])[0..-6]
      files = Dir["#{path}/**/*.erb"]
      ruby_parser = Ruby_parser.new
      erb_tags_remover = ErbTagsRemover.new
      files.each do |file_name|
        begin
          untagged_code = erb_tags_remover.remove_erb_tags(file_name)
          ruby_parser.parse_code(untagged_code)
        rescue
          $a = false
        end
      end
      expect($a).to eq true
    end
end