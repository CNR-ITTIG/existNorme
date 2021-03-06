xquery version "1.0" encoding "iso-8859-15";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace fn="http://www.w3.org/2003/05/xpath-functions";
declare namespace util="http://exist-db.org/xquery/util";


declare function local:createUser($userName as xs:string, $password as xs:string) as empty() {

	let $tmp := if (xmldb:exists-user($userName)) then "" else xmldb:create-user($userName, $password, "nir", concat($userName,"_home"))
	return ()
};

declare function local:createCollection($base as xs:string, $colName as xs:string) as empty() {
	let $tmp := if (xmldb:collection-exists(concat($base,$colName))) then "ok" else xmldb:create-collection($base,$colName)
	return ()
};

let $tmp := session:set-current-user("admin", "")

let $tmp := session:set-current-user("maurizio", "tesconi")

let $tmp := local:createCollection("//db/nir", "cms")
let $tmp:= xmldb:store-files-from-pattern("/db/nir", "webapps/cocoon/cmsnir/repository", "**/*.xml", "text/xml", true()) 

	return  <init>{$tmp}</init>

		
