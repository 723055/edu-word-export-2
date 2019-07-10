/**
 * Created by user on 5/16/2019.
 */

public with sharing class OpportunityToDocxRemote {

    @AuraEnabled
    public static Opportunity getOpportunity(Id opportId) {
        return [
                SELECT Id, CloseDate, CreatedBy.Name
                FROM Opportunity
                WHERE Id = :opportId
        ];
    }

}