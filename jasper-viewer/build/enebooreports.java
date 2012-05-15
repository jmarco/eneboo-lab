import java.sql.*;
import java.util.*;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.view.JasperViewer;
import net.sf.jasperreports.engine.data.JRXmlDataSource;

public class enebooreports {
 
		public static void main(String[] args) {
			try {
 				String Archivo = args[0];
				long start = System.currentTimeMillis(); /* Para controlar el tiempo */
				if ( args[1].equals( "XMLDAT" ) )
								{	
						String recordPath = "/addressbook/category/person";
                                                JRXmlDataSource jrxmlds = new JRXmlDataSource(args[3],recordPath);
                                                HashMap hm = new HashMap();
						Connection conn = DriverManager.getConnection(args[2],args[3],args[4]);
						JasperReport report = JasperCompileManager.compileReport(Archivo);
						JasperPrint print = JasperFillManager.fillReport(report, hm, jrxmlds);
						JasperViewer viewer = new JasperViewer(print);
                                                viewer.setSize(850, 500); /* * Tamaño mas o menos adecuado. * */
						viewer.setVisible(true);


								
							   } else
								{
	                     
						
					Class.forName(args[1]);
					Connection conn = DriverManager.getConnection(args[2],args[3],args[4]);
					System.err.println("DB Connection time : " + (System.currentTimeMillis() - start));
					JasperReport report = JasperCompileManager.compileReport(Archivo);
					System.err.println("CompileReport time : " + (System.currentTimeMillis() - start));
					JasperPrint print = JasperFillManager.fillReport(report, null, conn);
					System.err.println("FillReport time : " + (System.currentTimeMillis() - start));
					JasperViewer viewer = new JasperViewer(print);
                                        viewer.setSize(850, 500); /* * Tamaño mas o menos adecuado. * */
					viewer.setVisible(true);
					System.err.println("Set Visible time : " + (System.currentTimeMillis() - start));
						                }
						
			} catch (JRException e) {
				e.printStackTrace();
			}catch (SQLException e) {
				e.printStackTrace();
			}		
			 catch (ClassNotFoundException e) {
				e.printStackTrace();
			} 
		
	}
}
