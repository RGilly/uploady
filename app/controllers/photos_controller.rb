class PhotosController < ApplicationController
	before_action :authenticate_user!

  def index
  	@photos = current_user.photos
  end

  def new
  	@photo = Photo.new
  end

  def create
  	#@photo = Photo.new(photo_params)
  	#@photo.user = current_user

  	@photo = current.user.photos.build(photo_params) 

  	#this is an alternate way that is commonly used in production


  	if @photo.save 
  		redirect_to photos_path
  	else
  		render :new
  	end
  end

  def edit
  	@photo = current_user.photos.find(params[:id])
  end

  def update
  	#have to retrieve data from databse to update
  	@photo = current_user.photos.find(params[:id])

  	if @photo.update_attributes(photo_params) #if photo able to update these attributes
  		redirect_to photos_path
  	else
  		render :edit
  	end
  end

  private

  def photo_params
  	params.require(:photo).permit(:filename, :caption)
  end
end
