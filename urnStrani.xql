xquery version "1.0" encoding "iso-8859-15";
(: Developed by Maurizio Tesconi - Istituto di Informatica e Telematica - CNR - maurizio.tesconi@iit.cnr.it :)

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace nir="http://www.normeinrete.it/nir/2.2/";


<ul>
{
	let $colName := "/db/nir/normeCnipa"
	
	for $res in collection($colName)
	
		 where $res//nir:urn[contains(@valore,"/")] 
			return
			<li>
				{$res/nir:NIR/*/nir:intestazione/nir:titoloDoc[1]/text()} 
				<ul>
					{
					for $urn in $res//nir:urn
						return <li><strong>URN:</strong> {$urn/@valore cast as xs:string}</li>
					}
				</ul>
			</li>
}
</ul>	


