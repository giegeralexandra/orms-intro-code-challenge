class Listing
    # Listing belongs to Agent
    attr_reader :location
    attr_accessor :status, :price, :agent

    @@all = []

    def initialize(location, price, status="for sale", agent)
        @location = location
        @price = price
        @status = status
        @agent = agent 
        @@all << self
    end

    def price_drop(percentage)
        self.price -= self.price*percentage
    end

    def self.all
        sql = <<-SQL 
        SELECT * FROM listings 
        SQL

        DB[:conn].execute(sql).map{|row| row }
    end

    def self.create_table
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS listings (
          id INTEGER PRIMARY KEY,
          location TEXT,
          price INTEGER,
          status TEXT,
          agent INTEGER
        )
        SQL
    
        DB[:conn].execute(sql)
    end

    def save
        sql = <<-SQL
          INSERT INTO listings (location, price, status, agent) 
          VALUES (?, ?, ?, ?)
        SQL
    
        DB[:conn].execute(sql, self.location, self.price, self.status, self.agent)
    end


end