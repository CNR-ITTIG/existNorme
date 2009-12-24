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


// Array che contiene la history
var historyArray = new Array();

// Nodo della history visualizzato
var currentGraphPosition = null;

// Variabile impostata a true se sto navigando usando i tasti della history
var useHistory = false;

// Struttura dati di un elemento della history
function Hist(urn,queryType) {
	this.urn=urn;
	this.queryType=queryType;
}

// funzione per prendere un parametro dalla url
function getUrlParameter( paramName ){
  paramName = paramName.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+paramName+"=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec( parent.location.href );
  if( results == null )
    return "";
  else
    return results[1];
}

// funzione che viene invocata quando da exist visualizziamo la norma.
// si occupa di gestire la visualizzazione della norma e di chiamare l'eventuale resolver
function loadParam(){
	var queryType = getUrlParameter("query");
	var urn = getUrlParameter("urn");
	var doc = getUrlParameter("doc");
	var datafine = getUrlParameter("datafine");
	
	// Se è una urn la passa al resolver come urn
	if (queryType=="norma"){
		alert("norma " +urn);
		parent.mainFrame.location.href = "./urnResolver.html?urn="+urn;
	} 
	// se è il nome del documento xml lo passa al resolver come doc
	else if (doc){
			var url = "./urnResolver.html?doc="+doc;
			if (!datafine){
			url = url + "&datafine=" + datafine;
			}
			parent.mainFrame.location.href = url;
	} 
	// se è una visualizzazione del grafo la passa come tipo di visualizzazione richiesta e urn
	else{
		parent.mainFrame.location.href = "./graph.html?query="+queryType+"&urn="+urn;
	}
}


// funzione che gestisce la history
function historyHandler(urn, queryType){
	var hist = new Hist(urn, queryType);
//	alert(urn +" "+queryType);
	if (historyArray.length==0){
		historyArray[0] = hist;
		currentGraphPosition = (historyArray.length) - 1;
		
	} else {
//		alert("useHistory "+useHistory);
		if (useHistory){
//			alert("Uso");
//			alert("urn e query vecchia "+historyArray[parseInt(currentGraphPosition)].urn+ " "+historyArray[parseInt(currentGraphPosition)].queryType+ " urn e query nuova " + hist.urn + " " + hist.queryType );
//			alert("Check "+(!((historyArray[parseInt(currentGraphPosition)].urn == hist.urn) && (historyArray[parseInt(currentGraphPosition)].queryType ==  hist.queryType))));
			if (!((historyArray[parseInt(currentGraphPosition)].urn == hist.urn) && (historyArray[parseInt(currentGraphPosition)].queryType ==  hist.queryType))){
//				alert("Tronco");
				currentGraphPosition++;;
				historyArray[parseInt(currentGraphPosition)] = hist;
				historyArray = historyArray.splice(0, (parseInt(currentGraphPosition)+1) );
				useHistory = false;
			}			
		} else  {
			if (!((historyArray[parseInt(currentGraphPosition)].urn == hist.urn) && (historyArray[parseInt(currentGraphPosition)].queryType ==  hist.queryType))){
				historyArray[historyArray.length] = hist;
				currentGraphPosition = (historyArray.length) - 1;
			}
		}
		
	}
	
	
//	printArray(currentGraphPosition);
		
	manageButton(currentGraphPosition);	
}


// funzione per gestire i bottoni della history
function manageButton(position){
	if( ((parseInt(position) + 1) < historyArray.length) && (historyArray.length != 1)){
			var redo = document.getElementById('redo');
			redo.src = "./img/redo.gif";
			redo.setAttribute("class", "pointer");
			var redoCode = "historyManage('"+(parseInt(position) + 1)+"')";
			redo.onclick = null;	
			redo.onclick = function(){
					eval(redoCode);
			}
		} else {
			var redo = document.getElementById("redo");
			redo.src = "./img/redoDisable.gif";
			redo.setAttribute("class", "");
			
			
			redo.onclick = null;		
		}
	
		if((parseInt(position) - 1)>= 0){
			var undo = document.getElementById('undo');
			undo.src = "./img/undo.gif";
			undo.setAttribute("class", "pointer");
			var undoCode = "historyManage('"+(parseInt(position) - 1)+"')";
			undo.onclick = null;	
			undo.onclick = function(){
					eval(undoCode);
			};
		} else {
			var undo = document.getElementById('undo');
			undo.src = "./img/undoDisable.gif";
			undo.setAttribute("class", "");
			undo.onclick = null;
		}
		
}


// funzione per manipolare la history. Viene invocata dal click sul bottone
function historyManage(position){
		
//		printArray(position);
		currentGraphPosition = position;
		useHistory = true;
		if (historyArray[position].queryType=="norma"){
			parent.mainFrame.location.href = "./urnResolver.html?urn="+historyArray[position].urn;
		} else {
			resetMenuColour(historyArray[position].queryType);
		
			parent.mainFrame.location.href = "./graph.html?query="+historyArray[position].queryType+"&urn="+historyArray[position].urn;
			
		}
		
		
}




function showGraph(queryType){
		
		resetMenuColour(queryType);

	if (queryType=="inRef"){
		parent.mainFrame.location.href = "./graph.html?query=inRef&urn="+historyArray[currentGraphPosition].urn;
		} else if (queryType=="outRef"){
		parent.mainFrame.location.href = "./graph.html?query=outRef&urn="+historyArray[currentGraphPosition].urn;
	} else if (queryType=="inMod"){
		parent.mainFrame.location.href = "./graph.html?query=inMod&urn="+historyArray[currentGraphPosition].urn;
	} else {
		parent.mainFrame.location.href = "./graph.html?query=outMod&urn="+historyArray[currentGraphPosition].urn;
	} 
}


// funzione di debug
function printArray(position){
	var valore = "Posizione chiamata "+position +"\n";
	for(i=0; i < historyArray.length; i++){
		valore += "posizione: "+ i + " valore "+ historyArray[i].urn + "\n";
	}
	alert(valore);

}

function resetMenuColour(queryType){
	document.getElementById("inRef").className = "query";
	document.getElementById("outRef").className = "query";
	document.getElementById("inMod").className = "query";
	document.getElementById("outMod").className = "query";
	if (queryType!=""){
		document.getElementById(queryType).className = "querySelezionata";
	}

}

