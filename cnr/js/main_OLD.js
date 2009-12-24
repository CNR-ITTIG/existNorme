 function loadHistory(doc){
	$("#modalContainer").load(doc,showModal);
 }


function showModal(){
		$("#modalContainer").css("display","block");
		$("#background").css("display","block");
}			

function hideModal(){
		$("#modalContainer").css("display","none");
		$("#background").css("display","none");
}			

function ReverseContentDisplay(d) {
		if(d.length < 1) { return; }
		if(document.getElementById(d).style.display == "none") { document.getElementById(d).style.display = "block"; }
		else { document.getElementById(d).style.display = "none"; }
}
