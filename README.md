cordova-screenshot
==================

The Screenshot plugin allows your application to take screenshots of the current screen and save them into the phone.

##how to install

* install it via cordova cli
```
cordova plugin add https://github.com/gitawego/cordova-screenshot.git
```

* add this line to `www/config.xml`
```xml
<feature name="http://api.phonegap.com/1.0/file" />
```
* then remove and add platform to upate the features, ex: android
```
cordova platform remove android

cordova platform add android
```

##usage

```js
navigator.screenshot.save();
```
