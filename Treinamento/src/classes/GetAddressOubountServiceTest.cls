/**
 * @author walmeida
 */
@isTest
public class GetAddressOubountServiceTest {
    @isTest
    public static void givenZipCodeWhenCallViaCepServiceThenReturnValidZipCodeAddress(){
        String payloadsuccess = '{ "cep": "01001-000", "logradouro": "Praça da Sé", "complemento": "lado ímpar", "bairro": "Sé", "localidade": "São Paulo", "uf": "SP", "ibge": "3550308", "gia": "1004", "ddd": "11", "siafi": "7107" } ';
        String payloaderror = '{"code" : "400", "message" : "failed"}';
        Test.setMock(HttpCallOutMock.class, new ViaCepFailHttpMock(payloaderror));
        GetAddressOubountService service = new GetAddressOubountService();
        Test.startTest();

        try{

            ZipCodeAddress response = service.findAddress('12227000');
            System.assert(false);

        }catch(CalloutException e ){

            System.assert(true);
        }
        Test.setMock(HttpCallOutMock.class, new ViaCepSuccessHttpMock(payloadsuccess));
        ZipCodeAddress response = service.findAddress('12227000');
        Test.stopTest();
        System.assertEquals(response.zipCode,'01001-000');
    }

    public class ViaCepSuccessHttpMock implements HttpCalloutMock{
        String payload;

        public ViaCepSuccessHttpMock (String payload){
            this.payload = payload;
        }

        public HttpResponse respond (HttpRequest request){
            HttpResponse response = new HttpResponse();
            response.setBody(payload);
            response.setStatusCode(200);
            return response;
        }
    }
    public class ViaCepFailHttpMock implements HttpCalloutMock{
        String payload;

        public ViaCepFailHttpMock (String payload){
            this.payload = payload;
        }

        public HttpResponse respond (HttpRequest request){
            HttpResponse response = new HttpResponse();
            response.setBody(payload);
            response.setStatusCode(400);
            return response;
        }
    }

}