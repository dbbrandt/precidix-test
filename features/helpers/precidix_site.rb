require_relative("site")

class CognifySite < Site

  @@titles = { "login" => "Login",
               "home" => "Home" }


  @@urls = { "login" => "/#/login",
             "home" => "/#/home" }

  # Don't change appication value, this is what is used to identify this class to the parent site class.
  def initialize
    @application = "precidix"
    super
  end

  def get_title(key)
    @@titles[key]
  end

  def get_path(key)
    @@urls[key]
  end

  def base_url
    ENV[environment.upcase+'_PRECIDIX_URL']
  end

  def login_page
    @login_page ||= PrecidixLoginPage.new(@browser, self)
  end

  def main_page
    @main_page ||= PrecidixMainPage.new(@browser, self)
  end
end