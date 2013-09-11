var base64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'.split("");
var base64inv = {};

for (var i = 0; i < base64chars.length; i++) 
{
	base64inv[base64chars[i]] = i;
}

/**
 * Base64 utility class
 * 
 * Base64Utility.encode(s) returns a base64 encoded string
 * Base64Utility.decode(s) returns a base64 decoded string
 */
var Base64Utility = 
{
	encode: function(s) 
 	{
		var r = "";
		var p = "";
		var c = s.length % 3;
		if (c > 0) 
		{
			for (; c < 3; c++) 
			{
				p += '=';
				s += "\0";
			}
		}
		for (c = 0; c < s.length; c += 3) 
		{
			if (c > 0 && (c / 3 * 4) % 76 == 0) 
				r += "\r\n";
			var n = (s.charCodeAt(c) << 16) + (s.charCodeAt(c + 1) << 8) + s.charCodeAt(c + 2);
			n = [(n >>> 18) & 63, (n >>> 12) & 63, (n >>> 6) & 63, n & 63];
			r += base64chars[n[0]] + base64chars[n[1]] + base64chars[n[2]] + base64chars[n[3]];
		}
		return r.substr(0, r.length - p.length) + p;
	},
	decode: function(s) 
	{
		var p = (s.charAt(s.length - 1) == '=' ? (s.charAt(s.length - 2) == '=' ? 'AA' : 'A') : "");
		var r = "";
		s = s.substr(0, s.length - p.length) + p;
		s = s.replace(new RegExp('[^' + base64chars.join("") + ']', 'g'), "");
		for (var c = 0; c < s.length; c += 4) 
		{
			var n = (base64inv[s.charAt(c)] << 18) + base64inv[s.charAt(c + 3)] + (base64inv[s.charAt(c + 1)] << 12) + (base64inv[s.charAt(c + 2)] << 6);
			r += String.fromCharCode((n >>> 16) & 255, (n >>> 8) & 255, n & 255);
		}
		return r.substr(0, r.length - p.length);
	}
}

