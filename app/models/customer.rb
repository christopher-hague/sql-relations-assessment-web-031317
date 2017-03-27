class Customer
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    birth_year: "INTEGER",
    hometown: "TEXT"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  # returns all of the reviews written by that customer
  def reviews
    sql = <<-SQL
      SELECT * FROM reviews
      WHERE id = ?
    SQL

    self.class.db.execute(sql, self.reviews_id)
  end

  def restaurants
    sql = <<-SQL
      SELECT * FROM restaurants INNER JOIN reviews
      ON reviews.restaurant_id = restaurants.id
      WHERE reviews.customer_id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end
end
