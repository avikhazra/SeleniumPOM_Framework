package Reports;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.reporter.ExtentHtmlReporter;
import com.aventstack.extentreports.reporter.configuration.ChartLocation;
import com.aventstack.extentreports.reporter.configuration.Theme;

public class ExtentReportManager {
    private static ExtentReports extent;
    private static String reportFileName= "";
    private static String reportFilepath = "";
    private static String reportFileLocation =  "";
  
 
    public static ExtentReports getInstance() { 
        if (extent == null)
            createInstance();
        return extent;
    }
 
    
    public static ExtentReports createInstance() {
        String fileName = getReportPath(reportFilepath);
       
        ExtentHtmlReporter htmlReporter = new ExtentHtmlReporter(fileName);
        htmlReporter.config().setTestViewChartLocation(ChartLocation.BOTTOM);
        htmlReporter.config().setChartVisibilityOnOpen(true);
        htmlReporter.config().setTheme(Theme.STANDARD);
        htmlReporter.config().setDocumentTitle(reportFileName);
        htmlReporter.config().setEncoding("utf-8");
        htmlReporter.config().setReportName(reportFileName);
        htmlReporter.config().setTimeStampFormat("EEEE, MMMM dd, yyyy, hh:mm a '('zzz')'");
 
        extent = new ExtentReports();
        extent.attachReporter(htmlReporter);
        //Set environment details
		extent.setSystemInfo("OS", "Windows");
 
        return extent;
    }
     
    //Create the report path
    private static String getReportPath (String path) {
    	
    	
    	String dirpath = Filecreation(System.getProperty("user.dir")+"/Reports");
    	Date dnow = new Date();
    	SimpleDateFormat dateF= new SimpleDateFormat("MM_dd_yyyy_hh_mm_ss_SS");
    	reportFilepath="Test-Automaton-Report_"+ dateF.format(dnow)+".html";
		reportFilepath=dirpath+"/"+reportFilepath;
		
    	return reportFilepath;
    }
    
    
    public  synchronized static String Filecreation(String FilecreationPath) {
		Date dnow = new Date();
		SimpleDateFormat dateF= new SimpleDateFormat("MM_dd_yyyy");
		String Foldername=dateF.format(dnow);
		String filepath=FilecreationPath+"/Test-Reports_"+Foldername;
		File thedir = new File(filepath);
		if(!thedir.exists()) {
			try {
				thedir.mkdirs();
				System.out.println("Path is created");
			}catch(SecurityException ex) {}
		}else {
			System.out.println("Path Is already exists");
		}

		return filepath;
	}
 
}