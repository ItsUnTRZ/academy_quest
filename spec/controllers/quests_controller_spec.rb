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

    it "assigns all quests to @quests ordered by created_at desc" do
      quest1 = Quest.create!(name: "Quest 1", created_at: 2.days.ago)
      quest2 = Quest.create!(name: "Quest 2", created_at: 1.day.ago)
      get :index
      expect(assigns(:quests).to_a).to eq([quest2, quest1])
    end

    it "assigns a new quest to @quest" do
      get :index
      expect(assigns(:quest)).to be_a_new(Quest)
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

      it "renders turbo stream template" do
        post :create, params: { quest: { name: "New Quest" } }, format: :turbo_stream
        expect(response).to have_http_status(:success)
        expect(response.content_type).to include("text/vnd.turbo-stream.html")
      end
    end

    context "with invalid parameters" do
      it "does not create a quest and renders index" do
        expect {
          post :create, params: { quest: { name: nil } }
        }.not_to change(Quest, :count)
        expect(response).to render_template(:index)
      end

      it "renders turbo stream with errors" do
        post :create, params: { quest: { name: nil } }, format: :turbo_stream
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include("text/vnd.turbo-stream.html")
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

    it "renders turbo stream template" do
      delete :destroy, params: { id: quest.id }, format: :turbo_stream
      expect(response).to have_http_status(:success)
      expect(response.content_type).to include("text/vnd.turbo-stream.html")
    end
  end
end
