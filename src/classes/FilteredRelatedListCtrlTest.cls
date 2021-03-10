@isTest
public class FilteredRelatedListCtrlTest {
    @TestSetup
    static void setupFilteredRelatedListCtrl() {

        Account acc = new Account();
        acc.Name = 'Test Account';

        insert acc;

        List<Contact> contacts = new List<Contact>();

        Contact c1 = new Contact();
        c1.FirstName = 'Test';
        c1.LastName = 'A';
        c1.AccountId = acc.Id;
        contacts.add(c1);

        Contact c2 = new Contact();
        c2.FirstName = 'Test';
        c2.LastName = 'B';
        c2.AccountId = acc.Id;
        contacts.add(c2);

        Contact c3 = new Contact();
        c3.FirstName = 'Test';
        c3.LastName = 'C';
        c3.AccountId = acc.Id;
        contacts.add(c3);
        
        insert contacts;
    }

    @isTest
    static void getParentSObjectIdTest() {
        String queryString = 'SELECT Id, Name FROM Account';

        Test.startTest();

        Account a = (Account) FilteredRelatedListCtrl.getParentSObject(queryString);

        Test.stopTest();

        System.assertNotEquals(null, a);
        System.assertNotEquals(null, a.Id);
        System.assertEquals('Test Account', a.Name);
    }

    @isTest
    static void getRelatedTest() {
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        Id accountId = acc.Id;
        String queryString = 'SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE AccountId = ';
        queryString +=  '\'' + String.escapeSingleQuotes(accountId) + '\'';
                
        Test.startTest();

        List<Contact> contacts = FilteredRelatedListCtrl.getRelated(queryString);

        Test.stopTest();

        System.assertEquals(false, contacts.isEmpty());
        System.assertEquals(3, contacts.size());
    }
    
    @isTest
    static void getMetadataForColumnsTest() {
        List<String> columns = new List<String>();
        columns.add('FirstName');
        columns.add('MobilePhone');
        columns.add('LastCURequestDate');
        columns.add('LeadSource');

        Test.startTest();

        Map<String, String> metadataForColumns = FilteredRelatedListCtrl.getMetadataForColumns('Contact', columns);

        Test.stopTest();

        System.assertEquals(4, metadataForColumns.keySet().size());
        for (String label : metadataForColumns.keySet()) {
            if (label.equals('First Name')) {
                System.assertEquals('First Name', label);
            }
            else if (label.equals('Mobile Phone')) {
                System.assertEquals('Mobile Phone', label);
            }
            else if (label.equals('Last Stay-in-Touch Request Date')) {
                System.assertEquals('Last Stay-in-Touch Request Date', label);
            }
            else if (label.equals('Lead Source')) {
                System.assertEquals('Lead Source', label);
            }
        }
        for (String fieldType : metadataForColumns.values()) {
            if (fieldType.equals('STRING')) {
                System.assertEquals('STRING', fieldType);
            }
            else if (fieldType.equals('DATETIME')) {
                System.assertEquals('DATETIME', fieldType);
            }
            else if (fieldType.equals('PHONE')) {
                System.assertEquals('PHONE', fieldType);
            }
            else if (fieldType.equals('PICKLIST')) {
                System.assertEquals('PICKLIST', fieldType);
            }
        }
    }
}