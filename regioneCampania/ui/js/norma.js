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


// viene usato all'interno dello xslt che converte la norma in xml, per aggiornare la history (menu.js)


// Estrae i parametri da una url
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


var query = getUrlParameter("query");
var urn = getUrlParameter("urn");
var datafine = getUrlParameter("datafine");

// non mette nella history i click sulla multivifenza
if (!datafine){
	parent.leftFrame.historyHandler(urn, query);

}

