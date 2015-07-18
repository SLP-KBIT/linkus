class GroupUserDecorator < Draper::Decorator
  delegate_all

  def position
    GroupUser::POSITION[object.position]
  end
end
