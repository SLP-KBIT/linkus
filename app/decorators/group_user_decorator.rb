class GroupUserDecorator < Draper::Decorator
  delegate_all

  def name_and_position
    "#{object.group.name}(#{GroupUser::POSITION[object.position]})"
  end
end
