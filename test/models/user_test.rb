require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user with email is valid" do
    user = User.new(default_user_params)
    assert user.valid?
  end

  test "user without email is invalid" do
    user = User.new(default_user_params.except(:email))
    assert_not user.valid?
  end

  test "user with invalid email is invalid" do
    user = User.new(default_user_params.merge(email: 'foo'))
    assert_not user.valid?
  end

  test "email must be unique" do
    user1 = users(:one)
    user2 = User.new(default_user_params.merge(email: user1.email))
    assert_not user2.valid?
  end

  test "email is downcased before save" do
    user = User.new(default_user_params.merge(email: 'admIN@Example.com'))
    user.save
    assert_equal 'admin@example.com', user.email
  end

  test "password update requires confirmation" do
    user = User.new(default_user_params.merge(password: 'password', password_confirmation: 'passwor'))
    assert_not user.valid?
  end

  test "password can be updated when confirmed" do
    user = User.new(default_user_params.merge(password: 'password', password_confirmation: 'password'))
    assert user.valid?
  end

  test "user can be authenticated with correct password" do
    user = users(:one)
    assert_equal user, user.authenticate('password')
  end

  test "user cannot be authenticated with incorrect password" do
    user = users(:one)
    assert_not user.authenticate('wrong_password')
  end

  def default_user_params
    { email: 'admin@example.com', password: 'password', password_confirmation: 'password' }
  end

end
