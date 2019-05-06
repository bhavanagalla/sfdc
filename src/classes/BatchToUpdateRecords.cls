/**
  * 
  * Description:
  * This is a one time batch run when we want to make a field updated in all the records
  * This is achieved by executing following similar code in Developer Console
  * here, we are populating External_AutoNumber__c field value with AutoNumber__c value
  * *
  *   String q = 'SELECT Id, AutoNumber__c, External_AutoNumber__c FROM Contact';
  *   String f = 'External_AutoNumber__c';
  *   String v = 'AutoNumber__c';
  *   Id JobId = Database.executeBatch(new BatchToUpdateRecords(q,f,v));
  * *
  * 
 **/
global class ApexBatchToUpdateRecords implements Database.Batchable<sObject>{
    
    string Query;
    string Field;
    string Value;
    string Value1;
    
    //constructor
    public BatchToUpdateRecords(string q, string f, string v){
        Query=q; Field=f; Value=v;
    }
    
    //Start Method
    public Database.QueryLocator Start(Database.BatchableContext bc){
			Return Database.getQueryLocator(Query);
	  }

    //Execute Method 
	  public void Execute(Database.BatchableContext bc, List<sObject> scope){
                        
        for(sObject s : scope){
            //Get the value of the source field(value)
            Value1 = String.valueOf(s.get(Value));
            //assign source field value(value1) to target field(Field)
            s.put(Field, Value1);
        }
        update scope;
    }
    
    //Finish Method
    public void Finish(Database.Batchablecontext bc){
    }

}