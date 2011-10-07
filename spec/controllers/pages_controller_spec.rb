require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                                    :content => @base_title + " | Home")
    end

    describe "for unsigned-in users" do
      it "should have a sign-in button" do
        get 'home'
        response.should have_selector("a",
                                      :content => "Sign up now!")
      end

      it "should not ask for a micropost" do
        get 'home'
        response.should_not have_selector("h1",
                                          :content => "What's up?")
      end
    end

    describe "for signed-in users" do
      before(:each) do
        test_sign_in(create_user!)
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
