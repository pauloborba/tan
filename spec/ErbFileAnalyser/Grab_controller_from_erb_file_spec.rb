require 'rspec'
require_relative '../../lib/Util/file_manager'
require_relative '../../lib/ErbFileAnalyser/Grab_controller_from_erb_file'

describe "Extraction of dependencies in erb files, including calls to controller actions" do
  it "does produce correct mappings for the files in the samples directory" do
    path = get_relative_path
    i = 1
    $passed = true
    file_manager = File_manager.new
    while i < 5 do
      controller_grabber = ControllerGrabber.new
      sample_path = "#{path}/samples/sample#{i}.html.erb"
      answer_string = file_manager.read_file("#{path}/samples/sample#{i}_expected_answer.txt").gsub(/\s+/, "")
      tool_answer = controller_grabber.grab_controllers(sample_path).gsub(/\s+/, "")
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