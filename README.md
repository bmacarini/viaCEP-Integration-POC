# Salesforce External Integration – ViaCEP API (POC)

## 📌 Overview
This project is a proof of concept (POC) that demonstrates how to integrate Salesforce with an external REST API.  
The goal is to consume the **ViaCEP API** (Brazilian postal code service) using **Apex callouts**, **Named Credentials**, and display the response in a **Lightning Web Component (LWC)**.

## 🎯 Objectives
- Show how to configure **Named Credentials** for secure authentication
- Demonstrate an **Apex class** that performs a callout to an external service
- Handle **JSON responses** and map them into Salesforce objects (DTO pattern)
- Expose the results in a **Lightning Web Component** for end users
- Include **unit tests** to ensure reliability and maintainability

## 🛠️ Tech Stack
- **Apex** for HTTP callouts and JSON parsing  
- **Salesforce Named Credentials** for external authentication
- **Lightning Web Components (LWC)** for UI
- **Test Classes** to validate logic and maintain coverage 

## 📂 Project Structure
/force-app/main/default/classes

    ├─ AddressDTO.cls (Address DTO for structured API response)

    ├─ ViaCEPService.cls (Apex class for API integration)

    ├─ ViaCEPServiceTest.cls (Unit tests)

/force-app/main/default/lwc

    ├─ viaCepLookup (LWC for searching and displaying address data)

## ⚙️ CI/CD Pipeline
This project includes a **GitHub Actions workflow** to automate Salesforce deployments and testing:

- **Scratch Org Creation** – A temporary org is created for each PR to validate changes
- **Source Deployment** – Apex classes, DTOs, LWC and metadata are pushed automatically to the scratch org
- **Automated Apex Tests** – All tests, including ViaCEPServiceTest, run automatically to ensure code reliability
- **Scratch Org Deletion** – Temporary orgs are cleaned up after tests

**Workflow triggers:**

- Push or PR to `develop` → validates code in a scratch org
- Merge to `main` → represents production-ready code

## 🚀 How It Works
1. Configure a **Named Credential** in Salesforce:
   - URL: `https://viacep.com.br`
   - Authentication: None (public API)  


2. Use the `ViaCEPService` class to query an address by postal code (CEP)
   Example:
   ```apex
   String cep = '01001000'; 
   ViaCEPAddress result = ViaCEPService.getAddress(cep);
   System.debug(result);
3. The response is deserialized into a strongly typed Apex object
4. The LWC calls the Apex service and renders the data in the UI

## 🏗️ Integration Architecture

The integration with the public **ViaCEP** API was implemented to fetch address data based on a ZIP code provided by the user and **display the result directly in a Lightning Web Component**.

The flow works as follows:

1. The user enters a **ZIP code** in the LWC input
2. An **Apex Controller** is triggered to perform the HTTP request
3. The **ViaCEP service** returns a JSON response with the address details
4. The LWC displays the address information (street, neighborhood, city, state) in a Salesforce UI card 

### Architecture Diagram

    Salesforce User --> LWC (Lightning Web Component)
    LWC --> ApexController [Apex Controller]
    ApexController --> HTTP Callout [ViaCEP API]
    ViaCEP --> ApexController
    ApexController --> LWC (Displays result to user)
    
## ✅ Unit Tests
- ViaCEPServiceTest validates success and error scenarios.
- Covers both valid and invalid CEPs.

## 📖 References
- [ViaCEP API Documentation](https://viacep.com.br/)
- [Salesforce Named Credentials Guide](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_callouts_named_credentials.htm)
