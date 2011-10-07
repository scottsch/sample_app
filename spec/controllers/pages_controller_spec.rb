require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
    describe "when not signed in" do
      before(:each) do
        get :home
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_selector("title",
                                      :content => @base_title + " | Home")
      end

      it "should have a sign-in button" do
        response.should have_selector("a",
                                      :content => "Sign up now!")
      end

      it "should not ask for a micropost" do
        response.should_not have_selector("h1",
                                          :content => "What's up?")
      end
    end

    describe "when signed in" do
      before(:each) do
        @user = test_sign_in(create_user!)
      end

      it "should not have a sign-in button" do
        get 'home'
        response.should_not have_selector("a",
                                          :content => "Sign up now!")
      end

      it "should ask for a micropost" do
        get 'home'
        response.should have_selector("h1",
                                      :content => "What's up?")
      end

      it "should have the right follower/following counts" do
        other_user = create_user!(:email => "follower@example.net")
        other_user.follow!(@user)
        get :home
        response.should have_selector("a", :href => following_user_path(@user),
                                           :content => "0 following")
        response.should have_selector("a", :href => followers_user_path(@user),
                                           :content => "1 follower")
      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                                    :content => @base_title + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                                    :content => @base_title + " | About")
    end
  end
end
