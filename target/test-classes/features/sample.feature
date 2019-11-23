@sample
  Feature: Predefined steps for Sample page
    @sample1
    Scenario: Responsive UI test
      Given I open url "https://skryabin.com/webdriver/html/sample.html"
      When I resize window to 1280 and 1024
      Then element with xpath "//b[@id='location']" should be displayed
      When I resize window to 400 and 1024
      Then element with xpath "//b[@id='location']" should not be displayed

    @sample2
    Scenario: Validate min "Username" field requirement as 2 characters
      Given I open url "https://skryabin.com/webdriver/html/sample.html"
      When I type "a" into element with xpath "//input[@name='username']"
      And I click on element with xpath "//input[@id='password']"
      Then element with xpath "//label[@id='username-error']" should be displayed
      Then element with xpath "//label[@id='username-error']" should contain text "Please enter at least 2 characters."
      When I type "a" into element with xpath "//input[@name='username']"
      Then element with xpath "//label[@id='username-error']" should not be displayed
      
    @sample3-1
    Scenario Outline: Validate "Email" field behavior. Positive
      Given I open url "https://skryabin.com/webdriver/html/sample.html"
      When I type "<valid_email>" into element with xpath "//input[@name='email']"
      And I click on element with xpath "//input[@id='password']"
      Then element with xpath "//label[@id='email-error']" should not be present

      Scenarios:
      |valid_email                                   |
      |simple@example.com                            |
      |very.common@example.com                       |
      |disposable.style.email.with+symbol@example.com|
      |other.email-with-hyphen@example.com           |

    @sample3-2
    Scenario Outline: Validate "Email" field behavior. Negative
      Given I open url "https://skryabin.com/webdriver/html/sample.html"
      When I type "<invalid_email>" into element with xpath "//input[@name='email']"
      And I click on element with xpath "//input[@id='password']"
      Then element with xpath "//label[@id='email-error']" should be displayed
      And element with xpath "//label[@id='email-error']" should contain text "Please enter a valid email address."

      Scenarios:
      |invalid_email|
      |Abc.example.com|
      |a@a.           |
      |A@b@c@example.com|

    @sample4-1
    Scenario: Fill out and validate "Password" set of fields. Password field empty
      Given I open url "https://skryabin.com/webdriver/html/sample.html"
      Then element with xpath "//label[@id='password-error']" should not be present
      When I click on element using JavaScript with xpath "//button[@id='formSubmit']"
      Then element with xpath "//label[@id='password-error']" should be displayed
      And element with xpath "//label[@id='password-error']" should contain text "This field is required."
      And element with xpath "//input[@id='confirmPassword']" should be disabled

    @sample4-2
    Scenario: Fill out and validate "Password" set of fields. "Password" field and "Confirm Password" has 3 symbols
      Given I open url "https://skryabin.com/webdriver/html/sample.html"
      Then element with xpath "//label[@id='password-error']" should not be present
      When I type "gdu" into element with xpath "//input[@id='password']"
      Then element with xpath "//input[@id='confirmPassword']" should be enabled
      When I type "gdu" into element with xpath "//input[@id='confirmPassword']"
      And I click on element with xpath "//input[@name='username']"
      Then element with xpath "//label[@id='password-error']" should be displayed
      And element with xpath "//label[@id='password-error']" should contain text "Please enter at least 5 characters."
      And element with xpath "//label[@id='confirmPassword-error']" should be displayed
      And element with xpath "//label[@id='confirmPassword-error']" should contain text "Please enter at least 5 characters."

