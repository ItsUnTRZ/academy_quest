require 'rails_helper'

RSpec.describe Quest, type: :model do
  describe "validations" do
    it "is valid with a name" do
      quest = Quest.new(name: "Test Quest")
      expect(quest).to be_valid
    end

    it "is invalid without a name" do
      quest = Quest.new(name: nil)
      expect(quest).not_to be_valid
      expect(quest.errors[:name]).to include("can't be blank")
    end

    it "is invalid with blank name" do
      quest = Quest.new(name: "")
      expect(quest).not_to be_valid
      expect(quest.errors[:name]).to include("can't be blank")
    end
  end

  describe "default values" do
    it "has is_done default to false" do
      quest = Quest.create!(name: "New Quest")
      expect(quest.is_done).to be false
    end
  end
end
