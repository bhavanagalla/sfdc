trigger ContactDuplicatePreventer on Contact (before insert, before update) {

    Map<String, Contact> contactMap = new Map<String, Contact>();
    for (Contact contact : System.Trigger.new) {
    
        // Make sure we don't treat an email address that  
        // isn't changing during an update as a duplicate.  
    
        if ((contact.Email != null) &&
                (System.Trigger.isInsert ||
                (contact.Email != 
                    System.Trigger.oldMap.get(contact.Id).Email))) {
    
            // Make sure another new contact isn't also a duplicate  
    
            if (contactMap.containsKey(contact.Email)) {
                contact.Email.addError('Another new contact has the '
                                    + 'same email address.');
            } else {
                contactMap.put(contact.Email, contact);
            }
       }
    }
  
    // Using a single database query, find all the contacts in  
    
    // the database that have the same email address as any  
    
    // of the contacts being inserted or updated.  
    
    for (contact contact : [SELECT Email FROM contact
                      WHERE Email IN :contactMap.KeySet()]) {
        contact newcontact = contactMap.get(contact.Email);
        newcontact.Email.addError('A contact with this email '
                               + 'address already exists.');
    }
}