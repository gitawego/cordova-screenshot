cordova-screenshot
==================

The Screenshot plugin allows your application to take screenshots of the current screen and save them into the phone.

##how to install
intall it via cordova cli
```
cordova plugin add https://github.com/gitawego/cordova-screenshot.git
```

for android, add this line to `app/AndroidManifest.xml`
```xml
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

##usage

```js
navigator.screenshot.save();
```