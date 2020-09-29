class Agent
    # Agent has many Listings
    attr_reader :name
    attr_accessor :telephone, :yrs_experience

    def initialize(name, telephone, yrs_experience)
      @name = name 
      @telephone = telephone 
      @yrs_experience = yrs_experience
    end   

    def listings 
      Listing.all.select {|listing| listing.agent == self}
    end   

    def add_listing(location, price, status)
      new_listing = Listing.new(location, price, status)
      new_listing.agent = self
    end   

    def self.create_table
      sql = <<-SQL
      CREATE TABLE IF NOT EXISTS agents (
        id INTEGER PRIMARY KEY,
        name TEXT,
        telephone INTEGER,
        yrs_experience INTEGER
      )
      SQL
  
      DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO agents (name, telephone, yrs_experience) 
      VALUES (?, ?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.telephone, self.yrs_experience)
  end

  end  