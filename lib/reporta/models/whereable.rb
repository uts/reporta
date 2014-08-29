module Reporta
  module Whereable 
    

    def to_sql_where
      parts = []
      each_pair do |key, value|
        next unless allowed?(key)
        parts << "(" + query_from(key,value) + ")"
      end
      parts.join(' and ')
    end

    protected
    # define this method in your class
    #def query_from(key, value)
    #  e.g. status = 'active'
    #  "#{key} = #{quote(value)}" 
    #end

    # define this method in your class
    #def allowed?(key)
    #  true
    #end

    private
    def quote(value) 
      ActiveRecord::Base.connection.quote(value)
    end
   
  end
end
