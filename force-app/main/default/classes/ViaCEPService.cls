public with sharing class ViaCEPService {
    @AuraEnabled(cacheable=false)
    public static AddressDTO getAddress(String cep) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:viaCEP/ws/' + cep + '/json/');
        request.setMethod('GET');

        Http http = new Http();
        HttpResponse response = http.send(request);

        if(response.getStatusCode() != 200) {
            throw new CalloutException('Erro: ' + response.getStatusCode());
        }

        Map<String,Object> jsonResponse = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());

        AddressDTO address = new AddressDTO();
        address.logradouro = (String) jsonResponse.get('logradouro');
        address.bairro = (String) jsonResponse.get('bairro');
        address.localidade = (String) jsonResponse.get('localidade');
        address.uf = (String) jsonResponse.get('uf');
        
        return address;
    }
}