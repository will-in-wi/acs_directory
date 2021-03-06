module ACS
  class Individual < ACS::Request

    def self.find(indv_id)
      result = connection.get('individuals/' + indv_id.to_s)
      raise 'Bad response' unless result.status == 200
      result.body
    end

    def self.where(query)
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

      # Get all of the individual formats.
      individuals = []
      concat.each do |indv|
        puts indv.indv_id
        individuals << self.find(indv.indv_id)
      end

      individuals
    end

    def self.all
       self.where '%'
    end

  end
end
