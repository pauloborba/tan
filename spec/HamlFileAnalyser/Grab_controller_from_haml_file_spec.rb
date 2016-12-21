require 'rspec'
require_relative '../../lib/HamlFileAnalyser/Haml_controller_extractor'

describe 'Extraction of dependencies in haml files, including calls to controller actions' do
  it 'does produce correct mappings for the files in the samples directory' do
    path = get_relative_path
    i = 1
    $passed = true
    file_manager = File_manager.new
    while i < 9 do
      controller_extractor = HamlControllerExtractor.new
      sample_path = "#{path}/samples/sample#{i}.html.haml"
      answer_string = file_manager.read_file("#{path}/samples/haml_expected_answers/sample#{i}_haml_expected_answer.txt").gsub(/\s+/, "")
      tool_answer = controller_extractor.haml_controller_extractor(sample_path).gsub(/\s+/, "")
      i += 1
      if !(answer_string == tool_answer)
        $passed = false
      end
    end
    expect($passed).to eq true
  end
end

def get_relative_path
  hard_path = __FILE__
  path = /.*(?=\/)/.match(hard_path).to_s
  path = /.*(?=\/)/.match(path).to_s
  path = /.*(?=\/)/.match(path).to_s
end