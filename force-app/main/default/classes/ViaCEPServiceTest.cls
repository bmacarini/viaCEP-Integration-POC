@isTest
public class ViaCEPServiceTest {

        private class MockHttpSuccess implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {

            System.assertEquals('callout:viaCEP/ws/01001000/json/', req.getEndpoint());
            System.assertEquals('GET', req.getMethod());

            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            res.setBody('{"logradouro":"Praça da Sé","bairro":"Sé","localidade":"São Paulo","uf":"SP"}');
            return res;
        }
    }

        private class MockHttpInvalidCep implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {

            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            res.setBody('{"erro": true}');
            return res;
        }
    }

        private class MockHttpErrorResponse implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {

            HttpResponse res = new HttpResponse();
            res.setStatusCode(500);
            res.setBody('{"message": "Internal Server Error"}');
            return res;
        }
    }

    @isTest
    static void testCalloutSuccess() {
        Test.setMock(HttpCalloutMock.class, new MockHttpSuccess());
        AddressDTO res = ViaCEPService.getAddress('01001000');

        System.assertEquals('Praça da Sé', res.logradouro);
        System.assertEquals('Sé', res.bairro);
        System.assertEquals('São Paulo', res.localidade);
        System.assertEquals('SP', res.uf);
    }

    @isTest
    static void testCalloutInvalidCep() {
        Test.setMock(HttpCalloutMock.class, new MockHttpInvalidCep());
        AddressDTO res = ViaCEPService.getAddress('00000000');

        System.assertEquals(null, res.logradouro);
    }

    @isTest
    static void testCalloutErrorResponse() {
        Test.setMock(HttpCalloutMock.class, new MockHttpErrorResponse());
        try {
            AddressDTO res = ViaCEPService.getAddress('12345678');
            System.assert(false, 'Expected exception was not thrown');

        } catch (Exception e) {
            System.assert(e.getMessage().contains('500'));
        }
    }
}