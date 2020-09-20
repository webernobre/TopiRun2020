/**
 * @author walmeida
 */
public class GetAddressOubountService {


    public ViaCepAddressResponse findAddress ( String zipCode ) {

        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://viacep.com.br/ws/01001000/json/');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        Http http = new Http();
        HttpResponse response = http.send(request);

        String payload = response.getBody();

        System.debug('Status ---- ' + response.getStatus());
        System.debug('Status Code ' + response.getStatusCode());
        System.debug(payload);
        
        return ( ViaCepAddressResponse ) JSON.deserialize( payload , ViaCepAddressResponse.class );
    
    }


}