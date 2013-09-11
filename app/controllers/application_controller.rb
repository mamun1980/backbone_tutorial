
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :basic_authentication,:fetch_user,:fetch_qualifiers_from_header
  attr_accessor :http_username,:http_password,:http_fetch_qualifiers


    # credentials_from_basic_auth
    #
    # Params:
    # +b64auth_string+:: HTTP_AUTHENTICATION header (i.e. Basic zDjoad823892=)
    #
    def credentials_from_basic_auth(b64auth_string)
      
        # Grab the base 64 encoded string portion (exclude Basic Auth) 
        uid_pwd_string = b64auth_string[5,b64auth_string.length]
        
        # Did we find a base64 encoded string?
        if (uid_pwd_string)
          
            # decode the entire string
            uid_pwd_string = Base64.decode64(uid_pwd_string)
            
            # Find the : character within the uid:pwd string
            colon_seperator_indx = uid_pwd_string.index(":")
    
            # Create a hash table to store the "username" and "password"
            credentials_hash = Hash.new
            credentials_hash["username"] = uid_pwd_string[0,colon_seperator_indx]
            credentials_hash["password"] = uid_pwd_string[colon_seperator_indx+1,uid_pwd_string.length]
            
            return credentials_hash                
        end
    end
  
    def basic_authentication
        # Get the username and password from the Basic Auth header
        user_credentials=credentials_from_basic_auth(request.headers["HTTP_AUTHENTICATION"].to_s)
        
        # Set the http_username and password from the request
        if user_credentials
            if user_credentials["username"]
                @http_username = user_credentials["username"]
            end
            if user_credentials["password"]
                @http_password = user_credentials["password"]
            end
        end
        return user_credentials        
    end

  def fetch_qualifiers_from_header
        #puts ">>>>> FETCH QUAL METHOD CALLED"
        fq_header=request.headers["x-custom-fetch-qualifiers"]
        puts ">>> as_json= "+fq_header.to_s
  
        if (fq_header && fq_header != "null")
          as_json = JSON.parse(fq_header)
          @http_fetch_qualifiers = as_json
        else
          @http_fetch_qualifiers = nil
        end
  end    

  def fetch_user
    @http_user = User.first(:conditions=>["username = ? AND password = ?",@http_username, @http_password])

    if @http_user
        puts ">>>> BASE 64 AUTH SUCCESSFUL!"
    else
        puts ">>> http user not found"
    end        
  end
  
end
