Feature: pruebas de API de PetStore

Background:
  * def newUser =
"""
      {
        "username": "WilsonTest",
        "firstName": "Wilson",
        "lastName": "Test",
        "email": "wilson@test.com",
        "password": "wilsonTest123",
        "phone": "55555555",
        "userStatus": 0
      }
      """
Given url 'https://petstore.swagger.io/v2'

  Scenario: Crear un nuevo usuario
    Given path 'user'
    And request newUser
    When method POST
    Then status 200

  Scenario: Obtener usuario creado
      Given path 'user', newUser.username
      When method GET
      Then status 200
      And match response.firstName == newUser.firstName
      And match response.lastName == newUser.lastName
      And match response.password == newUser.password
      And match response.phone == newUser.phone
      And match response.email == newUser.email
      And match response.username == newUser.username

  Scenario: Obtener Pets por status
    Given path 'pet/findByStatus'
    And param status = 'sold'
    When method GET
    Then status 200
    And def petNames = karate.map(response, function(pet){ return { id: pet.id, name: pet.name } })
    And print 'Mascotas:', petNames
