class Api::TitlesController < Api::ApplicationController
  include Pagination

  before_action :set_title, only: [:show]
  before_action :set_title_associations, only: [:show]

  before_action -> { authorize(Api::TitlesPolicy) }, only: [:index]
  before_action -> { authorize(Api::TitlesPolicy, @title) }, only: [:show]

  def index
    titles = titles_scope.joins(:translations).order("title_translations.title ASC").all
    pagination, titles = paginate_countless(titles)

    set_pagination_headers(pagination)

    ActiveRecord::Associations::Preloader.new.preload(
      titles, [
        Title.translations_associations,
        original_content_language: [
          :locale,
          ContentLanguage.translations_associations
        ],
        cover: { file_attachment: :blob },
        writers: { artist: Artist.translations_associations },
        painters: { artist: Artist.translations_associations },
        genres: { tag: Tag.translations_associations },
        formats: { tag: Tag.translations_associations },
        demographics: { tag: Tag.translations_associations },
        marks: { tag: Tag.translations_associations },
        themes: { tag: Tag.translations_associations }
      ]
    )

    titles = Api::TitleDecorator.decorate(titles)
    titles = Api::TitleSerializer.serialize(titles)

    render json: titles, status: 200
  end

  def show
    title = Api::TitleDecorator.decorate(@title)
    title = Api::TitleSerializer.serialize(title)

    render json: title, status: 200
  end

  private

  def set_title
    @title = titles_scope.find(params[:id])
  end

  def titles_scope
    policy_scope(Api::TitlesPolicy, Title)
  end

  def set_title_associations
    ActiveRecord::Associations::Preloader.new.preload(
      @title, [
        Title.translations_associations,
        original_content_language: [
          :locale,
          ContentLanguage.translations_associations
        ],
        cover: { file_attachment: :blob },
        writers: { artist: Artist.translations_associations },
        painters: { artist: Artist.translations_associations },
        genres: { tag: Tag.translations_associations },
        formats: { tag: Tag.translations_associations },
        demographics: { tag: Tag.translations_associations },
        marks: { tag: Tag.translations_associations },
        themes: { tag: Tag.translations_associations }
      ]
    )
  end
end
