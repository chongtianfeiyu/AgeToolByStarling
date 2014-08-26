package vo;

import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import org.jdom.Element;

public class FontVO {
	public String fontFamily;
	public String fontName;
	public String fontPath;
	public Vector<XmlFileConfigVO> vecXmlFile;
	public Vector<AsFileConfigVO> vecAsFile;

	@SuppressWarnings("unchecked")
	public FontVO(Element elem) {
		fontFamily = elem.getAttributeValue("fontFamily");
		fontName = elem.getAttributeValue("fontName");
		fontPath = elem.getAttributeValue("fontPath");
		vecXmlFile = new Vector<XmlFileConfigVO>();
		List<Element> xmlFileList = elem.getChildren("xmlfile");
		for (Iterator<Element> i = xmlFileList.iterator(); i.hasNext();) {
			Element xmlFileElem = (Element) i.next();
			vecXmlFile.add(new XmlFileConfigVO(xmlFileElem));
		}
		
		vecAsFile = new Vector<AsFileConfigVO>();
		List<Element> asFileList = elem.getChildren("asfile");
		for (Iterator<Element> i = asFileList.iterator(); i.hasNext();) {
			Element asFileElem = (Element) i.next();
			vecAsFile.add(new AsFileConfigVO(asFileElem));
		}
	}
}
