require 'rails_helper'
require_relative '../webhelpers.rb'

RSpec.feature "Timeline", type: :feature do
  scenario "Can delete a post" do
    # create_post
    # Sign up ----------------------------
    visit "/users"
    click_link "Create new account"
    fill_in "user[name]", with: "Zoe"
    fill_in "user[email]", with: "zoe@gmail.com"
    fill_in "user[password]", with: "123456"
    fill_in "user[password_confirmation]", with: "123456"
    click_button "Create User"

    # Create post ------------------------
    id = (User.find_by(email: "zoe@gmail.com")).id
    visit "/posts"
    click_link "New post"
    fill_in "post[message]", with: "Hello, world!"
    fill_in "post[user_id]", with: id
    click_button "Submit"
    visit '/posts'
    expect(page).to have_link("Hello, world!")

    # Delete post -------------------------
    visit "/posts"
    click_link "Delete post"
    expect(page).not_to have_content("Hello, world!")
  end
end