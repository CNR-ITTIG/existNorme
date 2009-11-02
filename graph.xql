xquery version "1.0" encoding "iso-8859-15";



declare namespace graph = "http://xmlgroup.iit.cnr.it/nir/graph";
declare namespace admin = "http://xmlgroup.iit.cnr.it/nir";
declare namespace xlink='http://www.w3.org/1999/xlink';
declare namespace request = "http://exist-db.org/xquery/request";
declare namespace session = "http://exist-db.org/xquery/session";
declare namespace util = "http://exist-db.org/xquery/util";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
declare namespace nir='http://www.normeinrete.it/nir/2.2/';

			
declare function graph:inRef($query as xs:string, $urnParam as xs:string) as element() {
	let $colName := "/db/nir/normeCnipa"
	return 
	<graph>
	<centerVertex>{$urnParam cast as xs:string}</centerVertex>
	
		{graph:inRefQuery($urnParam cast as xs:string)}	
	
	</graph>
};

declare function graph:inRefQuery($urnParam as xs:string) as element()* {
		let $colName := "/db/nir/normeCnipa"
		for $res in collection($colName)
		for $urn in $res//nir:descrittori/nir:urn/@valore
		where $res//nir:rif/contains(@xlink:href,$urnParam )
			return  <vertex>{$urn cast as xs:string}</vertex>
			
				
};


declare function graph:outRef($query as xs:string, $urnParam as xs:string) as element() {
	let $colName := "/db/nir/normeCnipa"
	return 
	<graph>
	<centerVertex>{$urnParam cast as xs:string}</centerVertex>
	
		{graph:outRefQuery($urnParam cast as xs:string)}	
	
	</graph>
};

declare function graph:outRefQuery($urnParam as xs:string) as element()* {
		let $colName := "/db/nir/normeCnipa"
				for $res in collection($colName)
				for $urn in $res//nir:rif/@xlink:href
				where $res//nir:descrittori/nir:urn/contains(@valore,$urnParam )
						return <vertex>{$urn cast as xs:string}</vertex>
					
					
				
};


declare function graph:inMod($query as xs:string, $urnParam as xs:string) as element() {
	let $colName := "/db/nir/normeCnipa"
	return 
	<graph>
	<centerVertex>{$urnParam cast as xs:string}</centerVertex>
	
		{graph:inModQuery($urnParam cast as xs:string)}	
	
	</graph>
};

declare function graph:inModQuery($urnParam as xs:string) as element()* {
	let $colName := "/db/nir/normeCnipa"
		for $res in collection($colName)
		for $urn in $res//nir:ciclodivita/nir:relazioni/nir:passiva/@xlink:href
		where $res//nir:descrittori/nir:urn/contains(@valore,$urnParam )
				return <vertex>{$urn cast as xs:string}</vertex>
					
				
};


declare function graph:outMod($query as xs:string, $urnParam as xs:string) as element() {
	let $colName := "/db/nir/normeCnipa"
	return 
	<graph>
	<centerVertex>{$urnParam cast as xs:string}</centerVertex>
	
		{graph:outModQuery($urnParam cast as xs:string)}	
	
	</graph>
};

declare function graph:outModQuery($urnParam as xs:string) as element()* {
	let $colName := "/db/nir/normeCnipa"
		for $res in collection($colName)
		for $urn in $res//nir:descrittori/nir:urn/@valore
		where $res//nir:ciclodivita/nir:relazioni/nir:passiva/contains(@xlink:href,$urnParam )
				return <vertex>{$urn cast as xs:string}</vertex>
					
				
};


let $urn := request:get-parameter("urn", "") 

let $query := request:get-parameter("query", "")  
	return
		 if($query eq "outRef") then
		(
		    graph:outRef($query, $urn) 
		)
			else  if($query eq "inRef") then
		(
		    graph:inRef($query, $urn)
		) else  if($query eq "inMod") then
		(
		    graph:inMod($query, $urn)  
		) else (
		    graph:outMod($query, $urn) 
		) 
