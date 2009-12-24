declare namespace search='http://xmlgroup.iit.cnr.it/nir/search';
			declare namespace util='http://exist-db.org/xquery/util';
			declare namespace xdb='http://exist-db.org/xquery/xmldb';
			declare namespace nir='http://www.normeinrete.it/nir/2.2/';
			declare namespace iit='http://www.iit.cnr.it/nir/meta/proprietario/1.0';
			declare namespace dsp='http://www.normeinrete.it/nir/disposizioni/2.2/';
			declare namespace xlink='http://www.w3.org/1999/xlink';
                        
			declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=yes";

			let $colName := "/db/nir/RegioneCampania"
			return 
				<root>
				{
					for $rif in collection($colName)//nir:rif	(: [matches(@xlink:href,"urn:nir:[a-z|.]*:[a-z|.]*:1972(;|-[0-9]{2}-[0-9]{2};)")] :)
						order by $rif
						return <rif art="{$rif/ancestor::nir:articolo/@id}" comma="{$rif/ancestor::nir:comma/@id}" value="{$rif/@xlink:href}"/>
				}
				</root>
							
