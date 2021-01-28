require 'rails_helper'

RSpec.describe Strain, type: :model do
    it "rejects empty and nills" do
        should validate_presence_of(:name)
    end

    it 'validates uniqueness name' do
        should validate_uniqueness_of(:name)
    end 
end