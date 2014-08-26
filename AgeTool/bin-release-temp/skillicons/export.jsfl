fl.outputPanel.clear();
 
var resourcePath = fl.browseForFolderURL("请选择素材路径：");
//var swfPath = fl.browseForFolderURL("请选择生成swf文件的路径：");

//var rootFolderEnd = resourcePath.lastIndexOf("/");
//var rootFolderName = resourcePath.substr(rootFolderEnd + 1, resourcePath.length - rootFolderEnd);
//fl.trace("rootFolderName: " + rootFolderName);

//var swfChildPath = rootFolderName;
analyseFolder(resourcePath, "");

//递归处理每个文件夹
function analyseFolder(folderPath, childFolderName) {
    
    fl.trace("文件夹: " + folderPath);
    
    /*
    if(childFolderName != "") {
        swfChildPath = swfChildPath + "/" + childFolderName;
        //fl.trace("创建文件夹：" + swfPath  + "/" + swfChildPath);
        FLfile.createFolder(swfPath  + "/" + swfChildPath);
    }
    */
    
    // 获取文件列表
    var fileList = FLfile.listFolder(folderPath, "files");
	var dom = fl.createDocument();
    var lib = dom.library;
    for(var i = 0; i < fileList.length; i++) {
        // 文件名
        var fileName = fileList[i];
        
        var filePath = folderPath + "/" + fileName;
        fl.trace("文件路径: " + filePath);
        
        var end = fileName.lastIndexOf(".");
        
        // 如果没有后缀或后缀不正确则略过
        if(end <= 0 || end == (fileName.length - 1)) {
            continue;
        }
        
        // 后缀
        var suffix = fileName.substr(end + 1, fileName.length - end);
        suffix = suffix.toLowerCase();
        
        // 不是PNG图片则略过
        if(suffix != "png") {
            continue;
        }
        
        // 不要后缀的文件名
        var shortName = fileName.substr(0, end);
        

        // 导入图片
        dom.importFile(filePath, true);
        
        // 选择项
        lib.selectItem(fileName);
        
        if(lib.getItemType() == "bitmap"){
            // 使用photo(JPEG)压缩
            lib.compressionType="photo";
            lib.quality = 80;
     
            // 使用文档的压缩质量，可在导出时设置
            lib.useImportedJPEGQulity = true;
         }
        
        lib.selectItem(shortName);
        lib.setItemProperty("linkageImportForRS", false);
        lib.setItemProperty("linkageExportForAS", true);
        lib.setItemProperty("linkageExportInFirstFrame", true);
        lib.setItemProperty("linkageBaseClass", "flash.display.BitmapData");
        lib.setItemProperty("linkageClassName",  shortName);
        
        // 放到舞台上
        /*
        lib.addItemToDocument({x:0,y:0});
        dom.selectAll();
        dom.convertToSymbol("movie clip",shortName,"top left");
        lib.selectItem(shortName);
        lib.setItemProperty("linkageImportForRS", false);
        lib.setItemProperty("linkageExportForAS", true);
        lib.setItemProperty("linkageExportForRS", false);
        lib.setItemProperty("linkageExportInFirstFrame", true);
        lib.setItemProperty("linkageIdentifier", shortName);
        dom.selectAll();
        dom.deleteSelection();
        */
        
        //var createSWFPath = swfPath  + "/" + swfChildPath;
        //fl.trace("createSWFPath: " + createSWFPath + "/" + shortName + ".swf");
 
    }
           
        dom.exportSWF(folderPath + "/" + shortName + ".swf", true);
        // 是否保存fla 文件
        fl.saveDocument(dom, folderPath + "/" + shortName + ".fla");
        dom.close(false);
    // 子文件夹
    var folderList = FLfile.listFolder(folderPath, "directories");
    
    for(var j = 0;j < folderList.length; j++) {
        var childFolder = folderList[j];
        
        fl.trace("文件夹: " + resourcePath + ", 子文件夹: " + childFolder);
        
         // 递归调用
        analyseFolder(folderPath + "/" + childFolder, childFolder);
    }
}