Feature: Registro de usuarios
  Background:
    Given url "https://api.qateamperu.com/"
    And path "/api/register"
  Scenario: CP01 - Registro de usuario exitoso
    * def data =
    """
    {
    "email": "hgonzale@gmail.com",
    "password": "11223344",
    "nombre": "Henry Gonzalez QA",
    "tipo_usuario_id": 1,
    "estado": 1
    }
    """
    And request data
    When method post
    Then status 200
    And match response.data contains { "email":"hgonzale@gmail.com"}

  Scenario: CP02 - Registro de usuario con email ya registrado
    * def data =
    """
    {
    "email": "hgonzalez123@gmail.com",
    "password": "11223344",
    "nombre": "Henry Gonzalez QA",
    "tipo_usuario_id": 1,
    "estado": 1
    }
    """
    And request data
    When method post
    Then status 500