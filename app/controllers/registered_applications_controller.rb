class RegisteredApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_registered_application, only: [:show, :edit, :update, :destroy]
  
  def index
    @registered_applications = current_user.registered_applications.all
  end

  def show
    @events = @registered_application.events.group_by(&:name)
  end

  def new
    @registered_application = RegisteredApplication.new  
  end

  def create
    @registered_application = current_user.registered_applications.new(registered_application_params)
    if @registered_application.save
      flash[:notice] = "Application was saved successfully."
      redirect_to registered_applications_path
    else
      flash[:error] = "Error creating application. Please try again."
      render :new
    end  
  end
  
  def edit    
  end
  
  def update
    if @registered_application.update_attributes(registered_application_params)
      flash[:notice] = "Application was updated successfully."
      redirect_to registered_applications_path
    else
      flash[:error] = "Error saving application. Please try again."
      render :edit
    end    
  end
  
  def destroy
    name = @registered_application.name  
    if @registered_application.destroy
      flash[:notice] = "#{name} was deleted successfully."
      redirect_to registered_applications_path
    else
      flash[:error] = "There was an error deleting the application. Please try again."
      render :show
    end    
  end
  
  private
  
  def set_registered_application
    @registered_application = RegisteredApplication.find(params[:id])
  end
  
  def registered_application_params
    params.require(:registered_application).permit(:name, :url)
  end
  
end
