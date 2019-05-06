@istest
public class CreateContact_RESTAPI_TEST{
    // Test with valid inputs
	static testMethod void Test1(){
       Test.startTest(); 
            String FirstName = 'Contact';
            String LastName  = 'Test';
            String Email     = 'Contact@test.com' ;
   	  
            CreateContact_RESTAPI reqst=new CreateContact_RESTAPI();
            String JsonMsg=JSON.serialize(reqst);
            RestRequest req  = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.requestURI  = '/CreateContact_RESTAPI';  //Request URL
            req.httpMethod  = 'POST';//HTTP Request Type
            req.requestBody = Blob.valueof(JsonMsg);
            RestContext.request = req;
            RestContext.response= res;
            CreateContact_RESTAPI.ReturnClass results = CreateContact_RESTAPI.doPost(FirstName, LastName, Email);
            System.assertEquals('TRUE', results.success);
            System.assertEquals(1, results.records.size());
            System.assertEquals('Contact Created Successfully.', results.message);
        Test.stopTest();
   }
   // Test with invalid inputs ie., invalid email
    static testMethod void Test2(){
       Test.startTest(); 
            String FirstName = 'Contact';
            String LastName  = 'Test';
            String Email     = 'Contact@testcom' ;
      
            CreateContact_RESTAPI reqst=new CreateContact_RESTAPI();
            String JsonMsg=JSON.serialize(reqst);
            RestRequest req  = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.requestURI  = '/CreateContact_RESTAPI';  //Request URL
            req.httpMethod  = 'POST';//HTTP Request Type
            req.requestBody = Blob.valueof(JsonMsg);
            RestContext.request = req;
            RestContext.response= res;
            CreateContact_RESTAPI.ReturnClass results = CreateContact_RESTAPI.doPost(FirstName, LastName, Email);
            System.assertEquals('FALSE', results.success);
            System.assertNotEquals('Contact Created Successfully.', results.message);
        Test.stopTest();
   }
}