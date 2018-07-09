namespace :import do
  desc "Import all breeds from API"
  task breeds: :environment do
    breeds, err = begin
      [JSON.parse(RestClient.get("https://dog.ceo/api/breeds/list/all"))["message"], nil]
    rescue => e
      [nil, e.message]
    end
    return p err if err || breeds.blank?
    Breed.update_all(to_delete: true)
    breeds.each do |breed, subbreeds|
      if subbreeds.blank?
        DogBreedFetcher.fetch(breed)
        next
      end
      subbreeds.each do |subbreed|
        DogBreedFetcher.fetch("#{breed}/#{subbreed}")
      end
    end
    Breed.delete_all(to_delete: true)
  end
end
