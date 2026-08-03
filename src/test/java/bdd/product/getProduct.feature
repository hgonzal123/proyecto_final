@automation-api
Feature: Listado de productos

  Background:
    * def codProduct = 201
    Given url "https://api.qateamperu.com/"
    * def apilogin = call read('../auth/loginAuth.feature@login')
    * def token = apilogin.token
    * def tokenAuth = 'Bearer ' + token
    And header Authorization = tokenAuth

  Scenario: CP01 - Listar producto existente
    And path "/api/v1/producto/" + codProduct
    When method get
    Then status 200
    And match response.id == '#number'

  Scenario Outline: CP02 - Listar productos desde un archivo externo
    And path "/api/v1/producto/" + <id>
    When method get
    Then status 200
    And match response.nombre == '#string'
    * print "Se listó el producto con ID",codigo,"-",nombre,"exitosamente"

    Examples:
      | read("classpath:resources/csv/auth/dataUpdProducts.csv") |

