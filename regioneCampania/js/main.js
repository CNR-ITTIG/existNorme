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


function aggiornaWidgets() {
			var tipo = $('#estremiTipo').val();
			
			if (tipo =='decreto') 
					$('#estremiEmanante').show();
				else
					$('#estremiEmanante').hide();
					

			var tipoRif = $('#tipoRiferimento').val();
			
			if (tipoRif =='legge' || tipoRif =='regolamento' || tipoRif =='direttiva') 
					$('#riferimentoEmanante').show();
				else
					$('#riferimentoEmanante').hide();
					
			if ($("#soloTitolo").is(":checked")) 
					$("#nonInTitolo").hide();
				else
					$("#nonInTitolo").show();					
}


$(document).ready(function() {

	$('#estremiTipo').change(function(){
		aggiornaWidgets();
	});

	$('#tipoRiferimento').change(function(){
		aggiornaWidgets();
	});

	$('#soloTitolo').click(function(){
		aggiornaWidgets();
	});

});

/*
	$('#emanante').change(function(){
			var emanante = $('#emanante').val();
			$('#tipo').load("rif.xql?emanante="+emanante);


	});

	$('#tipo').change(function(){
			var emanante = $('#emanante').val();
			var tipo = $('#tipo').val();
			$('#anno').load("rif.xql?emanante="+emanante+"&tipo="+tipo);
			//alert(tipo);
	});

	$('#anno').change(function(){
			var emanante = $('#emanante').val();
			var tipo = $('#tipo').val();
			var anno = $('#anno').val();
			$('#mese').load("rif.xql?emanante="+emanante+"&tipo="+tipo+"&anno="+anno);
			//alert(tipo);
	});

	$('#mese').change(function(){
			var emanante = $('#emanante').val();
			var tipo = $('#tipo').val();
			var anno = $('#anno').val();
			var mese = $('#mese').val();
			$('#giorno').load("rif.xql?emanante="+emanante+"&tipo="+tipo+"&anno="+anno+"&mese="+mese);
			//alert(tipo);
	});

	$('#numero').change(function(){
			var emanante = $('#emanante').val();
			var tipo = $('#tipo').val();
			var anno = $('#anno').val();
			var mese = $('#mese').val();
			var giorno = $('#giorno').val();
			$('#numero').load("rif.xql?emanante="+emanante+"&tipo="+tipo+"&anno="+anno+"&mese="+mese+"&giorno="+giorno);
			//alert(tipo);
	});

	
	
});

*/
