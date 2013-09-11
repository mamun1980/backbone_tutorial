
class UsersController < ApplicationController 
  
  # GET /users
  # GET /users.json
  def index
    
    if @http_fetch_qualifiers && @http_fetch_qualifiers["username"]
          uid = @http_fetch_qualifiers["username"]
          pwd = @http_fetch_qualifiers["password"]

          @users = User.find(:all, :conditions=>["username = ? AND password = ?",uid,pwd])
          if @users.count > 0
              render :json => @users
          else
              render :text => "",  :status => 401
          end          
    else
          render :text => "",  :status => 401
    end   
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    render :json => @user    
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    render :json => @user
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.first(:conditions=>["username = ?",params[:username]])
  
    puts ">>>> lookup user = " + @user.to_s
  
    if !@user
          @user = User.new(:username=>params[:username],:password=>params[:password])
          @user.save
          render :json => @user      
    else
          render :text => "",  :status => 401
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @user.update_attributes(:username=>params[:username],:password=>params[:password])
    @user.save
    render :json => @user    
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    head :ok
  end

end
