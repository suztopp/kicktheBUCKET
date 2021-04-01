require_relative '../lib/app'

RSpec.describe App do
    subject(:app){
        described_class.new
    }
    it 'should be an instance of App' do
        expect(subject).to be_a App
    end

    it 'should have a starting activities array' do
        expect(app.activities).to eq []
    end

    context "adding activities" do
        it 'should be able to add activities' do
            app.add_activity('Test Activity')
            expect(app.activities.last).to eq({ activity: 'Test Activity', ticked: false })
        end
        
        it 'should ask user for input' do
            expected_output = "Enter your Bucket List Activity\n"
            expect{ app.display_add_activity }.to output(expected_output).to_stdout
        end
    end
end