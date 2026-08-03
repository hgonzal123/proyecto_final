@automation-api
Feature: Registro de usuarios
  Background:
    Given url "https://api.qateamperu.com/"
    And path "/api/register"
    And header Accept = "application/json"
    And header Content-Type = "application/json"
  Scenario: CP01 - Registro de usuario exitoso
    * def data =
    """
    {
    "email": "hgonzal006232@gmail.com",
    "password": "11223344",
    "nombre": "Henry Gonzalez QA",
    "tipo_usuario_id": 1,
    "estado": 1
    }
    """
    And request data
    When method post
    Then status 200
    And match response.data contains { "email":"hgonzal006232@gmail.com"}
    * print "Usuario creado exitosamente"

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
    And match response.email contains ["The email has already been taken."]
    * print "El usuario ya existe"