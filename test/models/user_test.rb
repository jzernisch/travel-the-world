require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user with email is valid" do
    user = User.new(email: 'foo@bar.com')
    assert user.valid?
  end

  test "user without email is invalid" do
    user = User.new
    assert_not user.valid?
  end

  test "user with invalid email is invalid" do
    user = User.new(email: 'foo')
    assert_not user.valid?
  end

  test "email must be unique" do
    user1 = User.new(email: 'foo@bar.com')
    assert user1.save

    user2 = User.new(email: 'foo@bar.com')
    assert_not user2.valid?
  end

  test "email is downcased before save" do
    user = User.new(email: 'FOO@bar.com')
    user.save
    assert_equal 'foo@bar.com', user.email
  end
end
