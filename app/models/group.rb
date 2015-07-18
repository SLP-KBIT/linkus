# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
  has_many :group_users
  has_many :users, through: :group_users

  NAME = %w(CEM GMV ETR WSP).freeze
  POSITION = %w(なし リーダー サブリーダー).freeze
end
