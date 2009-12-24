xquery version "1.0" encoding "iso-8859-15";
(: Developed by Maurizio Tesconi - Istituto di Informatica e Telematica - CNR - maurizio.tesconi@iit.cnr.it :)

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace nir="http://www.normeinrete.it/nir/2.2/";


<ul>
{
	let $colName := "/db/nir/normeCnipa"
	
	for $v in distinct-values(collection($colName)//nir:materia/@valore)
	
			return
			<li>
				{$v cast as xs:string} 
			</li>
}
</ul>	


