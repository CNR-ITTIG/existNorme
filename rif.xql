declare namespace search='http://xmlgroup.iit.cnr.it/nir/search';
			declare namespace util='http://exist-db.org/xquery/util';
			declare namespace xdb='http://exist-db.org/xquery/xmldb';
			declare namespace nir='http://www.normeinrete.it/nir/2.2/';
			declare namespace iit='http://www.iit.cnr.it/nir/meta/proprietario/1.0';
			declare namespace dsp='http://www.normeinrete.it/nir/disposizioni/2.2/';
			declare namespace xlink='http://www.w3.org/1999/xlink';
                        
			let $colName := "/db/nir/RegioneCampania"
			let $name:= request:get-parameter("name", "")

			let $emanante:= request:get-parameter("emanante", "")
			let $tipo:= request:get-parameter("tipo", "")
			let $anno:= request:get-parameter("anno", "")
			let $mese:= request:get-parameter("mese", "")
			let $giorno:= request:get-parameter("giorno", "")

			let $urn := if ($emanante eq "") then "urn:nir:" else
						if ($tipo eq "") then	concat('urn:nir:',$emanante,':') else
						if ($anno eq "") then   concat('urn:nir:',$emanante,':',$tipo,":") else
						if ($mese eq "") then   concat('urn:nir:',$emanante,':',$tipo,":",$anno,"-") else 
						if ($giorno eq "") then concat('urn:nir:',$emanante,':',$tipo,":",$anno,"-",$mese,"-") else 
												concat('urn:nir:',$emanante,':',$tipo,":",$anno,"-",$mese,"-",$giorno,";")
						
			let $fine := if ($tipo eq "") then	 ":" else 
						 if ($mese eq "") then   "-" else ";"
			return
						if ($giorno eq "") then
							for $rif in distinct-values(collection($colName)//nir:rif/substring-before(substring-after(@xlink:href,$urn),$fine))
								order by $rif
								return <option value="{$rif}">{fn:replace($rif,'[.]',' ')}</option>
							else
							for $rif in distinct-values(collection($colName)//nir:rif/substring-after(@xlink:href,$urn))
								order by $rif
								return <option value="{$rif}">{fn:replace($rif,'[.]',' ')}</option>
							
