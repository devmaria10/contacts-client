require 'unirest'
require_relative 'controllers/contacts_controller'
require_relative 'views/contacts_views'
require_relative 'models/contact'

class Frontend
  include ProductsController
  include ProductsViews

  def run
    system "clear"

puts "You have engaged your Contacts Program"
puts "Please, choose an option: "
puts "      [1] Show all contacts"
puts "          [1.1] Search contacts by name"
puts "      [2] Show one contact"
puts "      [3] Create a new contact"
puts "      [4] Update a contact"
puts "      [5] Destroy a contact"

input_option = gets.chomp

if input_option == "1"
  contacts_index_action
elsif input_option == "1.1"
  print "Enter a name to search by: "
  input_name = gets.chomp
  response = Unirest.get("http://localhost:3000/contacts?search=#{input_name}")
  contacts = response.body
  puts JSON.pretty_generate(contacts)
elsif input_option == "2"
  contacts_show_action
elsif input_option == "3"
  contacts_create_action
elsif input_action == "4"
  contacts_update_action
elsif input_action == "5"
  contacts_destroy_action


  end
end 
