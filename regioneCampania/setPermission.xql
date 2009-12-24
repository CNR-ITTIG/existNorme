xquery version "1.0" encoding "iso-8859-15";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace fn="http://www.w3.org/2003/05/xpath-functions";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace system="http://exist-db.org/xquery/system";

(: imposta permessi alle collezioni :)

let $colName := "/db/nir/RegioneCampania"
	for $child at $pos in xmldb:get-child-collections($colName)
		return
			 xmldb:chmod-collection(concat($colName,"/",$child), 508)

(: imposta permessi alle risorse 

	for $resName at $pos in xmldb:get-child-resources(concat($colName,"/",$child))
		return
			xmldb:chmod-resource(concat($colName,"/",$child), $resName, 508)
:)
