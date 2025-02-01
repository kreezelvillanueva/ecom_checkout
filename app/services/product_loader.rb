require 'json'

class ProductLoader
  def self.load_products_from_file(file)
    return [] unless file.respond_to?(:read)

    json_data = file.read
    products = JSON.parse(json_data, symbolize_names: true)

    products.each do |product_data|
      Product.find_or_create_by(uuid: product_data[:uuid]) do |product|
        product.name = product_data[:name]
        product.price = product_data[:price].to_d
      end
    end

    products
  rescue JSON::ParserError
    []
  end
end
