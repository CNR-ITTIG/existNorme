xquery version "1.0" encoding "iso-8859-15";
module namespace clustering="http://xmlgroup.iit.cnr.it/nir/clustering";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace nir="http://www.normeinrete.it/nir/2.2/";
declare namespace iit="http://www.iit.cnr.it/nir/meta/proprietario/1.0";




import module namespace date="http://exist-db.org/xquery/admin-interface/date" at "dates.xqm";

(:
    Main function: outputs the page.
:)
declare function clustering:main() as element() {

let $valore := request:get-parameter("valore", "legginazionali")  
let $tipo := request:get-parameter("tipo", "tipoDoc")
let $anno := request:get-parameter("anno", "") 
let $css := request:get-parameter("css", "") 
				

   return
   <div>
	<div id="contenuto">
		<div class="spazioPiccolo">.</div>
		<H3>Norme CNR</H3>
		<IMG class="pallainterna" height="50" alt="" src="./img/palla_elearning.gif" width="45"/> 
		<!-- div id="nav">
			<ul>
				<li>{if ($tipo eq "materia") then attribute class{"sel"} else ()}<a href="?panel=clustering&amp;tipo=materia">Materia</a></li>
				<li>{if ($tipo eq "tipoDoc") then attribute class{"sel"} else ()}<a href="?panel=clustering&amp;tipo=tipoDoc">Tipo</a></li>
				<li>{if ($tipo eq "annoDoc") then attribute class{"sel"} else ()}<a href="?panel=clustering&amp;tipo=annoDoc">Anno</a></li>
				<li>{if ($tipo eq "") then attribute class{"sel"} else ()}<a href="?panel=search">Ricerca Norm.</a></li>
			</ul>
		</div--><br/>
		<div id="elencoArticoli">
			<ul>
				{clustering:listDocument($tipo,$valore,$anno)}
			</ul>
		</div>  
		
	</div>
	<div id="linkinterniDx">
		
		<ul><li>{if ($valore eq 'legginazionali') then attribute class{"sel"} else ()}<a href="?panel=clustering&amp;tipo=tipoDoc&amp;valore=legginazionali">» Legislazione nazionale</a></li></ul>
		<ul><li>{if ($valore eq 'Provvedimento') then attribute class{"sel"} else ()}<a href="?css={$css}&amp;panel=clustering&amp;tipo=tipoDoc&amp;valore=Provvedimento">» Provvedimenti</a></li></ul>
		{
		let $colName := "/db/cnr"
		let $listaanni := distinct-values(collection($colName)//iit:tipoDoc[@valore="Provvedimento"]/../iit:annoDoc/@valore)
		for $a in $listaanni
		order by $a descending
		return <ul><li style="padding-left:30px;">{if ($valore eq 'Provvedimento' and $a eq $anno) then attribute class{"sel"} else ()}<a href="?css={$css}&amp;panel=clustering&amp;tipo=tipoDoc&amp;valore=Provvedimento&amp;anno={$a}">{$a}</a></li></ul>
		}
		<ul><li>{if ($valore eq 'Regolamento') then attribute class{"sel"} else ()}<a href="?css={$css}&amp;panel=clustering&amp;tipo=tipoDoc&amp;valore=Regolamento">» Regolamenti</a></li></ul>
		
		
	</div>
	<!--div id="linkinterniSx" style="display:none" name="div_originale">
		{
			
			let $colName := "/db/cnr/norme"
			let $listaValori := 					
				if ($tipo eq "materia") then distinct-values(collection($colName)//iit:materia/@valore)
				else if ($tipo eq "tipoDoc") then distinct-values(collection($colName)//iit:tipoDoc/@valore)
				else if ($tipo eq "annoDoc") then distinct-values(collection($colName)//iit:annoDoc/@valore)
				else ()
			let $listaanni := distinct-values(collection($colName)//iit:tipoDoc[@valore="Provvedimento"]/../iit:annoDoc/@valore) 
			for $v in $listaValori
						order by $v ascending
						return <ul><li>{if ($v eq $valore) then attribute class{"sel"} else ()} <a href="?panel=clustering&amp;tipo={$tipo}&amp;valore={$v}"> » {if ($v eq "") then "Elenco Completo" else $v cast as xs:string}</a> </li>
						{if ($v eq "Provvedimento") then 
						for $a in $listaanni order by $a descending
						return <span style="padding-left:10px;"><a href="?panel=clustering&amp;tipo=tipoDoc&amp;valore=Provvedimento&amp;anno={$a}">{$a}</a><br/></span>
						
						(:distinct-values(collection($colName)//iit:annoDoc/@valore) :)
						else ()
						
		
		}
	</div-->
</div>
};

declare function clustering:makeResName($res as node()) as xs:string {

	let $tipoDoc := if ($res//iit:tipoDoc[1]/@valore) then $res//iit:tipoDoc[1]/@valore cast as xs:string else () 
	let $emanante := if ($res//nir:intestazione/nir:emanante[1]/text()) then concat(" - ",$res//nir:intestazione/nir:emanante[1] cast as xs:string) else ()
	let $dataDoc := if ($res//nir:intestazione/nir:dataDoc[1]/text()) then concat(" del ",$res//nir:intestazione/nir:dataDoc[1] cast as xs:string) else ()
	let $numDoc := if ($res//nir:intestazione/nir:numDoc[1]/text()) then concat(" n°",$res//nir:intestazione/nir:numDoc[1] cast as xs:string) else ()
	let $numProtocollo := if ($res//nir:intestazione/nir:numDoc[@nome='protocollo']/text()) then concat(" (protocollo n° ",$res//nir:intestazione/nir:numDoc[2] cast as xs:string,")") else ()

		(:
		return concat('Provvedimento CNR', $dataDoc, $numDoc) 
		:)
				
		return concat($tipoDoc,$emanante,$dataDoc,$numDoc,$numProtocollo) 	
};

declare function clustering:makeResNameSoloTITOLO($res as node()) as xs:string {

	let $titoloDoc := if ($res/nir:NIR/*/nir:intestazione/nir:titoloDoc[1]/*[name()='h:span'][not(@finevigore)]) then
		concat("",$res/nir:NIR/*/nir:intestazione/nir:titoloDoc[1]/*[name()='h:span'][not(@finevigore)] cast as xs:string)	
	else (
		if ($res/nir:NIR/*/nir:intestazione/nir:titoloDoc[1]/text()) then 
		concat("",$res/nir:NIR/*/nir:intestazione/nir:titoloDoc cast as xs:string) else ()
	)
	
	return $titoloDoc 
			
};


declare function clustering:listDocument($tipo as xs:string, $valore as xs:string, $ann as xs:string) as element()* {

	let $colName := "/db/cnr/norme"
	
	let $lastYear := max(collection($colName)//iit:annoDoc/@valore[1])
	
	
	let $resSelected := if ($valore eq "") then (
					if ($tipo eq "materia") then collection($colName)[.//iit:materia]
						else if ($tipo eq "tipoDoc") then collection($colName)[.//iit:tipoDoc/@valore='Regolamento']
						else if ($tipo eq "annoDoc") then collection($colName)[.//iit:annoDoc/@valore=$lastYear]
						else ()
				) else (
					if ($tipo eq "materia") then collection($colName)[.//iit:materia/@valore=$valore]
						else if ($tipo eq "tipoDoc" and $ann ne "" and $valore="Provvedimento") then collection($colName)[.//iit:tipoDoc[@valore=$valore]/../iit:annoDoc[@valore=$ann]]
						else if ($tipo eq "tipoDoc" and $ann eq "" and $valore="Provvedimento") then collection($colName)[.//iit:tipoDoc[@valore=$valore]]
						else if ($tipo eq "tipoDoc" and $valore eq "Regolamento") then collection($colName)[.//iit:tipoDoc[@valore='Regolamento' or @valore='Disciplinare']]
						else if ($tipo eq "tipoDoc" and $valore eq "legginazionali") then collection($colName)[.//nir:NIR/*[name() ne 'DocumentoNIR']]
						else if ($tipo eq "annoDoc") then collection($colName)[.//iit:annoDoc/@valore=$valore]
						else ()
				)
	
	for $res in $resSelected (: collection($colName) :)
	let $name := substring-before(util:document-name($res),".xml")
	let $url := concat(xdb:encode-uri(util:collection-name($res)),"/",xdb:encode-uri(util:document-name($res)))
		(: where $res//iit:materia[@valore=$valore] :)
			order by $res//nir:intestazione/nir:dataDoc[1]/@norm descending, $res//nir:intestazione/nir:numDoc[1] descending 
			return
			<li>
				<a target='_new' href='xml?doc={$url}'><img src='img/xml.png'/></a>
				<a target='_new' href='pdf?doc={$url}'><img src='img/pdf.png'/></a>
				<a target='_new' href='xhtml?doc={$url}&amp;datafine={date:normalize-date(current-dateTime())}'>{clustering:makeResName($res)}</a>
				<br/>{clustering:makeResNameSoloTITOLO($res)}
			</li>
	

};
