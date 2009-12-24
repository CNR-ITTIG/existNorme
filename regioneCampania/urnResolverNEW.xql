xquery version "1.0" encoding "iso-8859-15";

declare namespace admin = "http://xmlgroup.iit.cnr.it/nir";
declare namespace xlink='http://www.w3.org/1999/xlink';
declare namespace request = "http://exist-db.org/xquery/request";
declare namespace session = "http://exist-db.org/xquery/session";
declare namespace util = "http://exist-db.org/xquery/util";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
declare namespace nir='http://www.normeinrete.it/nir/2.2/';
declare namespace response='http://exist-db.org/xquery/response';


declare function local:getUrn2($urn as xs:string) as xs:string* {

	let $urnPrima := substring-before($urn , ";")
	let $urnDopo := substring-after($urn , ";")

	let $urnPrima2 := substring-before($urnDopo , ";")
	let $urnDopo2 := substring-after($urnDopo , ";")

	let $urnPrima3 := substring-before($urnDopo2 , ";")
	let $urnDopo3 := substring-after($urnDopo2 , ";")
	
	return 
	if (matches($urnDopo3,'')) then (
		if (matches($urnDopo2,'')) then (
			concat($urnPrima, "(.)*;", $urnDopo)			
		)
		else (
			concat($urnPrima,";",$urnPrima2, "(.)*;", $urnDopo2)
		)
	)
	else (
		concat($urnPrima,";",$urnPrima2,";",$urnPrima3, "(.)*;", $urnDopo3)
	)
				
};
			
declare function local:getDoc($urn as xs:string) as xs:string* {


	let $urnMatches := local:getUrn2($urn)
	let $colName := "/db/nir/RegioneCampania"
				for $res in collection($colName)
				return 
(:					if ($res//nir:ciclodivita/nir:relazioni/nir:originale[matches(@xlink:href, $urnMatches)]) then		:)
					if ($res//nir:descrittori/nir:urn[matches(@valore, $urnMatches)]) then
						concat(xdb:encode-uri(util:collection-name($res)),'/',xdb:encode-uri(util:document-name($res)))
						else
						()
				
};

let $dataoggi := string(current-date())
let $anno := substring-before($dataoggi, "-")
let $mesecc := substring-after($dataoggi, "-")
let $mese := substring-before($mesecc, "-")
let $giornoecc := substring-after($mesecc, "-")
let $giorno := substring-before($giornoecc, "+")
let $data := concat($anno,$mese,$giorno)

let $css := request:get-parameter("css", "")  
let $urn := request:get-parameter("urn", "")  
let $datafine := request:get-parameter("datafine", "")  

let $ee_sett := "3"
let $ee_anno := text:filter($urn,"[0-9]{4}")[1]
let $ee_temp := concat("0000",substring-after($urn, ";"))
let $ee_nume := substring($ee_temp,string-length($ee_temp)-3,4)

      
	return
	<root>
	{
	if (substring-after($urn, "urn:nir:comunita.europee")!="") then (
		if (matches($urn,":direttiva")) then
			response:redirect-to(xs:anyURI(concat("http://eur-lex.europa.eu/Result.do?code=" , $ee_sett , $ee_anno , "L" , $ee_nume , "&amp;Submit=Cercare&amp;RechType=RECH_celex&amp;_submit=Cercare","&amp;ihmlang=it")
))
		else
			response:redirect-to(xs:anyURI(concat("http://eur-lex.europa.eu/Result.do?code=" , $ee_sett , $ee_anno , "R" , $ee_nume , "&amp;Submit=Cercare&amp;RechType=RECH_celex&amp;_submit=Cercare","&amp;ihmlang=it")
))

	) else if (local:getDoc($urn)[1]) then
		response:redirect-to(xs:anyURI(concat("xhtml?doc=",local:getDoc($urn)[1],"&amp;css=",$css,"&amp;datafine=",$data)))		
		else
		response:redirect-to(xs:anyURI(concat("http://www.nir.it/cgi-bin/N2Ln?",$urn)))		
	}
	 </root>
