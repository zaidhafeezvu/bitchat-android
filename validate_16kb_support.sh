#!/bin/bash

# 16KB Page Size Validation Script
# This script validates that all necessary configurations for 16KB page size support are in place

echo "🔍 Validating 16KB Page Size Google Play Compatibility Implementation"
echo "================================================================="

# Check if core library desugaring is enabled
echo "1. Checking core library desugaring configuration..."
if grep -q "isCoreLibraryDesugaringEnabled = true" app/build.gradle.kts; then
    echo "   ✅ Core library desugaring enabled"
else
    echo "   ❌ Core library desugaring not found"
fi

# Check if NDK ABI filters are configured
echo "2. Checking NDK ABI filters..."
if grep -q "abiFilters" app/build.gradle.kts; then
    echo "   ✅ NDK ABI filters configured"
else
    echo "   ❌ NDK ABI filters not found"
fi

# Check if JNI libs packaging is optimized
echo "3. Checking JNI library packaging optimization..."
if grep -q "useLegacyPackaging = false" app/build.gradle.kts; then
    echo "   ✅ JNI library packaging optimized"
else
    echo "   ❌ JNI library packaging optimization not found"
fi

# Check gradle properties for 16KB optimizations
echo "4. Checking gradle.properties for 16KB optimizations..."
if grep -q "android.experimental.enableCoreLibraryDesugaring=true" gradle.properties; then
    echo "   ✅ Core library desugaring enabled in gradle.properties"
else
    echo "   ❌ Core library desugaring not enabled in gradle.properties"
fi

if grep -q "android.bundle.enableUncompressedNativeLibs=false" gradle.properties; then
    echo "   ✅ Uncompressed native libs disabled"
else
    echo "   ❌ Uncompressed native libs setting not found"
fi

if grep -q "android.enableR8.fullMode=true" gradle.properties; then
    echo "   ✅ R8 full mode enabled"
else
    echo "   ❌ R8 full mode not enabled"
fi

# Check AndroidManifest.xml for performance settings
echo "5. Checking AndroidManifest.xml for performance settings..."
if grep -q "android:largeHeap=\"false\"" app/src/main/AndroidManifest.xml; then
    echo "   ✅ Large heap disabled for optimal memory usage"
else
    echo "   ❌ Large heap setting not found"
fi

if grep -q "android:hardwareAccelerated=\"true\"" app/src/main/AndroidManifest.xml; then
    echo "   ✅ Hardware acceleration enabled"
else
    echo "   ❌ Hardware acceleration setting not found"
fi

# Check for core library desugaring dependency
echo "6. Checking core library desugaring dependency..."
if grep -q "coreLibraryDesugaring" app/build.gradle.kts; then
    echo "   ✅ Core library desugaring dependency added"
else
    echo "   ❌ Core library desugaring dependency not found"
fi

# Check for managed devices configuration for testing
echo "7. Checking managed devices for 16KB testing..."
if grep -q "managedDevices" app/build.gradle.kts; then
    echo "   ✅ Managed devices configured for testing"
else
    echo "   ❌ Managed devices configuration not found"
fi

# Check for documentation
echo "8. Checking documentation..."
if [ -f "16KB_PAGE_SIZE_SUPPORT.md" ]; then
    echo "   ✅ 16KB page size documentation exists"
else
    echo "   ❌ 16KB page size documentation not found"
fi

echo ""
echo "🎯 Next Steps:"
echo "   1. Fix Android Gradle Plugin version compatibility"
echo "   2. Build the project with: ./gradlew assembleDebug"
echo "   3. Test on devices/emulators with 16KB page sizes"
echo "   4. Verify native library compatibility"
echo "   5. Upload to Google Play Console for validation"

echo ""
echo "📚 Key Files Modified:"
echo "   - app/build.gradle.kts"
echo "   - gradle.properties"
echo "   - app/src/main/AndroidManifest.xml"
echo "   - 16KB_PAGE_SIZE_SUPPORT.md"

echo ""
echo "🔗 Useful Resources:"
echo "   - Google Play 16KB requirements: https://developer.android.com/guide/practices/page-sizes"
echo "   - Testing guide: See 16KB_PAGE_SIZE_SUPPORT.md"