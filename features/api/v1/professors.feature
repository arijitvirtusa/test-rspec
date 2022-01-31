Feature: Professors list API 
  In order to reference professors
  As an API client
  I want to be able to request professors via a JSON API 

  Scenario: Retrives a list of professors
    Given There are the following professors
      | name   | email            | mobile     | designation | dob        | joining_date | qualification |
      | Arijit | arijit@gmail.com | 9874561230 | HOD         | 16/05/1989 | 27/12/2021   | B.Tech        |
      | Dodo   | dodo@gmail.com   | 9874563210 | HOD         | 07/12/1992 | 27/12/2021   | B.Tech        |
    When I make a GET request to "/professors"
    Then The response code should be 200
    Then I should receive the following JSON representation of Professors:
    """
    [
      {
        name: 'Arijit',
        email: 'arijit@gmail.com',
        mobile: '9874563210',
        designation: 'HOD',
        dob: '16/05/1989',
        joining_date: '27/12/2021',
        qualification: 'B.Tech'
      },
      {
        name: 'Dodo',
        email: 'dodo@gmail.com',
        mobile: '9874563210',
        designation: 'HOD',
        dob: '07/12/1992',
        joining_date: '27/12/2021',
        qualification: 'B.Tech'
      }
    ]
    """