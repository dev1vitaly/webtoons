class TagSerializer < ApplicationSerializer
  include TranslationAttributes

  def attributes
    {
      id: model.id,
      title: model.title,
      created_at: model.created_at,
      updated_at: model.updated_at,
      translations: translations,
    }
  end
end
