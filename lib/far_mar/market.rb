module FarMar
  class Market
    attr_reader :id, :name, :address, :city, :county, :state, :zip

    def initialize(market_hash)
      @id = market_hash[:id].to_i
      @name = market_hash[:name]
      @address = market_hash[:address]
      @city = market_hash[:city]
      @county = market_hash[:county]
      @state = market_hash[:state]
      @zip = market_hash[:zip]
    end

    def self.all
      # if @@all_markets is nil, reads the csv and creates the array
      # otherwise uses array already in memory
      @@all_markets ||= CSV.read('./support/markets.csv').map do |col|
         FarMar::Market.new({
          id: col[0],
          name: col[1],
          address: col[2],
          city: col[3],
          county: col[4],
          state: col[5],
          zip: col[6]
        })
      end
    end

    def self.find(id)
      # can use all without self (all.find instead of self.all.find) because already in the class scope
      all.find do |market|
        market.id == id
      end
    end

    def vendors
    #  returns a collection of FarMar::Vendor instances
    #  that are associated with the market by the market_id field.
      FarMar::Vendor.all.find_all do |vendor|
        vendor.market_id == @id
      end
    end


  end
end
