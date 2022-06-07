require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "user will save" do
      @user = User.new(
        name: "Test", 
        email: "test@test.com",
        password: "test",
        password_confirmation: "test")

      saved = @user.save

      expect(saved).to be_truthy
    end

    it "name presence" do
      @user = User.new(
        name: nil, 
        email: "test@test.com",
        password: "test",
        password_confirmation: "test")
      
      @user.save

      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "email presence" do
      @user = User.new(
        name: "Test", 
        email: nil,
        password: "test",
        password_confirmation: "test")

      @user.save

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "email should be unique" do
      @userA = User.new(
        name: "Test", 
        email: "test@test.com",
        password: "test",
        password_confirmation: "test")
      @userA.save

      @userB = User.new(
        name: "Test2", 
        email: "test@Test.com",
        password: "test2",
        password_confirmation: "test2")
      saved = @userB.save

      expect(saved).to be_falsy
      expect(@userB.errors.full_messages).to include("Email has already been taken")
    end

    it "password presence" do
      @user = User.new(
        name: "Test", 
        email: "test@test.com",
        password: nil,
        password_confirmation: "test")

      @user.save

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "password confirmation presence" do
      @user = User.new(
        name: "Test", 
        email: "test@test.com",
        password: "test",
        password_confirmation: nil)

      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "password and confirmation should match" do
      @user = User.new(
        name: "Test", 
        email: "test@test.com",
        password: "test",
        password_confirmation: "tes")

      @user.save

      expect(@user.password).to_not eq(@user.password_confirmation)
    end   

    it "password should be a minimum length of 4" do
      @user = User.new(
        name: "Test", 
        email: "test@test.com",
        password: "boo",
        password_confirmation: "boo")

      @user.save
      
      expect(@user.password.length).to_not eq(4)
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end 
  end

  describe '.authenticate_with_credentials' do
    it "email should be valid" do
      @user = User.new(
        name: "Amy", 
        email: "a@a.com",
        password: "test",
        password_confirmation: "test")
      @user.save

      expect(User.authenticate_with_credentials(nil, "test")).to be_falsy
    end 

    it "password should be valid" do
      @user = User.new(
        name: "Amy", 
        email: "a@a.com",
        password: "test",
        password_confirmation: "test")
      @user.save

      expect(User.authenticate_with_credentials("a@a.com", nil)).to be_falsy
    end 

    it "email leading and trailing whitespace should be ignored" do
      @user = User.new(
        name: "Amy", 
        email: "a@a.com",
        password: "test",
        password_confirmation: "test")
      @user.save

      expect(User.authenticate_with_credentials(" a@a.com ", "test")).to be_truthy
    end 

    it "email should be case insensitive" do
      @user = User.new(
        name: "Amy", 
        email: "a@a.com",
        password: "test",
        password_confirmation: "test")
      @user.save

      expect(User.authenticate_with_credentials("A@a.CoM", "test")).to be_truthy
    end 
  end
end
