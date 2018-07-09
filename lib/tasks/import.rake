namespace :import do
  desc "Import all breeds from API"
  task breeds: :environment do
    breeds, err = begin
      [JSON.parse(RestClient.get("https://dog.ceo/api/breeds/list/all")), nil]
    rescue => e
      [nil, e.message]
    end
    return p err if err || breeds["message"].blank?
    Breed.update_all(to_deleted: true)
    breeds["message"].each do |breed, subbreeds|
      DogBreedFetcher.fetch(breed)
      subbreeds.each do |subbreed|
        DogBreedFetcher.fetch("#{breed}/#{subbreed}")
      end
    end
    Breed.delete_all(to_deleted: true)
  end
end
