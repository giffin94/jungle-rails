require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(first_name: 'Aedan', last_name: 'Giffin', email: 'aedan@site.com', password: '12345678', password_confirmation: '12345678') }
  
  describe 'Validations' do
    
    it 'should be valid with good data' do
      expect(subject).to be_valid
    end

    it 'should not accept a registered email' do
      User.create!(first_name: 'Aedan', last_name: 'Giffin', email: 'aedan@site.com', password: '12345678', password_confirmation: '12345678')
      subject.save
      expect(subject.errors.full_messages[0]).to match /Email has already been taken/
    end

    it 'should not accept when passwords do not match' do
      subject.password_confirmation = '123456789'
      subject.save
      expect(subject.errors.full_messages[0]).to match /Password confirmation doesn't match/
    end

    it 'should be invalid if password confirmation is missing' do
      subject.password_confirmation = nil
      subject.save
      expect(subject.errors.full_messages[0]).to match /Password confirmation can't be blank/
    end

    it 'should be invalid if password is missing' do
      subject.password = nil
      subject.save
      expect(subject.errors.full_messages[0]).to match /Password can't be blank/
    end

    it 'should not be valid without a first name' do
      subject.first_name = nil
      subject.save
      expect(subject.errors.full_messages[0]).to match /First name can't be blank/
    end

    it 'should not be valid without a last name' do
      subject.last_name = nil
      subject.save
      expect(subject.errors.full_messages[0]).to match /Last name can't be blank/
    end

    it 'should not accept passwords shorter than 8 characters' do
      subject.password = '1234567'
      subject.password_confirmation = '1234567'
      subject.save
      expect(subject.errors.full_messages[0]).to match /Password is too short/      
    end
  end

  describe '.authenticate_with_credentials' do
    
    it 'should succeed if email and password match an existing user' do
      User.create!(first_name: 'Aedan', last_name: 'Giffin', email: 'aedan@site.com', password: '12345678', password_confirmation: '12345678')
      email = 'aedan@site.com'
      password = '12345678'
      expect(user = User.authenticate_with_credentials(email, password)).to be_present
    end

    it 'should succeed when the user adds leading and/or trailing spaces around email' do
      User.create!(first_name: 'Aedan', last_name: 'Giffin', email: 'aedan@site.com', password: '12345678', password_confirmation: '12345678')
      email = '       aedan@site.com             '
      password = '12345678'
      expect(user = User.authenticate_with_credentials(email, password)).to be_present      
    end

    it 'should succeed when email matches regardless of case' do
      User.create!(first_name: 'Aedan', last_name: 'Giffin', email: 'aedan@site.com', password: '12345678', password_confirmation: '12345678')
      email = 'AEDAN@SITE.COM'
      password = '12345678'
      expect(user = User.authenticate_with_credentials(email, password)).to be_present
    end

    it 'should fail when the email is not registered' do
      User.create!(first_name: 'Aedan', last_name: 'Giffin', email: 'aedan@site.com', password: '12345678', password_confirmation: '12345678')
      email = 'nonexistent@user.com'
      password = '12345678'
      expect(user = User.authenticate_with_credentials(email, password)).to be_nil
    end

    it 'should fail when the password is incorrect' do
      User.create!(first_name: 'Aedan', last_name: 'Giffin', email: 'aedan@site.com', password: '12345678', password_confirmation: '12345678')
      email = 'aedan@site.com'
      password = '23456789'
      expect(user = User.authenticate_with_credentials(email, password)).to be_nil
    end

  end


end
