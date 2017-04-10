class SubjectsController < ApplicationController

    layout 'admin'
    
    before_action :set_subject_count, :only => [:edit, :new, :create, :update]

    def index
        @subjects = Subject.sorted
    end

    def show
        @subject = Subject.find(params[:id])
    end

    def new
        @subject = Subject.new({:name => "Default"})
    end

    def create
        @subject = Subject.new(subject_params)
        if @subject.save
            redirect_to(subjects_path) 
            flash[:notice] = "subject '#{@subject.name}'  created sucessfully."
        else
            render('new') 
        end
    end


    def edit
        @subject = Subject.find(params[:id])

    end

    def update

        @subject = Subject.find(params[:id])

        if @subject.update_attributes(subject_params)
            redirect_to ({:action => :show, :id => @subject.id})
            flash[:notice] = "subject '#{@subject.name}' updated sucessfully."
        else
            render('edit')  
        end
    end

    def delete
        @subject = Subject.find(params[:id])
    end

    def destroy
        @subject = Subject.find(params[:id])
        @subject.destroy
        redirect_to(subjects_path)
        flash[:notice] = "subject '#{@subject.name}' deleted sucessfully."
    end

    private 

    def subject_params
        params.require(:subject).permit(:name, :position, :visible, :created_at)
    end
    
     def set_subject_count
         @subject_count = Subject.count
         if params[:action] == 'new' || params[:action] == 'create'
             @subject_count += 1
         end
     end   


end
