class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_idea
    def create
        @review = Review.new review_params
        @review.idea = @idea
        @review.user = @current_user
        
        if @review.save
          redirect_to idea_path(@idea), notice: 'Review created!'
        else
          redirect_to idea_path(@idea)
        end
    end
    def update
        @review=Review.find params[:id]
        if can?(:crud, @review)
            @review.save
            redirect_to idea_path(@review.idea), notice: "Review visibility changed"
        else
            redirect_to root_path, alert: 'Not Authorized'
        end
    end
    def destroy
        @review=Review.find params[:id]
        if can?(:crud, @review)
            @review.destroy
            redirect_to idea_path(@idea), notice: "Review deleted"
        else
            redirect_to idea_path(@idea), alert: 'Not Authorized'
        end
    end
    private
    def find_idea
        @idea=Idea.find params[:idea_id]
    end
    def review_params
        params.require(:review).permit(:body)
    end
end
