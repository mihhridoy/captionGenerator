# 🚀 AI Caption Generator — Complete Setup & Play Store Guide
### From Zero to Published — Step by Step for Beginners

---

## 📋 WHAT YOU NEED BEFORE STARTING
- ✅ Android Studio installed
- ✅ Flutter SDK installed
- ✅ Firebase project created (console.firebase.google.com)
- ✅ Gemini API key (aistudio.google.com)
- ✅ AdMob account (admob.google.com)
- ✅ Google Play Developer account ($25 one-time fee — play.google.com/console)

---

## PHASE 1 — OPEN THE PROJECT

### Step 1: Extract the ZIP
1. Extract `ai_caption_generator.zip` to a folder on your computer
   - Example: `C:\Projects\ai_caption_generator\`  (Windows)
   - Example: `~/Projects/ai_caption_generator/`   (Mac/Linux)

### Step 2: Open in Android Studio
1. Open Android Studio
2. Click **"Open"** (not "New Project")
3. Navigate to the extracted folder → click **OK**
4. Wait for Gradle to sync (2–5 minutes, first time only)
5. If it asks to upgrade Gradle → click **"Don't remind me"** for now

### Step 3: Install Flutter dependencies
1. Open the Terminal in Android Studio (bottom of screen)
2. Type this command and press Enter:
```
flutter pub get
```
3. Wait for it to finish (downloads all packages)

---

## PHASE 2 — CONNECT FIREBASE

### Step 4: Install FlutterFire CLI
In the same terminal, run these ONE BY ONE:
```
dart pub global activate flutterfire_cli
```
If you get a PATH warning, follow the instructions it shows.

### Step 5: Connect your Firebase project
```
flutterfire configure
```
- It will open a browser → sign in with your Google account
- Select your existing Firebase project from the list
- Check ✅ **Android** only
- Press Enter to confirm the package name: `com.company.ainewsapp`
- This will **automatically replace** `lib/firebase_options.dart` with your real credentials ✅

### Step 6: Enable Firebase services
Go to **console.firebase.google.com** → Your project:

**Authentication:**
1. Click **Authentication** → Get Started
2. Sign-in method tab → Enable **Email/Password** → Save
3. Enable **Google** → set support email → Save

**Firestore Database:**
1. Click **Firestore Database** → Create Database
2. Choose **Production mode** → Next
3. Select location: `asia-south1` (Mumbai — closest to Bangladesh) → Enable

**Upload Security Rules:**
1. In Firestore → **Rules** tab
2. Delete everything there
3. Copy-paste the contents of `firestore.rules` file
4. Click **Publish**

### Step 7: Download google-services.json
1. Firebase Console → Project Settings (gear icon top left)
2. Scroll down to "Your apps" → Android app
3. Click **Download google-services.json**
4. Copy this file into: `android/app/google-services.json`
   (Replace if one already exists)

---

## PHASE 3 — ADD YOUR API KEYS

### Step 8: Add Gemini API Key
1. Open `lib/constants.dart`
2. Find this line:
```dart
static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';
```
3. Replace `YOUR_GEMINI_API_KEY_HERE` with your real key from aistudio.google.com

### Step 9: Set up AdMob Ad Units
1. Go to **admob.google.com**
2. Click **Apps** in the left menu → **Add App**
3. Platform: **Android** → Is the app on Play Store? → **No** (for now)
4. App name: `AI Caption Generator` → Add
5. Copy the **App ID** shown (format: `ca-app-pub-XXXX~XXXX`)

**Create 3 Ad Units:**
For each: Apps → Your App → Ad Units → Add Ad Unit

| Ad Type | Name to use |
|---------|-------------|
| Banner | `home_banner` |
| Interstitial | `result_interstitial` |
| Rewarded | `limit_rewarded` |

After creating each, copy its **Unit ID**.

### Step 10: Add AdMob IDs to project

**In `lib/constants.dart`**, replace the placeholders:
```dart
static const String admobAppId = 'ca-app-pub-XXXX~XXXX';         // Your App ID
static const String bannerAdUnitId = 'ca-app-pub-XXXX/XXXX';     // Banner Unit ID
static const String interstitialAdUnitId = 'ca-app-pub-XXXX/XXXX'; // Interstitial
static const String rewardedAdUnitId = 'ca-app-pub-XXXX/XXXX';   // Rewarded
```

**In `android/app/src/main/AndroidManifest.xml`**, find:
```xml
android:value="ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX"
```
Replace with your real AdMob App ID.

> 💡 **TESTING TIP:** While developing, use the TEST IDs in constants.dart
> (they're commented out — just swap which ones are active).
> Using real IDs during testing can get your AdMob account banned!

---

## PHASE 4 — TEST THE APP

### Step 11: Connect your Android phone
1. On your Android phone: Settings → About Phone → tap **Build Number** 7 times
2. This enables **Developer Options**
3. Go to Developer Options → Enable **USB Debugging**
4. Connect phone to computer via USB cable
5. A popup appears on phone → tap **Allow**

### Step 12: Run the app
In Android Studio:
1. In the top toolbar, your phone should appear in the device dropdown
2. Click the **▶ Run** button (green play button)
3. First build takes 3–5 minutes
4. App will launch on your phone! ✅

### Step 13: Test all features
Go through this checklist:
- [ ] Splash screen shows and navigates
- [ ] Sign up with email works
- [ ] Google sign-in works
- [ ] Enter a topic, select platform, generate caption
- [ ] Caption result shows correctly
- [ ] Copy button works
- [ ] Save to favorites works
- [ ] Saved tab shows saved captions
- [ ] History tab shows all captions
- [ ] Sign out works

---

## PHASE 5 — CREATE APP ICON & STORE ASSETS

### Step 14: Create app icon
You need a 512×512 PNG icon.

**Free tools:**
- **Canva** (canva.com) — easiest for beginners
- Design a simple icon: purple gradient background + a star/pen emoji

**Add icon to project:**
1. Go to: https://www.appicon.co
2. Upload your 512×512 image
3. Select **Android** → Generate
4. Download the ZIP
5. Extract and copy the `mipmap-*` folders into `android/app/src/main/res/`
   (overwrite existing folders)

### Step 15: Create Play Store screenshots
You need **at least 2 screenshots** of the app running.

**How to take screenshots on connected phone:**
- In Android Studio → Logcat panel → camera icon
- Or just use your phone's screenshot button while app is running

**Required sizes:** Phone screenshots (any size works, min 320px wide)

**Recommended screens to screenshot:**
1. Home/Generate screen
2. Result screen with a caption
3. Saved captions screen

---

## PHASE 6 — BUILD RELEASE APK / AAB

### Step 16: Create a signing keystore
This is your app's "signature" — keep it safe forever!

In Android Studio terminal:
```
keytool -genkey -v -keystore ~/caption-app-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias caption-key
```
It will ask you questions — fill them in:
- Password: choose a strong password (SAVE IT!)
- First/last name: your name
- Organization: your name or company
- City, State, Country: your details
- Confirm: yes

> ⚠️ IMPORTANT: Save the `.jks` file and password somewhere safe.
> If you lose it, you can NEVER update your app on Play Store.

### Step 17: Configure signing in build.gradle
Open `android/app/build.gradle`, find the `android {}` block and add:

```gradle
android {
    // ... existing code ...
    
    signingConfigs {
        release {
            storeFile file("/YOUR/PATH/TO/caption-app-key.jks")
            storePassword "YOUR_STORE_PASSWORD"
            keyAlias "caption-key"
            keyPassword "YOUR_KEY_PASSWORD"
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release  // change from .debug to .release
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

### Step 18: Build the release AAB
Google Play requires AAB format (not APK).

In terminal:
```
flutter build appbundle --release
```

Wait 2–5 minutes. When done, your file is at:
```
build/app/outputs/bundle/release/app-release.aab
```

---

## PHASE 7 — PUBLISH TO GOOGLE PLAY STORE

### Step 19: Create Play Console account
1. Go to: **play.google.com/console**
2. Sign in with your Google account
3. Pay the **$25 one-time registration fee**
   - You can pay with a friend's card or use a virtual card service in Bangladesh
   - Options: Wise (wise.com), payoneer.com — both work in Bangladesh
4. Fill in your developer profile details

### Step 20: Create new app
1. Play Console → **Create app**
2. App name: `AI Caption Generator – Hashtags & Bio`
3. Default language: **English (United States)**
4. App type: **App** (not Game)
5. Free or paid: **Free**
6. Accept policies → Create app

### Step 21: Fill in store listing
Go to **Store presence → Main store listing**:

**App name:** `AI Caption Generator – Hashtags & Bio`

**Short description** (80 chars):
```
Generate viral captions & hashtags for Instagram, TikTok, Facebook & Twitter
```

**Full description** (4000 chars max):
```
🚀 Create viral social media captions in seconds with AI!

AI Caption Generator uses Google Gemini AI to create perfect captions for:
📸 Instagram — emotional, story-driven captions with emojis
🎵 TikTok — trendy hooks and punchy one-liners
👥 Facebook — warm, community-focused content
𝕏 Twitter/X — witty, concise posts under 280 chars

✨ FEATURES:
• Choose caption length: Short, Medium, or Long
• AI-powered hashtag suggestions (12 hashtags)
• Copy captions with one tap
• Save your favorite captions
• Full history of all generated captions
• Regenerate instantly if you don't like it

🆓 FREE TO USE:
• 5 free caption generations per day
• Watch an ad to earn 3 bonus generations

Perfect for content creators, influencers, small businesses,
and anyone who wants to grow their social media presence!

Try it now — your next viral post is one tap away! ✨
```

**Upload screenshots:** Add the screenshots from Step 15

**App icon:** Upload your 512×512 PNG icon

**Feature graphic:** 1024×500 PNG banner (create in Canva)

### Step 22: Fill in app content ratings
1. **Policy → App content** → fill all sections
2. **Content rating** → Start questionnaire
   - App type: Utility
   - Answer all questions (mostly "No" for this app)
   - Submit → you'll get a rating (likely "Everyone")

### Step 23: Set up pricing & distribution
1. **Monetization → Free**
2. **Distribution → Countries**: Select all, or specific countries
3. For Bangladesh: make sure Bangladesh is included ✅

### Step 24: Upload your AAB
1. **Release → Production → Create new release**
2. Upload `app-release.aab`
3. Release notes (what's new):
```
• First release of AI Caption Generator
• Generate captions for Instagram, TikTok, Facebook & Twitter
• AI-powered hashtags
• Save & share your favorite captions
```
4. Click **Review release**
5. Fix any warnings shown
6. Click **Start rollout to Production**

### Step 25: Wait for review
- Google reviews new apps in **1–3 days** (sometimes up to 7 days)
- You'll get an email when approved
- Your app will be live on the Play Store! 🎉

---

## 🔧 COMMON ERRORS & FIXES

| Error | Fix |
|-------|-----|
| `google-services.json not found` | Download from Firebase Console and put in `android/app/` |
| `PlatformException: sign_in_failed` | Add SHA-1 fingerprint to Firebase (see below) |
| `minSdkVersion must be 21+` | Already set in build.gradle — check it's saved |
| `Gemini API 400 error` | Check your API key is correct in constants.dart |
| `gradle build failed` | Run `flutter clean` then `flutter pub get` again |
| Ads not showing | Use TEST ad unit IDs during development |

### Fix: Add SHA-1 to Firebase (for Google Sign-In)
In terminal:
```
cd android
./gradlew signingReport
```
Copy the **SHA1** value from "Variant: debug"
Go to Firebase Console → Project Settings → Your Android app → Add fingerprint

---

## 💰 HOW YOU GET PAID (AdMob in Bangladesh)

1. Go to **admob.google.com → Payments**
2. Add payment info → Wire Transfer
3. Enter your Bangladesh bank account details
4. Google pays monthly when balance reaches $100
5. Wire transfer works with all major Bangladeshi banks (Dutch-Bangla, bKash, BRAC, etc.)

---

## 📈 AFTER LAUNCH — NEXT STEPS

1. **Share your app link** on Facebook groups, WhatsApp, Reddit (r/sideproject)
2. **Ask for reviews** — 10+ reviews help ranking
3. **Monitor AdMob dashboard** for earnings
4. **Check Firebase Console** for user growth
5. **Reply to Play Store reviews** (helps ranking)

---

## 📁 FILE STRUCTURE REFERENCE

```
lib/
├── main.dart                    ← App entry point
├── constants.dart               ← ⚠️ Add your API keys here
├── firebase_options.dart        ← ⚠️ Auto-generated by FlutterFire
├── models/
│   ├── caption_model.dart       ← Caption data structure
│   └── user_model.dart          ← User data structure
├── services/
│   ├── firebase_service.dart    ← All Firebase calls
│   ├── gemini_service.dart      ← Gemini AI API calls
│   └── admob_service.dart       ← All ad management
├── theme/
│   └── app_theme.dart           ← Colors, fonts, styles
├── widgets/
│   └── common_widgets.dart      ← Reusable UI components
└── screens/
    ├── splash_screen.dart       ← Loading screen
    ├── result_screen.dart       ← Caption output screen
    ├── auth/
    │   └── login_screen.dart    ← Login & signup
    └── main/
        ├── main_nav_screen.dart ← Bottom navigation
        ├── generate_screen.dart ← Main input screen
        ├── saved_screen.dart    ← Saved + History screens
        ├── history_screen.dart  ← Re-exports saved_screen
        └── settings_screen.dart ← Profile & settings
```

---

*Built with Flutter • Firebase • Google Gemini AI • AdMob*
*Package: com.company.ainewsapp*
