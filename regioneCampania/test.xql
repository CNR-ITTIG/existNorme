xquery version "1.0" encoding "iso-8859-15";

declare namespace admin = "http://xmlgroup.iit.cnr.it/nir";
declare namespace xlink='http://www.w3.org/1999/xlink';
declare namespace request = "http://exist-db.org/xquery/request";
declare namespace session = "http://exist-db.org/xquery/session";
declare namespace util = "http://exist-db.org/xquery/util";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
declare namespace nir='http://www.normeinrete.it/nir/2.2/';

			
	<html>
		<body>
			<ul>
				{
				let $colName := "/db/nir/RegioneCampania"
				for $res in collection($colName)
				where $res//nir:rif/contains(@xlink:href, "urn:nir:stato:decreto.legislativo:1993-02-12;39" )
				return <li>{distinct-values($res//nir:descrittori/nir:urn/@valore)}</li>
				
				}
			</ul>

<ul>
				{

			let $colName := "/db/nir/RegioneCampania"
				for $emanante in distinct-values(collection($colName)//nir:descrittori/nir:urn/@valore)
					order by $emanante 

					return <li>****{$emanante}****</li>

					}
			</ul>

	<ul>
				{
				let $colName := "/db/nir/RegioneCampania"
				
				for $link in distinct-values(collection($colName)//nir:rif/@xlink:href)
						order by $link 

					return <li>####{$link}####</li>

					}
		
			</ul>	

		<ul>
				{
				let $colName := "/db/nir/RegioneCampania"
				
				for $link in distinct-values(collection($colName)//nir:ciclodivita/nir:relazioni/nir:passiva/@xlink:href)
						order by $link 

					return <li>$$$$${$link}$$$$</li>

					}
		
			</ul>	
	

		</body>
	</html>
	