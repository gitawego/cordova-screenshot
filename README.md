cordova-screenshot
==================

The Screenshot plugin allows your application to take screenshots of the current screen and save them into the phone.

##how to install

install it via cordova cli

```
cordova plugin add https://github.com/gitawego/cordova-screenshot.git
```


##usage

```js
navigator.screenshot.save(function(error){
  if(error){
    console.error(error);
  }else{
    console.log('ok');
  }
});
```
take screenshot with jpg and custom quality
```js
navigator.screenshot.save(function(error){
  if(error){
    console.error(error);
  }else{
    console.log('ok');
  }
},'jpg',50);
```

screenshot files are stored in /sdcard/Pictures for android.
