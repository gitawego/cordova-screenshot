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
navigator.screenshot.save(function(error,res){
  if(error){
    console.error(error);
  }else{
    console.log('ok',res.filePath);
  }
});
```
take screenshot with jpg and custom quality
```js
navigator.screenshot.save(function(error,res){
  if(error){
    console.error(error);
  }else{
    console.log('ok',res.filePath);
  }
},'jpg',50);
```

define a filename
```js
navigator.screenshot.save(function(error,res){
  if(error){
    console.error(error);
  }else{
    console.log('ok',res.filePath); //should be path/to/myScreenshot.jpg
  }
},'jpg',50,'myScreenShot');
```

screenshot files are stored in /sdcard/Pictures for android.


License
=========
this repo uses the MIT license
