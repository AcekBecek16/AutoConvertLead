@isTest
private class Test_AutoConvertLead {

    @isTest
    private static void TestAutoConvertLead() {
        // Test data setup

        Account account = new account(
            Name= 'test account',
            RecordTypeId = '0121e000000rbPPAAY'
        );
        Insert account;

        Contact contact = new Contact(
            FirstName= 'test first name',
            LastName= 'test last name',
            AccountId= account.Id,
            RecordTypeId = '0125g0000020o7nAAA',
            Email = 'test@example.com'
        );
        Insert contact;

        Lead lead = new Lead(
            FirstName= 'test first name',
            LastName= 'test last name',
            RecordTypeId = '0125g000000Ny6uAAC',
            Email = 'test@example.com',
            Status = 'Enquiry',
            Company = 'test'
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