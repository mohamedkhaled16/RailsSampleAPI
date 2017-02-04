class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

skip_before_filter :verify_authenticity_token, only: [:apicreate]

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.all
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
def apicreate
	respond_to do |format|
		notification = Notification.new

		if(params.has_key?(:token) && params.has_key?(:other))
			@token = params[:token]
			@other = params[:other]
			if @token != ""
				notification.token = @token
				notification.other = @other
				if notification.save
					format.json { render :json => {:status=> "200"} }
				end
			else
				format.json { render :json => {:status=> "0",:message=>'token cannot be empty'} }			
			end
		elsif params.has_key?(:token)
			@token = params[:token]
			if @token != ""
				notification.token = @token
				notification.other = "not set"
				if notification.save
					format.json { render :json => {:status=> "200"} }
				end
			else
			format.json { render :json => {:status=> "0",:message=>'token cannot be empty'} }
			end
		else
			format.json { render :json => {:status=> "0",:message=>'token must be exist'} }	
		end
		
		format.json { render :json => {:status=> "0",:message=>'token must be exist..nothing sent Or nothing saved'} }	
	end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:token, :other)
    end
end
