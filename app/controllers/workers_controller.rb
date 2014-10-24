class WorkersController < ApplicationController
 
  def index
  	
    @workers = Worker.all
    	
  	@panels = Worker.distinct.pluck(:panel)
  	
  	@fw = Worker.all.pluck(:email)
  	  	  	  	  	
  end
  
    def filter_workers

  	if params[:panels] && params[:panels] != ""
  		@workers = Worker.where(:panel => params[:panels])
  		@fw = Worker.where(:panel => params[:panels]).pluck(:email)
	else
    	@workers = Worker.all
		@fw = Worker.all.pluck(:email)
	end
    	
  	@panels = Worker.distinct.pluck(:panel)
  	  	
  	#@fw = Worker.where(:panel => params[:panels]).pluck(:email)
  
  	@abc = Worker.where(:id => params[:workers]).pluck(:email)
  	
  	render :partial => "filter_workers"
  	
  end
  
  def filter_workers_emails

  	  	
  	@abc = Worker.where(:id => params[:workers]).pluck(:email)
  	
  	render :partial => "filter_workers_emails"
  	
  end

  def new
  	@worker = Worker.new
  end

  def create
  	@worker = Worker.new(worker_params)
    if @worker.save
        redirect_to :action => 'show', :id => @worker.id
    else
        redirect_to worker_new_path, alert: "Error creating worker."
    end
  end

  def show
  	@worker = Worker.find(params[:id])
  end
  
  def edit
  	@worker = Worker.find(params[:id])
  end
  
  def update
  	worker = Worker.find(params[:id])
  	
  	worker.update(worker_params)
    
    if worker.save
        #redirect_to :action => 'show', :id => worker.id, alert: "Worker created successfully."
        #redirect_to :action => 'index', alert: "Worker update successfully."
        #redirect_to :controller => 'flash_teams', :action => 'panels', :id => 1, :event_id => 1
        redirect_to session.delete(:return_to)
    else
        redirect_to :action => 'edit', :id => worker.id, alert: "Error updating worker." 
    end
  end
  
   def destroy
  	worker = Worker.find(params[:id])
  	
  	worker.destroy
    
  	redirect_to workers_index_path, alert: "Worker destroyed successfully."

  end
  
  
  private

  def worker_params
    params.require(:worker).permit(:name, :email, :skype_username, :odesk_url, :timezone_utc, :additional_info, :panel)
  end

end
