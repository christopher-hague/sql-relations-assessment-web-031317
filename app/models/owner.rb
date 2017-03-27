class Owner
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods
  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  # returns all restaurants belonging to that owner
  def restaurants
    sql = <<-SQL
      SELECT * FROM restaurants
      WHERE restaurant_id = ?
    SQL
    self.class.db.execute(sql, self.restaurant_id)
  end
end
