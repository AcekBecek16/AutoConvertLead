public class AutoConvertLead {

    @InvocableMethod(label='AutoConvertLeadStudent')
    public static void AutoConvertLead(List<Id> IDs) {

        String ContactConvertedID;

        //get Lead Status for Converted
        LeadStatus leadstatus = [SELECT Id, MasterLabel FROM LeadStatus Where IsConverted=true Limit 1];
        System.debug(leadstatus);

        Contact getContactParent = [SELECT Id, AccountId, Email, FirstName, LastName FROM Contact WHERE Id=:IDs Limit 1];

        List<Lead> cekleadChilds = [SELECT Id, Company, MobilePhone, FirstName, LastName, Email FROM Lead Where Email=:getContactParent.Email AND RecordTypeId='0125g000000Ny6uAAC'];
        List<Id> ChildLeadIDs = New List<Id>();
        for(Lead listLead : cekleadChilds){
            ChildLeadIDs.add(listLead.Id);
        }

        System.debug(ChildLeadIDs);

        //set Variable Collection -> MassLeadConvert
        List<Database.LeadConvert> MassLeadConvert = New List<Database.LeadConvert>();

        //Define Variable LeadConvert
        for(id CurrentLead : ChildLeadIDs){
            Database.LeadConvert leadconvert = New Database.LeadConvert();
            Lead ceklead = [SELECT Id, Company, MobilePhone, FirstName, LastName, Email FROM Lead Where Id=:CurrentLead Limit 1];
            leadconvert.setLeadId(CurrentLead);
            leadconvert.setConvertedStatus(leadstatus.MasterLabel);


            //set Don't Create Opportunity
            leadconvert.isDoNotCreateOpportunity();
            
            //set Account for Contact Student
            leadconvert.setAccountId(getContactParent.AccountId);

            //set Contact Student for Converted
            ContactConvertedID = leadconvert.getContactId();
            
            
            MassLeadConvert.add(leadconvert);
        }
        System.debug(MassLeadConvert);
        System.debug(ContactConvertedID);

        //Convert Lead
        if (!MassLeadConvert.isEmpty()) {
            try {
                List<Database.LeadConvertResult> leadconvertresult = Database.convertLead(MassLeadConvert);
                
            System.debug(leadconvertresult);
            } catch (Exception e) {
                System.debug(e);
            }
            
        }
       
    }
}
