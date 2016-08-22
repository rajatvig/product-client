import Foundation
import SwiftyJSON

public class ProductList: NSObject {
    let products: [Product]

    public init(_ jsonData: JSON) {
        self.products = jsonData.arrayValue.map { return Product($0) }
    }

    public override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? ProductList else {
            return false
        }
        let lhs = self

        return lhs.products == rhs.products
    }

    public override var description: String {
        return "\(products)"
    }

}
