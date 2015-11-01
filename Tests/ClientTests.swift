//
// ClientTests.swift
//
// Copyright (c) 2015 Recrea (http://recreahq.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

@testable import Quaderno

import XCTest
import OHHTTPStubs


class ClientTests: XCTestCase {

  // MARK: Test Subject

  var httpClient: Client!

  // MARK: Set Up

  override func setUp() {
    super.setUp()
    httpClient = Client(baseURL: "https://quadernoapp.com/api/v1/", authenticationToken: "My token")
  }

  override func tearDown() {
    httpClient = nil
    OHHTTPStubs.removeAllStubs()
    super.tearDown()
  }

  // MARK: Ping

  func testThatPingCompletesWithSuccessWhenConnectionIsAvailable() {
    OHHTTPStubs.stubPingRequest(success: true)

    let expectation = expectationWithDescription("ping finishes")
    httpClient.ping { success in
      if success {
        expectation.fulfill()
      }
    }
    waitForExpectationsWithTimeout(1, handler: nil)
  }

  func testThatPingCompletesWithoutSuccessWhenConnectionIsUnavailable() {
    OHHTTPStubs.stubPingRequest(success: false)

    let expectation = expectationWithDescription("ping finishes")
    httpClient.ping { success in
      if !success {
        expectation.fulfill()
      }
    }
    waitForExpectationsWithTimeout(1, handler: nil)
  }

  // MARK: Connection Entitlements

  func testThatFetchingConnectionEntitlementsReturnsNilWhenHeadersAreInvalid() {
    let response = OHHTTPStubsResponse(JSONObject: PingResponse.successJSON, statusCode: CInt(PingResponse.successCode), headers: nil)
    OHHTTPStubs.stubPingRequest(success: true, response: response)

    let expectation = expectationWithDescription("ping finishes")
    httpClient.fetchConnectionEntitlements { entitlements in
      XCTAssertNil(entitlements)
      XCTAssertNil(self.httpClient.entitlements)
      expectation.fulfill()
    }
    waitForExpectationsWithTimeout(1, handler: nil)
  }

  func testThatFetchingConnectionEntitlementsReturnsEntitlementsWhenHeadersAreValid() {
    OHHTTPStubs.stubPingRequest(success: true)

    let expectation = expectationWithDescription("ping finishes")
    httpClient.fetchConnectionEntitlements { entitlements in
      XCTAssertNotNil(entitlements)
      XCTAssertNotNil(self.httpClient.entitlements)
      expectation.fulfill()
    }
    waitForExpectationsWithTimeout(1, handler: nil)
  }

}