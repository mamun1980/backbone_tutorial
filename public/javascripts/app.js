/**
 * Backbone intro App() object
 * 
 * Used to setup AJAX requests with Basic Auth.
 * Application-scope variables and functions are found here.
 *  
 */
var App = 
{
	username: "troy",
	password:"troy",
	fetchQualifiers:null,	
	/*
	 *  init()
	 * 
	 *  Sets up the AJAX requests to submit using Basic Auth
	 */
	init: function() 
	{

		$.ajaxSetup
		({
			'beforeSend': function(xhr) 
			{
				var token = App.basicAuthenticationToken();
				xhr.setRequestHeader("Authentication", "Basic " + token);
				xhr.setRequestHeader("x-custom-fetch-qualifiers",App.fetchQualifiers)
			}
		})
	},
	/*
	 * basicAuthenticationToken()
	 * 
	 * Convienience method that returns an Basic Auth (b64 encoded) string 
	 */
	basicAuthenticationToken:function()
	{
		var tmpstring = App.username+":"+App.password;
		return Base64Utility.encode(tmpstring);		
	}
}
var inspectKeys = function(obj) {
	var keys = [];
	for(var key in obj) {
		keys.push(key);
	}
	return keys;
}