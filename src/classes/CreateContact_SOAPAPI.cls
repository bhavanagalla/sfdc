/**
  * 
  * Description:
  * Exposing Apex SOAP API for Creating  contact record in SFDC
  * using Firstname, LastName and EmailId. 
  * 
 **/
global class CreateContact_SOAPAPI {

  webservice static ReturnClass doPost(String FirstName, String LastName, String Email) {
   
        // Map of all RecordType Names of the contact object
        Map <String,Schema.RecordTypeInfo> recordTypeMap = 
                Contact.sObjectType.getDescribe().getRecordTypeInfosByDeveloperName();

        // Create an empty list of Contacts
        List<Contact> contList = new List<Contact>();  
        Contact Con = new Contact(
                                    // retrieve the reqired Record Type Id
                                    RecordTypeId = recordTypeMap.get('Contact_RecordType').getRecordTypeId(),
                                    FirstName    = FirstName, 
                                    LastName     = LastName, 
                                    Email        = Email
                                   );
        contList.add(Con);           
    
        try{
              insert contList;
              
              List<Contact> cCont    = [SELECT Id, AutoNumber__c
                                          FROM Contact
                                         WHERE Id IN:contList
                                         LIMIT 1];

              return new ReturnClass('TRUE','Contact Created Successfully.', cCont);

            }catch (Exception e)  {
              return new ReturnClass('FALSE',e.getMessage(), NULL); } 
    }

    // ReturnClass Method
    global class ReturnClass {
        webservice String success;
        webservice String message;
        webservice List<Contact> records;

        global ReturnClass(String success, String message, List<Contact> records) {
              this.success = success;
              this.message = message;
              this.records = records;
        }
    }
}