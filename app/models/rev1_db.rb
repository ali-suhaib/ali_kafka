class Rev1DB < ActiveRecord::Base
  establish_connection(:rev1)

  def self.integrated_hotels(account_ids)
    rev1 = Rev1DB.connection
    hotels = rev1.exec_query("select * from Hotels where settings#>> '{enabled}' IN ('true') AND settings#>> '{type}' IN ('damn') AND account_id IN (#{ account_ids.map(&:to_i).join(',') })").rows
    rev1.close
    hotels
  end

  def self.api_token(hotel_id)
    rev1 = Rev1DB.connection
    api_token = rev1.exec_query("select token from api_tokens where hotel_id = #{hotel_id}").first["token"]
    rev1.close
    api_token
  end
end
