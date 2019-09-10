class KindsController < ApplicationController
  def show
    @kinds = Kind.all
    @kind = Kind.find(params[:id])
    @books = Book.where(kind_id: params[:id]).order(id: :desc)
  end
end
