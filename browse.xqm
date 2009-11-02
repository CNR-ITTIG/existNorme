xquery version "1.0" encoding "iso-8859-15";
(: Developed by Maurizio Tesconi - Istituto di Informatica e Telematica - CNR - maurizio.tesconi@iit.cnr.it :)
(: $Id$ :)
(:
    Module: display and browse collections.
:)

module namespace browse="http://xmlgroup.iit.cnr.it/nir/browse";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace nir="http://www.normeinrete.it/nir/2.2/";
declare namespace text="http://exist-db.org/xquery/text";
declare namespace iit="http://www.iit.cnr.it/nir/meta/proprietario/1.0";
declare namespace dsp="http://www.normeinrete.it/nir/disposizioni/2.2/";
declare namespace xlink="http://www.w3.org/1999/xlink";

import module namespace date="http://exist-db.org/xquery/admin-interface/date" at "dates.xqm";

declare function local:createCollection($base as xs:string, $colName as xs:string) as empty() {
	let $tmp := if (xdb:collection-exists(concat($base,$colName))) then "ok" else xdb:create-collection($base,$colName)
	return ()
};


declare function local:stringa($node as node()*) as xs:string
{
	let $res := if ($node) then $node cast as xs:string else ""
	return  $res
};

declare function local:tipoDoc($primoElem as xs:string) as xs:string
{
	let $tipoDoc := if (starts-with($primoElem, "DecretoLegislativo")) then "decreto legislativo"
			else	if (starts-with($primoElem, "DecretoMinisteriale")) then "decreto"
			else	if (starts-with($primoElem, "Dpcm")) then "decreto del presidente del consiglio dei ministri"
			else	if (starts-with($primoElem, "Dpr")) then "decreto del presidente della repubblica"
			else	if (starts-with($primoElem, "Legge")) then "legge" else "not found"
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




(:
    Main function: outputs the page.
:)
declare function browse:main() as element()
{
    let $colName := request:get-parameter("collection", "/db/nir/normeCnipa") return
        <div class="panel">
			<div id="browse"><a href="index.xql?panel=clustering">Torna alla pagina principale</a></div>
			<div id="browsePanel">
	            { browse:process-action($colName) }
	            <div class="panel-head">Browsing: {xdb:decode-uri(xs:anyURI($colName))}</div>
	            <form method="POST" enctype="multipart/form-data">
	                {
	                    browse:display-collection($colName)
	                }
	                <table class="actions" cellspacing="0">
	                    <tr><td colspan="2"><input type="submit" name="action" value="Remove Selected"/></td></tr>
	                
	                    <tr>
	                        <td><input type="submit" name="action" value="Create Collection"/></td>
	                        <td>New collection:<br/><input type="text" name="create" size="40"/></td>
	                    </tr>
	                    
	                    <tr>
	                        <td><input type="submit" name="action" value="Upload"/></td>
	                        <td><input type="file" size="30" name="upload"/></td>
	                    </tr>
	                    <tr>
	                        <td>Comment</td>
	                        <td><textarea name="comment">...</textarea></td>
	                    </tr>

					</table>
	                
	                <input type="hidden" name="collection" value="{$colName}"/>
	                <input type="hidden" name="panel" value="browse"/>
	            </form>
			</div>
        </div>
};

(:
    Process an action.
:)
declare function browse:process-action($colName as xs:string) as element()*
{
    let $action := request:get-parameter("action", ()) return
        util:catch("java.lang.Exception",
            if($action eq "Remove Selected") then
            (
                browse:remove()
            )
            else if($action eq "Create Collection") then
            (
                browse:create-collection($colName)
            )
            else if($action eq "Store") then
            (
                browse:store($colName)
            )
            else if($action eq "Upload") then
            (
                browse:upload($colName)
            )else(),
            
            <div class="error">
                An error occurred while processing the action:<br/>
                {$util:exception-message}
            </div>
        )
};

(:
    Store uploaded content.
:)
declare function browse:upload($colName as xs:string) as element()
{
	(:
    let $docName := request:get-uploaded-file-name("upload")
	:)
	(: salvo il doc in un file temporaneo :)
	let $file := request:get-uploaded-file("upload")
	let $tmp := xdb:store($colName, "tmp.xml", $file)

	(: estraggo i metadati :)
	let $urns := doc($tmp)/nir:NIR/*/nir:meta/nir:descrittori/nir:urn/@valore
	let $urn  := $urns[1] cast as xs:string
	let $docName := translate($urn, " :;@", "__na")
	let $anno := local:annoDoc($urn)
	let $tipo := local:tipoDoc(name(doc($tmp)/nir:NIR/*))
	let $comment := request:get-parameter("comment", ())
	let $author:= xdb:get-current-user()
	let $date := date:format-dateTime(current-dateTime())

	(: gestione versioning :)
	let $PathDoc := concat($colName,"/",$docName)
	let $ver := if (doc($PathDoc)//iit:version/@valore) then doc($PathDoc)//iit:version/@valore + 1  else 1
	
	(: nel caso il documento esista già lo copio in history :)
	let $tmp := local:createCollection("/db/nir/history", $docName)
	let $verName := if (doc($PathDoc)//iit:version/@valore) then doc($PathDoc)//iit:version/@valore cast as xs:string  else ()
	let $tmp:= if (doc($PathDoc)) then xdb:copy($colName, concat("/db/nir/history/", $docName), $docName) else () 
	let $tmp:= if (doc($PathDoc)) then xdb:rename(concat("/db/nir/history/", $docName), $docName, $verName) else () 

	
    let $tmp := if (doc($PathDoc)) then xdb:remove($colName, $docName) else ()
    let $tmp := xdb:rename($colName, "tmp.xml",$docName)
	

	
	let $urns := doc($PathDoc)/nir:NIR/*/nir:meta/nir:descrittori/nir:urn/@valore
	let $urn  := $urns[1] cast as xs:string
	let $docName1 := translate($urn, " :;@", "__na")
	let $anno := local:annoDoc($urn)
	let $tipo := local:tipoDoc(name(doc($PathDoc)/nir:NIR/*))

	let $doc2 := xdb:store($colName, $docName1, $file)
	
	
	let $meta := 
			<proprietario xmlns="http://www.normeinrete.it/nir/2.2/"  soggetto="IIT" xlink:href="http://www.iit.cnr.it" xlink:type="simple">
				<iit:meta xmlns:iit="http://www.iit.cnr.it/nir/meta/proprietario/1.0">
					<iit:author  valore="{$author}"/>
					<iit:dateTime valore="{$date}"/>
					<iit:version valore="{$ver}"/>
					<iit:comment valore="{$comment}"/>
					<iit:annoDoc valore="{$anno}"/>
					<iit:tipoDoc valore="{$tipo}"/>
				</iit:meta>
			</proprietario>
	
	return
    
        <div class="process">
            <h3>Actions:</h3>
            <ul>
		                <li>Storing uploaded content to: {$PathDoc}</li>
			                { (: xdb:decode-uri(xs:anyURI(xdb:store($colName, xdb:encode-uri($urn), $file))), :)
			                    if (exists(doc($PathDoc)/nir:NIR/*/nir:meta/nir:proprietario)) then 
										update replace doc($PathDoc)/nir:NIR/*/nir:meta/nir:proprietario with $meta
									else
										update insert $meta into doc($PathDoc)/nir:NIR/*/nir:meta
			                }
							
            </ul>
    </div>
};

