class Api::GenresController < Api::ApplicationController
  before_action :set_genre, only: [:show]
  before_action :set_genre_associations, only: [:show]

  def index
    genres = Genre.joins(tag: :translations).order("tag_translations.title ASC").includes(
      tag: [
        translations: [
          content_language: :locale
        ]
      ]
    ).all

    genres = Api::GenreDecorator.decorate_collection(genres)

    render json: Api::GenreSerializer.serialize(genres), status: 200
  end

  def show
    genre = Api::GenreDecorator.decorate(@genre)

    render json: Api::GenreSerializer.serialize(genre), status: 200
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def set_genre_associations
    ActiveRecord::Associations::Preloader.new.preload(
      @genre,
      [
        tag: [
          translations: [
            content_language: :locale
          ]
        ]
      ]
    )
  end
end