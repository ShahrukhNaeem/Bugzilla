class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bug, only: [:show, :edit, :update, :destroy]

  # GET /bugs
  # GET /bugs.json
  def index
    
    if current_user.user_type != "Developer"
      @bugs = Bug.all
      authorize @bugs
    ##### showing assigned project bugs of all users ###########
    else
      @bugs = Array.new
      current_user.projects.find_each do |project|
        project.bugs.each do |bug|
          @bugs << bug
        end
      end
    end
    @bugs.each do |bug|
      authorize bug
    end

    # respond_to  do  |format|
    #         format.html {render :index }
    #             format.json { render  :index }
            
    #     end

    # to show current user assigned project bugs
    # else
    #   @bugs = current_user.resolved_bugs #resolved bugs method defined in User model :P
    #   authorize @bugs
    # end
  end

  # GET /bugs/1
  # GET /bugs/1.json
  def show  
#    @project
  end


  # GET /bugs/new
  def new
    
    if current_user.user_type != "Developer"
      @projects = Project.all
    else
      @projects = current_user.projects
    end
    
    @bug = Bug.new
    @bug_types = ["feature","bug"]

    @assign_bugs_to_users = User.all
    authorize @bug
    
  end

  # GET /bugs/1/edit
  def edit
    if current_user.user_type != "Developer"
      @projects = Project.all
    else
      @projects = current_user.projects
    end
    @bug_types = ["feature","bug"]

     @assign_bugs_to_users = User.all    
  end

  # POST /bugs
  # POST /bugs.json
  def create
    @bug = Bug.new(bug_params)
    @bug.user_id = current_user.id
    authorize @bug

    if @bug.save
      redirect_to @bug, notice: 'Bug was successfully created.'
    else
      redirect_to new_bug_path, flash: {danger: @bug.errors.full_messages }
    end
  end

  def assign_bug

    @bug = Bug.find(params[:id])
    authorize @bug

    @bug.developer_id = current_user.id
    @bug.status = "started"

    if @bug.save
      render json: { message: "Succesfully Assigned.",name: current_user.name , status: 200}.to_json
    else
      render json: { message: "Error occured.", status: 500}
    end

  end

  def resolved_bug
    @bug = Bug.find(params[:id])
    authorize @bug
    @bug.status = "completed"

    if @bug.save
      render json: { message: "Bug Resolved.", status: 200}.to_json
    else
      render json: { message: "Error Occured.", status: 500}
    end

  end

  # PATCH/PUT /bugs/1
  # PATCH/PUT /bugs/1.json
  def update
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to @bug, notice: 'Bug was successfully updated.' }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1
  # DELETE /bugs/1.json
  def destroy
    @bug.destroy
    respond_to do |format|
      format.html { redirect_to bugs_url, notice: 'Bug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params[:id])
      authorize @bug
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bug_params
      params.require(:bug).permit(:title, :deadline, :screenshot, :status, :bug_type, :user_id, :developer_id, :project_id)
    end
end