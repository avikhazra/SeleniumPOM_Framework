package CommonLIB;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;

import java.util.Iterator;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.util.SystemOutLogger;

import com.codoid.products.exception.FilloException;
import com.codoid.products.fillo.Connection;
import com.codoid.products.fillo.Fillo;
import com.codoid.products.fillo.Recordset;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
public class ExcelRead extends CommonFunctionLib {
		
		public static Object[][] ExtractDataWithOutFillo(String Excelpath,String sheetName) throws InvalidFormatException {
			Workbook book = null;
			Sheet sheet;
			FileInputStream File = null;
			Object[][] DataObject;
			try
	          {
				File = new FileInputStream(Excelpath);
				try {
					book = WorkbookFactory.create(File);
				
				}catch(Exception ex) {
					System.out.println(ex);				
				}
			}catch(FileNotFoundException ex) {
				System.out.println(ex);
				
			}
			sheet = book.getSheet(sheetName);
			//System.out.println(sheet.getLastRowNum());
			//System.out.println(sheet.getRow(0).getLastCellNum());
			DataObject = new Object[sheet.getLastRowNum()][sheet.getRow(0).getLastCellNum()];
		    for (int i = 0; i < sheet.getLastRowNum(); i++) {
				for (int k = 0; k < sheet.getRow(0).getLastCellNum(); k++) {
					DataObject[i][k] = sheet.getRow(i + 1).getCell(k).toString();
					
				}
			}
			return DataObject;
			
		}
	public static Object[][] ExtractDataWithFillo(String Excelpath,String sheetName) throws FilloException {
	Object[][] DataObject = null;
	Fillo fillo=new Fillo();
	Connection connection=fillo.getConnection(Excelpath);
	String strQuery="Select * from "+sheetName;
	Recordset recordset=connection.executeQuery(strQuery);
	//System.out.println(recordset.getCount());
	 DataObject = new Object[recordset.getCount()][recordset.getCount()-1];
	 int k=0;
	while(recordset.next()){
	    ArrayList<String> DataColumn=recordset.getFieldNames();
	   
	    Iterator<String> dataRowIte=DataColumn.iterator();
	 
	    
	    while(dataRowIte.hasNext()){
	        for (int i=0;i<=DataColumn.size()-1;i++){
	            //System.out.println(i);
	            String data=dataRowIte.next();
	            String key=recordset.getField(data);
	             String value=recordset.getField(DataColumn.get(i));
	             DataObject[k][0] = key;  
	             
	        }

	        break;
	    }
	    k++;
	}

	recordset.close();
	connection.close();
	return DataObject;
	}
	}

