require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase

	context "#new" do 
		context "when not logged in" do 
			should "redirect to the login page" do
				get :new
				assert_response :redirect	
			end	
		end

	context "when logged in" do
		setup do
			sign_in users(:jason)
		end
	should "get new and return success" do
		get :new
		assert_response :success
	end	

	should "should set a flash error if friend_id params is missing" do
		get :new, {}
		assert_equal "Friend required", flash[:error]		
	end

	should "display the friend's name" do
		get :new, friend_id: users(:jim)
		assert_match /#{users(:jim).email}/, response.body
	end	

	should "assign a new user friendship to the correst friend" do
		get :new, friend_id: users(:jim)
		assert_equal users(:jim), assigns(:user_friendship).friend
	end	


	should "assign a new user friendship to the currently logged in user" do
		get :new, friend_id: users(:jim)
		assert_equal users(:jason), assigns(:user_friendship).user
	end	

	should "returns a 404 status if not friend is found" do
		get :new, friend_id: 'invalid'
		assert_response :not_found
	end

	should "ask if u really want to friend the user" do
		get :new, friend_id: users(:jim)
		assert_match /Do you really want to friend #{users(:jim).email}?/, response.body
	end




	end
	end	

	context "#create" do
		context "when not logged in" do
			should "redirect to the login page" do 
			get :new
			assert_response :redirect
			assert_redirected_to login_path
		end
	end

	context "when logged in" do
		setup do
			sign_in users(:jason)
		end	


		context "with no friend_id" do
			setup do
				post :create
			end

		should "set the flash error message" do
			assert !flash[:error].empty?
		end		

	end
end
end
end

