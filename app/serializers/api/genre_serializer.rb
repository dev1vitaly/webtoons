class Api::GenreSerializer < Api::ApplicationSerializer
  def attributes
    {
      id: model.id,
      tag_id: model.tag_id,
      title: model.tag.title,
      description: model.tag.description,
      created_at: model.created_at,
      updated_at: model.updated_at
    }
  end
end
