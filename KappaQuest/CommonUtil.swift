//便利な関数
import Foundation
import SpriteKit
class CommonUtil {
    
    // 0 から max までの整数の乱数(maxは返らない)
    class func rnd(max : Int) -> Int {
        if(max <= 0){
            return 0
        }
        let rand = Int(arc4random_uniform(UInt32(max)))
        return rand
    }
    
    // 破壊的に配列をシャッフルするメソッド
    class func shuffleBang<T>(inout array: [T]) {
        for index in 0..<array.count {
            let newIndex = Int(arc4random_uniform(UInt32(array.count - index))) + index
            if index != newIndex {
                swap(&array[index], &array[newIndex])
            }
        }
    }
    
    // 破壊的でないシャッフル / Array(配列)のみ引数で渡せる
    class func shuffleArray<S>(source: [S]) -> [S] {
        var copy = source
        shuffleBang(&copy)
        return copy
    }
    
    // 距離の表示
    class func displayDistance(distance : Int) -> String{
        var distance_km : Int = 0
        var distance_m : Int = 0
        if(distance > 1000){
            distance_km = Int(distance / 1000)
            distance_m = distance%1000
        } else {
            distance_m = distance
        }
        if(distance_km > 0){
            return "\(distance_km) km \(distance_m) m"
        } else {
            return "\(distance_m) m"
        }
    }
    
    // お金の桁数表示（と年数表示）
    // 2,000,000 のように３桁ずつカンマで表示
    class func displayMoney(gold: Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        var str = ""
        if gold >= 0 {
            str = "所持金: \(formatter.stringFromNumber(gold)!)"
        } else {
            str = "所持金：　文無し"
        }
        return str
    }

    // 年数の表示
    func displayYear(day : Int) -> String{
        let year : Int = (day/365) + 1
        return "カッパ歴\(year)年 \(day)日目"
    }
    
    // スクリーンショットを撮る
    class func screenShot(view : UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 1.0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenShot
    }
    
    // 使用メモリを出力
    class func report_memory() {
        var info = task_basic_info()
        var count = mach_msg_type_number_t(sizeofValue(info))/4
        let kerr: kern_return_t = withUnsafeMutablePointer(&info) {
            task_info(mach_task_self_,
                task_flavor_t(TASK_BASIC_INFO),
                task_info_t($0),
                &count)
        }
        if kerr == KERN_SUCCESS {
            print("Memory in use (in bytes): \(info.resident_size)")
        }
        else {
            print("Error with task_info(): " +
                (String.fromCString(mach_error_string(kerr)) ?? "unknown error"))
        }
    }
}