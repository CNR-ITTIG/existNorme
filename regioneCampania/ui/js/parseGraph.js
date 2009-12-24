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

var centerVertex = null;

//Lista paginata dei vertici del grafo
var vertexList = new Array(); 
var vertexDoubleList ="";
var test = false;
var queryType = "";

// Lista delle urn presenti nella collezione
var urnList = new Array(); 

var urnCenter = "";
	
// struttura dati per rappresentare un nodo
function Vertex(authority,type,year,number, urn) {
	this.authority=authority;
	this.type=type;
	this.year=year;
	this.number=number;
	this.urn=urn;
}


// Viene chiamata quando si apre la prima volta la norma da exist. Prende i parametri della norma in esame dall'url
function sendQueryFromUrl(){
	var query = getUrlParameter("query");
	var urn = getUrlParameter("urn");

	if (query == "norma"){
		parent.leftFrame.historyManage(parent.leftFrame.currentGraphPosition);
		return;
	} 


	parent.leftFrame.resetMenuColour(query);
	sendFirstQuery(query, urn);
}


// Chiama la funzione per interrogare exist per avere i quattro tipi di visualizzazione e si occupa di aggiornare la history (menu.js)
function sendFirstQuery(query, urn){
	
	parent.leftFrame.historyHandler(urn, query);
	
	sendQuery(query, urn);
}


// funzione per interrogare exist per avere i quattro tipi di visualizzazione
function sendQuery(query, urn){
		queryType = query;
	//Start AJAX Engine
	var url = "../graph.xql?query="+query+"&urn="+urn; // File XML da interrogare 
	urnCenter = urn;
	var isIE = false;
	var XMLHttpRequestObject = false;
	var xmlDocument = null;
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
//				alert(XMLHttpRequestObject.responseText);
				if (!isIE){
					xmlstring = "<?xml version='1.0'?>"+XMLHttpRequestObject.responseText;
						try {
							xmlDocument = (new DOMParser()).parseFromString(xmlstring, "text/xml");						
						} catch (e) {
							var xmldoc = "<?xml version='1.0'?>"+ XMLHttpRequestObject.responseText;
							xmlDocument = new ActiveXObject("Msxml2.DOMDocument.3.0");
							xmlDocument.loadXML(xmldoc);
						}	 
				} else {
					var xmldoc = "<?xml version='1.0'?>"+ XMLHttpRequestObject.responseText;
					xmlDocument = new ActiveXObject("Msxml2.DOMDocument.3.0");
					xmlDocument.loadXML(xmldoc);
				}

			parserXML(xmlDocument, query);
		
			} 
		}; 
	} else {
		alert("Il tuo browser non supporta AJAX");
	}
	XMLHttpRequestObject.send(null);
	//Fine AJAX Engine
}


// Esegue il parse dello stream xml ajax.
function parserXML(xmlDocument){

	var vertexes = null;
	
	centerVertex = parseURN(urnCenter);
	
	// Toglie gli elementi duplicati e i riferimenti a sè stesso
	xmlDocument = cleanDoubles(xmlDocument, urnCenter);
	
	// Struttura xml contente tutti i vertici del grafo
	vertexes = xmlDocument.getElementsByTagName("vertex");
	
	// Lista paginata contenente i vertici del grafo
	vertexList['vertexList'] = new jsPagination(vertexes, 10);

	//Prendo la prima pagina della lista
	vertexListPagination = vertexList['vertexList'].getPage(1);


	// Estraggo i dati del grafo da visualizzare
	extractGraph(vertexListPagination);
}


