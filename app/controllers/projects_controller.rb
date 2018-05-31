class ProjectsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json

  def index
    if current_user.user_type != "Developer"
      @projects = Project.all
    else
      @projects = current_user.projects
    end
    authorize @projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    authorize @project    
    @bugs = @project.bugs

    @project_users = @project.users
  end

  # GET /projects/new
  def new
    @project = Project.new
    @users = User.where(user_type: 'Developer')
    @project.user_projects.build

    authorize @project
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    @users = User.where(user_type: 'Developer')
    @project.user_projects.build
    authorize @project
    # @project.user_projects.build
  end

  def add_user
    @project = Project.find(params[:id])
    @users = User.where.not(user_type: "Manager")
    authorize @project

    if params[:user_id].present?
      UserProject.create!(user_id: params[:user_id], project_id: params[:id])
      flash[:notice] = "User Added Successfully."
    end
  end

  # POST /projects
  # POST /projects.json
  def create
      # if current_user.projects << @project
    @project = Project.new(project_params)


    authorize @project

    respond_to do |format|


      if @project.save!

        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    authorize @project    
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_path, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    authorize @project    
    @project.destroy
    authorize @project
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_project_user
    @project = Project.find(params[:id])

    @project.bugs.each do |bug|
      puts '----------------------'
      puts bug.developer_id.inspect
      puts params[:user_id].inspect
      puts (bug.developer_id == params[:user_id]).inspect
      puts '----------------------'



      if bug.developer_id.to_i == params[:user_id].to_i
        bug.update!(developer_id: nil)
      end
    end

  
    user_proj = UserProject.find_by(project_id: params[:id] , user_id: params[:user_id])
    if user_proj.destroy
      redirect_to @project
    end
    
    authorize @project
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
      authorize @project
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
       params.require(:project).permit(:name, user_projects_attributes: [[:user_id, :project_id]])
     end
end
