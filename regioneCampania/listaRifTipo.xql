
declare namespace search='http://xmlgroup.iit.cnr.it/nir/search';
			declare namespace util='http://exist-db.org/xquery/util';
			declare namespace xdb='http://exist-db.org/xquery/xmldb';
			declare namespace nir='http://www.normeinrete.it/nir/2.2/';
			declare namespace iit='http://www.iit.cnr.it/nir/meta/proprietario/1.0';
			declare namespace dsp='http://www.normeinrete.it/nir/disposizioni/2.2/';
			declare namespace xlink='http://www.w3.org/1999/xlink';


declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=yes";

			
let $colName := "/db/nir/"
let $rifsTipo :=
	<root xmlns="http://www.normeinrete.it/nir/2.2/" xmlns:xlink="http://www.w3.org/1999/xlink">
	{
			for $rif in collection($colName)//nir:rif
			 let $tmp:= substring-after($rif/@xlink:href,"urn:nir:")
			 let $tmp:= substring-after($tmp,":")
			 let $tmp:= substring-before($tmp,":")
				return <rif val="{$tmp}"/>
	}
	</root>

(: doc(concat("http://localhost:777/cocoon/cmsnir/listaRifEmanante.xql?tipo=",$rif)) :)
return
	<select id="tipoRiferimento" name="tipoRiferimento" class="low">
	{
	for $rif in distinct-values($rifsTipo//nir:rif/@val) order by $rif
		return <option value="{$rif}">{fn:translate($rif,"."," ")}</option>
		
	}
	</select>