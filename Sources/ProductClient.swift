import Foundation
import Alamofire
import SwiftyJSON

public class ProductClient {

    let baseUrl: String

    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    public func getProducts(success: (ProductList) -> Void, error: (Int) -> Void) -> Void {
        makeCall("\(baseUrl)/products", success: { (jsonObj) in
                     success(ProductList(jsonObj))
            },
                 error: {(statusCode) in
                     error(statusCode)
            })
    }

    public func getProduct(productId: String, success: (Product) -> Void, error: (Int) -> Void) -> Void {
        makeCall("\(baseUrl)/products/\(productId)", success: { (jsonObj) in
                     success(Product(jsonObj))
            },
                 error: {(statusCode) in
                     error(statusCode)
            })
    }

    public func deleteProduct(productId: String, success: () -> Void, error: () -> Void) -> Void {
        let headers = [
            "Accept": "application/json"
        ]

        Alamofire.request(.DELETE, "\(baseUrl)/products/\(productId)", headers: headers)
          .validate()
          .response { request, response, data, reqerror in
            guard reqerror == nil else {
                print("error while deleting product: \(reqerror)")
                error()
                return
            }

            success()
        }
    }

    private func makeCall(url: String, success: (JSON) -> Void, error: (Int) -> Void) -> Void {
        let headers = [
            "Accept": "application/json"
        ]

        Alamofire.request(.GET, url, headers: headers)
          .validate()
          .responseJSON { response in
            guard response.result.isSuccess else {
                print("error while performing get: \(url) : \(response.result.error)")
                error(response.response!.statusCode)
                return
            }

            if let value = response.result.value {
                success(JSON(value))
            }
        }
    }
}
