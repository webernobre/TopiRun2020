/**
 * @author walmeida
 */
public class SearchAddressCtrl {

    @AuraEnabled
    public static ZipCodeAddress searchAddress(String zipCode){

        GetAddressOubountService service = new GetAddressOubountService();

        return service.findAddress(zipCode);

    }

}