(:
    Store files from an URI.
    
    Allowing this opens a security whole as a user can
    upload arbitrary files on the server if the process is running
    as root.
:)
declare function browse:store($colName as xs:string) as element()
{
    let $uri := request:get-parameter("uri", ()),
    $path := if(starts-with($uri, "file:")) then $uri else concat("file:", $uri),
    $docName := request:get-parameter("name", ()) return
        
        <div class="process">
            <h3>Actions:</h3>
            <ul>
                <li>Storing resources from URI: {$path}</li>
                {
                    xdb:store($colName, $docName, xs:anyURI($path))
                }
            </ul>
        </div>
};

(:
    Remove a set of resources.
:)
declare function browse:remove() as element()
{
    let $resources := request:get-parameter("resource", ()) return
        
        <div class="process">
            <h3>Actions:</h3>
            <ul>
                {
                    for $resource in $resources
                    return
                        browse:remove-resource($resource)
                }
            </ul>
        </div>
};

(:
    Remove a resource.
:)
declare function browse:remove-resource($resource as xs:string) as element()* 
{
    let $isBinary := util:binary-doc-available($resource),
    $doc := if ($isBinary) then $resource else doc($resource) return
        
        if($doc)then
        (
            <li>Removing document: {xdb:decode-uri(xs:anyURI($resource))} ...</li>,
            xdb:remove(util:collection-name($doc), util:document-name($doc))
        )
        else
        (
            <li>Removing collection: {xdb:decode-uri(xs:anyURI($resource))} ...</li>,
            xdb:remove($resource)
        )
};

(:
    Create a collection.
:)
declare function browse:create-collection($parentColName as xs:string) as element()
{
    let $newcol := request:get-parameter("create", ()) return
        
        <div class="process">
            <h3>Actions:</h3>
            <ul>
            {
                if($newcol) then
                (
                    let $col := xdb:create-collection($parentColName, xdb:encode-uri($newcol)) return
                        <li>Created collection: {xdb:decode-uri(xs:anyURI(util:collection-name($col)))}.</li>
                )
                else
                (
                    <li>No name specified for new collection!</li>
                )
            }
            </ul>
        </div>
};

