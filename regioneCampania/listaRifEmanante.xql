
declare namespace search='http://xmlgroup.iit.cnr.it/nir/search';
			declare namespace util='http://exist-db.org/xquery/util';
			declare namespace xdb='http://exist-db.org/xquery/xmldb';
			declare namespace nir='http://www.normeinrete.it/nir/2.2/';
			declare namespace iit='http://www.iit.cnr.it/nir/meta/proprietario/1.0';
			declare namespace dsp='http://www.normeinrete.it/nir/disposizioni/2.2/';
			declare namespace xlink='http://www.w3.org/1999/xlink';


declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=yes";

let $tipo := request:get-parameter("tipo", "") 
			
let $colName := "/db/nir/"
let $rifsEmanante :=
	<root xmlns="http://www.normeinrete.it/nir/2.2/" xmlns:xlink="http://www.w3.org/1999/xlink">
	{
			for $rif in collection($colName)//nir:rif[matches(@xlink:href,concat("urn:nir:[a-z\.]*:",$tipo,":[0-9]{4}(;|-[0-9]{2}-[0-9]{2})"))]
			 let $tmp:= substring-after($rif/@xlink:href,"urn:nir:")
			 let $tmp:= substring-before($tmp,":")
				return <rif val="{$tmp}"/>
	}
	</root>

return
	<select name="autoritaRiferimento" class="low">
	{
	for $rif in distinct-values($rifsEmanante//nir:rif/@val)
		return 
			<option value="{$rif}">{fn:translate($rif,"."," ")}</option>
		
	}
	</select>