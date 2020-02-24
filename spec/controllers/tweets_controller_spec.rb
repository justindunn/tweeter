# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TweetsController do
  describe 'POST #create' do
    context 'when creating a new user' do
      let(:user) do
        User.create(name: 'Jim Carrey', email: 'jim@carrey.com', twitter_handle: 'JimCarrey')
      end

      let(:new_tweet_params) do
        {
          'user_id' => user.id,
          'tweet' => {
            'user_id' => user.id,
            'message' => 'Jim Carrey is funny.',
            'tweet_id' => '1234567'
          }
        }
      end

      it 'creates a new tweet' do
        expect do
          post :create, params: new_tweet_params, format: :json
        end.to change(Tweet, :count).by 1
      end
    end
  end
end