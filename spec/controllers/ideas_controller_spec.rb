require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    describe '#new' do
        context "with signed in user" do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            it 'render the new template' do
                get(:new)
                expect(response).to(render_template(:new)) 
            end
            it 'sets an instance variable with new ideas' do
                get(:new)
                expect(assigns(:ideas)).to(be_a_new(Idea))
            end
        end 
        context 'with user not signed in'do
            it 'should redirect to sign in page' do
                get(:new)
                expect(response).to redirect_to(new_session_path)
            end
        end
    end
    describe '#create' do
        def valid_request
            post(:create, params:{idea: FactoryBot.attributes_for(:idea)})
        end
        context 'with user signed in' do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            context " with valid parameter " do 
                it 'creates a idea in the database' do
                    count_before = Idea.count
                    valid_request
                    count_after=Idea.count
                    expect(count_after).to(eq(count_before + 1))
                end
                it 'redirects us to a show page of that idea' do
                    valid_request
                    idea=Idea.last
                    expect(response).to(redirect_to(idea_url(idea.id)))
                end
            end
            context 'with invalid parameters' do
                def invalid_request
                    post(:create, params:{idea: FactoryBot.attributes_for(:idea, title: nil)})
                end
                it 'doesnot save a record in the database'do
                    count_before = Idea.count
                    invalid_request
                    count_after = Idea.count
                    expect(count_after).to(eq(count_before))
                end
                it 'renders the new template' do
                    invalid_request
                    expect(response).to render_template(:new)
                end
            end
        end
        context 'with user not signed in'do
            it 'should redirect to sign in page' do
                valid_request
                expect(response).to redirect_to(new_session_path)
            end
        end
    end
    # describe '#show' do
    #     it 'render show template' do
    #         idea=FactoryBot.create(:idea)
    #         get(:show, params:{id: idea.id})
    #         expect(response).to render_template(:show)
    #     end
    #     it 'set an instance variable post for the shown object' do
    #         idea=FactoryBot.create(:idea)
    #         get(:show, params:{id: idea.id})
    #         expect(assigns(:ideas)).to(eq(Idea))
    #     end
    # end
    # describe '#index' do 
    #     it 'render the index template' do
    #         get(:index)
    #         expect(response).to render_template(:index)
    #     end
    #     it 'assign an instance variable idea which contains all created ideas' do
    #         idea1=FactoryBot.create(:idea)
    #         idea2=FactoryBot.create(:idea)
    #         idea3=FactoryBot.create(:idea)
    #         get(:index)
    #         expect(assigns(:ideas)).to eq([idea3, idea2,idea1])
    #     end
    # end
    # describe "# edit" do
    #     context "with signed in user" do
    #         context " as owner" do
    #             before do
    #                 @idea=FactoryBot.create(:idea)
    #                 session[:user_id] = @idea.user
    #             end
    #             it "render the edit template" do
    #                 get(:edit, params:{id: @idea.id})
    #                 expect(response).to render_template :edit
    #             end
    #         end
    #         context 'as non owner' do
    #             before do
    #                 session[:user_id] = FactoryBot.create(:user)
    #                 @idea=FactoryBot.create(:idea)
    #             end
    #             it 'should redirect to the show page' do
    #                 get(:edit, params:{id: @idea.id})
    #                 expect(response).to redirect_to idea_path(@idea)
    #             end
    #         end
    #     end
    # end
    # describe '#update' do
    #     before do 
    #         @idea= FactoryBot.create(:idea)
    #     end
    #     context "with signed in user"do
    #         before do
    #             session[:user_id] = @idea.user.id
    #         end
    #         context "with valid parameters" do
    #             it "update the idea record with new attributes" do
    #                 new_title = "#{@idea.title} plus some changes!!!"
    #                 patch(:update, params:{id: @idea.id, idea: {title: new_title}})
    #                 expect(@idea.reload.title).to(eq(new_title))
    #             end
    #             it 'redirect to the show page' do
    #                 new_title = "#{@idea.title} plus some changes!!!"
    #                 patch(:update, params:{id: @idea.id, idea: {title: new_title}})
    #                 expect(response).to redirect_to(@idea)
    #             end
    #         end
    #         context "with invalid parameters" do
    #             it 'should not update the idea record' do
    #                 patch(:update, params:{id: @idea.id, idea: {title: nil}})
    #                 expect(@idea.reload.title).to(eq(@idea.title))
    #             end
    #         end
    #     end
    # end
    # describe '#destroy' do
    #     context "with signed in user" do
    #         context 'as owner' do
    #             before do
    #                 @idea=FactoryBot.create(:idea)
    #                 session[:user_id] = @idea.user
    #                 delete(:destroy, params:{id: @idea.id})
    #             end
    #             it 'remove idea from the db' do
    #                 expect(Idea.find_by(id: @idea.id)).to(be(nil))
    #             end
    #             it 'redirect to the idea index' do
    #                 expect(response).to redirect_to(ideas_path)
    #             end
    #             it 'set a flash message' do
    #                 expect(flash[:danger]).to be
    #             end 
    #         end
    #         context "as non owner" do
    #             before do
    #                 session[:user_id]=FactoryBot.create(:user)
    #                 @idea=FactoryBot.create(:idea)
    #             end
    #             it 'does not remove the idea' do
    #                 delete(:destroy,params:{id: @idea.id})
    #                 expect(Idea.find(@idea.id)).to eq(@idea)
    #             end
    #         end
    #     end
    # end
end
