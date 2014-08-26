import vo.ConfigVO;

/**
 * 
 */

/**
 * @author moyubing
 * 
 */
public class FontTool {

	/**
	 * @param args
	 */

	public static void main(String[] args) {
		ConfigVO configVO = new ConfigVO(args[0]);
		configVO.output(args[1]);
	}
}
