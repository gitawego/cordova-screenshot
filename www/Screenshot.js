/*
 *  This code is adapted from the work of Michael Nachbaur 
 *  by Simon Madine of The Angry Robot Zombie Factory
 *   - Converted to Cordova 1.6.1 by Josemando Sobral.
 *   - Converted to Cordova 2.0.0 by Simon MacDonald
 *  2012-07-03
 *  MIT licensed
 */
var exec = require('cordova/exec');
module.exports = {
	save:function(callback,fallback) {
		exec(callback, fallback, "Screenshot", "saveScreenshot", []);
	}
};
