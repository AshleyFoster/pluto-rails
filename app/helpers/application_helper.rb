module ApplicationHelper
  def gravatar_url(email, size)
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    default_url = "http://mysite.com/myavatar.png"
    url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI::escape(default_url)}"
  end
end
