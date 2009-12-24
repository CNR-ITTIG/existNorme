xquery version "1.0" encoding "iso-8859-15";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace fn="http://www.w3.org/2003/05/xpath-functions";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace system="http://exist-db.org/xquery/system";

declare function local:createUser($userName as xs:string, $password as xs:string) as empty() {

	let $tmp := if (xmldb:exists-user($userName)) then "" else xmldb:create-user($userName, $password, "cnr", concat($userName,"_home"))
	return ()
};

declare function local:createCollection($base as xs:string, $colName as xs:string) as empty() {
	let $tmp := if (xmldb:collection-exists(concat($base,$colName))) then "ok" else xmldb:create-collection($base,$colName)
	return ()
};

let $tmp := session:set-current-user("admin", "")

let $tmp:= local:createUser("maurizio", "tesconi")
let $tmp:= local:createUser("andrea", "marchetti")
let $tmp:= local:createUser("caterina", "lupo")
let $tmp:= local:createUser("pierluigi", "spinosa")

let $tmp := session:set-current-user("pierluigi", "spinosa")

let $tmp := local:createCollection("//db/", "cnr")
let $tmp := xmldb:chmod-collection("/db/cnr", 508)

let $tmp := local:createCollection("//db/cnr", "history")
let $tmp := xmldb:chmod-collection("/db/cnr/history", 508)

let $tmp := local:createCollection("//db/cnr", "norme")
let $tmp := xmldb:chmod-collection("/db/cnr/norme", 508)


let $modulePath := system:get-module-load-path()

let $tmp:= xmldb:store-files-from-pattern("/db/cnr/norme", concat($modulePath, "/repository/cnr"), "**/*.xml", "text/xml", true()) 


	return  <init>{$tmp}</init>

		
