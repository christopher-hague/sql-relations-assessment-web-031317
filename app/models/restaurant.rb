class Restaurant
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    location: "TEXT",
    owner_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  # returns the owner of that restaurant
  def owner
    sql = <<-SQL
      SELECT * FROM OWNERS
      WHERE id = ?
    SQL

    self.class.db.execute(sql, self.owner_id)
  end
end
