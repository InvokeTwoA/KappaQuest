// アイテム管理クラス
import UIKit
var itemManager: ItemManager = ItemManager()

struct item {
    var name : String
    var desc : String
}

class ItemManager: NSObject {
    var tasks : [item] = []
    
    // アイテム追加
    func addItem(name : String, desc: String){
        tasks.append(item(name: name, desc: desc))
    }
}