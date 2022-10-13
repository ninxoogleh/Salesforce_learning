@RestResource(urlMapping='/propery/v1/*')
global class REST_Service_Property {
	
    @HttpGet
    global static String getProperty() {
        String uri = RestContext.request.requestURI.substringAfterLast('v1/');
        if (uri.contains('by_owner?owner=')) {
        	return JSON.serialize([SELECT Id FROM Property__c WHERE Owner__c = :uri.substringBetween('=<', '>')], true);
        } else if (uri.contains('report/')) {
            return JSON.serialize(new REST_Wrappers.Response(Date.valueOf(startDate), Date.valueOf(endDate), deals), true);
    	} else {
            return 'uri error';
        }
    }

    @HttpPost
    global static Property__c createNewProperty() {
        JSON.deserialize(RestContext.request.requestBody.toString());
        return PropertyManager.createPropertyShort(PropertyPreparer pp, true);
    }

    @HttpPut
    global static String changePropertyOwner() {
        REST_Wrappers.changeOwnerWrapper chow = (REST_Wrappers.changeOwnerWrapper)
                                                                      JSON.deserialize(RestContext.request.requestBody.toString(),
                                                                      REST_Wrappers.changeOwnerWrapper.class);

        Id ownerID = [SELECT Owner__c FROM Property__c WHERE Id = :chow.propertyId].Owner__c;
        Contact owner = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Id =:ownerID LIMIT 1];
        owner.Id = String.isNotEmpty(chow.newOwner.sfId) ? chow.newOwner.sfId : owner.Id;
        owner.FirstName = String.isNotEmpty(chow.newOwner.firstName) ? chow.newOwner.firstName : owner.FirstName;
        owner.LastName = String.isNotEmpty(chow.newOwner.lastName) ? chow.newOwner.lastName : owner.LastName;
        owner.Email = chow.newOwner.email;
        upsert owner;
        return JSON.serialize(owner);
    }
}