class UploadPhotoController < ApplicationController
  def new
    @upload_photo = UploadPhoto.new
  end
  
  # POST /upload_photo
  # POST /upload_photo.xml
  def create
    @upload_photo = UploadPhoto.new(params[:upload_photo])

    @upload_photo.user_id = 0 - @session_id.to_i # this will be updated when user logged in.
    @upload_photo.user_id = params[:user_id] unless params[:user_id].blank?

    if @upload_photo.save
		  render :text => @upload_photo.data.url(:medium).split('?').first  # @upload_photo.data.url(:thumb)
    else
      render :text => "ERROR WHILE UPLOADING IMAGE"
    end
  end

  def user_uploaded_photos
    logged_user_id = 0-@session_id.to_i
    logged_user_id = params[:user_id] unless params[:user_id].blank?

    @uploaded_photos = UploadPhoto.find_all_by_user_id(logged_user_id)

    respond_to do |format|
      format.html # user_uploaded_photos.html.erb
      format.xml  { render :xml => @uploaded_photos }
    end
  end
end
