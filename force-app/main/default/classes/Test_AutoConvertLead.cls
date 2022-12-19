@isTest
private class Test_AutoConvertLead {

    @isTest
    private static void TestAutoConvertLead() {
        // Test data setup
        //! get Account RecordType
        RecordType AccountRecordType = [
            SELECT
                Id,
                Name,
                DeveloperName,
                SobjectType
            FROM
                RecordType
            WHERE
                SobjectType = 'Account' 
                AND
                Name ='Household'];

        Account account = new account(
            Name= 'test account',
            RecordTypeId = AccountRecordType.Id
        );
        Insert account;

        //! get Contact Record Type
        RecordType ContactRecordType = [
            SELECT
                Id,
                Name,
                DeveloperName,
                SobjectType
            FROM
                RecordType
            WHERE
                SobjectType = 'Contact' 
                AND
                Name ='Guardian'];

        Contact contact = new Contact(
            FirstName= 'test first name',
            LastName= 'test last name',
            AccountId= account.Id,
            RecordTypeId = ContactRecordType.Id,
            Email = 'test@example.com'
        );
        Insert contact;

        //! get Lead Record Type
        RecordType LeadRecordType = [
            SELECT
                Id,
                Name,
                DeveloperName,
                SobjectType
            FROM
                RecordType
            WHERE
                SobjectType = 'Lead' 
                AND
                Name ='Student'];

        Lead lead = new Lead(
            FirstName= 'test first name',
            LastName= 'test last name',
            RecordTypeId = LeadRecordType.Id,
            Email = 'test@example.com',
            Status = 'Admitted',
            Company = 'test Company'
        );
        Insert lead;


        // Actual test
        Test.startTest();

            List<Id> Ids = new List<Id>();
            Ids.add(contact.Id);

            AutoConvertLead.AutoConvertLead(Ids);

        Test.stopTest();

        // Asserts
    }

}