import { LightningElement, track } from 'lwc';
import getAddress from '@salesforce/apex/ViaCEPService.getAddress';

export default class ViaCepLookup extends LightningElement {
    address = {};
    textValue = '';
    isLoading = false;
    hasAddress = false;
    error;

    handleInputChange(event) {
        this.textValue = event.target.value;
        if (!this.textValue) {
            this.handleClear();
        }
    }

    async handleSearch() {

        const input = this.template.querySelector('lightning-input');
        if (!input.checkValidity()) {
            input.reportValidity();
            return;
        }

        this.address = {};
        this.error = undefined;
        this.hasAddress = false;

        if (!this.textValue) {
            return;
        }

        try {
            this.isLoading = true;
            const result = await getAddress({ cep: this.textValue });

            if (result && Object.keys(result).length > 0) {
                this.address = result;
                this.error = undefined;
                this.hasAddress = true;
            } else {
                this.error = 'CEP não encontrado.';
            }
        } catch (error) {
            this.address = {};
            this.hasAddress = false;
            this.error = 'Aconteceu um erro: ' + (error.body?.message || error.message || 'Erro desconhecido');
        } finally {
            this.isLoading = false;
        }
    }

    handleClear() {
        this.address = {};
        this.textValue = '';
        this.hasAddress = false;
    }
}