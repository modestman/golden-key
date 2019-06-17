//
//  SHA256Tests.swift
//  GoldenKeyTests
//
//  Created by Alexander Ignatev on 11/01/2019.
//  Copyright © 2019 RedMadRobot. All rights reserved.
//

import XCTest
import GoldenKey

final class SHA256Tests: XCTestCase {

    private let bytes: [UInt8] = [
        240, 218, 85,  158, 165, 156, 237, 104,
        180, 214, 87,  73,  107, 238, 151, 83,
        192, 68,  125, 112, 112, 42,  241, 163,
        81,  199, 87,  114, 38,  217, 119, 35
    ]

    func testUpdateAndFinalize() {
        var hasher1 = SHA256()
        hasher1.update(data: Data("hello".utf8))

        var hasher2 = hasher1
        hasher2.update(data: Data(" word".utf8))

        let digest = hasher1.finalize()
        XCTAssertEqual(digest, hasher1.finalize())
        XCTAssertEqual(digest, hasher1.finalize())
        XCTAssertEqual(digest, hasher2.finalize())
        XCTAssertEqual(Array(digest), bytes)
    }

    func testHash() {
        let digest = SHA256.hash(data: Data("hello word".utf8))
        XCTAssertEqual(Array(digest), bytes)
    }

    func testDigest() {
        let digest1 = bytes.withUnsafeBytes { SHA256Digest(bufferPointer: $0) }
        XCTAssertEqual(digest1.map { Array($0) }, bytes)

        var bytes = self.bytes
        bytes.append(contentsOf: [21, 32])
        let digest2 = bytes.withUnsafeBytes { SHA256Digest(bufferPointer: $0) }
        XCTAssertNil(digest2)
    }

}
