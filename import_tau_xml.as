// create a new XML object
var tauXML = new XML();

// create a new array to store XML node order
var charsArray = new Array();

// set the ignoreWhite property to true (default value is false)
tauXML.ignoreWhite = true;

// After loading is complete, trace the XML object
tauXML.onLoad = function(success) {
	if (success) {
		
		for (var thisNode = tauXML.firstChild.firstChild; thisNode != null; thisNode = thisNode.nextSibling) {
			
			var obj = new Object();

			for (var str in thisNode.attributes) {
            	//trace(thisNode.nodeName+".attributes."+str+" = "+thisNode.attributes[str]);				
				obj[str] = unescape(thisNode.attributes[str]);
        	}
			
			charsArray.push(obj);
		}
		// move playhead forward
		play();
		//loadTauhanList();
	} else {
		trace("Error loading XML");
	}
};

// load the XML into the flooring object
tauXML.load(_level0.tauxmlFile);
