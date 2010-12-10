Feature: Search TMDb
  In order to make it easier to add movies
  RottenPotatoes users
  want to be able to search for a movie and autofill information.
  
  Scenario: Show a search form
    Given I am on the home page
    When I follow "Add New Movie"
    Then I should be on the new movie page
    And I should see the search form

  Scenario: Searching for a movie
    Given I am on the new movie page
    When I fill in "title" with "Inception"
    And I press "Search"
    Then I should be on the find movie page
    And I should see "Inception"
    And I should see "Search Again"

  Scenario: Selecting a movie
    Given I am on the new movie page
    When I fill in "title" with "Inception"
    And I press "Search"
    Then I should be on the find movie page

    When I select the first result
    Then I should be on the movie page for "Inception"
    And I should see "Inception added to Rotten Potatoes!"

  Scenario: Failing to find a movie
    Given I am on the new movie page
    When I fill in "title" with "ASDFASDFASDF"
    And I press "Search"
    Then I should see "Movie not found. Try again!"
    And I should see the search form
    And the "Input Movie Title" field should contain "ASDFASDFASDF"