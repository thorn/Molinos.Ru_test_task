# encoding: utf-8
require 'rails_helper'

describe User do
  let(:attr) { { email: FactoryGirl.generate(:email),
                 password: 'password',
                 password_confirmation: 'password'
             } }

  it 'creates a user record' do
    expect do
      User.create(attr)
    end.to change { User.count }.by(1)
  end
end