// Si occupa di togliere gli elementi duplicati e i riferimenti a sè stesso
function cleanDoubles(xmlDocument, urnCenter){
	var xmlVertex = xmlDocument.getElementsByTagName("vertex");
	var urnTxt = null;
	var docIdentifier = null;
	var patternDocIdentifier = /[^#@]*/i;
	var vertexDoubleList =  "#"+urnCenter.match(patternDocIdentifier)+"#";
	var remove = false;
	for (i=xmlVertex.length; i>0; i-- ){
		urnTxt = xmlVertex[i-1].childNodes[0].nodeValue;
		docIdentifier = "#"+urnTxt.match(patternDocIdentifier)+"#";
		if(docIdentifier=="##"){
			remove=true;
		} else
		if(vertexDoubleList.match(docIdentifier)){
			remove=true;
		} else {
			vertexDoubleList += docIdentifier;
			remove = false;
		}
		if (remove){
			;
			xmlVertex[i-1].parentNode.removeChild(xmlVertex[i-1]);
		} 
	}
	return xmlDocument;
}


// Estrae dalla lista il grafo e lo visualizza disegnando nodi e archi
function extractGraph(vertexListPagination){
	var nodeList = new Array(); 
	graph.reset();

	// disegna il nodo centrale
	center =  control.addNode(centerVertex.type,centerVertex.year,centerVertex.number, centerVertex.urn, queryType,  1, true, 100 );
	
	//Imposta i colori del nodo in base al tipo di norma
	setNodeColor(center, centerVertex.type, true);

	//disegna i nodi
	for (var i = 0; i < vertexListPagination.length; i++){
		var urnTxt =  vertexListPagination[i].childNodes[0].nodeValue;

		// Memorizza nella struttura vertex i dati estratti dalla urn
		var vertex = parseURN(urnTxt);
		nodeList[i] = control.addNode(vertex.type,vertex.year,vertex.number, vertex.urn, queryType, 1, true, 100 );
    	
		//Imposta i colori del nodo in base al tipo di norma
		setNodeColor(nodeList[i], vertex.type, false);

		
	}
	//disegna gli archi
	for (i = 0;i < nodeList.length ; i++){
		control.addEdge( center, nodeList[i], 100 );
	}

// Aggiorna la toolbar a destra
drawToolbar();

}

// Esegue il parse dell'urn per estrarre le informazioni sulla norma
function parseURN(urnTxt){
	var vertex;
	var urnArray = urnTxt.split(":");
	authority = urnArray[2];
	var patternC = /^urn:nir:stato:costituzione(.)*$/i;
	var patternCBC = /^urn:nir:stato:codice.beni.culturali(.)*$/i;
	var patternCC = /^urn:nir:stato:codice.civile(.)*$/i;
	var patternCCS = /^urn:nir:corte.costituzionale:sentenza(.)*$/i;
	var patternCED = /^urn:nir:comunita.europee:direttiva(.)*$/i;
	var patternCER = /^urn:nir:comunita.europee:regolamento(.)*$/i;
	var patternCP = /^urn:nir:stato:codice.penale(.)*$/i;
	var patternCPC = /^urn:nir:stato:codice.procedura.civile(.)*$/i;
	var patternDL=/^urn(.)*decreto\.legge(.)*$/i;
	var patternDLgs=/^urn(.)*stato:decreto.legislativo(.)*$/i;
	var patternDM2 = /^urn:nir:ministro.innovazione.tecnologie:decreto(.)*$/i;
	var patternDM3 = /^urn:nir:ministro.riforme.innovazioni.pubblica.amministrazione:decreto(.)*$/i;
	var patternDM=/^urn(.)*ministero(.)*decreto(.)*$/i;
	var patternDPCM=/^urn(.)*consiglio(.)*decreto(.)*$/i;
	var patternDPR=/^urn(.)*repubblica(.)*decreto(.)*$/i;
	var patternL=/^urn(.)*stato:legge(.)*$/i;
	var patternLC = /^urn:nir:stato:legge.costituzionale(.)*$/i;
	var patternRD = /^urn:nir:stato:regio.decreto(.)*$/i;
	var patternRDL = /^urn:nir:stato:regio.decreto.legge(.)*$/i;
	var patternRDLgs = /^urn:nir:stato:regio.decreto.legislativo(.)*$/i;
	var patternRegioneCampania = /^urn:nir:regione.campania:legge(.)*$/i;
	var patternRegioneCampaniaStatuto = /^urn:nir:regione.campania:statuto(.)*$/i;
	var patternRegioneCampaniaDel = /^urn:nir:regione.campania:delib(.)*$/i;

	
	if (patternRegioneCampania.test(urnTxt))	{
		type = "Legge R.C."; 
	} else if (patternRegioneCampaniaStatuto.test(urnTxt))	{
		type = "Statuto R.C."; 
	} else if (patternRegioneCampaniaDel.test(urnTxt))	{
		type = "Del. R.C."; 
	} else if (patternC.test(urnTxt))	{
		type = "Cost.";
	} else if (patternCBC.test(urnTxt))	{
		type = "Cod.B.Cult.";
	} else if (patternCC.test(urnTxt))	{
		type = "Cod.Civ.";
	} else if (patternCCS.test(urnTxt))	{
		type = "C.Cost.Sent.";
	} else if (patternCED.test(urnTxt))	{
		type = "Com.Eu.Dir.";
	} else if (patternCER.test(urnTxt))	{
		type = "Com.Eu.Reg.";
	} else if (patternCP.test(urnTxt))	{
		type = "C.P.";
	} else if (patternCPC.test(urnTxt))	{
		type = "C.P.C.";
	} else if (patternDL.test(urnTxt))	{
		type = "D.L.";
	} else if (patternDLgs.test(urnTxt))	{
		type = "D.Lgs";
	} else if (patternDM2.test(urnTxt))	{
		type = "D.M.";
	} else if (patternDM3.test(urnTxt))	{
		type = "D.M.";
	} else if (patternDM.test(urnTxt))	{
		type = "D.M.";
	} else if (patternDPCM.test(urnTxt))	{
		type = "D.P.C.M.";
	} else if (patternDPR.test(urnTxt))	{
		type = "D.P.R.";
	} else if (patternL.test(urnTxt))	{
		type = "Legge";
	} else if (patternLC.test(urnTxt))	{
		type = "L.C.";
	} else if (patternRD.test(urnTxt))	{
		type = "R.D.";
	} else if (patternRDL.test(urnTxt))	{
		type = "R.D.L.";
	} else if (patternRDLgs.test(urnTxt))	{
		type = "R.D.Lgs";
	} else {
		type = "Da Definire";
	}
	dateAndNumber = urnArray[4].split(";");
	date = dateAndNumber[0].split("-");
	year = date[0];
	if (dateAndNumber[1]){
		numberAndGarbage = dateAndNumber[1].split(/[#@]/);
		number = numberAndGarbage[0];
	} else {
		number = "null"
	}
	
	 
	var patternNumber=/^[0-9]*$/;
	if (!patternNumber.test(number)){
		number="--";
	}
	vertex = new Vertex (authority,type,year,number,urnTxt);
	return vertex;
}



// Estrae la lista delle urn presenti nella collezione per usarla nel controllo dei duplicati
function getUrnList(){
	
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


// Esegue il parse per la lista delle urn
function parserURNList(xmlUrn){
	var list = xmlUrn.getElementsByTagName("list")
	for (var i = 0; i < list.length; i++){
		var urn = list[i].getElementsByTagName("urn")[0].childNodes[0].nodeValue;
		urnList[i] = urn;
		
	}

	sendQueryFromUrl();
}


// Gestisce i tasti della paginazione del grafo
function drawToolbar(){
	var next = null;
	var prev = null;
	if (vertexList['vertexList'].getTotalPages()==0){
		next = document.getElementById('next');
		next.src = "./img/nextDisable.gif";
		next.setAttribute("class", "");
		next.onclick = null;
	
	} else 	if (vertexList['vertexList'].getPageNum() != vertexList['vertexList'].getTotalPages()){
		nextCode = "changePage('next', vertexList['vertexList'].getPage(vertexList['vertexList'].getPageNum()+1))";
		next = document.getElementById('next');
		next.src = "./img/next.gif";
		next.setAttribute("class", "pointer");
		next.onclick = function(){
				eval(nextCode);
		};
	} else {
		next = document.getElementById('next');
		next.src = "./img/nextDisable.gif";
		next.setAttribute("class", "");
		next.onclick = null;
	}
	
	if (vertexList['vertexList'].getPageNum() != 1){
		prevCode = "changePage('prev', vertexList['vertexList'].getPage(vertexList['vertexList'].getPageNum()-1))";
		prev = document.getElementById('prev');
		prev.src = "./img/prev.gif";
		prev.setAttribute("class", "pointer");
		prev.onclick = function(){
				eval(prevCode);
		};
	} else {
		prev = document.getElementById('prev');
		prev.src = "./img/prevDisable.gif";
		prev.setAttribute("class", "");
		prev.onclick = null;
	}

}

//Imposta i colori del nodo in base al tipo di norma
function setNodeColor(node, type, center){
	if (center){
		width="6px ";
	} else {
		width="3px ";
	}

	if (type == "Legge R.C."){
		graphui.getNode( node.id ).style.backgroundColor="#ff6633";
		graphui.getNode( node.id ).style.border=width+"solid #993300";	
	} 
	if (type == "Statuto R.C."){
		graphui.getNode( node.id ).style.backgroundColor="#ff6633";
		graphui.getNode( node.id ).style.border=width+"solid #993300";		
	}
	if (type == "Del. R.C."){
		graphui.getNode( node.id ).style.backgroundColor="#ff6633";
		graphui.getNode( node.id ).style.border=width+"solid #993300";		
	}
	if (type == "Cost."){
		graphui.getNode( node.id ).style.backgroundColor="#ff0000";
		graphui.getNode( node.id ).style.border=width+"solid #990000";
	}  else if (type == "Cod.B.Cult."){
		graphui.getNode( node.id ).style.backgroundColor="#ffcc00";
		graphui.getNode( node.id ).style.border=width+"solid #996600";
	} else if (type == "Cod.Civ."){
		graphui.getNode( node.id ).style.backgroundColor="#cccccc";
		graphui.getNode( node.id ).style.border=width+"solid #666666";
	} else if (type == "C.Cost.Sent."){
		graphui.getNode( node.id ).style.backgroundColor="#ff0066";
		graphui.getNode( node.id ).style.border=width+"solid #990033";
	} else if (type == "Com.Eu.Dir."){
		graphui.getNode( node.id ).style.backgroundColor="#00ff66";
		graphui.getNode( node.id ).style.border=width+"solid #009933";
	} else if (type == "Com.Eu.Reg."){
		graphui.getNode( node.id ).style.backgroundColor="#cc00ff";
		graphui.getNode( node.id ).style.border=width+"solid #660066";
	} else if (type == "C.P."){
		graphui.getNode( node.id ).style.backgroundColor="#ccccff";
		graphui.getNode( node.id ).style.border=width+"solid #996699";
	} else if (type == "C.P.C."){
		graphui.getNode( node.id ).style.backgroundColor="#6633ff";
		graphui.getNode( node.id ).style.border=width+"solid #330099";
	} else if (type == "D.L."){
		graphui.getNode( node.id ).style.backgroundColor="#66ff33";
		graphui.getNode( node.id ).style.border=width+"solid #339933";	
	} else if (type == "D.Lgs"){
		graphui.getNode( node.id ).style.backgroundColor="#66ccff";
		graphui.getNode( node.id ).style.border=width+"solid #336699";
	} else if (type == "D.M."){
		graphui.getNode( node.id ).style.backgroundColor="#99cc33";
		graphui.getNode( node.id ).style.border=width+"solid #666633";
	} else if (type == "D.P.C.M."){
		graphui.getNode( node.id ).style.backgroundColor="#00ffcc";
		graphui.getNode( node.id ).style.border=width+"solid #009966";
	} else if (type == "D.P.R."){
		graphui.getNode( node.id ).style.backgroundColor="#ff9999";
		graphui.getNode( node.id ).style.border=width+"solid #996666";	
	} else if (type == "Legge"){
		graphui.getNode( node.id ).style.backgroundColor="#ffcc33";
		graphui.getNode( node.id ).style.border=width+"solid #cc9900";
	} else if (type == "L.C."){
		graphui.getNode( node.id ).style.backgroundColor="#ffff33";
		graphui.getNode( node.id ).style.border=width+"solid #999900";
	} else if (type == "R.D."){
		graphui.getNode( node.id ).style.backgroundColor="#ff66cc";
		graphui.getNode( node.id ).style.border=width+"solid #663366";
	} else if (type == "R.D.L."){
		graphui.getNode( node.id ).style.backgroundColor="#99ffff";
		graphui.getNode( node.id ).style.border=width+"solid #669999";
	} else if (type == "R.D.Lgs"){
		graphui.getNode( node.id ).style.backgroundColor="#ff9933";
		graphui.getNode( node.id ).style.border=width+"solid #996633";
	} else if (type == "Da Definire"){
		graphui.getNode( node.id ).style.backgroundColor="#cccccc";
		graphui.getNode( node.id ).style.border=width+"solid #666666";		
	} 
}


// Mostra il grafo
function displayGraph(){
 var tagList = document.getElementsByName("graphCanvas");
	if(test){
		test = false;
		
		for(i=0; i < tagList.length; i++)
			tagList[i].style.display = "";
	} else {
		test = true;
		for(i=0; i < tagList.length; i++)
			tagList[i].style.display = "none";
	}
}

// Gestisce la paginazione del grafo
function changePage(action, pageIndex){
	if (action=="prev" ){
		
		extractGraph(pageIndex);
	} else {
		extractGraph(pageIndex);
	} 
}


// Estrae i parametri dalla url
function getUrlParameter( paramName ){
  paramName = paramName.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+paramName+"=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec( window.location.href );
  if( results == null )
    return "";
  else
    return results[1];
}




/**
* Serializza un xml in una stringa.
*/
function serialize(node) {
	if (typeof XMLSerializer != "undefined")
		return (new XMLSerializer( )).serializeToString(node);
	else if (node.xml) return node.xml;
	
};
