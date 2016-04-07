import Foundation

class BaseModel {
    var _table_name : String = "table_name"
    var _db : FMDatabase = FMDatabase.init()

    func connectDB(){
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory,
            .UserDomainMask, true)
        let path = paths[0].stringByAppendingPathComponent("kappa_quest.db")
        _db = FMDatabase(path: path)
    }
    
    // DBの初期化
    func resetAllData(){
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory,
            .UserDomainMask, true)
        let path = paths[0].stringByAppendingPathComponent("kappa_quest.db")
        let manager = NSFileManager()
        
        do {
            try manager.removeItemAtPath(path)
        }
        catch let error as NSError {
            print("データリセット失敗 \(error.description)")
        }
    }
    

    // テーブルが存在するかどうか
    // false: 存在しない　 true: 存在する
    func isExistTable() -> Bool {
        let sql = "SELECT COUNT(*) AS table_count FROM sqlite_master WHERE type='table' AND name = '\(_table_name)'"
        _db.open()
        let results = _db.executeQuery(sql, withArgumentsInArray: nil)
        var result : Int = 0
        while results.next() {
            result = Int(results.intForColumn("table_count"))
        }
        _db.close()
        if result == 0 {
            return false
        } else {
            return true
        }
    }
    
    // データが存在するかどうか
    // false: 存在しない　 true: 存在する
    func isExistData() -> Bool {
        let sql = "SELECT COUNT(*) AS data_count FROM \(_table_name)"
        _db.open()
        let results = _db.executeQuery(sql, withArgumentsInArray: nil)
        var result : Int = 0
        while results.next() {
            result = Int(results.intForColumn("data_count"))
        }
        _db.close()
        if result == 0 {
            return false
        } else {
            return true
        }
    }
    
    // テーブルの削除
    func dropTable(){
        _db.open()
        let sql = "DROP TABLE \(_table_name)"
        let ret = _db.executeUpdate(sql, withArgumentsInArray: nil)
        if ret {
            print("テーブルの削除に成功")
        } else {
            print("テーブル\(_table_name)削除に失敗")
        }
        _db.close()
    }
}

