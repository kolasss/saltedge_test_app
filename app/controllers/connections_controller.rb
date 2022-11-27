class ConnectionsController < ApplicationController
  # before_action :set_book, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    # @connections = Connection.all
    @connections = current_user.connections
  end

  def show
    @connection = current_user.connections.find(params[:id])
    @accounts = @connection&.accounts
  end

  # def new
  #   @book = Book.new
  # end

  # # GET /books/1/edit
  # def edit
  # end

  # # POST /books
  # def create
  #   @book = Book.new(book_params)

  #   if @book.save
  #     redirect_to @book, notice: "Book was successfully created."
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # # PATCH/PUT /books/1
  # def update
  #   if @book.update(book_params)
  #     redirect_to @book, notice: "Book was successfully updated."
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  # DELETE /books/1
  # def destroy
  #   @book.destroy
  #   redirect_to books_url, notice: "Book was successfully destroyed."
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_book
    #   @book = Book.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:title, :mark)
    end
end
