public with sharing class AddressDTO {
    @AuraEnabled
    public String logradouro;
    @AuraEnabled
    public String bairro;
    @AuraEnabled
    public String localidade;
    @AuraEnabled
    public String uf;
}