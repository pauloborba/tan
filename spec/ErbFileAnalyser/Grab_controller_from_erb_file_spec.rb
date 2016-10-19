require 'rspec'
require_relative '../../Util/file_manager'
require_relative '../../ErbFileAnalyser/Grab_controller_from_erb_file'

describe "Get actions calls" do
  context "by getting actions and controllers behind it" do
    it "so it should get actions and respective methods or variables" do
      path = get_relative_path
      i = 1
      print path
      $passed = true
      file_manager = File_manager.new
      while i < 4 do
        controller_grabber = ControllerGrabber.new
        sample_path = "#{path}/samples/sample#{i}.html.erb"
        controller_grabber.grab_controllers(sample_path)
        answer_string = file_manager.read_file("#{path}/samples/sample#{i}_expected_answer.txt").gsub(/\s+/, "")
        tool_answer = file_manager.read_file("#{path}/outputs/#{file_manager.get_file_name(sample_path)}_output.txt").gsub(/\s+/, "")
        i += 1
        if !(answer_string == tool_answer)
          $passed = false
        end
      end
      expect($passed).to eq true
    end
  end
end

def get_relative_path
  hard_path = __FILE__
  path = /.*(?=\/)/.match(hard_path).to_s
  path = /.*(?=\/)/.match(path).to_s
  path = /.*(?=\/)/.match(path).to_s
end