# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Product.destroy_all

Product.create!([{
    name: "book",
    price: 1249,
    imported: false
},
{
    name: "music CD",
    price: 1499,
    imported: false
},
{
    name: "chocolate bar",
    price: 85,
    imported: false
},
{
    name: "imported chocolates",
    price: 1000,
    imported: true
},
{
    name: "perfume",
    price: 4750,
    imported: true
},
{
    name: "imported bottle perfume",
    price: 2799,
    imported: true
},
{
    name: "bottle perfume",
    price: 1899,
    imported: false
},
{
    name: "headache pills",
    price: 975,
    imported: false
},
{
    name: "imported chocolates",
    price: 1125,
    imported: true
}])

p "Created #{Product.count} products"
