class Saltedge
  class << self
    include Dry::Monads[:result]

    # attr_reader :app_id, :secret, :private_key
    # EXPIRATION_TIME = 60
    APP_ID = ENV['SALTEDGE_APP_ID']
    SECRET = ENV['SALTEDGE_SECRET']

    # def self.verify_signature(public_key, data, signature)
    #   public_key.verify(OpenSSL::Digest::SHA256.new, Base64.decode64(signature), data)
    # end

    # def initialize
    #   @app_id      = ENV['']
    #   @secret      = secret
    #   @private_key = OpenSSL::PKey::RSA.new(File.open(private_pem_path))
    # end

    def request(method, url, params={})
      # hash = {
      #   method:     method,
      #   url:        url,
      #   expires_at: (Time.now + EXPIRATION_TIME).to_i,
      #   params:     as_json(params)
      # }

      response = RestClient::Request.execute(
        method:  method,
        url:     url,
        payload: params.to_json,
        # log:     Logger.new(STDOUT),
        headers: {
          "Accept"       => "application/json",
          "Content-type" => "application/json",
          # "Expires-at"   => hash[:expires_at],
          # "Signature"    => sign_request(hash),
          "App-Id"       => APP_ID,
          "Secret"       => SECRET
        }
      )
      Success(json_parse(response.body))
    rescue RestClient::ExceptionWithResponse => e
      Failure(json_parse(e.response.body))
    end

    def customers
      Saltedge::Customers
    end

    private

    def json_parse(string)
      JSON.parse(string, symbolize_names: true)
    end

    # def sign_request(hash)
    #   data = "#{hash[:expires_at]}|#{hash[:method].to_s.upcase}|#{hash[:url]}|#{hash[:params]}"
    #   pp data
    #   Base64.encode64(private_key.sign(OpenSSL::Digest::SHA256.new, data)).delete("\n")
    # end

    # def as_json(params)
    #   return "" if params.empty?
    #   params.to_json
    # end
  end

  # class Customers
  #   class << self
  #     def create(identifier)
  #       Saltedge.request(
  #         :post,
  #         'https://www.saltedge.com/api/v5/customers',
  #         {
  #           data: {
  #             identifier: identifier
  #           }
  #         }
  #       )
  #     end
  #   end
  # end
end
