import Foundation

// Bad Code — недотримання конвенцій іменування та безпеки
class orderMgr {
    func calc(o: [String: Any]) -> Double {
        let p = o["price"] as! Double
        let q = o["qty"] as! Int
        var t = p * Double(q)
        if (t > 1000) {
            t = t * 0.9
        }
        return t * 1.2
    }
}

// Good Code — рефакторинг за правилами Swift API Design Guidelines
enum Pricing {
    static let discountThreshold = 1000.0
    static let discountFactor = 0.9
    static let taxFactor = 1.2
}

func totalPrice(for order: [String: Any]) -> Double? {
    guard let price = order["price"] as? Double,
          let quantity = order["quantity"] as? Int else {
        return nil
    }
    
    var total = price * Double(quantity)
    if total > Pricing.discountThreshold {
        total *= Pricing.discountFactor
    }
    
    return total * Pricing.taxFactor
}
