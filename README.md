# Salesforce External Integration – ViaCEP API (POC)

## 📌 Overview
This project is a proof of concept (POC) that demonstrates how to integrate Salesforce with an external REST API.  
The goal is to consume the **ViaCEP API** (Brazilian postal code service) using **Apex callouts** and **Named Credentials**, following Salesforce best practices for integrations.

## 🎯 Objectives
- Show how to configure **Named Credentials** for secure authentication.
- Demonstrate an **Apex class** that performs a callout to an external service.
- Handle **JSON responses** and map them into Salesforce objects.
- Include **unit tests** to ensure reliability and maintainability.

## 🛠️ Tech Stack
- **Apex** for HTTP callouts and JSON parsing  
- **Salesforce Named Credentials** for external authentication  
- **Test Classes** to validate logic and maintain coverage 

## 📂 Project Structure
/force-app/main/default/classes

    ├─ AddressDTO.cls (Address DTO for structured API response)

    ├─ ViaCEPService.cls (Apex class for API integration)

    ├─ ViaCEPServiceTest.cls (Unit tests)

## 🚀 How It Works
1. Configure a **Named Credential** in Salesforce:
   - URL: `https://viacep.com.br`
   - Authentication: None (public API)  


2. Use the `ViaCEPService` class to query an address by postal code (CEP).  
   Example:
   ```apex
   String cep = '01001000'; 
   ViaCEPAddress result = ViaCEPService.getAddress(cep);
   System.debug(result);

3. The response is deserialized into a strongly typed Apex object.

## 🏗️ Integration Architecture

The integration with the public **ViaCEP** API was implemented to automatically populate address data in **Accounts, Leads, and Contacts** based on the ZIP code provided by the user.

The flow works as follows:

1. The user enters a **ZIP code** in a Salesforce record.  
2. An **Apex Controller** is triggered to perform the HTTP request.  
3. The **ViaCEP service** returns a JSON response with the address details.  
4. Apex processes the response and updates the corresponding fields (street, neighborhood, city, state) on the record.  

### Architecture Diagram

    Salesforce User --> UI [Lightning Interface / Form]
    UI --> ApexController [Apex Controller]
    ApexController --> HTTP Callout [ViaCEP API]
    ViaCEP --> ApexController
    ApexController --> Salesforce DB [(Objects: Account, Lead, Contact)]


## ✅ Unit Tests
- ViaCEPServiceTest validates success and error scenarios.
- Covers both valid and invalid CEPs.

## 📖 References
- [ViaCEP API Documentation](https://viacep.com.br/)
- [Salesforce Named Credentials Guide](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_callouts_named_credentials.htm)
