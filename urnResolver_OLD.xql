xquery version "1.0" encoding "iso-8859-15";

declare namespace admin = "http://xmlgroup.iit.cnr.it/nir";
declare namespace xlink='http://www.w3.org/1999/xlink';
declare namespace request = "http://exist-db.org/xquery/request";
declare namespace session = "http://exist-db.org/xquery/session";
declare namespace util = "http://exist-db.org/xquery/util";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
declare namespace nir='http://www.normeinrete.it/nir/2.2/';
declare namespace response='http://exist-db.org/xquery/response';

			
declare function local:getDoc($urn as xs:string) as xs:string* {
	let $colName := "/db/nir/RegioneCampania"
				for $res in collection($colName)
				return 
					if ($res//nir:descrittori/nir:urn/contains(@valore,$urn)) then
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

let $urn := request:get-parameter("urn", "")  
let $datafine := request:get-parameter("datafine", "")  
	return
	<root>
	{
	if (local:getDoc($urn)) then
		response:redirect-to(xs:anyURI(concat("xhtml?doc=",local:getDoc($urn),"&amp;datafine=",$data)))		
		else
		response:redirect-to(xs:anyURI(concat("http://www.nir.it/cgi-bin/N2Ln?",$urn)))		
	}
	 </root>
		