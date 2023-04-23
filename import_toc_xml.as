// create a new XML object
var tocXML = new XML();

// create a new array to store XML node order
var _toc = new Array();
var pageValues = new Array();
var _scenes = new Array();
var attr = "";
var booktitle = "";
// set the ignoreWhite property to true (default value is false)
tocXML.ignoreWhite = true;

// After loading is complete, trace the XML object
tocXML.onLoad = function(success) {
	if (success) {
		var pagenumber = 0;
		var i = 0;
		attr = (tocXML.firstChild.attributes.chapname) ? tocXML.firstChild.attributes.chapname : "Kabanata"; // set to value in xml, or default to hard-coded value
		booktitle = tocXML.firstChild.attributes.booktitle;
		
		for (var thisNode = tocXML.firstChild.firstChild; thisNode != null; thisNode = thisNode.nextSibling) {

			var obj = new Object();
			obj.pagetitle = unescape(thisNode.attributes.ttle);
			obj.numofscene = Number(thisNode.attributes.numofscene);
			_toc.push(obj);
			
			var tempNumofscene:Number = thisNode.attributes.numofscene;
			var tempscene:Number = 0;
			
			for (var j:Number =0; j<Math.ceil(Number(thisNode.attributes.numofscene)/2); j++){
				
				pagenumber+=1;
				
				var obj = new Object();
				var ctr:Number = 0;
				var chapterscenes:Array = new Array();
				
				if(tempNumofscene==1){
					ctr = 1;
				} else {
					ctr = 2;
					tempNumofscene -= 2;
				}
				for (var k:Number=0; k<ctr; k++){
					chapterscenes.push(tempscene);
//					//trace(tempscene);
					tempscene+=1;
				}
				obj.chapterscenes = chapterscenes;
				obj.chapter = i + 1;
				obj.pagenumber = pagenumber;				
				obj.pagetitle = attr+" "+(i+1)+": "+unescape(thisNode.attributes.ttle);
				obj.numofscene = Number(thisNode.attributes.numofscene);
				
				pageValues.push(obj);
			}
			
			for (var j:Number =0; j<Number(thisNode.attributes.numofscene); j++){
				var sceneObj:Object = new Object();
				sceneObj.scenenumber = j+1;
				sceneObj.chapter = i+1;
				sceneObj.sceneTotal = Number(thisNode.attributes.numofscene);
				sceneObj.pagetitle = attr+" "+(i+1)+": "+unescape(thisNode.attributes.ttle);

				_scenes.push(sceneObj);
			}
			i++;
		}
		// move playhead forward
		//trace("totalNumOfPages: "+pageValues.length);
		play();
	} else {
		trace("Error loading XML");
	}
};

// load the XML into the flooring object
tocXML.load(_level0.tocxmlFile);
