declare namespace search='http://xmlgroup.iit.cnr.it/nir/search';
			declare namespace util='http://exist-db.org/xquery/util';
			declare namespace xdb='http://exist-db.org/xquery/xmldb';
			declare namespace nir='http://www.normeinrete.it/nir/2.2/';
			declare namespace iit='http://www.iit.cnr.it/nir/meta/proprietario/1.0';
			declare namespace dsp='http://www.normeinrete.it/nir/disposizioni/2.2/';
			declare namespace xlink='http://www.w3.org/1999/xlink';
                        
			let $colName := "/db/nir/normeCnipa"

			return
			<html>
				<head>
					<script src="js/jquery-1.2.3.js" ><!-- * --></script>
					<script src="js/main.js" ><!-- * --></script>
					<link type="text/css" href="css/urn.css" rel="stylesheet"/>
				</head>
				<body>
					<div>
						TEST per generare dinamicamente gli URN dei riferimenti basandosi sugli elementi 'rif' dei documenti caricati dentro il sistema
					</div>
					<div id="urn">
						<div id="div_emanante"><span class="label">Emanante:</span>
							<select id="emanante" name="emanante">
								{
								for $rif in distinct-values(collection($colName)//nir:rif/substring-before(substring-after(@xlink:href,"urn:nir:"),":"))
										order by $rif
										return <option value="{$rif}">{fn:replace($rif,'[.]',' ')}</option>
								}
							</select>
						</div>
						<div id="div_tipo"><span class="label">Tipo:</span>
							<select id="tipo" name="tipo"><option/></select>
						</div>
						<div id="div_anno"><span class="label">Anno:</span>
							<select id="anno" name="anno"><option/></select>
						</div>
						<div id="div_mese"><span class="label">Mese:</span>
							<select id="mese" name="mese"><option/></select>
						</div>
						<div id="div_giorno"><span class="label">Giorno:</span>
							<select id="giorno" name="giorno"><option/></select>
						</div>
						<div id="div_numero"><span class="label">Numero:</span>
							<select id="numero" name="numero"><option/></select>
						</div>
					</div>
				</body>
			</html>