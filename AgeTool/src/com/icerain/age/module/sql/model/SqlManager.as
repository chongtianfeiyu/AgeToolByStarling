package com.icerain.age.module.sql.model
{
	import flash.data.SQLConnection;
	import flash.filesystem.File;

	import com.icerain.age.module.sql.controller.SqlCmd;

	public class SqlManager
	{
		private static var _sql:SQLConnection;
		private static var _sqlFile:File;
		private static const path:String=File.applicationStorageDirectory.nativePath + "/agetool.sql";
		private static var _firstRun:Boolean;

		public function SqlManager()
		{
		}

		public static function get sql():SQLConnection
		{
			return _sql;
		}

		public static function init():void
		{
//			_sqlFile=new File(path);
//			_firstRun=!_sqlFile.exists;
//			_sql=new SQLConnection();
//			_sql.open(_sqlFile);
//			trace("打开数据库文件：" + _sqlFile.nativePath);
//			if (_firstRun)
//			{
//				runCreateTabelST();
//			}
		}

		private static function runCreateTabelST():void
		{
//			var sql:String="CREATE TABLE stage(id int,status varchar(255));" +
//				"INSERT INTO stage VALUES('1','challenge');"
//				+ "CREATE TABLE user(rp int,guessing varchar(255));" +
//				"INSERT INTO user VALUES('0','');";
			SqlCmd.instance.executeSQL("CREATE TABLE stage(id int,status varchar(255));");
			SqlCmd.instance.executeSQL("CREATE TABLE user(rp int,guessing varchar(255));");
			SqlCmd.instance.executeSQL("INSERT INTO user VALUES('0','');");
		}
	}
}
