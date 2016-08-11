class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find params[:id]
  end
  def create
    @project = Project.new(project_parmas)
    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      flash.now[:alert] = "Project has not been created."
      render "new"
    end
  end

  def edit
    @project = Project.find params[:id]
  end

  def update
    @project = Project.find params[:id]
    if @project.update(project_parmas)
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash.now[:alert] = "Project has not been updated."
      render "edit"
    end
  end

  def destroy
    @project = Project.find params[:id]
    @project.destroy
    flash[:notice] = "Project has been deleted."
    redirect_to projects_path
  end

  private

  def project_parmas
    params.require(:project).permit(:name,:description)
  end

end