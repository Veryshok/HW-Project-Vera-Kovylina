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

  def go_to_home_page
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

    @user1email = 'user1@email.com'
    @user1password = 'password1'

    @browser.find_element(:class, 'register').click
    @browser.find_element(:id, 'user_login').send_keys 'User1'
    @browser.find_element(:id, 'user_password').send_keys user1password
    @browser.find_element(:id, 'user_password_confirmation').send_keys user1password
    @browser.find_element(:id, 'user_firstname').send_keys 'First_name'
    @browser.find_element(:id, 'user_lastname').send_keys 'Last_name'
    @browser.find_element(:id, 'user_mail').send_keys user1email
    @browser.find_element(:name, 'commit').click
  end



  # 1. User Registration
  def test_user_registration_1
    setup
    registration


  # visible = @browser.find_element(:id, 'flash_notice').displayed?
  # assert_equal(true,visible)
  # 
  # if text: expect(@browser.find_element(:id, 'flash_notice').text).to include('Ваша учётная запись активирована. Вы можете войти.')
  # 
  expect(@browser.find_element(:id, 'flash_notice')).to be_displayed
  
  end

 
  # 2. Log in/Log out
  def test_login
  	setup
    register_user1 
  # непонятно как поступить в случае есл такой пользователь уже существует. Если не существует создать
  # и под ним залогиниться, а если да, то пропустить этот шаг и залогиниться.

    @browser.find_element(:class, 'logout').click

    @browser.find_element(:class, 'login').click
    @browser.find_element(:id, 'username').send_keys 'user1email' #как использовать переменную из метода?
    @browser.find_element(:id, 'password').send_keys 'user1password'
    @browser.find_element(:name, 'login').click
        
  end

  def test_logout
	setup
    registration
    @browser.find_element(:class, 'logout').click


    

  # 3. Change password
  def test_change_password
    go_to_home_page
    # http://demo.redmine.org/my/password
    @browser.find_element(:class, 'icon-passwd').click
    @browser.find_element(:id, 'password').send_keys 'password1' #old password
    @browser.find_element(:id, 'new_password').send_keys 'new_password2'
    @browser.find_element(:id, 'new_password_confirmation').send_keys 'new_password2'

    @browser.find_element(:name, 'commit').click

    expected = 'Your account has been activated. You can now log in.'
    assert_equal(expected, @browser.find_element(:id, 'flash_notice').text)
  end


  # 4. Create Project + Create Project version
  def test_project_and_version
    go_to_home_page
    @browser.find_element(:class, 'login').click
    @browser.find_element(:id, 'username').send_keys 'User1'
    @browser.find_element(:id, 'password').send_keys 'password1'
    @browser.find_element(:name, 'login').click

    @browser.find_element(:class, 'projects').click
    @browser.find_element(:class, 'icon-add').click
    @browser.find_element(:id, 'project_name').send_keys 'Project_1'
    @browser.find_element(:id, 'project_indentifier').send_keys 'Project_1' # проверить чтоб совпадал с именем без регистра???
    @browser.find_element(:name, 'commit').click

    @browser.find_element(:id, 'tab-versions').click
    @browser.find_element(:class, 'icon_add').click
    @browser.find_element(:id, 'version_name').send_keys 'Project_1_Version_1'
    @browser.find_element(:name, 'commit').click

    expected = 'Successful creation.'
    assert_equal(expected, @browser.find_element(:id, 'flash_notice').text)

  end


  	# 5 Add another (your) user to the Project + Edit their (users’) roles
 	# 6. Create all 3 types of issues + Ensure they are visible on ‘Issues’ tab
 	# Closing browser after each test
   def teardown
    @browser.quit
   end

end