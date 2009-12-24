xquery version "1.0" encoding "iso-8859-15";
module namespace search="http://xmlgroup.iit.cnr.it/nir/search";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace session = "http://exist-db.org/xquery/session";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace nir="http://www.normeinrete.it/nir/2.2/";
declare namespace text="http://exist-db.org/xquery/text";
declare namespace iit="http://www.iit.cnr.it/nir/meta/proprietario/1.0";
declare namespace dsp="http://www.normeinrete.it/nir/disposizioni/2.2/";
declare namespace xlink="http://www.w3.org/1999/xlink";

import module namespace date="http://exist-db.org/xquery/admin-interface/date" at "dates.xqm";

(:
    Main function: outputs the page.
:)
declare function search:main() as element() {

	let $testo := request:get-parameter("testo", "")  
	let $titolo := request:get-parameter("titolo", "")  
	
	let $comma:= request:get-parameter("comma", "")  
	let $fonte:= request:get-parameter("fonte", "")  
	let $tipo := request:get-parameter("tipo", "")  
	let $materia:= request:get-parameter("materia", "")  
	
	let $autoritaModifica:= request:get-parameter("autoritaModifica", "") 
	let $tipoModifica:= request:get-parameter("tipoModifica", "") 
	let $giornoModifica:= request:get-parameter("giornoModifica", "") 
	let $meseModifica:= request:get-parameter("meseModifica", "") 
	let $annoModifica:= request:get-parameter("annoModifica", "") 
	let $numeroModifica:= request:get-parameter("numeroModifica", "") 

	
	let $autoritaRiferimento:= request:get-parameter("autoritaRiferimento", "") 
	let $tipoRiferimento:= request:get-parameter("tipoRiferimento", "") 
	let $giornoRiferimento:= request:get-parameter("giornoRiferimento", "") 
	let $meseRiferimento:= request:get-parameter("meseRiferimento", "") 
	let $annoRiferimento:= request:get-parameter("annoRiferimento", "") 
	let $numeroRiferimento:= request:get-parameter("numeroRiferimento", "") 
	
	let $giornoDoc := request:get-parameter("giornoDoc", "")  
	let $meseDoc := request:get-parameter("meseDoc", "")  
	let $annoDoc := request:get-parameter("annoDoc", "")  
	let $annoFonte := request:get-parameter("annoFonte", "")  
	let $num := request:get-parameter("num", "")  
	let $emanante := request:get-parameter("emanante", "")  
	let $tipoDisposizione := request:get-parameter("tipoDisposizione", "")  
	let $combinazione:= request:get-parameter("combinazione", "almeno") 

	let $combinazione:= if ($combinazione eq "") then "almeno" else $combinazione 

	let $colName := "/db/nir/RegioneCampania"

		return
<div> 
	<div id="contenuto">
		<div class="spazioPiccolo">.</div>
		<H3>Raccolta normativa Regione Campania </H3>
		<IMG class="pallainterna" height="50" alt="" src="./img/palla_elearning.gif" width="45"/> 
		<!--div id="nav">
			<ul>
				<li>{if ($tipo eq "materia") then attribute class{"sel"} else ()}<a href="?panel=clustering&amp;tipo=materia">Materia</a></li>
				<li>{if ($tipo eq "tipoDoc") then attribute class{"sel"} else ()}<a href="?panel=clustering&amp;tipo=tipoDoc">Tipo</a></li>
				<li>{if ($tipo eq "annoDoc") then attribute class{"sel"} else ()}<a href="?panel=clustering&amp;tipo=annoDoc">Anno</a></li>
				<li>{if ($tipo eq "") then attribute class{"sel"} else ()}<a href="?panel=search">Ricerca Norm.</a></li>
			</ul>
		</div--><br/>  

		
		<div id="elencoRicerca">
					<ul>
						{
						if ($testo eq "" and $tipo eq "" and $titolo eq ""  and $fonte eq "" and $materia eq ""
										 and $annoFonte eq "" and $num eq "" and $giornoDoc eq "" and $meseDoc eq "" and $annoDoc eq "" 
										 and $tipoDisposizione eq "" and $emanante eq "" and $comma eq "" and $tipoModifica eq "" and $giornoModifica eq ""  and $meseModifica eq "" and $annoModifica eq "" and $numeroModifica eq "" and $tipoRiferimento eq "" and $giornoRiferimento eq "" and $meseRiferimento eq "" and $annoRiferimento eq "" and $numeroRiferimento eq "")
							then () else search:search()
						}
					</ul>
				</div>
		<br/><br/>
		<div  id="formRicerca">
			<form name="ricercaForm" method="post" action="{session:encode-url(request:get-uri())}" >
				<input type="hidden" name="panel" value="search"/>
			<table witdh="700px">
				<tr>
					<th colspan="2" align="center">Estremi del Provvedimento</th>
					
				</tr>
				 <tr>
							<td align="right">Titolo 
							<input type="text" name="titolo"   style="width:257px;"/></td>
							<td align="right">Anno <select name="annoDoc" style="width:60px;">
								<option/>
								{
									for $valore in distinct-values(collection($colName)//iit:annoDoc/@valore)
										order by $valore 
										return <option>{if ($valore eq $annoDoc) then attribute selected {"selected"} else ()}{$valore cast as xs:string}</option>
								}
								</select>
							</td>
						</tr>
						{ if (count(distinct-values(collection($colName)//iit:tipoDoc/@valore)) > 1) then
												<tr>
													<td align="right" width="350px">Tipo 
													<select name="tipo"  style="width:257px;">
														<option/>
													{
														let $colName := "/db/nir/RegioneCampania"
														for $tipoDoc in distinct-values(collection($colName)//iit:tipoDoc/@valore)
															order by $tipoDoc 
															return <option>{if ($tipoDoc eq $tipo) then attribute selected {"selected"} else ()}{$tipoDoc cast as xs:string}</option>
													}
													</select>
													</td>
													<td align="right" width="150px">Numero <input type="text" name="num"   style="width:60px;"/></td>
												</tr>
									else ()
						}
						<tr>
							<td align="right" colspan="2">Emanante 
								<select name="emanante"  style="width:411px;">
								{ 
									let $colName := "/db/nir/RegioneCampania"
									for $emanante in distinct-values(collection($colName)//nir:intestazione/nir:emanante)
										order by $emanante 
										return <option>{$emanante}</option>
								}
								</select>
							</td>

						</tr>
				</table><br/>
			<!-- table witdh="700px">
						<tr>
							<th align="center" colspan="2">Pubblicazione</th>
						</tr>
						<tr>
								<td  align="right" colspan="2">Fonte 
								<select name="fonte">
									<option/>
									<option>BURC</option>
								</select>
							 Anno <input type="text" name="annoFonte"   style="width:50px;"/></td>
						</tr>	
			</table -->
			<br/>
						<table witdh="700px">
			<tr>
				<th colspan="2" align="center">Parole dell'Atto</th>
						</tr>
						<tr>
							<td align="right" width="300px">Testo <input type="text" name="testo"  style="width:209px;"/></td>
							<td  align="left" width="200px">
							<input type="radio" name="combinazione" value="esatta">{if ($combinazione eq "esatta") then attribute checked {"checked"} else ()}frase esatta</input><br/>
							<input type="radio" name="combinazione" value="almeno">{if ($combinazione eq "almeno") then attribute checked {"checked"} else ()}almeno una parola</input><br/>
							<input type="radio" name="combinazione" value="tutte">{if ($combinazione eq "tutte") then attribute checked {"checked"} else ()}tutte le parole</input><br/>
							<input type="radio" name="combinazione" value="comma">{if ($combinazione eq "comma") then attribute checked {"checked"} else ()}nello stesso comma</input><br/>
							<input type="radio" name="combinazione" value="articolo">{if ($combinazione eq "articolo") then attribute checked {"checked"} else ()}nello stesso articolo</input>
							</td>
						</tr>
			</table><br/>
			<table width="500px">
					<tr>
							<th align="center"  colspan="3" >Modificati da</th>
						</tr>
						<tr>
							<td  align="center" colspan="3">Autorità
								  <select name="autoritaModifica"   class="low" >
									    <option></option>
									    <option value="regione.campania">Regione Campania</option>
									    <option value="stato">Stato</option>
									</select>
							</td>
						</tr>	
						<tr>
							<td  align="right"  colspan="2">Tipo 
								  <select name="tipoModifica"   class="low" >
									    <option></option>
									    <option value="legge">Legge</option>
									    <option value="decreto.legge">Decreto Legge</option>
									    <option value="decreto.legislativo">Decreto Legislativo</option>
									    <option value="decreto.presidente.consiglio.ministri">Decreto presidente consiglio ministri</option>
									</select></td>
								<td align="right">Numero <input type="text" name="numeroModifica"  style="width:50px;"/></td>
						</tr>	
						<tr>
							<td  align="right" >Giorno 
								  <input type="text" name="giornoModifica"  style="width:50px;"/></td>
								<td align="center">Mese <input type="text" name="meseModifica"  style="width:50px;"/></td>
								<td  align="right" >Anno <input type="text" name="annoModifica"  style="width:50px;"/>
								</td>
						</tr>	
						</table><br/>
			
			<table width="500px">
						<tr>	
							<th align="center" colspan="3">Contiene riferimenti</th>
						</tr>
						<tr>
							<td  align="center" colspan="3">Autorità
								  <select name="autoritaRiferimento"   class="low" >
									    <option></option>
									    <option value="regione.campania">Regione Campania</option>
									    <option value="stato">Stato</option>
									</select>
							</td>
						</tr>	
						<tr>
							<td  align="right"  colspan="2">Tipo 
								  <select name="tipoRiferimento"   class="low" >
									    <option></option>
									    <option value="legge">Legge</option>
									    <option value="statuto">Statuto</option>
									    <option value="decreto.legge">Decreto Legge</option>
									    <option value="decreto.legislativo">Decreto Legislativo</option>
									    <option value="decreto.presidente.consiglio.ministri">Decreto presidente consiglio ministri</option>
									    <!--option value="costituzione">Costituzione</option-->
									</select></td>
								<td align="right" >Numero <input type="text" name="numeroRiferimento" style="width:50px;"/></td>
						</tr>	
						<tr>
							<td  align="right" >Giorno 
								  <input type="text" name="giornoRiferimento"  style="width:50px;"/></td>
								<td  align="center">Mese <input type="text" name="meseRiferimento"  style="width:50px;"/></td>
								<td  align="right" >Anno <input type="text" name="annoRiferimento"   style="width:50px;"/>
								</td>
						</tr>	
					
				</table><br/>
					<table witdh="700px">
						<tr>
							<td align="right"  width="300px"><input id="trova" type="submit" value="Trova"/></td><td  width="200px" align="right"><input type="button" id="azzera"  value="Azzera" onclick="javascript:location.href='./index.xql?panel=search'"/></td>
						</tr>
						
					</table>
					</form>
				</div>
				

	        </div>
	</div>
};

declare function search:displayRif($res as node(),$urnRif as xs:string,$url as xs:string) as element()*{
	for $ref in $res//nir:rif[matches(@xlink:href, $urnRif)]
		return 
		if (empty($ref/ancestor::nir:comma/@id)) then () else
		<li><a target="_new" href="xhtml?doc={$url}&amp;datafine={date:normalize-date(current-dateTime())}#{$ref/ancestor::nir:comma/@id}">{$ref/ancestor::nir:comma/@id cast as xs:string}</a></li>
			
};

declare function search:displayComma($res as node(),$testo as xs:string,$url as xs:string) as element()*{
	for $comma in $res//nir:comma 
		where $comma &= $testo
		return <li><a target="_new" href="xhtml?doc={$url}&amp;datafine={date:normalize-date(current-dateTime())}#{$comma/@id}">{if (empty($comma/@id)) then () else $comma/@id cast as xs:string}</a></li>
			
};

declare function search:displayArticolo($res as node(),$testo as xs:string,$url as xs:string) as element()*{
	for $articolo in $res//nir:articolo
		where $articolo &= $testo
		return <li><a target="_new" href="xhtml?doc={$url}&amp;datafine={date:normalize-date(current-dateTime())}#{$articolo/@id}">{if (empty($articolo/@id)) then () else $articolo/@id cast as xs:string}</a></li>
			
};



declare function search:makeResName($res as node(),$url as xs:string) as element()*{

	let $tipoDoc := if ($res//iit:tipoDoc[1]/@valore) then $res//iit:tipoDoc[1]/@valore cast as xs:string else () 
	let $emanante := if ($res//nir:intestazione/nir:emanante[1]/text()) then concat(" - ",$res//nir:intestazione/nir:emanante[1] cast as xs:string) else ()
	let $dataDoc := if ($res//nir:intestazione/nir:dataDoc[1]/text()) then concat(" - ",$res//nir:intestazione/nir:dataDoc[1] cast as xs:string) else ()
	let $numDoc := if ($res//nir:intestazione/nir:numDoc[1]/text()) then concat(" - N°",$res//nir:intestazione/nir:numDoc[1] cast as xs:string) else ()
	let $id := util:random()
	let $titoloDoc := if ($res/nir:NIR/*/nir:intestazione/nir:titoloDoc[1]/text()) then concat(" - ",$res/nir:NIR/*/nir:intestazione/nir:titoloDoc[1] cast as xs:string) else ()
		return <span>
					<a target='_new' href='xhtml?doc={$url}&amp;datafine={date:normalize-date(current-dateTime())}'>{concat($tipoDoc, $emanante, $dataDoc, $numDoc,$titoloDoc)}</a>
					{if (empty($res//nir:ciclodivita/nir:relazioni/nir:passiva/@xlink:href)) then () else
						(
						<a href='#' style="color:grey; margin-left: 15px; font-size:8pt" onclick="javascript:ReverseContentDisplay('{$id}');">[modifiche]</a>,
						<ul id="{$id}" style="display:none; border-color:grey; border-style: 1px solid; margin-left: 15px; z-index: -1; font-size:8pt">
							{for $passive in $res//nir:ciclodivita/nir:relazioni/nir:passiva/@xlink:href
								return <li>{$passive cast as xs:string}</li>
							
							}
							</ul>
						)
					}
				</span>
			
};

declare function search:search() as element()* {

	let $testo := request:get-parameter("testo", "")  
	let $titolo := request:get-parameter("titolo", "")  
	
	let $comma:= request:get-parameter("comma", "")  
	let $fonte:= request:get-parameter("fonte", "")  
	let $tipo := request:get-parameter("tipo", "")  
	let $materia:= request:get-parameter("materia", "")  
	
	let $autoritaModifica:= request:get-parameter("autoritaModifica", "") 
	let $tipoModifica:= request:get-parameter("tipoModifica", "") 
	let $giornoModifica:= request:get-parameter("giornoModifica", "") 
	let $meseModifica:= request:get-parameter("meseModifica", "") 
	let $annoModifica:= request:get-parameter("annoModifica", "") 
	let $numeroModifica:= request:get-parameter("numeroModifica", "") 

	let $autoritaModifica := if ($autoritaModifica eq "") then "[a-z|.]*" else $autoritaModifica
	let $tipoModifica := if ($tipoModifica eq "") then "[a-z|.]*" else $tipoModifica
	let $giornoModifica := if ($giornoModifica eq "") then "[0-9]{2}" else $giornoModifica
	let $meseModifica := if ($meseModifica eq "") then "[0-9]{2}" else $meseModifica
	let $annoModifica := if ($annoModifica eq "") then "[0-9]{4}" else $annoModifica
	let $numeroModifica := if ($numeroModifica eq "") then "" else $numeroModifica

	
	let $autoritaRiferimento:= request:get-parameter("autoritaRiferimento", "") 
	let $tipoRiferimento:= request:get-parameter("tipoRiferimento", "") 
	let $giornoRiferimento:= request:get-parameter("giornoRiferimento", "") 
	let $meseRiferimento:= request:get-parameter("meseRiferimento", "") 
	let $annoRiferimento:= request:get-parameter("annoRiferimento", "") 
	let $numeroRiferimento:= request:get-parameter("numeroRiferimento", "") 

	let $autoritaRiferimento := if ($autoritaRiferimento eq "") then "[a-z|.]*" else $autoritaRiferimento
	let $tipoRiferimento := if ($tipoRiferimento eq "") then "[a-z|.]*" else $tipoRiferimento
	let $giornoRiferimento := if ($giornoRiferimento eq "") then "[0-9]{2}" else $giornoRiferimento
	let $meseRiferimento := if ($meseRiferimento eq "") then "[0-9]{2}" else $meseRiferimento
	let $annoRiferimento := if ($annoRiferimento eq "") then "[0-9]{4}" else $annoRiferimento
	let $numeroRiferimento := if ($numeroRiferimento eq "") then "" else $numeroRiferimento

	
	let $giornoDoc := request:get-parameter("giornoDoc", "")  
	let $meseDoc := request:get-parameter("meseDoc", "")  
	let $annoDoc := request:get-parameter("annoDoc", "")  
	let $annoFonte := request:get-parameter("annoFonte", "")  
	let $num := request:get-parameter("num", "")  
	let $emanante := request:get-parameter("emanante", "")  
	let $tipoDisposizione := request:get-parameter("tipoDisposizione", "")  
	let $combinazione:= request:get-parameter("combinazione", "almeno") 

	let $combinazione:= if ($combinazione eq "") then "almeno" else $combinazione 

	let $giornoDoc := if ($giornoDoc eq "") then "??" else $giornoDoc
	let $meseDoc := if ($meseDoc eq "") then "??" else $meseDoc
	let $annoDoc := if ($annoDoc eq "") then "????" else $annoDoc
	let $dataDoc := concat($annoDoc,$meseDoc,$giornoDoc)

	(: |= almeno una parola  &= tutte le parole   = frase esatta   :)
	let $opApertura := if ($combinazione eq "almeno") then "[. |=" else 
					  if ($combinazione eq "tutte") then "[. &amp;=" else 
					  if ($combinazione eq "esatta") then "[near(. , " else ""

	let $opChiusura := if ($combinazione eq "esatta") then ",1)]" else "]"

	let $colName := "/db/nir/RegioneCampania"
	let $query1 := "
			declare namespace search='http://xmlgroup.iit.cnr.it/nir/search';
			declare namespace util='http://exist-db.org/xquery/util';
			declare namespace xdb='http://exist-db.org/xquery/xmldb';
			declare namespace nir='http://www.normeinrete.it/nir/2.2/';
			declare namespace iit='http://www.iit.cnr.it/nir/meta/proprietario/1.0';
			declare namespace dsp='http://www.normeinrete.it/nir/disposizioni/2.2/';
			declare namespace xlink='http://www.w3.org/1999/xlink';
			
			for $res in collection($colName)
				let $name := substring-before(util:document-name($res),'.xml')
				let $url := concat(xdb:encode-uri(util:collection-name($res)),'/',xdb:encode-uri(util:document-name($res)))
				where $res//nir:pubblicazione/starts-with(@norm,$annoFonte)"
				
		
	
	let $query2 := if ($tipo eq "") then "" else " and $res//iit:tipoDoc/@valore=$tipo"
	let $query3 := if ($combinazione ne "articolo" or $testo eq "") then "" else " and $res//nir:articolo[. &amp;= $testo]" 
	let $query4 := if ($dataDoc eq "????????") then "" else " and $res//nir:intestazione/nir:dataDoc/@norm &amp;= $dataDoc"
	let $query5 := if ($num eq "") then "" else " and $res//nir:intestazione/nir:numDoc=$num"
	let $query6 := if ($emanante eq "") then "" else " and $res//nir:intestazione/contains(nir:emanante,$emanante)"
	let $query7 := if ($combinazione eq "comma" or $combinazione eq "articolo" or $testo eq "") then "" else concat(" and $res//*", $opApertura," $testo",$opChiusura)
	let $query8 := if ($titolo eq "") then "" else " and $res//nir:intestazione/contains(nir:titoloDoc[1], $titolo)"
	let $query9 := if ($combinazione ne "comma" or $testo eq "") then "" else " and $res//nir:comma[. &amp;= $testo]"
	
	let $urnRif := concat("urn:nir:",$autoritaRiferimento,":",$tipoRiferimento,":",$annoRiferimento,"(;|-",$meseRiferimento,"-",$giornoRiferimento,";)",$numeroRiferimento)  
	let $query10 := if ($urnRif eq "urn:nir:[a-z|.]*:[a-z|.]*:[0-9]{4}(;|-[0-9]{2}-[0-9]{2};)") then "" else " and $res//nir:rif/matches(@xlink:href, $urnRif )" 
	
	let $urnRelazione := concat("urn:nir:",$autoritaModifica,":",$tipoModifica,":",$annoModifica,"(;|-",$meseModifica,"-",$giornoModifica,";)",$numeroModifica)
	let $query11 :=  if ($urnRelazione eq "urn:nir:[a-z|.]*:[a-z|.]*:[0-9]{4}(;|-[0-9]{2}-[0-9]{2};)") then "" else " and $res//nir:ciclodivita/nir:relazioni/nir:passiva/matches(@xlink:href, $urnRelazione)"
	
	let $query12 := if ($materia eq "" ) then "" else " and $res//iit:materia/@valore=$materia"

	let $query13 := if ($fonte eq "" ) then "" else " and $res//nir:descrittori/nir:pubblicazione/@tipo=$fonte"
	
	let $query14 := "
				return
				<li > 
					<a target='_new' href='xml?doc={$url}'><img src='img/xml.png' /></a>
					<a target='_new' href='pdf?doc={$url}'><img src='img/pdf.png'/></a>
					{search:makeResName($res,$url)}
				

					{if ($combinazione ne 'articolo' or $testo eq '') then () else
						<ul>
							{search:displayArticolo($res,$testo,$url)}
							<span/>
						</ul>
					}
					
					{if ($combinazione ne 'comma' or $testo eq '') then () else
						<ul>
							{search:displayComma($res,$testo,$url)}
							<span/>
						</ul>
					}

					{if ($urnRif eq 'urn:nir:[a-z|.]*:[a-z|.]*:[0-9]{4}(;|-[0-9]{2}-[0-9]{2};)') then () else
						<ul>
							{search:displayRif($res,$urnRif,$url)}
							<span/>
						</ul>
					}
				</li>"

	let $query := 	concat($query1,$query2,$query3,$query4,$query5,$query6,$query7,$query8,$query9,$query10,$query11,$query12,$query13,$query14)
				
				return 
				<div > 
					<table width="470px" >
						<tr>
							<td class="trovati">
								Trovati {count(util:eval($query))} documenti	
								<!--<a href="#" onclick="javascript:ReverseContentDisplay('debug');javascript:ReverseContentDisplay('formRicerca')">[mostra/nascondi] XQuery</a>
								<pre id="debug" style="display:none;border-style: solid; padding: 5px; z-index: -1; font-size:8pt">{$query}</pre>-->
							</td>
							<td class="nuovaRicerca" >
								<a href="?panel=search">Imposta una Nuova Ricerca</a>
							</td>
						</tr>
						</table>
					<br/><!--strong>{$urnRif}</strong--><br/>
					<div  class="risultatiRicerca">
						{util:eval($query)}
					</div>
				
				</div>
};

