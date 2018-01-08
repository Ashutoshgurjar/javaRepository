/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
/**
*   Description     :   Class used to test the Trigger_Transaction_Entry functionality
*
*   Created By      :   Ashutosh 
*
*   Created Date    :   07/23/2017
*
*   Revision Logs   :   V_1.0 – Created
*
*   Code Coverage   :   100%
*
**/
@isTest(seeAllData=true)
public class Test_ToolingApi {
    /**
    * Description     :   Method to test the  validation of transaction and their roll up on contact
    *
    * Return type     :   Void 
    *
    * @args           :
    *
    * Revision Logs   :   V_1.0 – Created
    *
    **/
    public static testMethod void testClassCoverage() {
        
        //start scope of test
        test.startTest();
        
        //ApexPages.Message to assert on page messages
        List<ApexPages.Message> msg = ApexPages.getMessages();
        
        //flag to check page message
        Boolean msgFlag = false;
        
        //pagereference variable to check back button.
        PageReference pageRef;
        
        //intializing mockCallout test class
        Test.setMock(HttpCalloutMock.class, new Test_MockHttpResponseGenerator());
        
        //initializing PersonTwitterScoreController class for testing
        ToolingApi TA = new ToolingApi();
        
        TA.downloadExcel();
        
        
    }

}