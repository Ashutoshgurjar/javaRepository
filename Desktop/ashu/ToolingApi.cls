/**
*	Description 	:	class hold the logic how to fetch the test classes coverage using tooling api
*
*	Created By		:	Ashutosh 
*
*	Created Date 	: 	03/11/2017
*
*	Revision Logs	: 	V_1.0 – Created
*
**/
public class ToolingApi {
    
    ObjectWrapper wrapper;
    public List<SobjectsWrapper> listTestCoverage {get;set;}
    public String excelString{get;set;}
    public ToolingApi() {
        
        listTestCoverage= new List<SobjectsWrapper>();
        getObjects();
    }
    /**
    *	Description 	:	Method used to fetch the coverage of all test classes
    *
    *	Return type		:	Void 
    *
    *	@args			:	
    *
    *	Revision Logs	: 	V_1.0 – Created
    *
    **/
    public void getObjects() {
        
        //Initialize the HttpRequest
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        //system.assertEquals('d', System.URL.getSalesforceBaseUrl().toExternalForm());
        
        //This the setting query into the endPoint
        req.setEndpoint('https://ap5.salesforce.com/services/data/v41.0/tooling/query/?q=Select+id,ApexClassorTrigger.Name,NumLinesCovered,NumLinesUncovered+from+ApexCodeCoverageAggregate');
        //req.setEndpoint('https://ap5.salesforce.com/services/data/v41.0/tooling/sobjects/');
        req.setMethod('GET'); 
        excelString = '<table border = "1"><tr><td>';
        excelString += 'Class Name</td><td>Coverage</td></tr>';
        
        //Initialize the http url
        Http h = new Http();
        HttpResponse res = h.send(req);
        
        //Parse the json into the json to apex convertor class
       	TestCoverageResponseReader1  testCoverage =  TestCoverageResponseReader1.parse(res.getBody());
        
        //Iterate on all the test classes record
		for(TestCoverageResponseReader1.Records test : testCoverage.Records) {
            
            Integer coverage;
            Double covered = test.NumLinesCovered;
            Double unCovered = test.NumLinesCovered;
            Double base = test.NumLinesCovered + test.NumLinesUncovered;
            
            //Check that base of finding coverage percent is not zero
            if(test.NumLinesCovered + test.NumLinesUncovered != 0) {
                coverage = Integer.valueOf((covered/base) * 100);
                listTestCoverage.add(new SobjectsWrapper(test.ApexClassOrTrigger.Name, coverage));
                excelString += '<tr><td>'+test.ApexClassOrTrigger.Name+'</td><td>'+coverage+'</td></tr>';
            }
        }
        excelString += '</table>';
    }
    /**
    *	Description 	:	Method redirect to the excel page
    *
    *	Return type		:	Void 
    *
    *	@args			:	Decimal,String,String
    *
    *	Revision Logs	: 	V_1.0 – Created
    *
    **/
    public PageReference downloadExcel() {
        PageReference pageRef = page.TestClassExcel;
        pageRef.setRedirect(false);
        return pageRef;
    }
    
    
    public class ObjectWrapper {
        
        List<SobjectsWrapper> sobjects;
    }
  /**
    *	Description 	:	Wrapper class to hold different type of values
    *
    *	Created By		:	Ashutosh 
    *
    *	Created Date 	: 	03/11/2017
    *
    *	Revision Logs	: 	V_1.0 – Created
    *
    **/
    public class SobjectsWrapper {
        public String className{get;set;}
        public String NumLinesCovered{get;set;}
        public String NumLinesUncovered{get;set;}
        public String coverage{get;set;}
        public SobjectsWrapper(String className, Integer coverage) {
            this.className = className;
            this.coverage = String.valueOf(coverage);
        }
    }
}