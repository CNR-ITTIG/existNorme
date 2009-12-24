xquery version "1.0" encoding "iso-8859-15";

declare namespace admin = "http://xmlgroup.iit.cnr.it/nir";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace nir="http://www.normeinrete.it/nir/2.2/";
declare namespace text="http://exist-db.org/xquery/text";
declare namespace iit="http://www.iit.cnr.it/nir/meta/proprietario/1.0";
declare namespace dsp="http://www.normeinrete.it/nir/disposizioni/2.2/";
declare namespace xlink="http://www.w3.org/1999/xlink";

declare function local:tr($meta as node(), $link as xs:string) as node()
{
	<tr>
		<td>
			<a href="xml?doc={$link}">{$meta/iit:version/@valore cast as xs:string}</a>
		</td>
		<td>{$meta/iit:dateTime /@valore cast as xs:string}</td>
		<td>{$meta/iit:author/@valore cast as xs:string}</td>
		<td>{$meta/iit:comment/@valore cast as xs:string}</td>
		<td><a target="_new" href="xhtml?doc={$link}"><img src="img/xhtml.png"/></a></td>
		<td><a target="_new" href="pdf?doc={$link}"><img src="img/pdf.png"/></a></td>
		<td><a target="_new" href="xml?doc={$link}"><img src="img/xml.png"/></a></td>

	</tr>
};

let $doc := request:get-parameter("doc", ())
let $historyPath := concat("/db/nir/history/urn",substring-after($doc,"/urn"))
	return
				<div id="modal">
					<div id="modalBar"><a onclick="hideModal()" href="#">Close</a></div>
					<table>
						<tr>
							<th>Versione</th>
							<th>Data</th>
							<th>Autore</th>
							<th>Commento</th>
				            <th colspan="3">Formato</th>

						</tr>
					{
					local:tr(doc($doc)//iit:meta,$doc)
					,
					for $doc in collection($historyPath)
						order by $doc//iit:meta/iit:version/@valore descending 
							return local:tr($doc//iit:meta,concat($historyPath,"/",$doc//iit:meta/iit:version/@valore))
					
					}
					</table>
				</div>
