// キャラクタ管理クラス
import Foundation
import UIKit

class CharacterModel: BaseModel {
    
    var user_id : Int  = 0       // ID
    var name : String  = ""      // 名前
    var job : String   = ""      // 職業
    var gender : String  = ""    // 性別
    var nickname : String  = ""  // 通り名
    var lv : Int = 1

    override init() {
        super.init()
        self._table_name = "characters"
        connectDB()
    }
    
    func createTable(){
        _db.open()
        /*
        let sql2 = "DROP TABLE \(_table_name)"
        let ret2 = _db.executeUpdate(sql2, withArgumentsInArray: nil)
        if ret2 {
            print("テーブルの削除に成功")
        } else {
            print("テーブル削除に失敗")
        }
        */
        let sql = "CREATE TABLE IF NOT EXISTS \(_table_name) ( user_id INTEGER PRIMARY KEY, lv INTEGER, name TEXT, gender TEXT, job TEXT, nickname TEXT );"
        let ret = _db.executeUpdate(sql, withArgumentsInArray: nil)
        if ret {
            //print("テーブルの作成に成功")
        } else {
            print("テーブル作成に失敗")
        }
        _db.close()
    }

    // キャラクタを追加
    func insertData(name: String, job: String, gender: String, nickname: String){
        let sql = "INSERT INTO \(_table_name) (lv, name, job, gender, nickname) VALUES (1, ?, ?, ?, ?);"
        _db.open()
        let ret = _db.executeUpdate(sql, withArgumentsInArray: [name, job, gender, "通り名"])
        if ret {
            //print("テーブルの作成に成功")
        } else {
            print("データ追加に失敗")
        }
        _db.close()
    }
    
    // キャラクタ一覧を取得
    func selectAllData() -> Array<CharacterModel> {
        let sql = "SELECT * FROM \(_table_name) ORDER BY user_id;"
        _db.open()
        let results = _db.executeQuery(sql, withArgumentsInArray: nil)
        var characters:Array<CharacterModel> = Array<CharacterModel>()
        while results.next() {
            let character:CharacterModel = CharacterModel.initWithFMResultSet(results)
            characters.append(character)
        }
        _db.close()
        return characters
    }
    
    // FMDB の結果を characterModel にセット
    class func initWithFMResultSet(result: FMResultSet) -> CharacterModel {
        let character:CharacterModel = CharacterModel()
        character.user_id   = Int(result.intForColumn("user_id"))
        character.lv        = Int(result.intForColumn("lv"))
        character.name      = result.stringForColumn("name")
        character.job       = result.stringForColumn("job")
        character.gender    = result.stringForColumn("gender")
        character.nickname  = result.stringForColumn("nickname")
        return character
    }
    
    // user_id をキーに単一データを取得
    func selectData(user_id : Int) -> CharacterModel {
        let sql = "SELECT * FROM \(_table_name) WHERE user_id = ? LIMIT 1;"
        _db.open()
        let results = _db.executeQuery(sql, withArgumentsInArray: [user_id])
        var character = CharacterModel()
        while results.next() {
            character = CharacterModel.initWithFMResultSet(results)
        }
        _db.close()
        return character
    }
    
    // ユーザーの削除
    func destroyData(){
        let sql = "DELETE FROM \(_table_name) WHERE user_id = ?;"
        _db.open()
        let ret = _db.executeUpdate(sql, withArgumentsInArray: [self.user_id])
        if ret {
//            print("データ削除に成功")
        } else {
            print("データ削除に失敗")
        }
        _db.close()
    }
}