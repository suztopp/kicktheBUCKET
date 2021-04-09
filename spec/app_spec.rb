require_relative '../lib/app'

ARGV.clear

RSpec.describe App do

    subject{App.new}

    it 'should have a starting activities array' do
        expect($activities).to eq []
    end

    describe 'Class Rspec' do
        it 'should be an instance of App' do
          expect(subject).to be_a App
        end
      end

    context 'displaying activities' do
        before(:each) do
            $activities = [Activities.new('Test Activity','one year','Activity Reason')]
        end

        it 'should display all of our bucket activities' do
            expected_output = '1. ' + 'Activity: ' + 'Test Activity'.green + ' - Time Needed: ' + 'one year'.green + ' - Reason: ' + 'Activity Reason'.green + ' - Ticked Off?: [ ]'"\n"
            expect{ subject.display_activity($activities.first,0) }.to output(expected_output).to_stdout
        end
    end

    context 'activities being ticked' do
        before(:each) do
            $activities = [Activities.new('Test Activity','one year','Activity Reason')]
        end

        it 'should allow ticked_off to mark ticked as true' do              #test run to check if the ticked_off method was applied to the test hash, the hash at index 0 would have TICKED change to true
            $activities << [Activities.new('Test Activity','one year','Activity Reason')]
            expect(subject.ticked_off(0)).to be true
        end
    end

    context 'deleting activites' do
        before(:each) do
            $activities = [Activities.new('Test Activity','one year','Activity Reason')]
        end

        it 'should delete a task at index 0' do                             #test to check if via the test activity above, if the delete_activity method was run it would leave the test array empty
            subject.delete_activity
            expect($activities).to be_empty
        end
    end
end
