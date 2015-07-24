require 'doorkeeper/grape/helpers'

module Linkus::V1
  class Base < Grape::API
    version 'v1', using: :path
    format :json

    helpers Doorkeeper::Grape::Helpers

    before do
      doorkeeper_authorize!
    end

    helpers do
      def current_resource_owner
        User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end

    mount Users
  end
end
