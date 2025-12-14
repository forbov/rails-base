module API
  module V1
    class Base < Grape::API
      include API::V1::Defaults
      mount API::V1::Example
    end
  end
end
