require "rails_helper"

RSpec.describe Api::InterfaceLanguagesController do
  describe ".index" do
    it "returns valid response" do
      # Entries creation skipped because english and russian interface languages created through rspec contexts
      # That is enough for this spec

      get "/api/interface_languages.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/interface_languages_controller/index/200")
    end
  end

  describe ".show" do
    it "returns valid response" do
      # Entries creation skipped because english interface language created through rspec contexts
      # That is enough for this spec

      get "/api/interface_languages/#{Current.interface_language.to_param}.json"

      expect(response).to have_http_status(200)
      expect(response).to match_json_schema("controllers/api/interface_languages_controller/show/200")
    end
  end
end
