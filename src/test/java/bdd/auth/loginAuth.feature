Feature: Logeo de usuarios
  Background:
    Given url "https://api.qateamperu.com/"
    And path '/api/login'

  @login
  Scenario: CP01 - Logeo de usuario exitoso
    * def data =
    """
    {
    "email": "hgonzalez@gmail.com",
    "password": "11223344"
    }
    """
    And request data
    When method post
    Then status 200
    And match response.user contains { "email":"hgonzalez@gmail.com"}
    * def token = response.access_token
    * print token

  Scenario: CP02 - Logeo de usuario fallido
    * def data =
    """
    {
    "email": "hgonzalez@gmail.com",
    "password": "11223346"
    }
    """
    And request data
    When method post
    Then status 401
    And match response contains { "message":"Datos incorrectos"}