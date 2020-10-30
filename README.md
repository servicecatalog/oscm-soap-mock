[![Build Status](https://travis-ci.org/servicecatalog/oscm-soap-mock.svg?branch=master)](https://travis-ci.org/servicecatalog/oscm-soap-mock)

# oscm-soap-mock

This is web application which serves as a mock for testing the OSCM SOAP APIs.

## Deploy
1. Run `mvn package`
2. Copy /oscm-soap-mock/target/oscm-soap-mock.war into running oscm-core container:

   ``` docker cp `<path>/`oscm-soap-mock.war oscm-core:/opt/apache-tomee/apps ```
   
3. Open `https://<FQDN>:8081/oscm-soap-mock`

## Short Use Case
### Provisioning Service Mock
1. Login to oscm-portal as supplier user having service manager and technology manager roles
2. Import the technical service template using [this XML file](https://github.com/servicecatalog/oscm-soap-mock/blob/master/TechnicalService_SoapMock.xml).
3. Create a marketable service from this mock service and choose a free price model
4. Publish your service offer to your marketplace and activate it
5. Find the service in the marketplace portal and subscribe it.
   Note down the subscription name you have chosen.
   
The subscription stays in pending and you need to complete it with this mock-up application

### Subscription Service API ###
Complete the pending subscription as follows.
1. Open https://FQDN:8081/oscm-soap-mock 
2. In the Settings table enter following values and save them:
``` 
   Base URL       : http:oscm-core:8080/
   User Name      : 10000 (give the user key of your supplier user)
   Password       : ***** (give the password of your supplier user)
   Authentication : BASIC AUTH 
```
   
3. Scroll down the left menu list and select *SubscriptionService.completeAsyncSubscription*
4. Enter following values in the Parameter table. Click 'Execute' to run this SOAP API call. 
```
   Subscription Id : the name of the subscription you have chosen
   Organization Id : 959c9bf7 (find the organization id in the user profile of your supplier user)
   Instance Id     : instance_20201030181512 (just any unique ASCII String label)   
   Base URL        : http://oscm-core:8080/oscm-soap-mock  
   Access Info     : https://FQDN:8081/oscm-soap-mock (replace FQDN here)   
   Login Path      : /login
```   
5. Back the to marketplace portal, after refershing your subscription it turns into ready state
6. Assign the supplier user to the subscription

### Operation Service Mock
Now you can use the operations, which are defined in the technical service.
1. As supplier user, locate the subscription in the My Subscriptions view and find the operation menu
2. Choose the Create Snapshot operation from the drop down
3. Choose a server, a comment and execute the operation
4. Ready! 

Since the operation is mocked, it returns very fast. Longer running actions can be tracked the Operations view, available in the marketplace account menu.

Have fun!
   
