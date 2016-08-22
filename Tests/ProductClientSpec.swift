import SwiftyJSON
import Quick
import Nimble
import OHHTTPStubs

class ProductClientSpec: QuickSpec {
    override func spec() {
        afterEach {
            OHHTTPStubs.removeAllStubs()
        }

        describe("get all products") {
            it("gets all the products") {
                let url = "http://localhost"
                let jsonObj = [
                    [
                        "name": "product1",
                        "availableAt": "2016-07-24T06:01:50.690Z",
                        "related": [],
                        "productType": "book",
                        "url": "/products/1"
                    ],
                    [
                        "name": "product2",
                        "availableAt": "2016-07-24T06:01:50.690Z",
                        "related": [],
                        "productType": "book",
                        "url": "/products/2"
                    ],
                    [
                        "name": "product3",
                        "availableAt": "2016-08-24T06:01:50.690Z",
                        "related": [],
                        "productType": "magazine",
                        "url": "/products/3"
                    ],
                    [
                        "name": "product4",
                        "availableAt": "2016-06-24T06:01:50.690Z",
                        "related": [],
                        "productType": "book",
                        "url": "/products/4"
                    ]
                ]

                stub(isHost("localhost") && isPath("/products") && isMethodGET()) { _ in
                    return OHHTTPStubsResponse(JSONObject: jsonObj, statusCode: 200, headers: nil)
                }

                let productClient = ProductClient(baseUrl: url)

                var completionCalled = false

                productClient.getProducts({ (productList) in
                                              completionCalled = true
                                              expect(productList.products).to(haveCount(4))
                                          },
                                          error: { (_) in
                                              completionCalled = true
                                              expect(true).to(equal(false))
                                          }
                )

                expect(completionCalled).toEventually(beTrue(), timeout: 10)
            }

            it("returns error when if fails get the products") {
                let url = "http://localhost"

                stub(isHost("localhost") && isPath("/products") && isMethodGET()) { _ in
                    return OHHTTPStubsResponse(JSONObject: [], statusCode: 500, headers: nil)
                }

                let productClient = ProductClient(baseUrl: url)

                var completionCalled = false

                productClient.getProducts({ (_) in
                                              completionCalled = true
                                              expect(true).to(equal(false))
                                          },
                                          error: { (statusCode) in
                                              completionCalled = true
                                              expect(statusCode).to(equal(500))
                                          }
                )

                expect(completionCalled).toEventually(beTrue(), timeout: 10)
            }
        }

        describe("get product") {
            it("gets the product") {
                let productId = NSUUID().UUIDString
                let productUrl = "/products/\(productId)"

                let url = "http://localhost"
                let jsonObj = [
                    "name": "product1",
                    "availableAt": "2016-07-24T06:01:50.690Z",
                    "related": [],
                    "productType": "book",
                    "url": productUrl
                ]

                stub(isHost("localhost") && isPath(productUrl) && isMethodGET()) { _ in
                    return OHHTTPStubsResponse(JSONObject: jsonObj, statusCode: 200, headers: nil)
                }

                let productClient = ProductClient(baseUrl: url)

                var completionCalled = false

                productClient.getProduct(productId,
                                         success: { (product) in
                                             completionCalled = true
                                             expect(product).to(equal(Product(JSON(jsonObj))))
                                         },
                                         error: { (_) in
                                             completionCalled = true
                                             expect(true).to(equal(false))
                                         }
                )

                expect(completionCalled).toEventually(beTrue(), timeout: 10)
            }

            it("returns error when if fails get the product") {
                let url = "http://localhost"
                let productId = NSUUID().UUIDString
                let productUrl = "/products/\(productId)"

                stub(isHost("localhost") && isPath(productUrl) && isMethodGET()) { _ in
                    return OHHTTPStubsResponse(JSONObject: [], statusCode: 500, headers: nil)
                }

                let productClient = ProductClient(baseUrl: url)

                var completionCalled = false

                productClient.getProduct(productId,
                                         success: { (_) in
                                             completionCalled = true
                                             expect(true).to(equal(false))
                                         },
                                         error: { (statusCode) in
                                             completionCalled = true
                                             expect(statusCode).to(equal(500))
                                         }
                )

                expect(completionCalled).toEventually(beTrue(), timeout: 10)
            }
        }

        describe("delete product") {
            it("deletes the product") {
                let url = "http://localhost"
                let productId = NSUUID().UUIDString
                let productUrl = "/products/\(productId)"

                stub(isHost("localhost") && isPath(productUrl) && isMethodDELETE()) { _ in
                    return OHHTTPStubsResponse(JSONObject: [], statusCode: 202, headers: nil)
                }

                let productClient = ProductClient(baseUrl: url)

                var completionCalled = false

                productClient.deleteProduct(productId,
                                            success: { (product) in
                                                completionCalled = true
                                            },
                                            error: { (_) in
                                                completionCalled = true
                                                expect(true).to(equal(false))
                                            }
                )

                expect(completionCalled).toEventually(beTrue(), timeout: 10)
            }

            it("returns error when if fails delete the product") {
                let url = "http://localhost"
                let productId = NSUUID().UUIDString
                let productUrl = "/products/\(productId)"

                stub(isHost("localhost") && isPath(productUrl) && isMethodDELETE()) { _ in
                    return OHHTTPStubsResponse(JSONObject: [], statusCode: 500, headers: nil)
                }

                let productClient = ProductClient(baseUrl: url)

                var completionCalled = false

                productClient.deleteProduct(productId,
                                            success: { (_) in
                                                completionCalled = true
                                                expect(true).to(equal(false))
                                            },
                                            error: { (statusCode) in
                                                completionCalled = true
                                            }
                )

                expect(completionCalled).toEventually(beTrue(), timeout: 10)
            }
        }

        describe("zzz") {
            it("zzz") {
            }
        }
    }
}
