require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'Includes all fields and saves successfully' do
      @category = Category.create(:name => "test")
      user =  User.new(
        :first_name => "first name",
        :last_name => "last name",
        :email => "email@email.com",
        :password => "1234",
        :password_confirmation => "1234"
        )

      user.validate
      # should save without error msg
      expect(user.errors.full_messages).to be_empty
    end

    it 'Validates presence of password' do
      @category = Category.create(:name => "test")
      user =  User.new(
        :first_name => "first name",
        :last_name => "last name",
        :email => "email@email.com",
        :password => nil,
        :password_confirmation => "1234"
        )

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include "Password can't be blank"
    end

    it 'Validates presence of password' do
      @category = Category.create(:name => "test")
      user =  User.new(
        :first_name => "first name",
        :last_name => "last name",
        :email => "email@email.com",
        :password => "1234",
        :password_confirmation => nil
        )

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include "Password confirmation can't be blank"
    end

    it 'Validates that password and password confirmation match' do
      @category = Category.create(:name => "test")
      user =  User.new(
        :first_name => "first name",
        :last_name => "last name",
        :email => "email@email.com",
        :password => "password",
        :password_confirmation => "1234"
        )

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it 'Validates the uniqueness of email' do
      @category = Category.create(:name => "test")
      user =  User.create(
        :first_name => "first name",
        :last_name => "last name",
        :email => "email@email.com",
        :password => "1234",
        :password_confirmation => "1234")
      
      user_two =  User.create(
        :first_name => "first",
        :last_name => "last",
        :email => "EMAIL@email.com",
        :password => "password",
        :password_confirmation => "password"
        )

      expect(user_two).to_not be_valid
      expect(user_two.errors.full_messages).to include "Email has already been taken"
    end

    it 'Validates presence of first name' do
      @category = Category.create(:name => "test")
      user =  User.new(
        :first_name => nil,
        :last_name => "last name",
        :email => "email@email.com",
        :password => "1234",
        :password_confirmation => "1234"
        )

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include "First name can't be blank"
    end

    it 'Validates presence of last name' do
      @category = Category.create(:name => "test")
      user =  User.new(
        :first_name => "first name",
        :last_name => nil,
        :email => "email@email.com",
        :password => "1234",
        :password_confirmation => "1234"
        )

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include "Last name can't be blank"
    end

    it 'Validates presence of email' do
      @category = Category.create(:name => "test")
      user =  User.new(
        :first_name => "first name",
        :last_name => "last name",
        :email => nil,
        :password => "1234",
        :password_confirmation => "1234"
        )

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include "Email can't be blank"
    end

    it "Validates that password must have a minimum length of 4" do
      @category = Category.create(:name => "test")
      user = User.new(
        :first_name => "first name",
        :last_name => "last name",
        :email => "email@email.com",
        :password => "123",
        :password_confirmation => "123"
        )

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include "Password is too short (minimum is 4 characters)"
    end

  end

  describe '.authenticate_with_credentials' do
    it "Authenticates with valid email/password" do
      @category = Category.create(:name => "test")
      user = User.new(
        :first_name => "first name",
        :last_name => "last name",
        :email => "email@email.com",
        :password => "1234",
        :password_confirmation => "1234"
        )
      
      user.save!
      userAuth = User.authenticate_with_credentials(user.email, user.password)
      expect(userAuth).to eq user
    end

    it "Authenticates with extra whitespace around email" do
      @category = Category.create(:name => "test")
      user = User.new(
        :first_name => "first name",
        :last_name => "last name",
        :email => "email@email.com",
        :password => "1234",
        :password_confirmation => "1234"
        )
      
      user.save!
      userAuth = User.authenticate_with_credentials("   email@email.com   ", user.password)
      expect(userAuth).to eq user
    end

    it "Authenticates when email is correct but in the wrong case" do
      @category = Category.create(:name => "test")
      user = User.new(
        :first_name => "first name",
        :last_name => "last name",
        :email => "email@email.com",
        :password => "1234",
        :password_confirmation => "1234"
        )
      
      user.save!
      userAuth = User.authenticate_with_credentials("EMAIL@email.com", user.password)
      expect(userAuth).to eq user
    end

    it "Returns nil/does not authenticate when emails do not match" do
      @category = Category.create(:name => "test")
      user = User.new(
        :first_name => "first name",
        :last_name => "last name",
        :email => "email@email.com",
        :password => "1234",
        :password_confirmation => "1234"
        )
      
      user.save!
      userAuth = User.authenticate_with_credentials("test@email.com", user.password)
      expect(userAuth).to be nil
    end

    it "Returns nil/does not authenticate when passwords do not match" do
      @category = Category.create(:name => "test")
      user = User.new(
        :first_name => "first name",
        :last_name => "last name",
        :email => "email@email.com",
        :password => "1234",
        :password_confirmation => "1234"
        )
      
      user.save!
      userAuth = User.authenticate_with_credentials(user.email, "12345")
      expect(userAuth).to be nil
    end

  end
end
