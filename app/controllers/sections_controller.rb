class SectionsController < ApplicationController

    layout 'admin'
    
     before_action :set_section_count, :only => [:edit, :new, :create, :update]
     before_action :page_sorted, :only => [:new, :create, :edit, :update]


    def index
        @sections = Section.sorted

    end

    def show
        @section = Section.find(params[:id])
    end

    def new
        @section = Section.new({:name => "Default"})
    end

    def create
        @section = Section.new(section_params)
        if @section.save
            redirect_to(sections_path) 
            flash[:notice] = "section '#{@section.name}'  created sucessfully."
        else
            render('new') 
        end
    end


    def edit
        @section = Section.find(params[:id])
    end

    def update

        @section = Section.find(params[:id])

        if @section.update_attributes(section_params)
            redirect_to ({:action => :show, :id => @section.id})
            flash[:notice] = "section '#{@section.name}' updated sucessfully."
        else
            render('edit')  
        end
    end

    def delete
        @section = Section.find(params[:id])
    end

    def destroy
        @section = Section.find(params[:id])
        @section.destroy
        redirect_to(sections_path)
        flash[:notice] = "section '#{@section.name}' deleted sucessfully."
    end

    private 

    def section_params
        params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
    end

    def set_section_count
         @section_count = Section.count
         if params[:action] == 'new' || params[:action] == 'create'
             @section_count += 1
         end
     end 
    
    def page_sorted
        @pages = Page.sorted
    end
end
