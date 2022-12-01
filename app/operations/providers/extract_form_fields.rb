module Providers
  class ExtractFormFields
    include Callable
    include Dry::Monads[:result]

    def call(provider)
      fields_json = provider.data.dig('data', 'required_fields')
      return Failure(:no_required_fields) if fields_json.blank?

      fields = transform_data(fields_json)

      Success(fields)
    end

    private

    def transform_data(fields_json)
      fields_json.map do |json|
        {
          name: json['name'],
          type: json['nature']
        }
      end
    end
  end
end
