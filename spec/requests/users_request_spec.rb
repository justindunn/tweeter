require 'rails_helper'

RSpec.describe 'Users', type: :request do

  describe '#index seeing the list of users' do
    user = User.create(name: 'Jim Carrey')
    it 'should show the created user successful' do
      get users_path, xhr: true
      expect(response).to be_successful
    end

    it 'should show the created user' do
      get users_path, xhr: true
      expect(response.body).to include('Jim Carrey')
    end

    it 'should show  the button to create a new user' do
      get users_path, xhr: true
      expect(response.body).to include('Create User')
    end
    it 'should show the button to show the user' do
      get users_path, xhr: true
      expect(response.body).to include('Show')
    end

    it 'should show the button to edit the user' do
      get users_path, xhr: true
      expect(response.body).to include('Edit')
    end
  end

  describe '#show' do
    user = User.create(name: 'Jim Carrey', email: 'jim@carrey.com', twitter_handle: 'JimCarrey')
    it 'should show the created user successful' do
      get user_path(User.last.id), xhr: true
      expect(response).to be_successful
    end

    it 'should show the user name' do
      get user_path(User.last.id), xhr: true
      expect(response.body).to include(user.name)
    end

    it 'should show the user email' do
      get user_path(User.last.id), xhr: true
      expect(response.body).to include(user.email)
    end

    it 'should show the user twitter handle' do
      get user_path(User.last.id), xhr: true
      expect(response.body).to include(user.twitter_handle)
    end

    it 'should show the search bar for tweets' do
      get user_path(User.last.id), xhr: true
      expect(response.body).to include('Search')
    end
  end

  describe '#edit' do
    user = User.create(name: 'Jim Carrey', email: 'jim@carrey.com', twitter_handle: 'JimCarrey')
    it 'should show the created user succesfully' do
      get edit_user_path(User.last.id), xhr: true
      expect(response).to be_successful
    end

    it 'should show the created user name' do
      get edit_user_path(User.last.id), xhr: true
      expect(response.body).to include(user.name)
    end

    it 'should show the user email' do
      get edit_user_path(User.last.id), xhr: true
      expect(response.body).to include(user.email)
    end

    it 'should show the user twitter handle' do
      get edit_user_path(User.last.id), xhr: true
      expect(response.body).to include(user.twitter_handle)
    end

    it 'should show the update button instead of create' do
      get edit_user_path(User.last.id), xhr: true
      expect(response.body).to include('Update User')
      expect(response.body).to_not include('Create User')
    end
    it 'should not show the search bar' do
      get edit_user_path(User.last.id), xhr: true
      expect(response.body).to_not include('Search')
    end
  end

  describe '#new' do
    it 'should show the created user successfully' do
      get new_user_path, xhr: true
      expect(response).to be_successful
    end

    it 'should show the form input for name' do
      get new_user_path, xhr: true
      expect(response.body).to include('Name')
    end

    it 'should show the form input for email' do
      get new_user_path, xhr: true
      expect(response.body).to include('Email')
    end

    it 'should show the form input for Twitter Handle' do
      get new_user_path, xhr: true
      expect(response.body).to include('Twitter handle')
    end

    it 'should show the button to create a user not update' do
      get new_user_path, xhr: true
      expect(response.body).to include('Create User')
      expect(response.body).to_not include('Update User')
    end

    it 'should not show the search bar' do
      get new_user_path, xhr: true
      expect(response.body).to_not include('Search')
    end
  end
end
