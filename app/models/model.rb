# this is a simple model example
# check https://datamapper.org/getting-started.html
class History
	include DataMapper::Resource
	property :id,         	    Serial     
	property :created_at, 		Date  	  
	property :from_To,         	String 	
	property :amount,      	 	Float     
	property :result,     	  	Float    
end
class GetResultValue
	def initialize(fromTo,amount)
		@conversion = from_To
		@amount =amount 
	end
	def getResult
		mclb = Money::Bank::CurrencylayerBank.new
		mclb.access_key = '396ad1ecb91c32515bb1d716c0e03f21' 
		mclb.update_rates 
		responseUsdEur = mclb.get_rate('USD', 'EUR')
		if @conversion[0,3]=="USD"
			return @amount*responseUsdEur
		elsif @conversion[0,3]=="CHF"
			responseUsdChf = mclb.get_rate('USD', 'CHF')
			return @amount*responseUsdEur/responseUsdChf
		else
			if @conversion[4,7]=="USD"
				return @amount/responseUsdEur
			else
				responseUsdChf = mclb.get_rate('USD', 'CHF')
				return @amount*responseUsdChf/responseUsdEur
			end
		end
	end
end