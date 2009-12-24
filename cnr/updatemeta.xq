xquery version "1.0" encoding "iso-8859-15";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare namespace fn="http://www.w3.org/2003/05/xpath-functions";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace nir="http://www.normeinrete.it/nir/2.2/";
declare namespace xlink="http://www.w3.org/1999/xlink";
declare namespace iit="http://www.iit.cnr.it/nir/meta/proprietario/1.0";

import module namespace date="http://exist-db.org/xquery/admin-interface/date" at "dates.xqm";

declare option exist:serialize "method=xml media-type=text/xml encoding=iso-8859-15";


declare function local:stringa($node as node()*) as xs:string
{
	let $res := if ($node) then $node cast as xs:string else ""
	return  $res
};

declare function local:tipoDoc($stipo as xs:string , $primoElem as xs:string) as xs:string
{

	let $tipoDoc := if (starts-with($primoElem, "DecretoLegislativo")) then "Decreto legislativo"
			else	if (starts-with($primoElem, "DecretoMinisteriale")) then "Decreto"
			else	if (starts-with($primoElem, "Dpcm")) then "Decreto del Presidente del Consiglio dei ministri"
			else	if (starts-with($primoElem, "Dpr")) then "Decreto del Presidente della Repubblica"
			else	if (starts-with($primoElem, "Legge")) then "Legge"
			else	if (starts-with($primoElem, "DocumentoNIR")) then $stipo else "not found"
			
	return  $tipoDoc
};

declare function local:annoDoc($urn as xs:string) as xs:string
{
	let $tmp := substring-after($urn,"urn:nir:")
	let $tmp := substring-after($tmp,":") 
	let $tmp := substring-after($tmp,":")
	let $anno := substring-before($tmp,"-")
	return  $anno
};


let $tmp := session:set-current-user("pierluigi", "spinosa")

let $colName := "/db/cnr"

	(:
	let $anno := local:annoDoc($urn)
	let $tipo := local:tipoDoc(name(doc($tmp)/nir:NIR/*))
	:)

	let $comment := "originale"
	let $author:= xdb:get-current-user()
	let $date := date:format-dateTime(current-dateTime())
	let $ver := "1"

	return  <root xmlns="http://www.normeinrete.it/nir/2.2/" xmlns:iit="http://www.iit.cnr.it/nir/meta/proprietario/1.0" xmlns:xlink="http://www.w3.org/1999/xlink">
	{
		for $res in collection($colName) 
			let $colName := util:collection-name($res)
			let $docName := util:document-name($res)
			let $PathDoc := concat($colName,"/",$docName)
			let $sottotipo := string(doc($PathDoc)/nir:NIR/nir:DocumentoNIR/@nome)
			let $tipo := local:tipoDoc($sottotipo , name(doc($PathDoc)/nir:NIR/*))
			let $urns := doc($PathDoc)/nir:NIR/*/nir:meta/nir:descrittori/nir:urn/@valore
			let $urn  := $urns[1] cast as xs:string
			let $anno := local:annoDoc($urn)
			let $newDocName := translate($urn, " :;@", "__na")
			let $materie := doc($PathDoc)/nir:NIR//iit:materia

			let $meta := 
					<proprietario soggetto="IIT" xlink:href="http://www.iit.cnr.it" xlink:type="simple">
						<iit:meta xmlns:iit="http://www.iit.cnr.it/nir/meta/proprietario/1.0">
							<iit:author  valore="{$author}"/>
							<iit:dateTime valore="{$date}"/>
							<iit:version valore="{$ver}"/>
							<iit:comment valore="{$comment}"/>
							<iit:annoDoc valore="{$anno}"/>
							<iit:tipoDoc valore="{$tipo}"/>
							{$materie}
						</iit:meta>
					</proprietario>

			

			return
			<res docName="{xdb:decode($docName)}" newDocName="{xdb:decode($newDocName)}" eq="{if (xdb:decode($docName) != xdb:decode($newDocName)) then 'no' else 'si'}">
				{
				(:
				let $tmp:= if (doc($PathDoc)/nir:NIR//iit:tipoDoc/@valore eq $tipo) then "OK" else "NO"
				return $meta
				:)
				(: update replace doc($PathDoc)//nir:proprietario[@soggetto="IIT"] with $meta :)
                if (exists(doc($PathDoc)/nir:NIR/*/nir:meta/nir:proprietario[@soggetto="IIT"])) then update replace doc($PathDoc)/nir:NIR/*/nir:meta/nir:proprietario[@soggetto="IIT"] with $meta 
									else
										update insert $meta into doc($PathDoc)/nir:NIR/*/nir:meta
				,
				if (xdb:decode($docName) != xdb:decode($newDocName)) then xdb:rename($colName, $docName, $newDocName) else ()
				,
				xdb:chmod-resource($colName, $newDocName, 508)
				}
				
			</res>
	}</root>

		
