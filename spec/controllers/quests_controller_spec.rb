require 'rails_helper'

RSpec.describe QuestsController, type: :controller do
  before do
    Quest.destroy_all
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all quests to @quests" do
      quest = Quest.create!(name: "Quest 1")
      get :index
      expect(assigns(:quests)).to include(quest)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new quest and redirects" do
        expect {
          post :create, params: { quest: { name: "New Quest" } }
        }.to change(Quest, :count).by(1)
        expect(response).to redirect_to(quests_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a quest and renders index" do
        expect {
          post :create, params: { quest: { name: nil } }
        }.not_to change(Quest, :count)
        expect(response).to render_template(:index)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:quest) { Quest.create!(name: "To Be Deleted") }

    it "destroys the quest and redirects" do
      expect {
        delete :destroy, params: { id: quest.id }
      }.to change(Quest, :count).by(-1)
      expect(response).to redirect_to(quests_path)
    end
  end
end
