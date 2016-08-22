import SwiftyJSON
import Quick
import Nimble
import PactConsumerSwift

class ProductClientContractSpec: QuickSpec {

    override func spec() {
        describe("contract tests") {
            var productService: MockService?
            var productClient: ProductClient?

            beforeEach {
                productService = MockService(
                        provider: "Product Service",
                        consumer: "Product iOS Client",
                        done: { result in
                            expect(result).to(equal(PactVerificationResult.Passed))
                        })

                productClient = ProductClient(baseUrl: productService!.baseUrl)
            }

            it("gets all the products") {
                let availableAt = "2016-07-24T06:01:50.690Z"
                let dateTerm = Matcher.term(
                                   matcher: "\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}.\\d{3}Z",
                                   generate: availableAt
                               )

                let productTypeTerm = Matcher.term(
                                          matcher: "book|magazine|newspaper",
                                          generate: "book"
                                      )

                let expectedResponse = Matcher.eachLike([
                                           "name": Matcher.somethingLike("product1"),
                                           "url": Matcher.somethingLike("/products/1"),
                                           "related": Matcher.eachLike([
                                                          "name": Matcher.somethingLike("product2"),
                                                          "url": Matcher.somethingLike("/products/2"),
                                                          "availableAt": dateTerm,
                                                          "productType": productTypeTerm
                                                      ]),
                                           "availableAt": dateTerm,
                                           "productType": productTypeTerm
                                       ])

                let expectedProductList = ProductList(JSON([[
                                "name": "product1",
                                "url": "/products/1",
                                "related": [
                                    "name": "product2",
                                    "url": "/products/2",
                                    "availableAt": "2016-07-24T06:01:50.690Z",
                                    "productType": "book"
                                ],
                                "availableAt": "2016-07-24T06:01:50.690Z",
                                "productType": "book"
                            ]]))

                var complete: Bool = false

                productService!.uponReceiving("a request for all products")
                  .withRequest(
                      method: .GET,
                      path: "/products",
                      headers: ["Accept": "application/json"])
                  .willRespondWith(
                      status: 200,
                      headers: ["Content-Type": "application/json"],
                      body: expectedResponse)

                productService!.run { (testComplete) -> Void in
                    productClient!.getProducts({ (productList) in
                                                   complete = true
                                                   testComplete()
                                                   expect(productList).to(equal(expectedProductList))
                                               },
                                               error: { (_) in
                                                   complete = true
                                                   testComplete()
                                                   expect(true).to(equal(false))
                                               }
                    )
                }

                expect(complete).toEventually(beTrue())
            }

            it("gets one product") {
                let productId = NSUUID().UUIDString
                let productUrl = "/products/\(productId)"

                let availableAt = "2016-07-24T06:01:50.690Z"
                let dateTerm = Matcher.term(
                                   matcher: "\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}.\\d{3}Z",
                                   generate: availableAt
                               )

                let productTypeTerm = Matcher.term(
                                          matcher: "book|magazine|newspaper",
                                          generate: "book"
                                      )

                let expectedResponse = [
                                           "name": Matcher.somethingLike("product1"),
                                           "url": Matcher.somethingLike(productUrl),
                                           "related": Matcher.eachLike([
                                                          "name": Matcher.somethingLike("product2"),
                                                          "url": Matcher.somethingLike("/products/2"),
                                                          "availableAt": dateTerm,
                                                          "productType": productTypeTerm
                                                      ]),
                                           "availableAt": dateTerm,
                                           "productType": productTypeTerm
                                       ]

                let expectedProduct = Product(JSON([
                            "name": "product1",
                            "url": productUrl,
                            "related": [
                                "name": "product2",
                                "url": "/products/2",
                                "availableAt": "2016-07-24T06:01:50.690Z",
                                "productType": "book"
                            ],
                            "availableAt": "2016-07-24T06:01:50.690Z",
                            "productType": "book"
                        ]))

                var complete: Bool = false

                productService!.uponReceiving("a request for a product")
                  .withRequest(
                      method: .GET,
                      path: productUrl,
                      headers: ["Accept": "application/json"])
                  .willRespondWith(
                      status: 200,
                      headers: ["Content-Type": "application/json"],
                      body: expectedResponse)

                productService!.run { (testComplete) -> Void in
                    productClient!.getProduct(productId,
                                              success: { (product) in
                                                   complete = true
                                                   testComplete()
                                                   expect(product).to(equal(expectedProduct))
                                               },
                                               error: { (_) in
                                                   complete = true
                                                   testComplete()
                                                   expect(true).to(equal(false))
                                               }
                    )
                }

                expect(complete).toEventually(beTrue())
            }

            it("deletes the product") {
                let productId = NSUUID().UUIDString
                let productUrl = "/products/\(productId)"

                var complete: Bool = false

                productService!.uponReceiving("a request to delete a product")
                  .withRequest(
                      method: .DELETE,
                      path: productUrl,
                      headers: ["Accept": "application/json"])
                  .willRespondWith(
                      status: 202,
                      headers: ["Content-Type": "application/json"])

                productService!.run { (testComplete) -> Void in
                    productClient!.deleteProduct(productId,
                                              success: { () in
                                                   complete = true
                                                   testComplete()
                                                 },
                                               error: { (_) in
                                                   complete = true
                                                   testComplete()
                                                   expect(true).to(equal(false))
                                               }
                    )
                }

                expect(complete).toEventually(beTrue())
            }

            describe("zzz") {
                it("zzz") {
                }
            }

        }
    }
}
