import Foundation
import SwiftyJSON
import Quick
import Nimble
import SwiftDate

class ProductSpec: QuickSpec {
    override func spec() {
        describe("create") {
            it("should parse JSON") {
                let availableAt = "2016-07-24T06:01:50.690Z"
                let product1 = Product(JSON([
                            "name": "product1",
                            "url": "http://localhost:3000/product/1",
                            "related": [],
                            "availableAt": availableAt,
                            "productType": "book"
                        ]))

                expect(product1.name).to(equal("product1"))
                expect(product1.url).to(equal(NSURL(fileURLWithPath: "http://localhost:3000/product/1")))
                expect(product1.related).to(beEmpty())
                expect(product1.productType).to(equal(Product.ProductType.Book))
                expect(product1.availableAt).to(equal(availableAt.toDate(DateFormat.ISO8601Format(.Extended))))
            }

            it("should parse related products JSON") {
                let availableAt = "2016-07-24T06:01:50.690Z"

                let relatedProduct1JSON = [
                    "name": "product2",
                    "url": "http://localhost:3000/product/2",
                    "availableAt": availableAt,
                    "productType": "magazine"
                ]
                let relatedProduct2JSON = [
                    "name": "product3",
                    "url": "http://localhost:3000/product/2",
                    "availableAt": availableAt,
                    "productType": "magazine"
                ]

                let product1 = Product(JSON([
                            "name": "product1",
                            "url": "http://localhost:3000/product/1",
                            "related": [relatedProduct1JSON, relatedProduct2JSON],
                            "availableAt": availableAt,
                            "productType": "book"
                        ]))

                expect(product1.name).to(equal("product1"))
                expect(product1.url).to(equal(NSURL(fileURLWithPath: "http://localhost:3000/product/1")))
                expect(product1.related).to(contain(Product(JSON(relatedProduct1JSON))))
                expect(product1.related).to(contain(Product(JSON(relatedProduct2JSON))))
                expect(product1.productType).to(equal(Product.ProductType.Book))
                expect(product1.availableAt).to(equal(availableAt.toDate(DateFormat.ISO8601Format(.Extended))))
            }
        }

        describe("isEqual") {
            it("should be equal for same JSON") {
                let availableAt = "2016-07-24T06:01:50.690Z"
                let productData1 = [
                    "name": "product1",
                    "url": "http://localhost:3000/product/1",
                    "related": [],
                    "availableAt": availableAt,
                    "productType": "book"
                ]

                let product = Product(JSON(productData1))

                expect(product).to(equal(Product(JSON(productData1))))
            }

            it("should not be equal for same JSON") {
                let availableAt = "2016-07-24T06:01:50.690Z"
                let productData1 = [
                    "name": "product1",
                    "url": "http://localhost:3000/product/1",
                    "related": [],
                    "availableAt": availableAt,
                    "productType": "book"
                ]
                let productData2 = [
                    "name": "product2",
                    "url": "http://localhost:3000/product/2",
                    "related": [],
                    "availableAt": availableAt,
                    "productType": "book"
                ]

                let product1 = Product(JSON(productData1))
                let product2 = Product(JSON(productData2))

                expect(product1).toNot(equal(product2))
            }

            it("should not be equal for different type") {
                let availableAt = "2016-07-24T06:01:50.690Z"
                let productData1 = [
                    "name": "product1",
                    "url": "http://localhost:3000/product/1",
                    "related": [],
                    "availableAt": availableAt,
                    "productType": "book"
                ]

                let product = Product(JSON(productData1))

                expect(product).toNot(equal(productData1))
            }
        }

        describe("zzz") {
            it("zzz") {
            }
        }
    }

}
