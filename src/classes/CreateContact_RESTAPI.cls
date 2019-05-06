/**
  * Description:
  * Exposing Apex REST API for Creating contact record in SFDC
  * 
 **/
@RestResource(urlMapping='/CreateContact_RESTAPI/*')
global class CreateContact_RESTAPI{
  @HttpPost
    global static ReturnClass doPost(String FirstName, String LastName, String Email) {
      
        // Map of all RecordType Names of the contact object
        Map <String,Schema.RecordTypeInfo> recordTypeMap = 
                Contact.sObjectType.getDescribe().getRecordTypeInfosByDeveloperName();
        Contact pCont;

        List<User> lstUser = [Select u.ContactId from User u]; 

        List<Contact> contList = new List<Contact>();
       
            pCont = new Contact(
                                  // retrieve the reqired Record Type Id
                                  RecordTypeId                = recordTypeMap.get('Contact_RecordType').getRecordTypeId(),
                                  FirstName                   = FirstName, 
                                  LastName                    = LastName, 
                                  Email                       = Email       
                                );

             contList.add(pCont);           
      
            try{
                    insert contList;
                    List<Contact> cCont    = [SELECT Id, AutoNumber__c
                                                FROM Contact
                                               WHERE Id IN:contList];
                        return new ReturnClass('TRUE','Contact Created Successfully.', cCont);
                }catch (Exception e)  {
                        return new ReturnClass('FALSE',e.getMessage(), NULL); } 
    }
    global class ReturnClass {

        global String success;
        global String message;
        global List<Contact> records;

        global ReturnClass(String success, String message, List<Contact> records) {
              this.success = success;
              this.message = message;
              this.records = records;
        }
    }
}