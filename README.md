cordova-screenshot
==================

[![NPM version](http://img.shields.io/npm/v/com.darktalker.cordova.screenshot.svg?style=flat)](https://www.npmjs.com/package/com.darktalker.cordova.screenshot)


The Screenshot plugin allows your application to take screenshots of the current screen and save them into the phone.

## how to install

install it via cordova cli

```
cordova plugin add https://github.com/gitawego/cordova-screenshot.git
```

notice:
in iOS, only jpg format is supported
in Android, the default WebView and [Crosswalk](https://crosswalk-project.org/documentation/cordova.html) are both supported

## usage


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

take screenshot and get it as Data URI
```js
navigator.screenshot.URI(function(error,res){
  if(error){
    console.error(error);
  }else{
    html = '<img style="width:50%;" src="'+res.URI+'">';
    document.body.innerHTML = html;
  }
},50);
```

## usage in AngularJS

```js
.service('$cordovaScreenshot', ['$q', function ($q){
	return {
		capture: function (filename, extension, quality){
			extension = extension || 'jpg';
			quality = quality || '100';

			var defer = $q.defer();
			
			navigator.screenshot.save(function (error, res){
				if (error) {
					console.error(error);
					defer.reject(error);
				} else {
					console.log('screenshot saved in: ', res.filePath);
					defer.resolve(res.filePath);
				}
			}, extension, quality, filename);
			
			return defer.promise;
		}
	};
}])
```

## Known Issue
### in Android platform I receive the black image with crosswalk 
#### solution: 

add this line ``<preference name="CrosswalkAnimatable" value="true" />`` in config.xml, see [bug](https://crosswalk-project.org/jira/browse/XWALK-2233)


License
=========
this repo uses the MIT license
