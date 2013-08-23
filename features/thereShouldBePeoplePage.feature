Feature: Go to the people page
  In order for logged in users to see everyone in the company
  As any logged in user 
  I should be able to go to the people page

  Scenario: Seeing 'people' when logged in
    Given a I'm a logged-in user
    When I go to cv.bvn.com.au/people
    Then I see all the people in the company
