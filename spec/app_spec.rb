require_relative '../lib/app'

ARGV.clear

RSpec.describe App do

    subject{App.new}

    it 'should have a starting activities array' do
        expect($activities).to eq []
    end

    it 'should '

    #     before(:each) do
    #         $activities = [{activity: 'Test Activity', time_needed: 'one year', activity_reason: 'Activity Reason', ticked: false }]
    #     end

    #     it 'should display all of our bucket activities' do
    #         expected_output = "1. Activity: Test Activity - Time Needed: one year - Reason: Activity Reason - Ticked Off?: [ ]\n"
    #         expect(subject.display_activity).to output(expected_output).to_stdout
    #     end
    # end
    
    # context 'adding activities' do

    #     it 'should be able to add activities' do
    #         subject.build_activity('Test Activity')
    #         expect($activities.last).to eq({ activity: 'Test Activity', time_needed: 'one year', activity_reason: 'Activity Reason', ticked: false })
    #     end

    #     # it 'should ask user for input' do
    #     #     expected_output = "Enter your Dream Bucket List Activity:  "
    #     #     expect(subject.build_activity).to output(expected_output).to_stdout
    #     # end

    # end

    # context 'ticking off tasks' do

    #     it 'should display activities that are completed with TICKED' do
    #         $activities << { activity: 'Test Activity', ticked: true }
    #         expected_output = "1. Activity: Test Activity is now TICKED OFF WOO!!!!!!!!!"
    #         expect { subject.ticked_off }.to output(expected_output).to_stdout
    #       end
    
    #       it 'should display activities that are not completed with a space' do
    #         $activities << { activity: 'Test Activity', time_needed: 'one year', activity_reason: 'Activity Reason', ticked: false }
    #         expected_output = "1. Activity: Test Activity - Time Needed: one year - Reason: Activity Reason, Ticked?: [ ]"
    #         expect { subject.display_activities }.to output(expected_output).to_stdout
    #       end 

    # end
end
