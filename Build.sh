#!/bin/bash

# Define variables
FRAMEWORK_NAME="JFramework"
BUILD_DIR="build"
XCFRAMEWORK_DIR="${BUILD_DIR}/${FRAMEWORK_NAME}.xcframework"

# Clean up previous builds
rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

# Build for iOS device
xcodebuild archive \
  -scheme "${FRAMEWORK_NAME}" \
  -destination "generic/platform=iOS" \
  -archivePath "${BUILD_DIR}/iOS.xcarchive" \
  -sdk iphoneos \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Build for iOS Simulator
xcodebuild archive \
  -scheme "${FRAMEWORK_NAME}" \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "${BUILD_DIR}/iOSSimulator.xcarchive" \
  -sdk iphonesimulator \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Create XCFramework
xcodebuild -create-xcframework \
  -framework "${BUILD_DIR}/iOS.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
  -framework "${BUILD_DIR}/iOSSimulator.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
  -output "${XCFRAMEWORK_DIR}"

# Cleanup intermediate archives
rm -rf "${BUILD_DIR}/iOS.xcarchive" "${BUILD_DIR}/iOSSimulator.xcarchive"

echo "XCFramework created at ${XCFRAMEWORK_DIR}"
