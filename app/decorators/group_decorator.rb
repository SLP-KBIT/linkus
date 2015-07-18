class UserDecorator < Draper::Decorator
  delegate_all

  def name
    Group::NAME[object.laboratory]
  end

  def position
    Group::POSITION[object.position]
  end
end
