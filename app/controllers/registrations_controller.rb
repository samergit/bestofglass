class RegistrationsController < Devise::RegistrationsController

  def create
    super
    if resource.save
      @path = URI(request.referer).path
      resource.set_default_role(@path)
    end  
  end

end
