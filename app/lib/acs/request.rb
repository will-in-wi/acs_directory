module ACS
  class Request
    def self.config
      @@config ||= Rails.configuration.acs_credentials
    end

    def self.connection
      # Note, as of 2014-07-16, ACS only supports :SSLv3 and :TLSv1.
      # Some servers (cough, webfaction) will fail to connect if this is not forced.
      @@conn ||= Faraday.new url: 'https://secure.accessacs.com/api_accessacs_mobile/v2/' + config['site_number'].to_s, ssl: {version: :TLSv1} do |builder|
        builder.request :basic_auth, config['username'], config['password']
        builder.response :rashify
        builder.response :json, :content_type => /\bjson$/
        # builder.adapter Faraday.default_adapter
        builder.adapter  :net_http_persistent
      end
    end
  end
end
