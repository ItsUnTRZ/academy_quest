require 'rails_helper'

RSpec.describe "Quests", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "index page" do
    it "displays the quest list" do
      Quest.create!(name: "Test Quest")
      visit quests_path
      expect(page).to have_content("Test Quest")
    end

    it "shows empty state when no quests" do
      visit quests_path
      expect(page).to have_content("No quests found.")
    end
  end

  describe "creating a quest" do
    it "creates a new quest" do
      visit quests_path
      fill_in "quest_name", with: "New Quest"
      click_button "Add Quest"
      expect(page).to have_content("New Quest")
    end
  end

  describe "quest status" do
    it "shows completed quest with line-through style" do
      Quest.create!(name: "Done Quest", is_done: true)
      visit quests_path
      expect(page).to have_css(".line-through", text: "Done Quest")
    end

    it "shows incomplete quest without line-through" do
      Quest.create!(name: "Pending Quest", is_done: false)
      visit quests_path
      expect(page).not_to have_css(".line-through", text: "Pending Quest")
    end
  end

  describe "deleting a quest" do
    it "removes the quest from the list" do
      quest = Quest.create!(name: "Delete Me")
      visit quests_path
      expect(page).to have_content("Delete Me")
      click_button "Destroy"
      expect(page).not_to have_content("Delete Me")
    end
  end
end
