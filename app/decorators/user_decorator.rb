class UserDecorator < Draper::Decorator
  delegate_all

  def last_sign_in_at
    return '未ログイン' unless object.last_sign_in_at
    object.last_sign_in_at.strftime('%Y/%m/%d %H:%M')
  end

  def laboratory
    User::LABORATORY[object.laboratory]
  end

  def position
    User::POSITION[object.position]
  end
end
