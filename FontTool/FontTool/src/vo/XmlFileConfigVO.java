package vo;

import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import org.jdom.Element;


public class XmlFileConfigVO {

	public String path;
	public Vector<String> vecColumn;

	@SuppressWarnings("unchecked")
	public XmlFileConfigVO(Element elem) {
		this.path = elem.getAttributeValue("path");
		vecColumn = new Vector<String>();
		List<Element> list =elem.getChildren("column");
		for (Iterator<Element> i = list.iterator(); i.hasNext();) {
			Element columnElem = (Element) i.next();
			vecColumn.add(columnElem.getAttributeValue("flag"));
		}
	}

}
