class PagesController < ApplicationController

    layout 'admin'

    def index
        @pages = Page.sorted
    end

    def show
        @page = Page.find(params[:id])
    end

    def new
        @page = Page.new
        @subjects = Subject.sorted
        @page_count = Page.count + 1
    end

    def create
        @page = Page.new(page_params)
        if @page.save
            flash[:notice] =  "Page '#{@page.name}'  created sucessfully."
            redirect_to(pages_path) 
        else
            @subjects = Subject.sorted
            @page_count = Page.count + 1
            render('new') 
        end
    end

    def edit
        @page = Page.find(params[:id])
        @page_count = Page.count 
        @subjects = Subject.sorted
    end

    def update
        @page = Page.find(params[:id])

        if @page.update_attributes(page_params)
            flash[:notice] = "Page '#{@page.name}' updated sucessfully."
            redirect_to ({:action => :show, :id => @page.id})
        else
            @subjects = Subject.sorted
            @page_count = Page.count
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

end
