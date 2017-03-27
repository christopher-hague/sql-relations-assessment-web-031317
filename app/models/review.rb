class Review
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    customer_id: "INTEGER",
    restaurant_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id


  # returns the customer of that review
  def customer
    sql = <<-SQL
      SELECT * FROM customers
      WHERE id = ?
    SQL

    self.class.db.execute(sql, self.customer_id)
  end

  # returns the restaurant of that particular review
  def restaurant
    sql = <<-SQL
      SELECT restaurant.name FROM customers INNER JOIN restaurants
      WHERE restaurant.id = ?
    SQL

    self.class.db.execute(sql, self.customer_id)
  end

end
