class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :only => :token

  def create
    super
    if @user.save
      @user.categories.create(name:"Groceries")
      @user.categories.create(name:"Beer")
      @user.categories.create(name:"Rent")
      @user.categories.create(name:"Chocolate")
      @user.categories.create(name:"Hobbies and Interests")
    end
  end
end
