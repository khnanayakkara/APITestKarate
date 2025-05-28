@pets
Feature: Tests to verify pet endpoint

  Background:
    * url 'https://petstore.swagger.io'
    * def PostData = read('../data/postData.json')

  @TC001
  Scenario: Add a new pet to the store and store pet ID in a JSON file
    Given path 'v2/pet'
    And request PostData
    When method POST
    Then status 200
    Then print response
    And match response.category.id == PostData.category.id
    And match response.category.name == PostData.category.name
    And match response.name == PostData.name
    And match response.tags[0].id == PostData.tags[0].id
    And match response.tags[0].name == PostData.tags[0].name
    And match response.status == PostData.status
    And def petId = response.id
    And print "petId : "+ petId
    And karate.write(petId,"petID.json");
    And print read('../data/petID.json')

  @TC002
  Scenario Outline: Create new pets with different tags & statuses
    Given path 'v2/pet'
    And request
    """
    {
      "id": 0,
      "category": {
        "id": <categoryId>,
        "name": "<categoryName>"
      },
      "name": "<name>",
      "photoUrls": [
        "string"
      ],
      "tags": [
        {
          "id": <tagId>,
          "name": "<tagName>"
        }
      ],
      "status": "<status>"
    }
    """
    When method POST
    Then status 200
    Then print response
    And match response.category.id == <categoryId>
    And match response.category.name == '<categoryName>'
    And match response.name == '<name>'
    And match response.tags[0].id == <tagId>
    And match response.tags[0].name == '<tagName>'
    And match response.status == '<status>'
    Examples:
      | categoryId | categoryName | name    | tagId | tagName | status    |
      | 1000       | cat          | cat0001 | 001   | cat001  | available |
      | 1000       | cat          | cat0002 | 002   | cat002  | available |
      | 2000       | dog          | dog001  | 003   | dog001  | sold      |
      | 3000       | puppy        | dog002  | 004   | dog002  | pending   |
      | 2000       | dog          | dog003  | 005   | dog003  | available |
      | 2000       | dog          | dog004  | 006   | dog004  | sold      |

  @TC003
  Scenario Outline: Update an existing pet
    Given path 'v2/pet'
    And request
    """
    {
      "id": <id>,
      "category": {
        "id": <categoryId>,
        "name": "<categoryName>"
      },
      "name": "<name>",
      "photoUrls": [
        "string"
      ],
      "tags": [
        {
          "id": <tagId>,
          "name": "<tagName>"
        }
      ],
      "status": "<status>"
    }
    """
    When method PUT
    Then status 200
    Then print response

    And match response.category.name == '<categoryName>'
    And match response.name == '<name>'
    And match response.tags[0].id == <tagId>
    And match response.tags[0].name == '<tagName>'
    And match response.status == '<status>'
    Examples:
      | id                  | categoryId | categoryName | name   | tagId | tagName | status |
      | 9223372036854330000 | 2000       | dog          | dog004 | 006   | dog004  | sold   |

  @TC004
  Scenario Outline: Find Pets by status
    Given path 'v2/pet/findByStatus'
    And param status = '<status>'
    When method GET
    Then status 200
    Then print response
    Then match response[*].status contains '<status>'
    Then match response[*].status !contains ['sold','pending']
    Examples:
      | status    |
      | available |

#  end-point is deprecated
  @TC005 @deprecatedEndPoint
  Scenario Outline: Find Pets by tags
    Given path 'v2/pet/findByTags'
    And param tag = '<tagNames>'
    When method GET
    Then status 200
    Then print response
    And match response.tags[0].name contains '<tagNames>'
    Examples:
      | tagNames      |
      | dog004        |
      | dog004,cat001 |
