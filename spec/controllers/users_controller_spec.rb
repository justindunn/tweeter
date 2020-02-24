# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController do
  describe 'POST #create' do
    context 'when creating a new user' do
      let(:new_user_params) do
        {
          'user' => {
            'name' => 'Jim Carrey',
            'twitter_handle' => 'JimCarrey',
            'email' => 'jim@carrey.com'
          }
        }
      end
      let(:new_user_params_invalid) do
        {
          'user' => {
            'name' => '',
            'twitter_handle' => 'JimCarrey',
            'email' => 'jim@carrey.com'
          }
        }
      end
      it 'creates a new user' do
        expect do
          post :create, params: new_user_params, format: :json
        end.to change(User, :count).by 1
      end
      
      it 'does not create a new user when the name is blank' do
        expect do
          post :create, params: new_user_params_invalid, format: :json
        end.to change(User, :count).by 0
      end
    end
  end
end