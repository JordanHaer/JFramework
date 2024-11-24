#!/bin/bash

rm -rf build

mkdir -p archives
mkdir -p build

xcodebuild docbuild \
  -scheme JFramework \
  -destination "generic/platform=iOS" \
  -quiet

xcodebuild archive \
  -project JFramework.xcodeproj \
  -scheme JFramework \
  -configuration Release \
  -destination "generic/platform=iOS" \
  -archivePath "archives/JFramework-iOS" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild docbuild \
  -scheme JFramework \
  -destination "generic/platform=iOS Simulator" \
  -quiet

xcodebuild archive \
  -project JFramework.xcodeproj \
  -scheme JFramework \
  -configuration Release \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "archives/JFramework-iOS_Simulator" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
  -archive archives/JFramework-iOS.xcarchive -framework JFramework.framework \
  -archive archives/JFramework-iOS_Simulator.xcarchive -framework JFramework.framework \
  -output build/JFramework.xcframework

rm -rf archives
