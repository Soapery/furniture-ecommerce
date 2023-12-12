require "csv"

# Clearing existing records for re-seeding
User.delete_all
Province.delete_all
ProductVariation.delete_all
ProductPattern.delete_all
Product.delete_all
Order.delete_all
OrderProduct.delete_all

# Resetting PK on tables
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='users';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='provinces';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='product_variations';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='product_patterns';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='products';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='orders';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='order_products';")

# Retrieving CSV Data
filename = Rails.root.join("db/housewares.csv")
puts "Loading Products from the CSV file: #{filename}"

# Province data
provinces = [
  {
    :name => "Alberta",
    :gst =>  0.05,
    :pst => nil,
    :hst => nil
  },
  {
    :name => "British Columbia",
    :gst => 0.05,
    :pst => 0.07,
    :hst => nil
  },
  {
    :name => "Manitoba",
    :gst => 0.05,
    :pst => 0.07,
    :hst => nil
  },
  {
    :name => "New Brunswick",
    :gst => 0.05,
    :pst => nil,
    :hst => nil
  },
  {
    :name => "Newfoundland and Labrador",
    :gst => nil,
    :pst => nil,
    :hst => 0.15
  },
  {
    :name => "Northwest Territories",
    :gst => 0.05,
    :pst => nil,
    :hst => nil
  },
  {
    :name => "Nova Scotia",
    :gst => nil,
    :pst => nil,
    :hst => 0.15
  },
  {
    :name => "Nunavut",
    :gst => 0.05,
    :pst => nil,
    :hst => nil
  },
  {
    :name => "Ontario",
    :gst => nil,
    :pst => nil,
    :hst => 0.13
  },
  {
    :name => "Prince Edward Island",
    :gst => nil,
    :pst => nil,
    :hst => 0.15
  },
  {
    :name => "Quebec",
    :gst => 0.05,
    :pst => 0.09975,
    :hst => nil
  },
  {
    :name => "Saskatchewan",
    :gst => 0.05,
    :pst => 0.06,
    :hst => nil
  },
  {
    :name => "Yukon",
    :gst => 0.05,
    :pst => nil,
    :hst => nil
  },
]

provinces.map{ |province|
  puts province
  Province.create(
    name: province[:name],
    gst:  province[:gst],
    pst:  province[:pst],
    hst:  province[:hst]
  )
}

# Populating Products table
# Encoding in UTF-8 while removing BOM
CSV.foreach(filename, 'r:BOM|UTF-8', headers: true) do |row|
  # Replaces "NA" values with equivalent values
  product = Product.find_or_create_by(
    name:    row["Name"],
    outdoor: row["Outdoor"] == "Yes",
    on_sale: 0
  ) do |new_product|
    new_product.price = Faker::Commerce.price # Set the price only if the product is newly created
  end

  unless row["Variation"] == "NA"
    variation = product.product_variations.find_or_create_by(variation_name: row["Variation"])
    puts variation.inspect
  end

  unless row["Pattern"] == "NA"
    pattern = product.product_patterns.find_or_create_by(pattern_name: row["Pattern"])
    puts pattern.inspect
  end

  puts product.inspect
end