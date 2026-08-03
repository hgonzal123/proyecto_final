@automation-api
Feature: Creacion de productos

  Background:

    Given url "https://api.qateamperu.com/"
    * def apilogin = call read('../auth/loginAuth.feature@login')
    * def token = apilogin.token
    * def tokenAuth = 'Bearer ' + token
    And header Authorization = tokenAuth

  Scenario: CP01 - Actualizar un nuevo producto existente
    * def codigoProducto = 200
    And path "/api/v1/producto",codigoProducto
    * def data =
        """
         {
          "codigo": "HG0003",
          "nombre": "Lapt DELL 23",
          "medida": "UND ",
          "marca": "Generico",
          "categoria": "Repuestos",
          "precio": "8000.00",
          "stock": "10",
          "estado": "3",
          "descripcion": "Ploma 14 pulgadas"
          }
        """
    And request data
    When method put
    Then status 200
    And match response.id == '#number'


  Scenario Outline: CP02 - Actualizar productos desde un archivo externo <id>
    And path "/api/v1/producto",<id>
    * print <id>
    And request { codigo: '#(codigo)', nombre: '#(nombre)', medida: '#(medida)', marca: '#(marca)', categoria: '#(categoria)', precio: '#(precio)', stock: '#(stock)', estado: '#(estado)', descripcion: '#(descripcion)' }
    When method put
    Then status 200
    * print "Se actualizo el producto con ID "+ <id> +" exitosamente"

    Examples:
      | read("classpath:resources/csv/auth/dataUpdProducts.csv") |