module BreedsHelper
  def friendly_name(name)
    name.split("/").reverse.map(&:capitalize).join(" ")
  end
end
