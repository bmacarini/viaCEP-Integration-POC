@isTest
public class ViaCEPServiceTest {

    private class MockHttpResponseGenerator implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {

        System.assertEquals('callout:viaCEP/ws/01001000/json/', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"cep":"01001-000","logradouro":"Praça da Sé","complemento":"lado ímpar","bairro":"Sé","localidade":"São Paulo","uf":"SP","ibge":"3550308","gia":"1004","ddd":"11","siafi":"7107"}');
        res.setStatusCode(200);
        return res;
    }
}

    @isTest
    static void testCallout() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        HttpResponse res = ViaCEPService.getAddress('01001000');

        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"cep":"01001-000","logradouro":"Praça da Sé","complemento":"lado ímpar","bairro":"Sé","localidade":"São Paulo","uf":"SP","ibge":"3550308","gia":"1004","ddd":"11","siafi":"7107"}';
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, res.getStatusCode());
    }
}