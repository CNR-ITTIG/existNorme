xquery version "1.0" encoding "iso-8859-15";



declare namespace urnIndex = "http://xmlgroup.iit.cnr.it/nir/urnIndex";
declare namespace admin = "http://xmlgroup.iit.cnr.it/nir";
declare namespace xlink='http://www.w3.org/1999/xlink';
declare namespace request = "http://exist-db.org/xquery/request";
declare namespace session = "http://exist-db.org/xquery/session";
declare namespace util = "http://exist-db.org/xquery/util";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
declare namespace nir='http://www.normeinrete.it/nir/2.2/';

			
declare function urnIndex:urnList() as element() {
	let $colName := "/db/nir/normeCnipa"
	return 
	<urnIndex>
		{urnIndex:urnQuery()}	
	
	</urnIndex>
};

declare function urnIndex:urnQuery() as element()* {
	let $colName := "/db/nir/normeCnipa"
				for $res in collection($colName)
				return <list>{concat(xdb:encode-uri(util:collection-name($res)),'/',xdb:encode-uri(util:document-name($res)))}
					{
						for $urn in $res//nir:descrittori/nir:urn/@valore
						return <urn>{$urn cast as xs:string}</urn>
					}
					</list>	
				
};


let $query := request:get-parameter("query", "")  
	return
	 urnIndex:urnList()
		