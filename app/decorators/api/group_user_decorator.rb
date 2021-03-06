class Api::GroupUserDecorator < Api::ApplicationDecorator
  decorates_association :group, with: Api::GroupDecorator
  decorates_association :user, with: Api::UserDecorator
end
