import Foundation
import SwiftyJSON
import SwiftDate

public class Product: NSObject {
    let name: String
    let url: NSURL
    let related: [Product]
    let availableAt: NSDate?
    let productType: ProductType

    public init(_ jsonData: JSON) {
        self.name = jsonData["name"].stringValue
        self.url = NSURL(fileURLWithPath: jsonData["url"].stringValue)
        self.related = jsonData["related"].arrayValue.map { return Product($0) }
        self.productType = ProductType(rawValue: jsonData["productType"].stringValue)!
        self.availableAt = jsonData["availableAt"].stringValue.toDate(DateFormat.ISO8601Format(.Extended))
    }

    public override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? Product else {
            return false
        }
        let lhs = self

        return lhs.url == rhs.url && lhs.name == rhs.name && lhs.availableAt == rhs.availableAt && rhs.productType == lhs.productType
    }

    public override var description: String {
        return "name=\(name),related=\(related),availableAt=\(availableAt),productType=\(productType)"
    }

    public enum ProductType: String {
        case Book = "book"
        case NewsPaper = "newspaper"
        case Magazine = "magazine"
    }

}
