class ContactsController < ApplicationController
 
  # GET request to /contact-us
  # show new contact form
  def new
    @contact = Contact.new
  end
  
  # POST request /contacts
  def create
    # mass assigment of form fields into contact object
    @contact = Contact.new(contact_params)
    # save the Contact object to the database
    if @contact.save
      # store form fields via parameters, into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:message]
      # plug variables into contact mailer email method 
      # and send the mail
      ContactMailer.contact_email(name, email, body).deliver
      # store message in flash hash
      # and redirect to the new action
      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else
      # if saving fails, store error message
      # and redirect to the new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  private
  # collect data from form using secure
  # Rails, "strong params" and whitelist
  # the form fields.
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end