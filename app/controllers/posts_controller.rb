class PostsController < ApplicationController

	http_basic_authenticate_with name: "dhh", password: "secret",
	except: [:index, :show]

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new # new action is creating a new instance variable called @post
	end

	def create 
		@post = Post.new(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new' # the render (instead of redirect) method is used so that the @post object is passed back to the new template when it is rendered
			# this rendering is done within the same request as the form submission, whereas the redirect_to will tell the browser to issue another request.
		end
	end

	def show
		@post = Post.find(params[:id])
		# we used @ to hold a reference to the post object. we used this 
		# becoz rails will passed all instance variables to the view.
	end

	def edit 
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end

	private
		def post_params
			params.require(:post).permit(:title, :text)
		end

end
