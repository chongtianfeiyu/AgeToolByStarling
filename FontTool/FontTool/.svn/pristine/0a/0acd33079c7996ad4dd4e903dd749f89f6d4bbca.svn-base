package vo;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import util.DataUtil;

public class ConfigVO {

	public Vector<FontVO> vecFontVO;

	public ConfigVO(String path) {

		vecFontVO = new Vector<FontVO>();
		SAXBuilder builder = new SAXBuilder(false);
		try {
			Document document = builder.build(path);
			Element root = document.getRootElement();
			@SuppressWarnings("unchecked")
			List<Element> list = root.getChildren("font");
			for (Iterator<Element> i = list.iterator(); i.hasNext();) {
				Element elem = (Element) i.next();
				vecFontVO.add(new FontVO(elem));
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JDOMException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void output(String embedPath) {
		int size = this.vecFontVO.size();
		for (int i = 0; i < size; i++) {
			FontVO fontVO = this.vecFontVO.get(i);
			String allStr = "";
			for (int j = 0; j < fontVO.vecAsFile.size(); j++) {
				AsFileConfigVO asVO = fontVO.vecAsFile.get(j);
				allStr += DataUtil.getValueInAsFile(asVO.path);
			}
			for (int j = 0; j < fontVO.vecXmlFile.size(); j++) {
				XmlFileConfigVO xmlVO = fontVO.vecXmlFile.get(j);
				for (int k = 0; k < xmlVO.vecColumn.size(); k++) {
					String columnName = xmlVO.vecColumn.get(k);
					allStr += DataUtil
							.getValueInXmlFile(xmlVO.path, columnName);
				}
			}
			allStr = DataUtil.deleteRepeatChar(allStr);
			DataUtil.writhTo(fontVO, embedPath,DataUtil.utf8ToUnicode(allStr));
		}
	}

}
