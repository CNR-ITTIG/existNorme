xquery version "1.0" encoding "iso-8859-15";
(: Developed by Maurizio Tesconi - Istituto di Informatica e Telematica - CNR - maurizio.tesconi@iit.cnr.it :)

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

let $valore := request:get-parameter("valore", "")  
let $tipo := request:get-parameter("tipo", "materia")  
				

   return
   <div>
	<div id="contenuto">
		<div class="spazioPiccolo">.</div>
		<H3>Raccolta normativa ICT </H3>
		<IMG class="pallainterna" height="50" alt="" src="./img/palla_elearning.gif" width="45"/> 
		<br/><br/>
		<div id="nav">
			<ul>
				<li>{if ($tipo eq "materia") then attribute class{"sel"} else ()}<a href="?panel=clustering&amp;tipo=materia">Materia</a></li>
				<li>{if ($tipo eq "tipoDoc") then attribute class{"sel"} else ()}<a href="?panel=clustering&amp;tipo=tipoDoc">Tipo</a></li>
				<li>{if ($tipo eq "annoDoc") then attribute class{"sel"} else ()}<a href="?panel=clustering&amp;tipo=annoDoc">Anno</a></li>
				<li>{if ($tipo eq "") then attribute class{"sel"} else ()}<a href="?panel=search">Ricerca Norm.</a></li>
			</ul>
		</div><br/>
		<div id="elencoArticoli">
			<ul>
				{clustering:listDocument($tipo,$valore)}
			</ul>
		</div>  
		
	</div>
	<div id="linkinterniDx">
		{
			let $colName := "/db/nir/normeCnipa"
			(:
			let $listaValori := 					
				if ($tipo eq "materia") then distinct-values(collection($colName)//iit:materia/@valore)
				else if ($tipo eq "tipoDoc") then distinct-values(collection($colName)//iit:tipoDoc/@valore)
				else if ($tipo eq "annoDoc") then distinct-values(collection($colName)//iit:annoDoc/@valore)
				else ()
			:)
			let $listaValori := 					
				if ($tipo eq "materia") then distinct-values(collection($colName)//nir:materia/@valore)
				else if ($tipo eq "tipoDoc") then distinct-values(collection($colName)//nir:tipoDoc/normalize-space(upper-case(text())))
				else if ($tipo eq "annoDoc") then distinct-values(collection($colName)//nir:dataDoc/substring(@norm,1,4))
				else ()
			for $v in $listaValori
						order by $v
						return <ul><li class="{if ($v eq $valore) then 'sel' else ''}">» <a href="?panel=clustering&amp;tipo={$tipo}&amp;valore={$v}"> {if ($v eq "") then "Elenco Completo" else $v cast as xs:string}</a> </li></ul>
		}
	</div>
</div>
};

declare function clustering:makeResName($res as node()) as xs:string {

	let $tipoDoc := if ($res//nir:tipoDoc[1]/text()) then $res//nir:tipoDoc[1]/text() cast as xs:string else () 
	let $emanante := if ($res//nir:intestazione/nir:emanante[1]/text()) then concat(" - ",$res//nir:intestazione/nir:emanante[1] cast as xs:string) else ()
	let $dataDoc := if ($res//nir:intestazione/nir:dataDoc[1]/text()) then concat(" - ",$res//nir:intestazione/nir:dataDoc[1] cast as xs:string) else ()
	let $numDoc := if ($res//nir:intestazione/nir:numDoc[1]/text()) then concat(" - N°",$res//nir:intestazione/nir:numDoc[1] cast as xs:string) else ()

	let $titoloDoc := if ($res/nir:NIR/*/nir:intestazione/nir:titoloDoc[1]/text()) then concat(" - ",$res/nir:NIR/*/nir:intestazione/nir:titoloDoc[1] cast as xs:string) else ()

		return concat($tipoDoc, $emanante, $dataDoc, $numDoc,$titoloDoc) 
			
};


declare function clustering:listDocument($tipo as xs:string, $valore as xs:string) as element()* {

	let $colName := "/db/nir/normeCnipa"
	let $resSelected := if ($valore eq "") then (
					if ($tipo eq "materia") then collection($colName)[.//nir:materia]
						else if ($tipo eq "tipoDoc") then collection($colName)[.//nir:tipoDoc]
						else if ($tipo eq "annoDoc") then collection($colName)[.//nir:dataDoc]
						else ()
				) else (
					if ($tipo eq "materia") then collection($colName)[.//nir:materia/@valore=$valore]
						else if ($tipo eq "tipoDoc") then collection($colName)[.//nir:tipoDoc/normalize-space(upper-case(text()))=$valore]
						else if ($tipo eq "annoDoc") then collection($colName)[.//nir:dataDoc/substring(@norm,1,4)=$valore]
						else ()
				)
	
	for $res in $resSelected (: collection($colName) :)
	let $name := substring-before(util:document-name($res),".xml")
	let $url := concat(xdb:encode-uri(util:collection-name($res)),"/",xdb:encode-uri(util:document-name($res)))
		(: where $res//iit:materia[@valore=$valore] :)
			return
			<li>
				<a target='_new' href='xml?doc={$url}'><img src='img/xml.png'/></a>
				<a target='_new' href='pdf?doc={$url}'><img src='img/pdf.png'/></a>
				<a target='_new' href='xhtml?doc={$url}&amp;datafine={date:normalize-date(current-dateTime())}'>{clustering:makeResName($res)}</a>
			</li>
	

};
