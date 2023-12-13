class AdminController < ApplicationController
  def edit_about
    @about_content = AboutContent.first_or_initialize
  end

  def update_about
    @about_content = AboutContent.first_or_initialize
    @about_content.assign_attributes(content_params)

    if @about_content.save
      redirect_to edit_about_path, notice: 'About content updated successfully.'
    else
      render :edit_about
    end
  end

  def edit_contact
    @contact_content = ContactContent.first_or_initialize
  end

  def update_contact
    @contact_content = ContactContent.first_or_initialize
    @contact_content.assign_attributes(content_params)

    if @contact_content.update(content_params)
      redirect_to edit_contact_path, notice: 'Contact content updated successfully.'
    else
      render :edit_contact
    end
  end

  private

  def content_params
    if params[:about_content]
      params.require(:about_content).permit(:content)
    elsif params[:contact_content]
      params.require(:contact_content).permit(:content)
    end
  end
end
