class ManagersController < CustomersController

  before_filter :find_customer

  def edit
  end

  def update
    redirect_to root_path if @manager.nil?
    if @manager.update_attributes(params[:manager])
      redirect_to root_path(secret: @customer.secret)
    else
      render 'edit'
    end
  end
end