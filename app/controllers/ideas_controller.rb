class IdeasController < ApplicationController
    before_action :authenticate_user!,  except:[:index, :show]
    before_action :find_idea, only:[:show, :edit, :update, :destroy]
    before_action :authorize_user!, only:[:edit, :update, :destroy]
    def index
        @ideas=Idea.all.order(created_at: :desc)
    end
    def create
        @ideas=Idea.new idea_params
        @ideas.user = current_user
        if @ideas.save
            redirect_to idea_path(@ideas.id)
        else
            render :new
        end
    end
    def new
        @ideas=Idea.new
    end
    def edit 
        if can?(:edit, @ideas)
            render :edit
        else
            redirect_to idea_path(@ideas)
        end
    end
    def show
        @review=Review.new
        @reviews= @ideas.reviews.order(created_at: :desc)
    end
    def destroy
        @ideas.destroy
        flash[:danger]= 'deleted idea'
        redirect_to ideas_path
    end
    def update
        if @ideas.update idea_params
            redirect_to idea_path(@ideas.id)
        else
            render :edit
        end
    end
    private
    def find_idea
        @ideas=Idea.find params[:id] 
    end
    def idea_params
        params.require(:idea).permit(:title, :description)
    end
    def authorize_user!
        redirect_to idea_path(@ideas), alert: "Not Authorized" unless can?(:crud, @ideas)
    end
end
