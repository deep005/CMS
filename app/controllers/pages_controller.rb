class PagesController < ApplicationController

    layout 'admin'
    before_action :find_subjects, :only => [:new, :create, :edit, :update]
    before_action :set_page_count, :only => [:edit, :new, :create, :update]
    
    def index
        @pages = Page.sorted
    end

    def show
        @page = Page.find(params[:id])
    end

    def new
        @page = Page.new
    end

    def create
        @page = Page.new(page_params)
        if @page.save
            flash[:notice] =  "Page '#{@page.name}'  created sucessfully."
            redirect_to(pages_path) 
        else
            render('new') 
        end
    end

    def edit
        @page = Page.find(params[:id])
    end

    def update
        @page = Page.find(params[:id])

        if @page.update_attributes(page_params)
            flash[:notice] = "Page '#{@page.name}' updated sucessfully."
            redirect_to ({:action => :show, :id => @page.id})
        else
            render('edit')  
        end
    end

    def delete
        @page = Page.find(params[:id])
    end

    def destroy
        @page = Page.find(params[:id])
        @page.destroy
        redirect_to(pages_path)
        flash[:notice] = "Page '#{@page.name}' deleted sucessfully"
    end

    private

    def page_params
        params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink)
    end
    
     def find_subjects
         @subjects = Subject.sorted
     end
    
     def set_page_count
         @page_count = Page.count
         if params[:action] == 'new' || params[:action] == 'create'
             @page_count += 1
         end
     end

end
