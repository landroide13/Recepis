module ApplicationHelper

  def gravatar_for(user, options = {size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar#{gravatar_id}?=#{size}"
    image_tag(gravatar_url, alt: user.chefname, class:"image-circle")
  end

end 
