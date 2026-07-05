#!/usr/bin/env python3
"""
Patches android/app/build.gradle(.kts), freshly generated each CI run by
`flutter create`, so release builds are signed with our persistent
upload-keystore.jks instead of the default (unsigned/debug) config.

Handles both the older Groovy build.gradle and the newer Kotlin DSL
build.gradle.kts, since Flutter has changed its default template between
versions and we don't control which one a given Flutter release generates.
"""
import pathlib
import sys

APP_DIR = pathlib.Path("android/app")
GROOVY_FILE = APP_DIR / "build.gradle"
KTS_FILE = APP_DIR / "build.gradle.kts"


def patch_groovy(text: str) -> str:
    keystore_block = '''
def keystorePropertiesFile = rootProject.file("key.properties")
def keystoreProperties = new Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
'''
    signing_configs = '''    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
'''
    # Insert the keystoreProperties loader right after the plugins block.
    if "def keystorePropertiesFile" not in text:
        marker = "android {"
        idx = text.index(marker)
        text = text[:idx] + keystore_block + "\n" + text[idx:]

    # Insert (or replace) signingConfigs inside the android { } block, and
    # point the release buildType at it.
    if "signingConfigs {" not in text:
        marker = "android {"
        idx = text.index(marker) + len(marker)
        text = text[:idx] + "\n" + signing_configs + text[idx:]

    if "signingConfig signingConfigs.release" not in text:
        text = text.replace(
            "signingConfig signingConfigs.debug",
            "signingConfig signingConfigs.release",
        )
        # If there was no debug fallback line to replace, inject into the
        # release buildType block explicitly.
        if "signingConfig signingConfigs.release" not in text:
            text = text.replace(
                "buildTypes {\n        release {",
                "buildTypes {\n        release {\n            signingConfig signingConfigs.release",
            )
    return text


def patch_kts(text: str) -> str:
    keystore_block = '''
import java.util.Properties
import java.io.FileInputStream

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}
'''
    signing_configs = '''    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }
'''
    if "val keystorePropertiesFile" not in text:
        text = keystore_block + "\n" + text

    if 'signingConfigs {' not in text:
        marker = "android {"
        idx = text.index(marker) + len(marker)
        text = text[:idx] + "\n" + signing_configs + text[idx:]

    if 'signingConfig = signingConfigs.getByName("release")' not in text:
        text = text.replace(
            'signingConfig = signingConfigs.getByName("debug")',
            'signingConfig = signingConfigs.getByName("release")',
        )
        if 'signingConfig = signingConfigs.getByName("release")' not in text:
            text = text.replace(
                "buildTypes {\n        release {",
                'buildTypes {\n        release {\n            signingConfig = signingConfigs.getByName("release")',
            )
    return text


def main():
    if GROOVY_FILE.exists():
        text = GROOVY_FILE.read_text()
        GROOVY_FILE.write_text(patch_groovy(text))
        print(f"Patched {GROOVY_FILE}")
    elif KTS_FILE.exists():
        text = KTS_FILE.read_text()
        KTS_FILE.write_text(patch_kts(text))
        print(f"Patched {KTS_FILE}")
    else:
        print("ERROR: no android/app/build.gradle or build.gradle.kts found", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
