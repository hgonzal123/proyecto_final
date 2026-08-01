Feature: Creacion de productos

    Background:
        Given url "https://api.qateamperu.com/"
        And path "/api/v1/producto"
        * def apilogin = call read('../auth/loginAuth.feature@login')
        * def token = apilogin.token
        * def tokenAuth = 'Bearer ' + token
        And header Authorization = tokenAuth

    Scenario: CP01 - Crear un nuevo producto exitoso
        * def data =
        """
        {
            "codigo": "HG0003",
            "nombre": "Laptop HP",
            "medida": "UND ",
            "marca": "Generico",
            "categoria": "Repuestos",
            "precio": "3500.00",
            "stock": "48",
            "estado": "3",
            "descripcion": "Ploma 14 pulgadas"
        }
        """
        And request data
        When method post
        Then status 200
        And match response contains { "nombre":"Laptop HP"}

    Scenario Outline: CP02 - Crear un nuevo producto exitoso desde un archivo externo
        And request { codigo: '#(codigo)', nombre: '#(nombre)', medida: '#(medida)', marca: '#(marca)', categoria: '#(categoria)', precio: '#(precio)', stock: '#(stock)', estado: '#(estado)', descripcion: '#(descripcion)' }
        When method post
        Then status 200

        Examples:
        | read("classpath:resources/csv/auth/dataProducts.csv") |


    Scenario: CP03 - Crear un nuevo producto repetido
        * def data =
        """
        {
            "codigo": "HG0003",
            "nombre": "Laptop HP",
            "medida": "UND ",
            "marca": "Generico",
            "categoria": "Repuestos",
            "precio": "3500.00",
            "stock": "48",
            "estado": "3",
            "descripcion": "Ploma 14 pulgadas"
        }
        """
        And request data
        When method post
        Then status 500
        And match response.error contains 'Integrity constraint violation'
        And print "Error: " + response.error

    Scenario: CP04 - Crear un nuevo producto sin codigo
        * def data =
        """
        {
            "codigo": "",
            "nombre": "Laptop HP",
            "medida": "UND ",
            "marca": "Generico",
            "categoria": "Repuestos",
            "precio": "3500.00",
            "stock": "48",
            "estado": "3",
            "descripcion": "Ploma 14 pulgadas"
        }
        """
        And request data
        When method post
        Then status 500
        And match response.codigo contains 'The codigo field is required.'
        And print "Error: " + response.codigo