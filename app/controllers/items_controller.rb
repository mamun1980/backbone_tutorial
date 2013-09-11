class ItemsController < ApplicationController

  # GET /items
  # GET /items.xml
  def index
    @items = Item.all
    render :json => @items
  end


  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])
    render :json => @item
  end


  # GET /items/new
  # GET /items/new.xml
  def new
    if @http_user
        @item = Item.new
        render :json => @item
    else
        render :text=>"", :status => 401        
    end
  end


  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end


  # POST /items
  # POST /items.xml
  def create
    if @http_user
        @item = Item.new(:part1=>params[:part1],:part2=>params[:part2])
        @item.save
        render :json => @item
    else
        render :text=>"", :status => 401
    end
  end


  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])
    @item.update_attributes(:part1=>params[:part1],:part2=>params[:part2])
    @item.save
    render :json => @item
  end


  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end


end
