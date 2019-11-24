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

    @sammple5
    Scenario: Popup dialog appears clicking inside of Name field. Name concatenation verification
      Given I open url "https://skryabin.com/webdriver/html/sample.html"
      Then element with xpath "//*[@aria-labelledby='ui-id-1']" should not be displayed
      When I click on element with xpath "//input[@id='name']"
      Then element with xpath "//*[@aria-labelledby='ui-id-1']" should be displayed
      When I type "Andrey" into element with xpath "//input[@id='firstName']"
      And I type "Sergeevich" into element with xpath "//input[@id='middleName']"
      And I type "Shevchenko" into element with xpath "//input[@id='lastName']"
      And I click on element with xpath "//span[contains(text(),'Save')]/../../button[1]"
      Then element with xpath "//input[@id='name']" should have attribute "value" as "Andrey Sergeevich Shevchenko"

    @sample6
    Scenario: Validate that Accepting Privacy Policy is required to submit the form, then check the field
      Given I open url "https://skryabin.com/webdriver/html/sample.html"
      Then element with xpath "//label[@id='agreedToPrivacyPolicy-error']" should not be present
      When I click on element with xpath "//button[@id='formSubmit']"
      Then element with xpath "//label[@id='agreedToPrivacyPolicy-error']" should be present
      When I click on element with xpath "//input[@name='agreedToPrivacyPolicy']"
      And I click on element with xpath "//button[@id='formSubmit']"
      Then element with xpath "//label[@id='agreedToPrivacyPolicy-error']" should not be displayed

      @sample7
      Scenario: entering non-required fields
        Given I open url "https://skryabin.com/webdriver/html/sample.html"
        And I type "5556561024" into element with xpath "//input[@name='phone']"
        And I select value "Ukraine" from list with xpath "//select[@name='countryOfOrigin']"
        And I click on element with xpath "//input[@name='gender' and @value='male']"
        And I click on element with xpath "//input[@name='allowedToContact']"
        And I type "154 New Year Road, New York, NY 01002" into element with xpath "//textarea[@id='address']"
        And I select value "BMW" from list with xpath "//select[@name='carMake']"
        And I click on element with xpath "//button[@id='thirdPartyButton']"
        And I accept alert
        And I type "12/22/2018" into element with xpath "//input[@id='dateOfBirth']"
        Then I wait for 3 sec

        @sample8
        Scenario: fill and submit form and verify information
          Given I open url "https://skryabin.com/webdriver/html/sample.html"
          And I type "test_user" into element with xpath "//input[@name='username']"
          And I type "simple@example.com" into element with xpath "//input[@name='email']"
          And I type "passw0rd" into element with xpath "//input[@id='password']"
          And I type "passw0rd" into element with xpath "//input[@id='confirmPassword']"
          And I click on element with xpath "//input[@id='name']"
          Then element with xpath "//*[@aria-labelledby='ui-id-1']" should be displayed
          When I type "Andrey" into element with xpath "//input[@id='firstName']"
          And I type "Sergeevich" into element with xpath "//input[@id='middleName']"
          And I type "Shevchenko" into element with xpath "//input[@id='lastName']"
          And I click on element with xpath "//span[contains(text(),'Save')]/../../button[1]"
          And I click on element with xpath "//input[@name='agreedToPrivacyPolicy']"
          And I type "5556561024" into element with xpath "//input[@name='phone']"
          And I select value "Ukraine" from list with xpath "//select[@name='countryOfOrigin']"
          And I click on element with xpath "//input[@name='gender' and @value='male']"
          And I click on element with xpath "//input[@name='allowedToContact']"
          And I type "154 New Year Road, New York, NY 01002" into element with xpath "//textarea[@id='address']"
          And I select value "BMW" from list with xpath "//select[@name='carMake']"
          And I click on element with xpath "//button[@id='thirdPartyButton']"
          And I accept alert
          And I type "12/22/2018" into element with xpath "//input[@id='dateOfBirth']"
          And I click on element with xpath "//button[@id='formSubmit']"
          Then element with xpath "//*[@name='username']" should have text as "test_user"
          And element with xpath "//*[@name='email']" should have text as "simple@example.com"
          And element with xpath "//*[@name='password']" should have text as "[entered]"
          And element with xpath "//*[@name='name']" should have text as "Andrey Sergeevich Shevchenko"
          And element with xpath "//*[@name='phone']" should have text as "5556561024"
          And element with xpath "//*[@name='countryOfOrigin']" should have text as "Ukraine"
          And element with xpath "//*[@name='address']" should have text as "154 New Year Road, New York, NY 01002"
          And element with xpath "//*[@name='carMake']" should have text as "BMW"
          And element with xpath "//*[@name='dateOfBirth']" should have text as "12/22/2018"
          And I wait for 10 sec


