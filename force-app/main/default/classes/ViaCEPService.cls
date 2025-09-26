public with sharing class ViaCEPService {
    public static HttpResponse getAddress(String cep) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:viaCEP/ws/' + cep + '/json/');
        request.setMethod('GET');
        Http http = new Http();
        HttpResponse response = http.send(request);
        return response;
    }
}