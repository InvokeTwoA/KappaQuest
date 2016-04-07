// 冒険の記録
// 1レコードのみ作成される（userDefaultで良いじゃん、とかのツッコミは堪忍）
import Foundation
class PlayRecordModel: BaseModel {
    var _quest_count = 0
    
    override init() {
        super.init()
        self._table_name = "play_records"
        connectDB()
        
        createTable()
        if !isExistData() {
            initData()
        }
        
    }
    
    func createTable(){
        _db.open()
        let sql = "CREATE TABLE IF NOT EXISTS \(_table_name) ( id INTEGER PRIMARY KEY, quest_count INTEGER DEFAULT 0);"
        let ret = _db.executeUpdate(sql, withArgumentsInArray: nil)
        if ret {
            //print("テーブルの作成に成功")
        } else {
            print("テーブル作成に失敗")
        }
        _db.close()
    }
    
    func initData(){
        let sql = "INSERT INTO \(_table_name) (quest_count) VALUES (0);"
        print(sql)
        _db.open()
        let ret = _db.executeUpdate(sql, withArgumentsInArray: [])
        if ret {
            //print("テーブルの作成に成功")
        } else {
            print("データ追加に失敗")
        }
        _db.close()
    }
    
    // 一覧を取得
    func selectAllData() {
        let sql = "SELECT * FROM \(_table_name);"
        print(sql)
        _db.open()
        let results = _db.executeQuery(sql, withArgumentsInArray: nil)
        while results.next() {
            _quest_count = Int(results.intForColumn("quest_count"))
        }
        _db.close()
    }
    
    /*
    class func initWithFMResultSet(result: FMResultSet) -> PlayRecordModel {
        let play_record:PlayRecordModel = PlayRecordModel()
        play_record._quest_count = Int(result.intForColumn("quest_count"))
        return play_record
    }
*/
    
    func increment(key : String){
        let sql = "UPDATE \(_table_name) SET \(key) = \(key) + 1"
        print(sql)
        _db.open()
        let ret = _db.executeUpdate(sql, withArgumentsInArray: [])
        
        if ret {
            print("インクリメントに成功")
        } else {
            print("インクリメントに失敗")
        }
        _db.close()
    }
}