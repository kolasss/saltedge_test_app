# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do |resource|
        Customers::Create.call(resource) if resource.persisted?
      end
    end
  end
end
