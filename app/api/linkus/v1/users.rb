module Linkus::V1
  class Users < Grape::API
    resource :users do
      desc 'get user information'
      get 'me' do
        current_resource_owner.to_json
      end
    end
  end
end
