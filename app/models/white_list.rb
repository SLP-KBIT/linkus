# == Schema Information
#
# Table name: white_lists
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  active     :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WhiteList < ActiveRecord::Base
end
