@automation-api
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
            "codigo": "ZZ1983",
            "nombre": "Laptop Asus",
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
        And match response contains { "nombre":"Laptop Asus"}
        And match response.id == '#number'
        * print "Se agrego el producto",data.codigo, "-" ,data.nombre, "exitosamente"


    Scenario Outline: CP02 - Crear un nuevo producto exitoso desde un archivo externo <codigo> - <nombre>
        And request { codigo: '#(codigo)', nombre: '#(nombre)', medida: '#(medida)', marca: '#(marca)', categoria: '#(categoria)', precio: '#(precio)', stock: '#(stock)', estado: '#(estado)', descripcion: '#(descripcion)' }
        When method post
        Then status 200
        And match response.id == '#number'
        * print "Se agrego el producto",response.codigo, "-" ,response.nombre, "exitosamente"

        Examples:
        | read("classpath:resources/csv/auth/dataNewProducts.csv") |


    Scenario: CP03 - Crear un producto repetido
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
        And print "El producto ya existe"

    Scenario: CP04 - Crear un nuevo producto sin codigo
        * def data =
        """
        {
            "codigo": "",
            "nombre": "Laptop DELL",
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
        And print "Debe ingresar el codigo del producto"