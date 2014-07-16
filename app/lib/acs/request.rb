module ACS
  class Request
    def self.config
      @@config ||= YAML.load_file("#{::Rails.root}/config/acs_authentication.yml")[::Rails.env]
    end

    def self.connection
      @@conn ||= Faraday.new url: 'https://secure.accessacs.com/api_accessacs_mobile/v2/' + config['site_number'].to_s, ssl: {version: :SSLv3} do |builder|
        builder.request :basic_auth, config['username'], config['password']
        builder.response :rashify
        builder.response :json, :content_type => /\bjson$/
        # builder.adapter Faraday.default_adapter
        builder.adapter  :net_http_persistent
      end
    end
  end
end
