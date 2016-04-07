// フラグ管理クラス
// key: フラグの key
// value: 0か1か

import Foundation
class FlagKeyValueModel: BaseModel {
    
    var _key : String = ""
    var _value : Int = 0
    
    override init() {
        super.init()
        self._table_name = "flag_key_values"
        connectDB()
        
        // データがなければ作成
        createTable()
    }
    
    func createTable(){
        _db.open()
        let sql = "CREATE TABLE IF NOT EXISTS \(_table_name) ( key TEXT PRIMARY KEY, value INTEGER);"
        let ret = _db.executeUpdate(sql, withArgumentsInArray: nil)
        if ret {
            //print("テーブルの作成に成功")
        } else {
            print("テーブル作成に失敗")
        }
        _db.close()
    }
    
    // 一覧を取得
    func selectAllData() -> Array<FlagKeyValueModel> {
        let sql = "SELECT * FROM \(_table_name) ORDER BY user_id;"
        _db.open()
        let results = _db.executeQuery(sql, withArgumentsInArray: nil)
        var flag_key_values : Array<FlagKeyValueModel> = Array<FlagKeyValueModel>()
        while results.next() {
            let flag_key_value = FlagKeyValueModel()
            flag_key_value._key = String(results.stringForColumn("key"))
            flag_key_value._value = Int(results.intForColumn("value"))

            flag_key_values.append(flag_key_value)
        }
        _db.close()
        return flag_key_values
    }    
}