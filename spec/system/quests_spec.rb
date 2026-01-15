require 'rails_helper'

RSpec.describe "Quests", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "index page" do
    it "displays the quest list" do
      Quest.create!(name: "Test Quest")
      visit quests_path
      expect(page).to have_selector("[data-testid='quest-item']", text: "Test Quest")
    end

    it "shows empty state when no quests" do
      Quest.destroy_all
      visit quests_path
      expect(page).to have_selector("[data-testid='empty-state']", text: "No quests found.")
    end
  end

  describe "creating a quest" do
    it "creates a new quest" do
      visit quests_path
      find("[data-testid='quest-name-input']").set("New Quest")
      find("[data-testid='add-quest-button']").click
      expect(page).to have_selector("[data-testid='quest-item']", text: "New Quest")
    end
  end

  describe "quest status" do
    it "shows completed quest with line-through style" do
      Quest.create!(name: "Done Quest", is_done: true)
      visit quests_path
      expect(page).to have_selector("[data-testid='quest-name'].line-through", text: "Done Quest")
    end

    it "shows incomplete quest without line-through" do
      Quest.create!(name: "Pending Quest", is_done: false)
      visit quests_path
      quest_name = find("[data-testid='quest-name']", text: "Pending Quest")
      expect(quest_name).not_to have_css(".line-through")
    end
  end

  describe "deleting a quest" do
    it "removes the quest from the list" do
      quest = Quest.create!(name: "Delete Me")
      visit quests_path
      expect(page).to have_selector("[data-testid='quest-item']", text: "Delete Me")
      quest_item = find("[data-testid='quest-item']", text: "Delete Me")
      quest_item.find("[data-testid='destroy-quest-button']").click
      expect(page).not_to have_selector("[data-testid='quest-item']", text: "Delete Me")
    end
  end

  describe "navigation" do
    it "has a link to brag document" do
      visit quests_path
      expect(page).to have_link("My Brag Document")
    end

    it "navigates to brag page when clicking the link" do
      visit quests_path
      click_link "My Brag Document"
      expect(page).to have_current_path(brag_path)
    end
  end
end