(:
    Display the contents of a collection in a table view.
:)
declare function browse:display-collection($colName as xs:string) as element()
{
 		<table summary="CMS NIR">
			<caption>CMS NIR</caption>
			<thead>
				<tr>
		            <th scope="col"/>
		            <th scope="col">Nome</th>
		            <th scope="col">Autore</th>
		            <th scope="col">Creazione</th>
		            <th scope="col">Modifica</th>
		            <th scope="col">Dim. (KB)</th>
		            <th scope="col">Ver.</th>
		            <th  scope="col" colspan="3">Formato</th>
		            <th scope="col">Commenti</th>
				</tr>
			</thead>	
			<tbody>
				<tr>
					<td/>
					<td><a href="?panel=browse&amp;collection={browse:get-parent-collection(xdb:encode-uri($colName))}">Up</a></td>
					<td/>
					<td/>
					<td/>
					<td/>
					<td/>
					<td/>
					<td/>
					<td/>
					<td/>
				</tr>
				{
					browse:display-child-collections($colName),
					browse:display-child-resources($colName)
				}
			</tbody>

    </table>
};

declare function browse:display-child-collections($colName as xs:string) as element()*
{
    for $child at $pos in xdb:get-child-collections($colName)
        let $path := concat($colName, '/', $child),
        $created := xdb:created($path)
    order by $child return
        <tr class="{if ($pos mod 2 eq 0) then 'odd' else ()}">
            <td><input type="checkbox" name="resource" value="{$path}"/></td>
            <td><a href="?panel=browse&amp;collection={xdb:encode-uri($path)}">{xdb:decode-uri(xs:anyURI($child))}</a></td>
			<!--td class="perm">{xdb:permissions-to-string(xdb:get-permissions($path))}</td>
            <td>{xdb:get-owner($path)}</td>
            <td>{xdb:get-group($path)}</td-->
			<td/>
            <td>{date:format-dateTime($created)}</td>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>

        </tr>
};

declare function browse:display-child-resources($colName as xs:string) as element()* 
{
    for $child in xdb:get-child-resources($colName) order by $child return
        <tr>
            <td><input type="checkbox" name="resource" value="{$colName}/{$child}"/></td>
            <td><a target="_new" href="AllXml?doc={xdb:encode-uri($colName)}/{xdb:encode-uri($child)}">{xdb:decode-uri(xs:anyURI($child))}</a></td>
            
            <td><a target="_new" href="meta?doc={xdb:encode-uri($colName)}/{xdb:encode-uri($child)}">
				{local:stringa(doc(concat($colName,"/",$child))//iit:author/@valore)}
				</a>
			</td>
			
            <!--td class="perm">{xdb:permissions-to-string(xdb:get-permissions($colName, $child))}</td>
            <td>{xdb:get-owner($colName, $child)}</td>
            <td>{xdb:get-group($colName, $child)}</td-->
			
            <td>{date:format-dateTime(xdb:created($colName, $child))}</td>
            <td>{date:format-dateTime(xdb:last-modified($colName, $child))}</td>
            <td>{fn:ceiling(xdb:size($colName, $child) div 1024)}</td>
            <td><!--a target="_new" href="history?doc={xdb:encode-uri($colName)}/{xdb:encode-uri($child)}">
				</a-->
				<a onclick="loadHistory('history?doc={xdb:encode-uri($colName)}/{xdb:encode-uri($child)}')" href="#">
						{local:stringa(doc(concat($colName,"/",$child))//iit:version/@valore)}
				</a>
				
			</td>
				
			<td><a target="_new" href="xhtml?doc={xdb:encode-uri($colName)}/{xdb:encode-uri($child)}"><img src="img/xhtml.png"/></a></td>
            <td><a target="_new" href="pdf?doc={xdb:encode-uri($colName)}/{xdb:encode-uri($child)}"><img src="img/pdf.png"/></a></td>
            <td><a target="_new" href="xml?doc={xdb:encode-uri($colName)}/{xdb:encode-uri($child)}"><img src="img/xml.png"/></a></td>
            <td>{local:stringa(doc(concat($colName,"/",$child))//iit:comment/@valore)}</td>
        </tr>
};

(:
    Get the name of the parent collection from a specified collection path.
:)
declare function browse:get-parent-collection($path as xs:string) as xs:string
{
    if($path eq "/db") then
        $path
    else
        replace($path, "/[^/]*$", "")
};