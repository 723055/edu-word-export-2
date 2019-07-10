/**
 * Created by Leonid Bartenev
 */

public class AccountToDocxRemote {
    
    @AuraEnabled
    public static Account getAccount(Id accountId){
        try{
            return [
                    SELECT Id, Name, BillingCountry, BillingCity, BillingState, BillingStreet
                    FROM Account
                    WHERE Id =: accountId
            ];
        }catch (Exception e){
            return (Account)AuraHelper.throwException(e);
        }
    }

}