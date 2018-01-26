module ContactsController

def contacts_index_action
  if input_option == "1"
    response = Unirest.get("http://localhost:3000/contacts")
    contacts = response.body
    puts JSON.pretty_generate(contacts)
  end 
end

def contacts_show_action
  print "Enter a contact id: "
  input_id = gets.chomp

  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
  contact = response.body
  puts JSON.pretty_generate(contact)
end 

def contacts_create_action
  puts "Enter information for a new contact"
  client_params = {}

  print "First Name: "
  client_params[:first_name] = gets.chomp

  print "Middle Name: "
  client_params[:middle_name] = gets.chomp

  print "Last Name: "
  client_params[:last_name] = gets.chomp

  print "Email: "
  client_params[:email] = gets.chomp

  print "Bio: "
  client_params[:bio] = gets.chomp

  print "Phone Number: "
  client_params[:phone_number] = gets.chomp

  response = Unirest.post(
                          "http://localhost:3000/contacts",
                          parameters: client_params
                          )
  if response.code == 200
    contact = response.body
    puts JSON.pretty_generate(contact)
  else
    errors = response.body["errors"]
    puts
    puts "Your contact did not save"
    puts "please look at the following reasons"
    puts "------------------------------------"
    errors.each do |error|
      puts error
  end
end

def contacts_update_action
  print "Enter a contact id: "
  input_id = gets.chomp

  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
  contact = response.body

  puts "Enter new information for contact ##{input_id}"
  client_params = {}

  print "First Name (#{contact["first_name"]}): "
  client_params[:first_name] = gets.chomp

  print "Middle Name (#{contact["middle_name"]}): "
  client_params[:middle_name] = gets.chomp

  print "Last Name (#{contact["last_name"]}): "
  client_params[:last_name] = gets.chomp

  print "Email (#{contact["email"]}): "
  client_params[:email] = gets.chomp

  print "Bio (#{contact["bio"]}): "
  client_params[:bio] = gets.chomp

  print "Phone Number (#{contact["phone_number"]}): "
  client_params[:phone_number] = gets.chomp

  client_params.delete_if {|key, value| value.empty? }

  response = Unirest.patch(
                          "http://localhost:3000/contacts/#{input_id}",
                          parameters: client_params
                          )

  if response.code == 200
    contact = response.body
    puts JSON.pretty_generate(contact)
  else
    errors = response.body["errors"]
    puts
    puts "Your contact did not update"
    puts "please look at the following reasons"
    puts "------------------------------------"
    errors.each do |error|
      puts error
  end
end

  def contacts_destroy_action
    print "Enter a contact id that you want to delete: "
    input_id = gets.chomp

    response = Unirest.delete("http://localhost:3000/contacts/#{input_id}")
    data = response.body
    puts data["message"]
  end
end
