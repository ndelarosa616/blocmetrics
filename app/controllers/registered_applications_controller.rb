class RegisteredApplicationsController < ApplicationController

  def index
    @registered_applications = current_user.registered_applications.all
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def create 
    @registered_application = current_user.registered_applications.build(registered_applications_params)

    if @registered_application.save
      redirect_to registered_applications_path
    else
      flash[:error] = "Error saving application, please try again!"
      render :new
    end
  end

  def edit
  end

  def destroy
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.destroy
      flash[:notice] = "This application has been unregistered."
      redirect_to registered_applications_path
    else
      flash[:error] = "This application could not be unregistered. Please try again."
    end
  end

  private

  def registered_applications_params
    params.require(:registered_application).permit(:name, :url)
  end
end
