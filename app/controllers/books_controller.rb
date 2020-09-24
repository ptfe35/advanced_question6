class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user,{only: [:edit, :update]}

def ensure_correct_user
  @book = Book.find(params[:id])
  if current_user.id != @book.user.id
   redirect_to books_path
  end
end

  def index
    @books = Book.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
    @book_s = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end

