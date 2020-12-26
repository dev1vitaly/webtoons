class ContentLanguagesController < ApplicationController
  before_action :set_content_language, only: [:show]
  before_action :set_content_language_associations, only: [:show]

  def index
    content_languages = ContentLanguage.order(id: :asc).includes(
      :locale,
      translations: [
        content_language: :locale
      ]
    ).all

    content_languages = ContentLanguageDecorator.decorate_collection(content_languages)

    render json: ContentLanguageSerializer.serialize(content_languages), status: 200
  end

  def show
    content_language = ContentLanguageDecorator.decorate(@content_language)

    render json: ContentLanguageSerializer.serialize(content_language), status: 200
  end

  private

  def set_content_language
    @content_language = ContentLanguage.find(params[:id])
  end

  def set_content_language_associations
    ActiveRecord::Associations::Preloader.new.preload(
      @content_language,
      [
        :locale,
        translations: [
          content_language: :locale
        ]
      ]
    )
  end
end