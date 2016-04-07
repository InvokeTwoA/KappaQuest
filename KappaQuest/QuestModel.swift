// 探検時の選択肢
import Foundation

import UIKit

class QuestModel {
    struct door {
        var key: String
        var image : UIImage
        var description : String
        var quested : Bool
    }
    
    var _choiceList: Array<door> = Array<door>()
    
    // ランダムな選択肢をセット
    func setRandomChoice(){
        // 上への階段は最低一つ
        _choiceList.append(createChoiceByKey("up"))
        for _ in 0...3 {
            // print(i)
            _choiceList.append(createDoor())
        }
        CommonUtil.shuffleArray(_choiceList)
    }
    
    // 選択肢を作成
    func createDoor() -> door {
        let newDoor : door
        
        let rnd : Int = CommonUtil.rnd(3)
        switch(rnd) {
        case 0:
            newDoor = createChoiceByKey("satsui")
        case 1:
            newDoor = createChoiceByKey("akari")
        case 2:
            newDoor = createChoiceByKey("escape_door")
        default:
            print("例外に入りました")
            newDoor = createChoiceByKey("escape_door")
        }
        return newDoor
    }
    
    // 選択肢を選んだ時に表示されるテキスト
    class func getText(key: String) -> String {
        switch(key){
        case "up":
            return "次の階へと進む階段を見つけた"
        case "goUp":
            return "君は上の階層へと進んだ……"
        case "escape_door":
            return "緊急用の出口だ。ここを通れば街に帰れる。"
        case "akari":
            return "邪悪な気配もない。少し休憩ができそうだ。"
        case "satsui":
            return "扉を開けると殺意に満ちた襲撃者が待ち構えていた！"
        case "back":
            return "まだその時ではない……君はそう判断して引き返した。"
        default:
            return "まだテキストは用意されていない"
        }
    }
    
    // 次の選択肢
    func setNewChoice(key : String){
        _choiceList = Array<door>()
        switch(key){
        case "up":
            _choiceList.append(createChoiceByKey("goUp"))
            _choiceList.append(createChoiceByKey("back"))
        case "goUp":
            _choiceList.append(createChoiceByKey("up"))
            _choiceList.append(createChoiceByKey("escape_door"))
        case "akari":
            _choiceList.append(createChoiceByKey("yasumu"))
        case "satsui":
            _choiceList.append(createChoiceByKey("battle"))
        case "escape_door":
            _choiceList.append(createChoiceByKey("goEscape"))
            _choiceList.append(createChoiceByKey("back"))
        default:
            break
        }
    }
    
    func createChoiceByKey(key: String) -> door {
        let image = UIImage(named: "kappa_32_32")
        var description : String = ""
        
        switch(key){
        case "up":
            description = "次の階への扉"
        case "escape_door":
            description = "緊急用の出口"
        case "goUp":
            description = "次の階へと進む"
        case "goEscape":
            description = "命がある内に帰る"
        case "akari":
            description = "明かりが漏れた扉"
        case "satsui":
            description = "殺意に満ちた扉"
        case "yasumu":
            description = "少し休む"
        case "battle":
            description = "応戦する"
        case "back":
            description = "まだこの階を探索する"
        default:
            break
        }
        return door(key: key, image: image!, description: description, quested: false)
    }
    
    

    
}