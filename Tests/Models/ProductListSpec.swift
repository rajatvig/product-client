import Foundation
import SwiftyJSON
import Quick
import Nimble
import SwiftDate

class ProductListSpec: QuickSpec {
    override func spec() {
        describe("create") {
            it("should parse JSON") {
                let availableAt = "2016-07-24T06:01:50.690Z"
                let product1 = [
                    "name": "product1",
                    "url": "http://localhost:3000/product/1",
                    "related": [],
                    "availableAt": availableAt,
                    "productType": "book"
                ]
                let product2 = [
                    "name": "product2",
                    "url": "http://localhost:3000/product/2",
                    "related": [product1],
                    "availableAt": availableAt,
                    "productType": "book"
                ]

                let productList = ProductList(JSON([product1, product2]))

                expect(productList.products).to(haveCount(2))
                expect(productList.products).to(contain(Product(JSON(product1))))
                expect(productList.products).to(contain(Product(JSON(product2))))

                expect(productList).to(equal(ProductList(JSON([product1, product2]))))
            }
        }

        describe("isEqual") {
            it("should be equal for same JSON") {
                let availableAt = "2016-07-24T06:01:50.690Z"
                let product1 = [
                    "name": "product1",
                    "url": "http://localhost:3000/product/1",
                    "related": [],
                    "availableAt": availableAt,
                    "productType": "book"
                ]
                let product2 = [
                    "name": "product2",
                    "url": "http://localhost:3000/product/2",
                    "related": [product1],
                    "availableAt": availableAt,
                    "productType": "book"
                ]

                let productList = ProductList(JSON([product1, product2]))

                expect(productList).to(equal(ProductList(JSON([product1, product2]))))
            }

            it("should not be equal for same JSON") {
                let availableAt = "2016-07-24T06:01:50.690Z"
                let product1 = [
                    "name": "product1",
                    "url": "http://localhost:3000/product/1",
                    "related": [],
                    "availableAt": availableAt,
                    "productType": "book"
                ]
                let product2 = [
                    "name": "product2",
                    "url": "http://localhost:3000/product/2",
                    "related": [],
                    "availableAt": availableAt,
                    "productType": "book"
                ]

                let productList = ProductList(JSON([product1, product2]))

                expect(productList).toNot(equal(ProductList(JSON([product1]))))
            }

            it("should not be equal for different type") {
                let availableAt = "2016-07-24T06:01:50.690Z"
                let product1 = [
                    "name": "product1",
                    "url": "http://localhost:3000/product/1",
                    "related": [],
                    "availableAt": availableAt,
                    "productType": "book"
                ]
                let product2 = [
                    "name": "product2",
                    "url": "http://localhost:3000/product/2",
                    "related": [],
                    "availableAt": availableAt,
                    "productType": "book"
                ]

                let productList = ProductList(JSON([product1, product2]))

                expect(productList).toNot(equal(Product(JSON(product1))))
            }
        }

        describe("zzz") {
            it("zzz") {
            }
        }

    }
}
