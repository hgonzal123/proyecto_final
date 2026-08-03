@automation-api
Feature: Listado de productos

  Background:
    * def codProduct = 201
    Given url "https://api.qateamperu.com/"
    And path "/api/v1/producto/" + codProduct
    * def apilogin = call read('../auth/loginAuth.feature@login')
    * def token = apilogin.token
    * def tokenAuth = 'Bearer ' + token
    And header Authorization = tokenAuth

  Scenario: CP01 - Listar producto existente
    When method get
    Then status 200
    And match response.id == '#number'

