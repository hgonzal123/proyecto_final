Feature: Creacion de productos

  Background:
    Given url "https://api.qateamperu.com/"
    And path "/api/v1/producto"
    And params "200"
    * def apilogin = call read('../auth/loginAuth.feature@login')
    * def token = apilogin.token
    * def tokenAuth = 'Bearer ' + token
    And header Authorization = tokenAuth

  Scenario: CP01 - Actualizar un nuevo producto existente
    * def data =
        """
         {
          "codigo": "HG0003",
          "nombre": "Lapt DELLes",
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
    And match response contains { "nombre":"Laptop HP"}

  Scenario Outline: CP02 - Crear un nuevo producto exitoso desde un archivo externo
    And request { codigo: '#(codigo)', nombre: '#(nombre)', medida: '#(medida)', marca: '#(marca)', categoria: '#(categoria)', precio: '#(precio)', stock: '#(stock)', estado: '#(estado)', descripcion: '#(descripcion)' }
    When method post
    Then status 200

    Examples:
      | read("classpath:resources/csv/auth/dataProducts.csv") |