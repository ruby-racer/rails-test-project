module DogBreeds
  def self.get
    begin
      JSON.parse(RestClient.get("https://dog.ceo/api/breeds/list/all").body)['message']
    rescue StandardError
      []
    end
  end
end
