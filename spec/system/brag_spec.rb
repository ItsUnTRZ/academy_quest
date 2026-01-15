require 'rails_helper'

RSpec.describe "Brag", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "brag page" do
    it "displays the brag document" do
      visit brag_path
      expect(page).to have_content("My Brag Document")
    end

    it "shows goals section" do
      visit brag_path
      expect(page).to have_content("เป้าหมายของฉัน")
    end

    it "shows achievements section" do
      visit brag_path
      expect(page).to have_content("ความสำเร็จที่ผ่านมา")
    end

    it "shows skills section" do
      visit brag_path
      expect(page).to have_content("ทักษะที่ฉันมี")
    end

    it "has a link back to home" do
      visit brag_path
      expect(page).to have_link("Back to Home")
    end
  end
end
