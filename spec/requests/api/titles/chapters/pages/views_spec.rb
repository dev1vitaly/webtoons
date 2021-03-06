require "rails_helper"

RSpec.describe Api::Titles::Chapters::Pages::ViewsController do
  describe ".create", context: :as_signed_in_user do
    it "returns valid response" do
      title = create(:title)
      chapter = create(:chapter, title: title)
      page = create(:page, chapter: chapter)

      post "/api/titles/#{title.to_param}/chapters/#{chapter.to_param}/pages/#{page.to_param}/views.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/titles/chapters/pages/views_controller/create/200")
    end
  end
end
