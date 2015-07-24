# == Schema Information
#
# Table name: group_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_id   :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  POSITION = %w(なし リーダー サブリーダー).freeze

  module Select
    POSITION = POSITION.map.with_index { |pos, i| [pos, i] }
  end
end
