class Users::ContactsController < ApplicationController
  before_filter :set_user
  

  def index
    @contacts = @user.contacts.order(:nombre).page params[:page]
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = @user.contacts.create(params[:contact])

    if @contact.save
      redirect_to user_contact_path(@user, @contact), notice: 'Contact was successfully created.' #manda al show de contact
    else
      render action: "new"
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact].except(:user_id)) # except es para q no me cambien el user_id
      redirect_to user_contact_path(@user, @contact), notice: 'Contact was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to user_contacts_path(@user), notice: 'Contact was successfully deleted.'
  end

  private

  def set_user
    @user = current_user
  end
end