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
end