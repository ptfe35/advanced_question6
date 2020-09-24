class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    if comment.save
    else
      @book = Book.new
      @user = User.find(current_user.id)
      @book_s = Book.find(params[:book_id])
      @book_comment = comment
      render template: "books/show"
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end