Feature: Learner Experience
  As a user I want to be able to access the application as a learner
  so that I can start a workout for a program

  ● I can login

  Background: Setup and Login
    When I am on the Precidix website
      And I login as dbblearner to home page

  @learner @learner1 @learner-demo
  Scenario: Login as a learner
    Given I am not logged in
    When I login as dbblearner to learner page
    Then I goto the learner page

