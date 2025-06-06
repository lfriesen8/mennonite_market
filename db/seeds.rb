require 'faker'

# Creating the About Us page
Page.find_or_create_by!(slug: "about") do |page|
  page.title = "About Us"
  page.content = "This is the About page. Edit it in ActiveAdmin."
end

# Creating the Contact Us page
Page.find_or_create_by!(slug: "contact") do |page|
  page.title = "Contact Us"
  page.content = "This is the Contact page. Edit it in ActiveAdmin."
end

Province.create([
  { name: "Alberta", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "British Columbia", gst: 0.05, pst: 0.07, hst: 0.00 },
  { name: "Manitoba", gst: 0.05, pst: 0.07, hst: 0.00 },
  { name: "New Brunswick", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Newfoundland and Labrador", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Northwest Territories", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "Nova Scotia", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Nunavut", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "Ontario", gst: 0.00, pst: 0.00, hst: 0.13 },
  { name: "Prince Edward Island", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Quebec", gst: 0.05, pst: 0.09975, hst: 0.00 },
  { name: "Saskatchewan", gst: 0.05, pst: 0.06, hst: 0.00 },
  { name: "Yukon", gst: 0.05, pst: 0.00, hst: 0.00 }
])


# Creating Categories
Category.create([
  { name: 'Traditional Mennonite Baked Goods' },
  { name: 'Homemade Jams and Preserves' },
  { name: 'Fresh and Dried Meats' },
  { name: 'Bulk Pantry Staples' },
  { name: 'Specialty Dairy' },
  { name: 'Seasonal Mennonite Holiday Treats' }
])

# Fetch all categories into a variable
categories = Category.all

# Add 10 product entries with categories
Product.create([
  { name: 'Farmer Sausage', description: 'A delicious homemade sausage.', price: 10.99, stock_quantity: 50, category_id: Category.find_by(name: 'Fresh and Dried Meats').id },
  { name: 'Zwieback', description: 'Traditional Mennonite sweet bread.', price: 5.99, stock_quantity: 30, category_id: Category.find_by(name: 'Traditional Mennonite Baked Goods').id },
  { name: 'Platz', description: 'A delicious, sweet pastry often served at gatherings.', price: 7.99, stock_quantity: 40, category_id: Category.find_by(name: 'Traditional Mennonite Baked Goods').id },
  { name: 'Roll Kuchen', description: 'A sweet fried dough snack, perfect for any meal.', price: 6.49, stock_quantity: 35, category_id: Category.find_by(name: 'Traditional Mennonite Baked Goods').id },
  { name: 'Paska', description: 'A special bread for Easter celebrations.', price: 8.99, stock_quantity: 20, category_id: Category.find_by(name: 'Traditional Mennonite Baked Goods').id },
  { name: 'Saskatoon Berry Jam', description: 'Homemade jam made with saskatoon berries.', price: 4.99, stock_quantity: 50, category_id: Category.find_by(name: 'Homemade Jams and Preserves').id },
  { name: 'Apple Butter', description: 'A sweet and tangy homemade spread.', price: 5.49, stock_quantity: 45, category_id: Category.find_by(name: 'Homemade Jams and Preserves').id },
  { name: 'Chokecherry Syrup', description: 'Sweet syrup made from chokecherries.', price: 6.99, stock_quantity: 30, category_id: Category.find_by(name: 'Homemade Jams and Preserves').id },
  { name: 'Schmaunt Fat', description: 'A Mennonite specialty dairy product, perfect for baking.', price: 3.99, stock_quantity: 25, category_id: Category.find_by(name: 'Specialty Dairy').id },
  { name: 'Cheese Curds', description: 'Fresh, squeaky cheese curds.', price: 4.99, stock_quantity: 60, category_id: Category.find_by(name: 'Specialty Dairy').id }
])

# Add 100 product entries using Faker with relevant categories
100.times do
  category = categories.sample  # Select a random category

  product_name = Faker::Food.dish  # Random food dish names

  # Check if the product already exists to avoid duplicates
  next if Product.exists?(name: product_name)  # Skip if product already exists

  # Create the product with Faker-generated data
  Product.create!(
    name: product_name,
    description: Faker::Food.description,  # Random descriptions
    price: Faker::Commerce.price(range: 5..50.0),  # Random price between $5 and $50
    stock_quantity: Faker::Number.between(from: 10, to: 100),  # Random stock quantity between 10 and 100
    category: category,  # Assign random category from the existing ones
    image: nil,  # Remove image for now (you can later assign an actual image file if needed)
    sale: false
  )
end
  