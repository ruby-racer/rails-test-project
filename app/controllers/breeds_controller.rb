class BreedsController < ApplicationController
  include BreedsHelper

  def index
    @breeds = Rails.cache.fetch('breeds', expires_in: 1.hour) do
      parse_response(DogBreeds.get)
    end
  end

  def show
    @breed = DogBreedFetcher.fetch(params[:id].gsub("-", "/"))
  end

  private

  def parse_response(breeds)
    parsed_breeds = []
    breeds.each do |breed, subbreeds|
      if subbreeds.blank?
        parsed_breeds << breed
        next
      end
      subbreeds.each do |subbreed|
        parsed_breeds << "#{breed}/#{subbreed}"
      end
    end
    parsed_breeds
  end
end
