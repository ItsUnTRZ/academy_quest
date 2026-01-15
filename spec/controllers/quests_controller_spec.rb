require 'rails_helper'

RSpec.describe QuestsController, type: :controller do
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all quests to @quests" do
      quest1 = Quest.create!(name: "Quest 1")
      quest2 = Quest.create!(name: "Quest 2")
      get :index
      expect(assigns(:quests)).to match_array([quest1, quest2])
    end
  end

  describe "GET #show" do
    let(:quest) { Quest.create!(name: "Test Quest") }

    it "returns a successful response" do
      get :show, params: { id: quest.id }
      expect(response).to be_successful
    end

    it "assigns the requested quest to @quest" do
      get :show, params: { id: quest.id }
      expect(assigns(:quest)).to eq(quest)
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new quest to @quest" do
      get :new
      expect(assigns(:quest)).to be_a_new(Quest)
    end
  end

  describe "GET #edit" do
    let(:quest) { Quest.create!(name: "Test Quest") }

    it "returns a successful response" do
      get :edit, params: { id: quest.id }
      expect(response).to be_successful
    end

    it "assigns the requested quest to @quest" do
      get :edit, params: { id: quest.id }
      expect(assigns(:quest)).to eq(quest)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new quest" do
        expect {
          post :create, params: { quest: { name: "New Quest", body: "Quest body" } }
        }.to change(Quest, :count).by(1)
      end

      it "redirects to the created quest" do
        post :create, params: { quest: { name: "New Quest", body: "Quest body" } }
        expect(response).to redirect_to(Quest.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new quest" do
        expect {
          post :create, params: { quest: { name: nil } }
        }.not_to change(Quest, :count)
      end

      it "renders the new template" do
        post :create, params: { quest: { name: nil } }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH #update" do
    let(:quest) { Quest.create!(name: "Original Name", body: "Original body") }

    context "with valid parameters" do
      it "updates the quest" do
        patch :update, params: { id: quest.id, quest: { name: "Updated Name" } }
        quest.reload
        expect(quest.name).to eq("Updated Name")
      end

      it "redirects to the quest" do
        patch :update, params: { id: quest.id, quest: { name: "Updated Name" } }
        expect(response).to redirect_to(quest)
      end
    end

    context "with invalid parameters" do
      it "does not update the quest" do
        patch :update, params: { id: quest.id, quest: { name: nil } }
        quest.reload
        expect(quest.name).to eq("Original Name")
      end

      it "renders the edit template" do
        patch :update, params: { id: quest.id, quest: { name: nil } }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:quest) { Quest.create!(name: "To Be Deleted") }

    it "destroys the quest" do
      expect {
        delete :destroy, params: { id: quest.id }
      }.to change(Quest, :count).by(-1)
    end

    it "redirects to the quests index" do
      delete :destroy, params: { id: quest.id }
      expect(response).to redirect_to(quests_path)
    end
  end
end
