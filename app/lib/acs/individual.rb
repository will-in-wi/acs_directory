module ACS
  class Individual < ACS::Request

    def self.find(indv_id)
      result = connection.get('individuals/' + indv_id.to_s)
      raise 'Bad response' unless result.status == 200
      result.body
    end

    def self.list(query = '%')
      # ACS enforces a maximum of 500, so we need multiple requests.
      result = connection.get 'individuals', q: query, pageSize: 500
      raise 'Bad response' unless result.status == 200

      concat = result.body.page

      if result.body.page_count > 1
        result.body.page_count.times do |i|
          result = connection.get 'individuals', q: query, pageSize: 500, pageIndex: i
          concat += result.body.page
        end
      end

      concat
    end

  end
end
