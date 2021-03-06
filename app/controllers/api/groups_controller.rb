class Api::GroupsController < Api::ApplicationController
  include Pagination

  before_action :set_group, only: [:show]
  before_action :set_group_associations, only: [:show]

  before_action -> { authorize(Api::GroupsPolicy) }, only: [:index]
  before_action -> { authorize(Api::GroupsPolicy, @group) }, only: [:show]

  def index
    groups = group_scope.order("groups.title ASC").all
    pagination, groups = paginate_countless(groups)

    set_pagination_headers(pagination)

    if Current.user.present?
      ActiveRecord::Associations::Preloader.new.preload(
        groups, [
          :favorite
        ]
      )
    end

    groups = Api::GroupDecorator.decorate_collection(groups)
    groups = Api::GroupSerializer.serialize(groups)

    render json: groups, status: 200
  end

  def show
    group = Api::GroupDecorator.decorate(@group)
    group = Api::GroupSerializer.serialize(group)

    render json: group, status: 200
  end

  private

  def set_group
    @group = group_scope.find(params[:id])
  end

  def group_scope
    policy_scope(Api::GroupsPolicy, Group)
  end

  def set_group_associations
    if Current.user.present?
      ActiveRecord::Associations::Preloader.new.preload(
        @group, [
          :favorite
        ]
      )
    end
  end
end
