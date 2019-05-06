[![Build Status](https://travis-ci.org/servicecatalog/oscm-soap-mock.svg?branch=master)](https://travis-ci.org/servicecatalog/oscm-soap-mock)

# oscm-soap-mock

This is web application which serves as a mock for testing the OSCM SOAP APIs.

## deploy
1. Run `mvn package`
2. Copy /oscm-soap-mock/target/oscm-soap-mock.war into running oscm-core container:

   ``` docker cp `<path>/`oscm-soap-mock.war oscm-core:/opt/apache-tomee/apps ```
   
3. Open `https://<FQDN>:8081/oscm-soap-mock`   
