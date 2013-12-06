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
navigator.screenshot.save(function(){
  console.log('ok');
},function(error){
   console.error(error);
});
```
