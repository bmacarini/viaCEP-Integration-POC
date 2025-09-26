@isTest
public class ViaCEPServiceTest {

    private class MockHttpResponseGenerator implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {

        System.assertEquals('callout:viaCEP/ws/01001000/json/', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());

        HttpResponse res = new HttpResponse();
        res.setBody('{"logradouro":"Praça da Sé","bairro":"Sé","localidade":"São Paulo","uf":"SP"}');
        return res;
    }
}

    @isTest
    static void testCallout() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        AddressDTO res = ViaCEPService.getAddress('01001000');

        System.assertEquals('Praça da Sé', res.logradouro);
        System.assertEquals('Sé', res.bairro);
        System.assertEquals('São Paulo', res.localidade);
        System.assertEquals('SP', res.uf);
    }
}