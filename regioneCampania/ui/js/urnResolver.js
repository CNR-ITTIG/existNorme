//
// This work is licensed under the Creative Commons Attribution 2.5 License. To 
// view a copy of this license, visit
// http://creativecommons.org/licenses/by/2.5/
// or send a letter to Creative Commons, 543 Howard Street, 5th Floor, San
// Francisco, California, 94105, USA.
//
// All copies and derivatives of this source must contain the license statement 
// above and the following attribution:
//
// Author: Pietro N. Roselli Lorenzini
// Copyright: 2008
//


var normaList = new Array(); 

// struttura dati che rappresenta una norma
function Norma(urn,url) {
	this.urn=urn;
	this.url=url;
}


// prende un parametro dalla url
function getUrlParameter( paramName ){
 paramName = paramName.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+paramName+"=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec( this.location.href );
  if( results == null )
    return "";
  else
    return results[1];
}


// si occupa di fare il resolve della urn, se è presente nel db apre quella, altrimenti apre normainrete
function resolve(){
	//Start AJAX Engine
	var url = "../urnIndex.xql"; // File XML da interrogare 

	var isIE = false;
	var XMLHttpRequestObject = false;
	var xmlUrn = null;
	if (window.XMLHttpRequest){ // Mozilla, Safari,...	
		XMLHttpRequestObject = new XMLHttpRequest();
	} else if (window.ActiveXObject){ //IE
		try {
			isIE = true;
			XMLHttpRequestObject = new ActiveXObject("Msxml2.XMLHTTP");
			
		} catch (e) {
			try {
				isIE = true;
				XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
				
			} catch (e) {
				XMLHttpRequestObject = false;
			}
		}
	}
	
	if (XMLHttpRequestObject){
		XMLHttpRequestObject.open("GET", url);
		
		XMLHttpRequestObject.onreadystatechange = function(){ 
			// Per uso locale commentare lo status
			if((XMLHttpRequestObject.readyState == 4) && (XMLHttpRequestObject.status == 200)){
				if (!isIE){
					xmlstring = "<?xml version='1.0'?>"+XMLHttpRequestObject.responseText;
						try {
							xmlUrn = (new DOMParser()).parseFromString(xmlstring, "text/xml");						
						} catch (e) {
							var xmlu = "<?xml version='1.0'?>"+ XMLHttpRequestObject.responseText;
							xmlUrn = new ActiveXObject("Msxml2.DOMDocument.3.0");
							xmlUrn.loadXML(xmlu);
						}	 
				} else {
					var xmlu = "<?xml version='1.0'?>"+ XMLHttpRequestObject.responseText;
					xmlUrn = new ActiveXObject("Msxml2.DOMDocument.3.0");
					xmlUrn.loadXML(xmlu);
				}
				
				parserURNList(xmlUrn);
			} 
		}; 
	} else {
		alert("Il tuo browser non supporta AJAX");
	}
	XMLHttpRequestObject.send(null);
	//Fine AJAX Engine
}

// Crea la lista delle norme presenti nel db
function parserURNList(xmlUrn){
	
	var list = xmlUrn.getElementsByTagName("list")
	for (var i = 0; i < list.length; i++){
		var url = list[i].childNodes[0].nodeValue;
		var urn = list[i].getElementsByTagName("urn")[0].childNodes[0].nodeValue;
		norma = new Norma(urn, url);
		normaList[i] = norma;
	}
	resolveUrn();
}


// si pccupa della risoluzione effettiva della urn, confrontandola con quelle presente nel db
function resolveUrn(){
	var queryType = "norma";
	var newWindow = null;
	var href = null;
	var doc = getUrlParameter("doc");
	var datafine = getUrlParameter("datafine");
	
	parent.leftFrame.resetMenuColour("");
	if (doc){
		for (var i = 0; i < normaList.length ; i++ ){
			  if(normaList[i].url.match(doc)){
				  
				  href = "../xhtml?doc="+doc+"&datafine="+datafine+"&urn="+normaList[i].urn+"&query="+queryType;
				  parent.mainFrame.location.href = href;
				return; 
			  }
			 	  
		}
		
	} else {
		var urn = getUrlParameter("urn");
		urn =  urn.replace(/%20/, " ");
		for (var i = 0; i < normaList.length ; i++ ){
			  if(urn.match(normaList[i].urn) || (urn==normaList[i].urn)){
				  this.location.href="../xhtml?doc="+normaList[i].url+"&datafine="+datafine+"&urn="+urn+"&query="+queryType;
				  return;
			  }
			 
		}
		href = "http://www.nir.it/cgi-bin/N2Ln?"+urn;
		newWindow = window.open(href, '_blank');
		this.location.href= "./graph.html?query="+parent.leftFrame.historyArray[parent.leftFrame.currentGraphPosition].queryType+"&urn="+parent.leftFrame.historyArray[parent.leftFrame.currentGraphPosition].urn;
		newWindow.focus();
	} 
}
	  
	
