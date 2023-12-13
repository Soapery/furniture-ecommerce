class PagesController < ApplicationController
  def about
    @about_content = AboutContent.first_or_initialize
  end

  def contact
    @contact_content = ContactContent.first_or_initialize
  end

  def admin
  end
end

