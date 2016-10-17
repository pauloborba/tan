require 'rspec'
require_relative '../../Util/file_manager'
require_relative '../../ErbFileAnalyser/Grab_controller_from_erb_file'

describe "Get actions calls" do
  context "by getting actions and controllers behind it" do
    it "so it should get actions and respective methods or variables" do
      hard_path = __FILE__
      path = /.*(?=\/)/.match(hard_path).to_s
      path = /.*(?=\/)/.match(path).to_s
      path = /.*(?=\/)/.match(path).to_s
      print path
      passed = false
      controller_grabber = ControllerGrabber.new
      controller_grabber.grab_controllers("#{path}/samples/sample1.html.erb")
      file_manager = File_manager.new
      answer_string = file_manager.read_file("#{path}/samples/sample_expected_answer.txt").gsub(/\s+/, "")
      tool_answer = file_manager.read_file("#{path}/ErbFileAnalyser/output.txt").gsub(/\s+/, "")
      if answer_string == tool_answer
        passed = true
      end
      expect(passed).to eq true
    end
  end
end