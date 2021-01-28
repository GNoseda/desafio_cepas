require 'rails_helper'

RSpec.describe WinesController, type: :controller do
    describe 'GET #index' do
        before(:each) do
            @user = User.create!(email:'user01@example.com', password:'123456', password_confirmation:'123456', name:'User01')
        end

        it "renders the index template" do
            get :index, {}, auth_token: @user.authentication_token
            expect(response).to render_template('index')
        end
    end
    
end 
