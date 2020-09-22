/**
 * @author walmeida
 */
public class GetAddressOubountService { 
    
    ZipCodeAddressTransformer transformer;

    public GetAddressOubountService(){
        transformer = new ZipCodeAddressTransformer();
    }

    public ZipCodeAddress findAddress(String zipcode){
        return transformer.toAddress(findViaCepAddress(zipcode));
    }

    private ViaCepAddressResponse findViaCepAddress ( String zipCode ) {

        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://viacep.com.br/ws/' + zipCode + '/json/');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        Http http = new Http();
        HttpResponse response = http.send(request);

        String payload = response.getBody();

        System.debug('Status ---- ' + response.getStatus());
        System.debug('Status Code ' + response.getStatusCode());
        System.debug(payload);
        if (response.getStatusCode()>=400){
            throw new CalloutException('service unavailable');
        }
        
        return ( ViaCepAddressResponse ) JSON.deserialize( payload , ViaCepAddressResponse.class );
    
    }


}