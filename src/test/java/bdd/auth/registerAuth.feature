@automation-api
Feature: Registro de usuarios
  Background:
    Given url "https://api.qateamperu.com/"
    And path "/api/register"
    And header Content-Type = "application/json"
    And header Accept = "application/json"
  Scenario: CP01 - Registro de usuario exitoso
    * def idAleatorio = Math.floor(Math.random() * 1000)
    * def emailAleatorio = "hgonzal" + idAleatorio + "@gmail.com"
    * def data = { "email": "#(emailAleatorio)",    "password": "11223344",    "nombre": "Henry Gonzalez QA",    "tipo_usuario_id": 1,    "estado": 1    }
    And request data
    When method post
    Then status 200
    And match response.data contains { "email":"#(emailAleatorio)"}
    * print "Se creo el usuario con email: ",emailAleatorio," exitosamente"

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