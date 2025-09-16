# 16KB Page Size Support for Google Play Compatibility

## Overview

This document outlines the implementation of 16KB page size compatibility support in the Bitchat Android app to meet Google Play Store requirements.

## What is 16KB Page Size Compatibility?

Google Play now requires apps to be compatible with devices that use 16KB memory page sizes instead of the traditional 4KB page sizes. This affects:
- Memory allocation patterns
- Performance on newer Android devices and tablets
- Native library compatibility
- App startup and runtime performance

## Changes Made

### 1. Build Configuration (`app/build.gradle.kts`)

#### NDK Configuration
```kotlin
ndk {
    // Ensure native libraries are compatible with 16KB page sizes
    abiFilters += setOf("arm64-v8a", "armeabi-v7a", "x86", "x86_64")
}
```

#### Core Library Desugaring
```kotlin
compileOptions {
    sourceCompatibility = JavaVersion.VERSION_1_8
    targetCompatibility = JavaVersion.VERSION_1_8
    // Enable core library desugaring for 16KB page size compatibility
    isCoreLibraryDesugaringEnabled = true
}
```

#### Packaging Optimization
```kotlin
packaging {
    resources {
        excludes += "/META-INF/{AL2.0,LGPL2.1}"
    }
    // Optimize for 16KB page size compatibility
    jniLibs {
        useLegacyPackaging = false
    }
}
```

#### Test Configuration for 16KB Page Size Testing
```kotlin
testOptions {
    unitTests {
        isIncludeAndroidResources = true
    }
    // Enable 16KB page size testing
    managedDevices {
        devices {
            create("pixel6Api31") {
                device = "Pixel 6"
                apiLevel = 31
                systemImageSource = "google"
            }
            create("pixel6Api34") {
                device = "Pixel 6"
                apiLevel = 34
                systemImageSource = "google"
            }
        }
    }
}
```

### 2. Gradle Properties (`gradle.properties`)

```properties
# 16KB page size compatibility optimizations
android.experimental.enableCoreLibraryDesugaring=true
android.bundle.enableUncompressedNativeLibs=false

# Enable R8 full mode for better 16KB page size optimization
android.enableR8.fullMode=true
```

### 3. AndroidManifest.xml Updates

```xml
<application
    android:largeHeap="false"
    android:hardwareAccelerated="true"
    ... >
```

### 4. Dependencies

Added core library desugaring dependency:
```kotlin
coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
```

## Testing for 16KB Page Size Compatibility

### Local Testing
1. Use emulators configured with 16KB page sizes
2. Test on physical devices that support 16KB page sizes
3. Monitor memory usage and performance

### Google Play Console Testing
1. Upload AAB (Android App Bundle) to Google Play Console
2. Use Google Play's pre-launch reports to verify compatibility
3. Monitor crash reports for 16KB page size related issues

## Native Library Compatibility

The app uses the following native libraries that need to be verified for 16KB page size compatibility:
- **Arti (Tor in Rust) Android bridge** (`info.guardianproject:arti-mobile-ex:1.2.3`)
- **Nordic BLE library** (`no.nordicsemi.android:ble`)
- **Google Tink cryptography** (includes native components)

## Benefits of 16KB Page Size Support

1. **Google Play Compliance**: Meets Google Play Store requirements
2. **Performance**: Better performance on newer Android devices
3. **Memory Efficiency**: Optimized memory allocation patterns
4. **Future-Proofing**: Prepared for upcoming Android device architectures

## Verification Steps

1. Build the app with the new configurations
2. Test on devices/emulators with 16KB page sizes
3. Monitor memory usage and app performance
4. Verify native library functionality
5. Upload to Google Play Console for validation

## Known Considerations

- Some older native libraries may not be compatible with 16KB page sizes
- Memory usage patterns may change
- App startup time may be affected (usually improved)
- Testing is crucial on actual 16KB page size devices

## Additional Resources

- [Google Play 16KB page size requirements](https://developer.android.com/guide/practices/page-sizes)
- [Android Developer Guide: Page sizes](https://developer.android.com/guide/practices/page-sizes)
- [Google Play Console pre-launch reports](https://support.google.com/googleplay/android-developer/answer/7002270)