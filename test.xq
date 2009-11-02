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

			
<root xmlns="http://www.normeinrete.it/nir/2.2/">
				{
				for $doc in collection("/db/nir/normeCnipa")
					let $urns := $doc/nir:NIR/*/nir:meta/nir:descrittori/nir:urn/@valore
					let $urn1 := $urns[1] cast as xs:string
					let $anno := local:annoDoc($urn1[1])
					order by name($doc/nir:NIR/*)
						return <doc testTipoDoc="{if (local:tipoDoc(name($doc/nir:NIR/*)) eq $doc//iit:tipoDoc/@valore) then 'ok' else 'no'}" anno="{$anno}" urn="{$urn1}">
									{
									for $urn in $doc/nir:NIR/*/nir:meta/nir:descrittori/nir:urn
										return $urn
									}
								</doc>
						
				}
</root>
	