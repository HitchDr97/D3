require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'

def write_table(t, f, power)
	row = 0
	col = 0
	maxrow = 2**power
	html = "<table>"
	html += "<tr>\n"

	x = power-1
	while x>-1
		html += "<th>"+x.to_s+"</th>\n"
		x = x -1
	end
	html += "<th>AND</th>\n"
	html += "<th>OR</th>\n"
	html += "<th>XOR</th>\n"
	html += "</tr>\n"

	while row < maxrow
		html += "<tr>\n"
		col = 0

		rowtotal = 0
		while col < power
			
			if row & 2**(power-col-1) == 0

				html += "<td>"+f+"</td>\n"
			else
				rowtotal += 1

				html += "<td>"+t+"</td>\n"
			
			end
			col += 1
		end
		#logical results
		if rowtotal == power
			html += "<td>"+t+"</td>\n"
		else
			html += "<td>"+f+"</td>\n"
		end
		if rowtotal > 0
			html += "<td>"+t+"</td>\n"
		else
			html += "<td>"+f+"</td>\n"
		end
		if rowtotal == 1
			html += "<td>"+t+"</td>\n"
		else
			html += "<td>"+f+"</td>\n"
		end

		row += 1
		html += "</tr>\n"
	end
	puts html
	html+= "</table>\n"
end

# If a GET request comes in at /, do the following.

	get '/' do
	  # Get the parameters named guess and store it in pg
	  
	
	  erb :index
	  end

	
	get "/solved" do
	  t = params['truth']
	  f = params['fals']
	  powers = params['power']
	  power = powers.to_i
	 
	  if t.empty?
		t= 'T'
	  end
	  if f.empty?
		f= 'F'
	  end
	  if powers.empty?

		power = 3
	  end
	  if t.length > 1
		erb :wronginfo
	  elsif f.length > 1
		erb :wronginfo
	 elsif t.eql? f
      erb :wronginfo
	  elsif power < 3 || !powers.scan(/\D/).empty?
		erb :wronginfo
	  else
		 code = write_table(t, f, power)
		 puts code
		erb :solved, :locals => { code: code }
	 end
	 

	 
	 
	end
	 # 404 Error!
	not_found do
		  status 404
		  erb :filenotfound
		end