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
            expected_output = "1. Activity: Test Activity - Time Needed: one year - Reason: Activity Reason - Ticked Off?: [ ]\n"
            expect{ subject.display_activity($activities.first,0) }.to output(expected_output).to_stdout
        end
    end

    context 'activities being ticked' do
        before(:each) do
            $activities = [Activities.new('Test Activity','one year','Activity Reason')]
        end

        it 'should allow ticked_off to mark ticked as true' do
            $activities << [Activities.new('Test Activity','one year','Activity Reason')]
            expect(subject.ticked_off(0)).to be true
        end
    end

end
