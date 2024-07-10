require "sqlite3"
require "tty-table"

db = SQLite3::Database.open "shop_manager.db"
db.execute "CREATE TABLE IF NOT EXISTS items(id INTEGER PRIMARY KEY, name TEXT, type TEXT, price INTEGER, perishable INTEGER, stock INTEGER)"

while true
  system "clear"
  results = db.query "SELECT * FROM items"
  header = ["id", "name", "type", "price", "perishable", "stock"]
  rows = results.to_a
  table = TTY::Table.new header, rows
  puts "INVENTORY (Total: #{rows.length})"
  puts table.render(:unicode)
  puts
  print "[A]dd | [R]emove | [S]tock | [P]rice | [E]xit: "
  choice = gets.chomp.downcase
  if choice == "a"
    print "Enter item ID: "
    id = gets.chomp.to_i
    print "Enter item name: "
    name = gets.chomp.capitalize
    print "Enter item category: "
    type = gets.chomp.capitalize
    print "Enter item price: "
    price = gets.chomp.to_f.round(2)
    puts "Is this item perishable?: [Y]es or [N]o"
    perish = gets.chomp.downcase
    if perish == "y"
      perish = 1
    else
      perish = 0
    end
    print "Enter item stock: "
    stock = gets.chomp.to_i
    db.execute "INSERT INTO items (id, name, type, price, perishable, stock) VALUES (?, ?, ?, ?, ?, ?)", [id, name, type, price, perish, stock]
  elsif choice == "r"
    print "Enter item ID that you'd like to remove: "
    id = gets.chomp.to_i
    db.execute "DELETE FROM items WHERE id = ?", id
  elsif choice == "s"
    print "Enter item ID that you'd like to change stock: "
    id = gets.chomp.to_i
    print "Enter updated stock: "
    stock = gets.chomp.to_i
    db.execute "UPDATE items SET stock = ? WHERE id = ?", [stock, id]
  elsif choice == "p"
    print "Enter item ID that you'd like to change price: "
    id = gets.chomp.to_i
    print "Enter updated price: "
    price = gets.chomp.to_f.round(2)
    db.execute "UPDATE items SET price = ? WHERE id = ?", [price, id]
  elsif choice == "e"
    system "clear"
    return
  end
end
