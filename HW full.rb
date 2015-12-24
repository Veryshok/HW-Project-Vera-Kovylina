require 'selenium-webdriver'
require 'test/unit'
require 'rspec'

class Registration_Test < Test::Unit::TestCase
  include RSpec::Matchers

 # Starting browser before each test
  def setup
    @browser = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @browser.get 'http://demo.redmine.org'
  end

   def registration
    login = rand(999).to_s + 'loginTest'
    @browser.find_element(:class, 'register').click
    @browser.find_element(:id, 'user_login').send_keys login
    @browser.find_element(:id, 'user_password').send_keys 'password1'
    @browser.find_element(:id, 'user_password_confirmation').send_keys 'password1'
    @browser.find_element(:id, 'user_firstname').send_keys 'First_name'
    @browser.find_element(:id, 'user_lastname').send_keys 'Last_name'
    @browser.find_element(:id, 'user_mail').send_keys login + '@mail.com'

    @browser.find_element(:name, 'commit').click
  end

  def register_user1

    user1email = 'user1@email.com'
    user1password = 'password1'

    @browser.find_element(:class, 'register').click
    @browser.find_element(:id, 'user_login').send_keys 'User1'
    @browser.find_element(:id, 'user_password').send_keys user1password
    @browser.find_element(:id, 'user_password_confirmation').send_keys user1password
    @browser.find_element(:id, 'user_firstname').send_keys 'First_name'
    @browser.find_element(:id, 'user_lastname').send_keys 'Last_name'
    @browser.find_element(:id, 'user_mail').send_keys user1email
    @browser.find_element(:name, 'commit').click
  end

  def user1_login
    @browser.find_element(:class, 'login').click
    @browser.find_element(:id, 'username').send_keys 'user1'
    @browser.find_element(:id, 'password').send_keys 'password1'
    @browser.find_element(:name, 'login').click
  end

  def create_project
    project_name = rand(999).to_s + 'test_project'
    unigue_name = project_name
    @browser.find_element(:class, 'projects').click
    @browser.find_element(:class, 'icon-add').click
    @browser.find_element(:id, 'project_name').send_keys unigue_name.upcase
    @browser.find_element(:name, 'project[identifier]').send_keys '_' + unigue_name #очистить поле перед введением
    @browser.find_element(:name, 'commit').click
  end
=begin
  # 1. User Registration
  def test_user_registration_1
    registration

   # visible = @browser.find_element(:id, 'flash_notice').displayed?
   # assert_equal(true,visible)
   #
    expect(@browser.find_element(:id, 'flash_notice').text).to include('Your account has been activated. You can now log in.')
   #
   # expect(@browser.find_element(:id, 'flash_notice')).to be_displayed
  
  end


 
  # 2. Log in/Log out
  def test_login
    #{register_user1}" как пропустить этот шаг в случае если юзер уже был создан?
    user1_login
  #expect(@browser.find_element(:id, 'flash_notice').text).to include('Your account has been activated. You can now log in.')
  end


  def test_logout
	   user1_login
    @browser.find_element(:class, 'logout').click
  end



  # 3. Change password
  def test_change_password
    registration
    # http://demo.redmine.org/my/password
    @browser.find_element(:class, 'icon-passwd').click
    @browser.find_element(:id, 'password').send_keys 'password1' #old password
    @browser.find_element(:id, 'new_password').send_keys 'new_password2'
    @browser.find_element(:id, 'new_password_confirmation').send_keys 'new_password2'

    @browser.find_element(:name, 'commit').click

    expect(@browser.find_element(:id, 'flash_notice').text).to include('Password was successfully updated')
  end



  # 4. Create Project + Create Project version
  def test_create_project
    user1_login
    create_project

    expect(@browser.find_element(:id, 'flash_notice').text).to include('Successful creation.')
    end
=end

  def test_create_project_version
    user1_login
    create_project
    project_name = rand(999).to_s + 'Project'
    @browser.find_element(:id, 'tab-versions').click
    @browser.find_element(:id, '!!!tab-content-versions').click # написать правильный локатор =((
    @browser.find_element(:id, 'version_name').send_keys project_name
    @browser.find_element(:name, 'commit').click
  end


   # 5 Add another (your) user to the Project + Edit their (users’) roles

  def test_add_user_to_project
    user1_login
    create_project

  end
 	 # 6. Create all 3 types of issues + Ensure they are visible on ‘Issues’ tab
 	 # Closing browser after each test

=begin
   def teardown
    @browser.quit
   end

=end

end

