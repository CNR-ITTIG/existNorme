<?xml version="1.0" encoding="UTF-8"?> 
<xsl:stylesheet version="1.0" xmlns:nir = "http://www.normeinrete.it/nir/2.2" 
										xmlns:xsl="http://www.w3.org/1999/XSL/Transform"   
										xmlns:h="http://www.w3.org/HTML/1998/html4" 
										xmlns:xlink="http://www.w3.org/1999/xlink">
										
	<xsl:output method="html"  indent="yes"/>
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template principale                                     -->
	<!--                                                          -->
	<!-- ======================================================== -->

	<xsl:param name="datafine"></xsl:param>
	<xsl:param name="doc"></xsl:param>
	<xsl:param name="xml"></xsl:param>
	<xsl:param name="encoding"/>
	<xsl:param name="baseurl"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select="/*[name()='NIR']/*/*/*[name()='tipoDoc']"/>&#160;
					n. &#160;<xsl:value-of select="/*[name()='NIR']/*/*/*[name()='numDoc']"/>	
					&#160; del &#160; <xsl:value-of select="/*[name()='NIR']/*/*/*[name()='dataDoc']"/>
				</title>
				<meta http-equiv="Content-Type" content="text/html; charset= {$encoding}"/>


				<!-- ======================================================== -->
				<!--                                                          -->
				<!--  Foglio di Stile interno                                 -->
				<!--                                                          -->
				<!-- ======================================================== -->				
				<style type="text/css">
body {
					margin-left: 5px;
					font-family: 'Arial, Helvetica, sans-serif, Times New Roman' ;
					font-size: 90% ;
					text-align:center;
				}

div#contenitore {

margin-left: auto;
margin-right: auto;
margin-top: 10px;
margin-bottom: 10px ;
width: 780px ;

}				
				hr {
					margin:30px 25% 30px 25%;
					text-align:center;
				}
				em {
					font-size: 100%
				}
				.small {
					font-size: 65% ;
				}
.intestazione {
	margin: 15px 0;
	text-align: center;
	font-size: large;
	font-style:italic;
	border: 2px solid #ccc;
	padding:10px 10px;
	background-color:#f9f9f9;
}
				.title {
					margin-top: 10px;
					text-align:center;
					font-size: 90% ;
					text-align: center;
				}
.titoloDoc {
	margin-top: 10px;
	text-align:center;
	font-size: 110% ;
	font-weight: bold;
	font-style:normal;
	color: #990000;
}	
	
				.formulainiziale {
					text-align: center;
					font-size: 100%;
					margin-bottom: 30px;
				}
				.preambolo {
					text-align: left;
					font-size: 100%;
				}
				.articolo { 
					font-size: 100% ; 
					margin-top: 15px; 
					text-align: center;
				}
.articolo {
padding-bottom: 10px;
border-bottom: 2px solid #ccc;
}				
				.titolo, .libro, .parte, .sezione { 
					font-size: 100% ; 
					font-weight: bold;
					text-align: center;
				}	
				.capo {
					padding-top: 10px;
					text-align: center;
				}
				p.rubrica {
					text-align: center;
					margin-top: 0;
					font-style: italic;
					font-weight: lighter;
					font-size: 100%;
				}
				p.decorazione {
					text-align: center;
					margin-top: 0;
					font-weight: lighter;
					font-size: 100%;
				}
				.comma { 
					font-size: 100% ; 
					font-weight: normal;
					margin-top: 5px;
					margin-bottom: 5px;
					text-align: justify;
					text-indent: 1em;
	padding: 3px;					
				}
				.el {
					font-size: 100% ; 
					font-weight: normal;
					text-align: justify;
					margin-left: 5px;
					text-indent: 2em;
					margin-top: 2px;
	padding: 3px;					
				}
.en , .ep {
	font-size: 100%;
	text-align: justify;
	margin-left: 65px;
	/*text-indent: -10px;*/
	margin-top: 2px;
	font-weight: normal;
	
}
			    b b { font-weight: normal; }
				
				a, a:visited {
					text-align: justify;
					text-decoration: none;
					color: blue;
				}
				a:hover {text-decoration: underline;}
				.nota {
					font-size:90%;
					text-align: justify;
					display: inline;
					float: left;
				}
				.formulafinale {
					text-align: justify;
				}
				.dataeluogo {
					margin-top:25px;
					font-style:italic;
					font-weight:bold;
				}
				li {
					padding-right: 40px;
					text-align: left;
				}
				.visto {
					font-size: 80%;
					font-style:italic;
				}
				.firma {
					font-size: 80%;
					font-weight: bold;
				}
				.hidden {
					width:0px;
					height:0px;
					max-width:0px
					max-height:0px
					display: inline;
					margin: 0 0 0 0;
					padding: 0 0 0 0;
				}
				p {
					text-align:justify;
				}
				.allineadx, p.allineadx {
					width: 100%;
					text-align: right;
					margin-bottom: 20px;
				}
				.allineasx {
					width: 100%;
					text-align: left;
					margin-bottom: 20px;
				}
				.virgolette {
					background: #FFEE99;
				}
				.mmod {
					background: #FFDD88;
				}
				.mod {
					background: #FFDDAA;
				}
				.omissis {
					font-weight: bold;
					text-align: left;
				}		
				.coda {
					text-align: justify;
				}
				.emanante {
font-style:normal;
font-weight:bold;
margin:10px;
}	
				.info {
font-size:90%;
font-style:normal;
font-weight:lighter;
margin-top:20px;
text-align:center;
				}	
				.urnvigente{text-align: center; margin-bottom:10px;}
				.vigore{ text-align: center; color: red; font-weight: bold; font-size: 120%; margin:20px;}
div#timeline {

margin: 5px auto;
padding: 20px 20px;
border: dashed 1px #999;

text-align: left;

}

div#indice {

margin: 5px auto;
padding: 20px 20px;
border: dashed 1px #999;

text-align: left;

}

div.itemindice {
margin: 25px;
}

#timeline ul {
display: inline;
}

ul#choosedata {
list-style-type: none;
padding:0px;
margin:0px;
}

li.choosedata
{
padding: 3px 3px;
background-color: #eeeeec;
color: #3465a4;
text-align: center;
border: solid 1px  #888a85;
text-decoration: none;
margin-top: 5px;
margin-right: 1px;
margin-bottom: 5px;
margin-left: 1px;
display: inline-block;

}

ul.choosedata-active {
list-style-type: none;

}

li.choosedata-active {
padding: 3px 3px;
background-color: #284F94;
color: #fff;
text-align: center;
border: solid 1px  #888a85;
text-decoration: none;
margin-top: 5px;
margin-right: 1px;
margin-bottom: 5px;
margin-left: 1px;
display: inline-block;
}

.choosedata a {
text-decoration: none;
}

.choosedata a:visited {
color: #284F94;
}

			
				</style>
				<!-- ======================================================== -->
				<!--                                                          -->
				<!--  fine Foglio di Stile                                    -->
				<!--                                                          -->
				<!-- ======================================================== --> 	
				
			</head>
			<body>
			<div id="contenitore">
			<p style="font-weight:bold;">
				<xsl:choose>
					<xsl:when test="$datafine!=''">
						<div class="vigore">
							<xsl:text>Atto in vigore al </xsl:text>
							<xsl:value-of select="concat(substring($datafine,7,2),'/',substring($datafine,5,2),'/',substring($datafine,1,4))"/>
						</div>
					</xsl:when>
				</xsl:choose>
			</p>
			<!-- xsl:choose>
				<xsl:when test="//*[name()='NIR']/@tipo!='originale'"	-->	
					<div id="timeline">
						<xsl:call-template name="TimeLine" />
					</div>
				<!-- /xsl:when>
			</xsl:choose -->
			<xsl:apply-templates select="/*[name()='NIR']/*" />
           	<div class="allineasx">
   	        	<xsl:call-template name="notemultivigente" /> 
       	    </div>

       	    <xsl:if test="/*/*/*[name()='meta']/*[name()='redazionale']/*[name()='nota']">
				<div class="allineasx">
					<br/><h2>Note della redazione</h2>
					<xsl:apply-templates select="/*/*/*[name()='meta']/*[name()='redazionale']/*[name()='nota']" />
				</div>	
			</xsl:if>		
			<xsl:if test="/*/*/*[name()='annessi']/*[name()='annesso']/*/*[name()='meta']/*[name()='redazionale']/*[name()='nota']">
				<div class="allineasx">
					<br/><h2>Note in allegati</h2>
					<xsl:apply-templates select="/*/*/*[name()='annessi']/*[name()='annesso']/*/*[name()='meta']/*[name()='redazionale']/*[name()='nota']" />
					
				</div>	
			</xsl:if>
			</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="*[name()='annesso']" mode="indice">
		<div>
		   <a href="#{@id}">
			<xsl:value-of select="*[name()='testata']/*[name()='denAnnesso']" />
		   </a>
		</div>
	</xsl:template>


	<xsl:template match="*[name()='libro' or name()='parte' or name()='titolo' or name()='capo' or name()='sezione' or name()='paragrafo' or name()='partizione' or name()='articolo']" mode="indice">
	  <xsl:choose>
	   <xsl:when test="$datafine!=''">
		<xsl:variable name="inizio_id">
			<xsl:value-of select="@iniziovigore"/>
		</xsl:variable>
		<xsl:variable name="fine_id">
			<xsl:value-of select="@finevigore"/>
		</xsl:variable>			
		<xsl:variable name="data_inizio">
			<xsl:value-of select="//*[name()='evento'][@id=$inizio_id]/@data"/>
			<!--	xsl:value-of select="id($inizio_id)/@data"/	-->
		</xsl:variable>
		<xsl:variable name="data_fine">
			<xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/>
			<!--	xsl:value-of select="id($fine_id)/@data"/	-->
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$data_fine!=''">
				<xsl:if test="$data_inizio&lt;number(number($datafine)+1) and $data_fine&gt;$datafine">
					<xsl:call-template name="stampaindice"/>
				</xsl:if>	
			</xsl:when>
			<xsl:when test="$data_inizio!=''">
				<xsl:if test="$data_inizio&lt;number(number($datafine)+1)">
					<xsl:call-template name="stampaindice"/>
				</xsl:if>	
			</xsl:when>			
			<xsl:otherwise>
					<xsl:call-template name="stampaindice"/>
			</xsl:otherwise>
		</xsl:choose>
	    </xsl:when>			
 	  <xsl:otherwise>
		<xsl:call-template name="stampaindice"/>
 	  </xsl:otherwise>
	 </xsl:choose>
	</xsl:template>

	<xsl:template name="stampaindice" >
		<div>
		   <a href="#{@id}">
			<xsl:value-of select="*[name()='num']/text()" />
			<xsl:if test="*[name()='rubrica']!=''">
				<xsl:if test="*[name()='num']!=''">
					<xsl:text> - </xsl:text>
				</xsl:if>
				<xsl:value-of select="*[name()='rubrica']" />
			</xsl:if> 
			<xsl:if test="*[name()='libro' or name()='parte' or name()='titolo' or name()='capo' or name()='sezione' or name()='paragrafo' or name()='partizione' or name()='articolo']">
					<div class="itemindice">
				  		<xsl:apply-templates select="*[name()='libro' or name()='parte' or name()='titolo' or name()='capo' or name()='sezione' or name()='paragrafo' or name()='partizione' or name()='articolo']" mode="indice"/>
					</div>
			</xsl:if>
   	
		   </a>
		</div>
	</xsl:template>


	<xsl:template match="/*[name()='NIR']/*">	
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div>
		<xsl:choose>
			<xsl:when test="$datafine!=''">		
				<xsl:variable name="fine_id">
					<xsl:value-of select="@finevigore"/>
				</xsl:variable>		
				<xsl:variable name="inizio_id">
					<xsl:value-of select="@iniziovigore"/>
				</xsl:variable>
				<xsl:variable name="data_fine">
					<xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/>
					<!--	xsl:value-of select="id($fine_id)/@data"/	-->
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$data_fine&lt;number(number($datafine)+1)">
						<!--	eccezione intera legge abrogata	-->	
						<div style=" margin: 15px; color:red; font-size: 160%"> LEGGE ABROGATA </div>
						<span style="color:#f00;"> 								
							[<xsl:apply-templates select="*[name()='intestazione']"/>
							]<a href="#n{@id}" name="t{@id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
					 	</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="vigenza"/>
					</xsl:otherwise>							
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>
	</xsl:template>	

	<xsl:template match="/*[name()='NIR']/*/*[name()='formulainiziale']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="formulainiziale">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
				
			</xsl:otherwise>			
		</xsl:choose>
		
		<hr/>
	</xsl:template>
	
	<xsl:template match="/*/*/*[name()='meta']/*[name()='descrittori']/*[name()='materie']">		
	  	<xsl:for-each select="*[name()='materia']">
			<xsl:value-of select="@valore"/><xsl:text>, </xsl:text>	
	  	</xsl:for-each>
	</xsl:template>

	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template intestazione e relazione                       -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
	<xsl:template match="/*[name()='NIR']/*/*[name()='intestazione']">

		<div class="intestazione">
			
			<xsl:apply-templates select="*[name()='emanante']"/>
			<xsl:apply-templates select="*[name()='tipoDoc']"/><xsl:text> </xsl:text><xsl:apply-templates select="*[name()='dataDoc']"/><xsl:text>, n. </xsl:text><xsl:apply-templates select="*[name()='numDoc']"/>
			<xsl:apply-templates select="*[name()='titoloDoc']"/>

			<!--div class="meta">
				<br/>Numero Proposta: <xsl:value-of select="/*/*/*[name()='meta']/*[name()='proprietario']/*[name()='pacto:meta']/*[name()='pacto:proposta']/@anno" />
				<xsl:text>/</xsl:text><xsl:value-of select="/*/*/*[name()='meta']/*[name()='proprietario']/*[name()='pacto:meta']/*[name()='pacto:proposta']/@numero" />
 			    <br/>Ufficio: <xsl:value-of select="/*/*/*[name()='meta']/*[name()='proprietario']/*[name()='pacto:meta']/*[name()='pacto:ufficio']/@valore" />
			    <br/>Relatore: <xsl:value-of select="/*/*/*[name()='meta']/*[name()='proprietario']/*[name()='pacto:meta']/*[name()='pacto:relatore']/@valore" />
			    <br/>
				<br/>MATERIE: <xsl:apply-templates select="/*/*/*[name()='meta']/*[name()='descrittori']/*[name()='materie']" />
			</div-->	
			<div class="info">			
			<xsl:variable name="tipo">
				<xsl:value-of select="//*[name()='NIR']/*/*[name()='meta']/*[name()='descrittori']/*[name()='pubblicazione']/@tipo" />   				
   			</xsl:variable>
			<xsl:variable name="num">
				<xsl:value-of select="//*[name()='NIR']/*/*[name()='meta']/*[name()='descrittori']/*[name()='pubblicazione']/@num" />   				
   			</xsl:variable>
			<xsl:variable name="data">
				<xsl:value-of select="//*[name()='NIR']/*/*[name()='meta']/*[name()='descrittori']/*[name()='pubblicazione']/@norm" />   				
   			</xsl:variable>
			<xsl:text>Pubblicato su </xsl:text><xsl:value-of select="$tipo"/><xsl:text>, n.</xsl:text><xsl:value-of select="$num"/>
			<xsl:text> del </xsl:text><xsl:value-of select="concat(substring($data,7,2),'/',substring($data,5,2),'/',substring($data,1,4))" />
			</div>
		</div>

		<!-- non far vedere l'indice se e' abrogato per intero   RIVEDERE fatto velocemente  -->
		<xsl:choose>
			<xsl:when test="$datafine!=''">		
				<xsl:variable name="fine_id">
					<xsl:value-of select="/*[name()='NIR']/*/@finevigore"/>
				</xsl:variable>		
				<xsl:variable name="inizio_id">
					<xsl:value-of select="/*[name()='NIR']/*/@iniziovigore"/>
				</xsl:variable>
				<xsl:variable name="data_fine">
					<xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/>
					<!--	xsl:value-of select="id($fine_id)/@data"/	-->
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$data_fine&lt;number(number($datafine)+1)">
					</xsl:when>
					<xsl:otherwise>
		<div id="indice"><center> Indice: </center><br/>
			<xsl:apply-templates select="/*[name()='NIR']/*/*[name()='articolato']/*" mode="indice"/>
			<xsl:apply-templates select="/*[name()='NIR']/*/*[name()='annessi']/*" mode="indice"/>
		</div>
					</xsl:otherwise>							
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
		<div id="indice"><center> Indice: </center><br/>
			<xsl:apply-templates select="/*[name()='NIR']/*/*[name()='articolato']/*" mode="indice"/>
			<xsl:apply-templates select="/*[name()='NIR']/*/*[name()='annessi']/*" mode="indice"/>
		</div>
			</xsl:otherwise>
		</xsl:choose>				


		<hr/>
	</xsl:template>
	
	
	<xsl:template match="//*[name()='tipoDoc']">
		<span> 
			<xsl:value-of select="."/>
		</span>
	</xsl:template>
	<xsl:template match="//*[name()='dataDoc']">
		<span> 
			<xsl:value-of select="."/>
		</span>
	</xsl:template>	
	<xsl:template match="//*[name()='numDoc']">
		<span> 
			<xsl:value-of select="."/>
		</span>
	</xsl:template>
	
	
	<xsl:template match="//*[name()='emanante']">
		<div class="emanante"> 
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="//*[name()='titoloDoc']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="titoloDoc">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>
		
	</xsl:template>
	
	
	<xsl:template match="//*[name()='preambolo']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="preambolo">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
				
			</xsl:otherwise>			
		</xsl:choose>
		
	</xsl:template>	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template articolato                                     -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
	<xsl:template match="//*[name()='articolato'] | //*[name()='contenitore']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div width="100%">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>

	<!-- ========================== 	LIBRO		============================== -->
	<xsl:template match="//*[name()='libro']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="libro">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>	
		&#160;			
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>

	<!-- ========================== 	PARTE		============================== -->
	<xsl:template match="//*[name()='parte']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="parte">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>		
		&#160;		
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>

	<!-- ========================== 	TITOLO		============================== -->
	<xsl:template match="//*[name()='titolo']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="titolo">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>		
		&#160;		
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>

	<!-- ========================== 	SEZIONE		============================== -->
	<xsl:template match="//*[name()='sezione']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="sezione">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>		
		&#160;		
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>

	<!-- ========================== 	CAPO	============================== -->
	<xsl:template match="//*[name()='capo']">
		<hr />
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="capo">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>		
		&#160;		
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>
	
	<!-- ========================== 	RUBRICA	 	============================== -->
	
	<xsl:template match="//*[name()='rubrica']">
		<p class="rubrica">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</p>
	</xsl:template>
	
	<xsl:template match="//*[name()='decorazione']">
		<p class="decorazione">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	

	
	<!-- =========================	ARTICOLO	=============================== -->
	
	<xsl:template match="//*[name()='articolo']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="articolo">
			<xsl:choose>
				<xsl:when test="$datafine!=''">
					<xsl:call-template name="vigenza"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="multivigenza"/>
				</xsl:otherwise>
			</xsl:choose>				
		&#160;
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>

	<!-- =========================	COMMA e sotto comma	=============================== -->

	<xsl:template match="//*[name()='comma']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<p class="comma">
			<xsl:choose>
				<xsl:when test="$datafine!=''">
					<xsl:call-template name="vigenza"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="multivigenza"/>
				</xsl:otherwise>
			</xsl:choose>				
		</p>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>

	<xsl:template match="//*[name()='num']">
		<xsl:choose>
			<xsl:when test="parent::node()[name()='el'] or parent::node()[name()='en'] or parent::node()[name()='ep']">
				<em><xsl:apply-templates />&#160;</em>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates />&#160;
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- =========================	EL , EN , EP	=============================== -->
	<xsl:template match="//*[name()='el'] | //*[name()='en'] | //*[name()='ep']">
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<a name="{@id}">&#160;</a>
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

	<p class="{local-name()}">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<a name="{@id}">&#160;</a>
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<a name="{@id}">&#160;</a>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
	</p>			
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>
	
	<xsl:template match="//*[name()='corpo']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<!--	div class="corpo">	
		<xsl:choose>		
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>
		</div	-->			
		<xsl:apply-templates/>			
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>
	
	<xsl:template match="//*[name()='alinea']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<!--	div class="alinea">
		<xsl:choose>		
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>
		</div	-->	
		<xsl:apply-templates/>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>
	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template sotto il comma                                 -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
	
	<xsl:template match="//*[name()='mmod']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<span class="mmod">
	        <xsl:choose>		
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
			</xsl:choose>
		</span>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template> 
		
	<xsl:template match="//*[name()='mod']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<span class="mod">
	        <xsl:choose>		
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
			</xsl:choose>
		</span>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template> 
		
	<xsl:template match="//*[name()='virgolette']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<xsl:choose>
		<xsl:when test="@tipo='struttura'">
	   		<table width="100%" cellpadding="15"><tr><td class="virgolette">
				<xsl:apply-templates/>
			</td></tr></table>	
		</xsl:when>
		<xsl:otherwise>
	    	<span class="virgolette">
				<xsl:apply-templates/>
			</span>	
		</xsl:otherwise>
		</xsl:choose>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>
	
	<xsl:template match="//*[name()='nome']">
		<span title="Nome: {.}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="//*[name()='rif']">
		<xsl:variable name="url">
			<xsl:value-of select="@xlink:href" />
		</xsl:variable>
		<xsl:variable name="post">
			<xsl:value-of select="./parent::*" />
		</xsl:variable>			
		<xsl:variable name="strina">
			<xsl:value-of select="substring(substring-after($post,.),1,1)" />
		</xsl:variable>	
		<xsl:choose>
			<xsl:when test="contains($url,'urn:nir:')">
				<xsl:choose>
					<xsl:when test="$strina='&#59;' or $strina='&#46;' or $strina='&#58;' or $strina='&#44;'  or $strina='&#45;'">		 
						<a href="urnResolver.xql?urn={@xlink:href}" title="URN = {@xlink:href}">
							<xsl:apply-templates/>
						</a>
					</xsl:when>
					<xsl:otherwise>					 
						<a href="urnResolver.xql?urn={@xlink:href}" title="URN = {@xlink:href}">						
							<xsl:apply-templates/>						
						</a>&#160;
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$strina='&#59;' or $strina='&#46;' or $strina='&#58;' or $strina='&#44;'  or $strina='&#45;'">		 
						<a href="{@xlink:href}" title="Destinazione: {@xlink:href}">
							<xsl:apply-templates/>
						</a>
					</xsl:when>
					<xsl:otherwise>					 
						<a href="{@xlink:href}" title="Destinazione: {@xlink:href}">						
						<xsl:apply-templates/>						
						</a>&#160;
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	<xsl:template match="//*[name()='data']">
		<span title="Data: {concat(substring(@norm,7,2),'/',substring(@norm,5,2),'/',substring(@norm,1,4))}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="//*[name()='ndr']">
		<a name="{concat('ndr',@num)}" href="#{@num}" title="Destinazione: {@num}">
			<sup class="ndr">
				<xsl:attribute name="title">Nota: <xsl:value-of select="."/></xsl:attribute>
				<xsl:value-of select="."/>
			</sup>
		</a>
	</xsl:template>
	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template conclusioni e formula finale                   -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="//*[name()='formulafinale']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="formulafinale">
		<hr/>
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>		
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>
	
	<xsl:template match="//*[name()='conclusione']">
		<div class="conclusione">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="//*[name()='dataeluogo']">
		<p class="dataeluogo">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	
	<xsl:template match="//*[name()='firma']">
			<xsl:choose>
			  <xsl:when test="@tipo='visto'">
				<p class="visto">
					<xsl:choose>
						<xsl:when test="$datafine!=''">
							<xsl:call-template name="vigenza"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="multivigenza"/>
			  			</xsl:otherwise>
					</xsl:choose>	
				</p>
			  </xsl:when>
			  <xsl:otherwise>
				<p class="firma">
					<xsl:choose>
					  <xsl:when test="$datafine!=''">
						<xsl:call-template name="vigenza"/>
					  </xsl:when>
					  <xsl:otherwise>
						<xsl:call-template name="multivigenza"/>
					  </xsl:otherwise>
					</xsl:choose>	
				</p>
			  </xsl:otherwise>
			</xsl:choose>	
	</xsl:template>	
	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template allegati                                       -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="//*[name()='annessi']">
		<br/>ALLEGATI:
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="//*[name()='annesso']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
	</xsl:template>
	<xsl:template match="//*[name()='testata']">
			<hr/>
			<xsl:apply-templates select="*[name()='denAnnesso'] | *[name()='titAnnesso']"/>
			<br/>
	</xsl:template>
	<xsl:template match="*[name()='denAnnesso']">
		<xsl:text> - </xsl:text>
		<b>
			<xsl:apply-templates select=".//text()"/>
		</b>
		<xsl:text> - </xsl:text>
	</xsl:template>
	<xsl:template match="*[name()='titAnnesso']">
			<xsl:apply-templates select=".//text()"/>
	</xsl:template>
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template metadati                                       -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="//*[name()='meta']"/>
	<!--	xsl:template match="//*[name()='urn']">
		<tr>
			<td class="small">
				<a href="http://www.senato.it/japp/bgt/showdoc/frame.jsp?tipodoc={//nir:approvazione/@tipodoc}&amp;leg={//nir:approvazione/@leg}&amp;id={//nir:approvazione/@internal_id}">
					<xsl:value-of select="."/>
				</a>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="//*[name()='redazionale']">
		<div class="redazionale">
			<xsl:apply-templates />
		</div>
	</xsl:template	-->
	<xsl:template match="//*[name()='nota']">
		<xsl:variable name="idnota">
			<xsl:value-of select="@id" />
		</xsl:variable>
		
		<xsl:for-each select="//*[name()='ndr'][@num=$idnota]">		
			<a class="nota" name="{$idnota}" href="{concat('#ndr',$idnota)}">
				<xsl:value-of select="."/>
			</a>
		</xsl:for-each>

		<span class="nota"><xsl:text>&#160;-&#160;</xsl:text></span>
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="//*[name()='confronto']"/>
	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template generici                                       -->
	<!--                                                          -->
	<!-- ======================================================== -->
<xsl:template match="h:table">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*"/>
			<xsl:if test="not(@width)">
	        	<xsl:attribute name="width">95%</xsl:attribute>
	        </xsl:if>
 		    <xsl:if test="not(@border)">
        	    <xsl:attribute name="border">1</xsl:attribute>        
	        </xsl:if>
 		    <xsl:if test="not(@cellpadding)">
        	    <xsl:attribute name="cellpadding">2</xsl:attribute>        
	        </xsl:if>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="@*">
		<xsl:attribute name="{local-name()}"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>
	
	<xsl:template match="@*" mode="object">
		<xsl:choose>
			<xsl:when test="name()='src'">
				<xsl:variable name="nome"><xsl:value-of select="." /></xsl:variable>
				<xsl:attribute name="src"><xsl:value-of select="concat('file://',$baseurl,$nome)"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>	
	
	<xsl:template match="h:*">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>&#160;
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="h:img">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*" mode="object"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template riferimenti incompleti                         -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="processing-instruction('rif')">
		<xsl:value-of select="substring-before(substring-after(.,'&gt;'),'&lt;')" />&#160;
	</xsl:template>
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template span 				                              -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="//*[name()='h:span']">
		&#160;<span>
			<xsl:choose>
				<xsl:when test="$datafine!=''">
					<xsl:call-template name="vigenza"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="multivigenza"/>
				</xsl:otherwise>
			</xsl:choose>				
		</span>&#160;
	</xsl:template>	


	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template p 				                              -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="//*[name()='h:p']">
		<p>
			<xsl:choose>
				<xsl:when test="$datafine!=''">
					<xsl:call-template name="vigenza"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="multivigenza"/>
				</xsl:otherwise>
			</xsl:choose>				
		</p>
	</xsl:template>	

	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template gestione MULTIvigenze                          -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
	<xsl:template name="multivigenza" >
		<xsl:variable name="stato">
		<xsl:value-of select="@status" />
		</xsl:variable>
		<xsl:variable name="inizio_id">
			<xsl:value-of select="@iniziovigore"/>
		</xsl:variable>
		<xsl:variable name="fine_id">
			<xsl:value-of select="@finevigore"/>
		</xsl:variable>				
		<xsl:variable name="data_inizio">

			<xsl:value-of select="//*[name()='evento'][@id=$inizio_id]/@data"/>
			<!--	xsl:for-each select="key('dateventi',$inizio_id)">
				<xsl:value-of select="@data"/>
			</xsl:for-each	-->
			<!--	xsl:value-of select="key('dateventi',$inizio_id)" /	-->
			<!--	xsl:value-of select="id($inizio_id)/@data"/	-->			
		</xsl:variable>
		<xsl:variable name="data_fine">
		
			<xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/>
			<!--	xsl:for-each select="key('dateventi',$fine_id)">
				<xsl:value-of select="@data"/>
			</xsl:for-each	-->
			<!--	xsl:value-of select="key('dateventi',$fine_id)" /	-->
			<!--	xsl:value-of select="id($fine_id)/@data"/	-->
		</xsl:variable>
		<xsl:variable name="giornoprima">		
			<xsl:call-template name="finevigenza">
				<xsl:with-param name="datafinevigenza" select="$data_fine" />
			</xsl:call-template>
		</xsl:variable>						
		<xsl:variable name="tooltip">
				<xsl:choose>
					<xsl:when test="$data_fine!=''">In vigore&#160;<xsl:choose>
										<xsl:when test="$data_inizio!=''">dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/>
										</xsl:when>
										<xsl:otherwise><xsl:text>fino</xsl:text>
										</xsl:otherwise>
									</xsl:choose>&#160;al <xsl:value-of select="$giornoprima"/>
									<xsl:choose>			
										<xsl:when test="$stato!=''">(<xsl:value-of select="$stato"/>)</xsl:when>
									</xsl:choose>		
					</xsl:when>
					<xsl:when test="$data_inizio!=''">In vigore&#160;dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/></xsl:when>
				</xsl:choose>
		</xsl:variable>

			<xsl:attribute name="title"><xsl:copy-of select="$tooltip" /></xsl:attribute>
			<xsl:choose>

			<!-- ========================================== DATA FINE !='' ====================================== -->				
				<xsl:when test="$data_fine!=''">
					<xsl:choose>
						<xsl:when test="$data_fine&lt;$datafine">
							<!--===================== n{@id}, t{@id}:'n' e 't' differenziano il testo dalle note
							    ===================== <xsl:value-of select="@id"/>: il valore accanto a 'VigNota', l'id della partizione
							-->

							<xsl:variable name="id">
								<xsl:value-of select="@id" />
							</xsl:variable>
							<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
								<xsl:if test="../@id=$id">
									<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
								</xsl:if>		
							</xsl:for-each>
							
							
						</xsl:when>
						<xsl:when test="$data_inizio&gt;number(number($datafine)-1)">
							<span style="color:#060;">
							 	[<xsl:apply-templates/>]
								<xsl:variable name="id">
									<xsl:value-of select="@id" />
								</xsl:variable>
								<xsl:for-each select="//*[name()!='urn']/@iniziovigore">	
									<xsl:if test="../@id=$id">
										<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
									</xsl:if>		
								</xsl:for-each>
							</span>
						</xsl:when>						
						<xsl:otherwise>
							<xsl:choose>			
								<xsl:when test="$stato!=''">
									<span style="color:#f00;">
										[<xsl:apply-templates/>]
										<xsl:variable name="id">
											<xsl:value-of select="@id" />
										</xsl:variable>
										<xsl:for-each select="//*[name()!='urn']/@iniziovigore">							
											<xsl:if test="../@id=$id">
												<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
											</xsl:if>		
										</xsl:for-each>
									</span>
								</xsl:when>
								<xsl:otherwise>
									<span style="color:#f00;">
										[<xsl:apply-templates/>]
										<xsl:variable name="id">
											<xsl:value-of select="@id" />
										</xsl:variable>
										<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
											<xsl:if test="../@id=$id">
												<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
											</xsl:if>		
										</xsl:for-each>
									</span>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>	
								<!-- ========================================== DATA inizio !='' ====================================== -->
				<xsl:when test="$data_inizio!=''">
					<xsl:choose>
						<xsl:when test="$data_inizio&gt;$datafine or $data_fine&lt;$datafine">
							<!--===================== n{@id}, t{@id}:'n' e 't' differenziano il testo dalle note
							    ===================== <xsl:value-of select="@id"/>: il valore accanto a 'VigNota', l'id della partizione
							-->							
							<xsl:variable name="id">
								<xsl:value-of select="@id" />
							</xsl:variable>
							<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
								<xsl:if test="../@id=$id">
									<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
								</xsl:if>		
							</xsl:for-each>							
						</xsl:when>
						<xsl:otherwise>
							<span style="color:#060;">
								<xsl:apply-templates/>
								<xsl:variable name="id">
									<xsl:value-of select="@id" />
								</xsl:variable>
								<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
									<xsl:if test="../@id=$id">
										<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
									</xsl:if>		
								</xsl:for-each>								
							</span>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>			


				<xsl:otherwise>
					<xsl:apply-templates />
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>

		<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template gestione urnvigente                            -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
	<xsl:template name="urnvigente" >
		<div class="urnvigente">
		<xsl:choose>
			<xsl:when test="/*[name()='NIR']/@tipo!='multivigente'">
				<xsl:value-of select="/*[name()='NIR']/*/*[name()='meta']/*[name()='descrittori']/*[name()='urn']/@valore"/>
			</xsl:when>	
			<xsl:otherwise>
				<xsl:for-each select="/*[name()='NIR']/*/*[name()='meta']/*[name()='descrittori']/*[name()='urn']">
					<xsl:choose>
						<xsl:when test="$datafine!=''">
							<xsl:variable name="inizio_id">
								<xsl:value-of select="@iniziovigore"/>
							</xsl:variable>
							<xsl:variable name="fine_id">
								<xsl:value-of select="@finevigore"/>
							</xsl:variable>
							<xsl:variable name="data_inizio">
								<xsl:value-of select="//*[name()='evento'][@id=$inizio_id]/@data"/>
								<!--	xsl:value-of select="id($inizio_id)/@data"/	-->
							</xsl:variable>
							<xsl:variable name="data_fine">
								<xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/>
								<!--	xsl:value-of select="id($fine_id)/@data"/	-->
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="$data_fine!=''">		
									<!-- aggiungo un caso: posso avere un intervallo che parte e termina lo stesso giorno							
									<xsl:if test="$data_inizio&lt;number(number($datafine)+1) and $data_fine&gt;$datafine">
										<xsl:value-of select="@valore" /><br/>
									</xsl:if -->
									<xsl:choose>
										<xsl:when test="$data_inizio&lt;number(number($datafine)+1) and $data_fine&gt;$datafine">		
											<xsl:value-of select="@valore" /><br/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:if test="$data_inizio=$datafine and $data_fine=$data_inizio=number(number($datafine)+1)">
												<xsl:value-of select="@valore" /><br/>
											</xsl:if>
										</xsl:otherwise>	
									</xsl:choose>
								</xsl:when>	
								<xsl:otherwise>	
									<xsl:if test="$data_inizio&lt;number(number($datafine)+1)">
										<xsl:value-of select="@valore" /><br/>
									</xsl:if>
								</xsl:otherwise>	
							</xsl:choose>
						</xsl:when>	
						<xsl:otherwise>
				       	    <xsl:if test="@iniziovigore='t1'">
								<xsl:value-of select="@valore" /><br/>
							</xsl:if>
						</xsl:otherwise>				
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>				
		</xsl:choose>		
		</div>		
	</xsl:template>

	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template gestione vigenze                               -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
<xsl:template name="vigenza" >
		<xsl:variable name="idnota">
			<xsl:value-of select="@id" />
		</xsl:variable>
		<xsl:variable name="stato">
		<xsl:value-of select="@status" />
		</xsl:variable>
		<xsl:variable name="inizio_id">
			<xsl:value-of select="@iniziovigore"/>
		</xsl:variable>
		<xsl:variable name="fine_id">
			<xsl:value-of select="@finevigore"/>
		</xsl:variable>	
		
<!--		NON LO USO + PER IL TEST
		<xsl:variable name="data_entratainvigore">
			<xsl:value-of select="//*[name()='evento'][@fonte='ro1']/@data"/>
		</xsl:variable>
-->
		
		<xsl:variable name="data_inizio">
			<xsl:value-of select="//*[name()='evento'][@id=$inizio_id]/@data"/>
			<!--	xsl:value-of select="id($inizio_id)/@data"/	-->
		</xsl:variable>
		<xsl:variable name="data_fine">
			<xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/>
			<!--	xsl:value-of select="id($fine_id)/@data"/	-->
		</xsl:variable>
		<xsl:variable name="giornoprima">		
			<xsl:call-template name="finevigenza">
				<xsl:with-param name="datafinevigenza" select="$data_fine" />
			</xsl:call-template>
		</xsl:variable>		
		<xsl:variable name="tooltip">
				<xsl:choose>
					<xsl:when test="$data_fine!=''">In vigore&#160;<xsl:choose>
										<xsl:when test="$data_inizio!=''">dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/>
										</xsl:when>
										<xsl:otherwise><xsl:text>fino</xsl:text>
										</xsl:otherwise>
									</xsl:choose>&#160;al <xsl:value-of select="$giornoprima"/>
									<xsl:choose>			
										<xsl:when test="$stato!=''">(<xsl:value-of select="$stato"/>)</xsl:when>
									</xsl:choose>		
					</xsl:when>
					<xsl:when test="$data_inizio!=''">In vigore&#160;dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/></xsl:when>
				</xsl:choose>
		</xsl:variable>

			<xsl:choose>

			<!-- ========================================== DATA FINE !='' ====================================== -->				
				<xsl:when test="$data_fine!=''">
					<xsl:variable name="ittignota">
						<xsl:value-of select="/*[name()='NIR']/*/*[name()='meta']/*[name()='disposizioni']/*[name()='modifichepassive']/*/*/*[name()='dsp:pos'][@xlink:href=$idnota]/../../*[name()='dsp:norma']/*[name()='dsp:subarg']/*[name()='ittig:notavigenza']/@id"/>
					</xsl:variable>		
					<xsl:choose>
						<xsl:when test="$data_fine&lt;number(number($datafine)+1)">
							<xsl:attribute name="title"><xsl:copy-of select="$tooltip" /></xsl:attribute>
 							<xsl:choose>
					  		  <xsl:when test="following-sibling::node()[1][@iniziovigore=$fine_id]">
							  </xsl:when>
					   		  <xsl:when test="preceding-sibling::node()[1][@iniziovigore=$fine_id]">
					 		  </xsl:when>
					 		  <xsl:otherwise>	
					 		  
					 		  
					 		  	<!-- ************
						 		<span style="color:#f00;"> [ ... ] <a href="#n{@id}" name="t{@id}"> <sup>{<xsl:value-of select="substring($ittignota,4,number(string-length($ittignota)))"/>}</sup></a></span>						 								 		
								-->
								<span style="color:#f00;"> 								
								<xsl:choose>
					  		  		<xsl:when test="*[name()='num']">
									  	[ <xsl:value-of select="*[name()='num']"/> ]						  		  		
							  		</xsl:when>
					   		  	    <xsl:otherwise>
							  		  	[ ... ]	
					   		  	    </xsl:otherwise>
								</xsl:choose>
								<xsl:variable name="id">
									<xsl:value-of select="@id" />
								</xsl:variable>
								<xsl:for-each select="//*[name()!='urn']/@iniziovigore">	
									<xsl:if test="../@id=$id">
										<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
									</xsl:if>		
								</xsl:for-each>	
						 		</span>
						 		
						 		
						 		
						 		
						 		
 							  </xsl:otherwise>
						   </xsl:choose>

						</xsl:when>
						<xsl:when test="$data_inizio&lt;number(number($datafine)+1) and $data_fine&gt;$datafine">
							<xsl:attribute name="title"><xsl:copy-of select="$tooltip" /></xsl:attribute>
 							<xsl:choose>
								<xsl:when test="$data_inizio and $inizio_id!='t1'">
									<span style="color:#060;">
										<xsl:apply-templates />															
										<xsl:variable name="id">
											<xsl:value-of select="@id" />
										</xsl:variable>
										<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
											<xsl:if test="../@id=$id">
												<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
											</xsl:if>		
										</xsl:for-each>											
									</span>									
								</xsl:when>
						 		<xsl:otherwise>
									<xsl:apply-templates />		
									<xsl:variable name="id">
										<xsl:value-of select="@id" />
									</xsl:variable>
									<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
										<xsl:if test="../@id=$id">
											<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
										</xsl:if>		
									</xsl:for-each>	
 							  	</xsl:otherwise>
						   	</xsl:choose>
						</xsl:when>						
					</xsl:choose>
				</xsl:when>	
			<!-- ========================================== DATA inizio !='' ====================================== -->
				<xsl:when test="$data_inizio!=''">
					<xsl:choose>
						<xsl:when test="$data_inizio&gt;$datafine">
							<!--===================== n{@id}, t{@id}:'n' e 't' differenziano il testo dalle note
							    ===================== <xsl:value-of select="@id"/>: il valore accanto a 'VigNota', l'id della partizione
							-->
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="title"><xsl:copy-of select="$tooltip" /></xsl:attribute>						
									<span style="color:#060;">
										<xsl:apply-templates />					
										
										
										<xsl:variable name="id">
											<xsl:value-of select="@id" />
										</xsl:variable>
										<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
											<xsl:if test="../@id=$id">
												<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
											</xsl:if>		
										</xsl:for-each>	
										
										
									</span>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>			

				<xsl:otherwise>
					<xsl:apply-templates />
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>
	

 	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template note testo MultiVigente (fondo pagina)         -->
	<!--                                                          -->
	<!-- ======================================================== -->

   <xsl:template name="notemultivigente">
	  <xsl:for-each select="//*[name()!='urn']/@iniziovigore">
    	<xsl:variable name="saltare">
			<xsl:value-of select="../@valore" />
		</xsl:variable>
		<xsl:choose>
		<xsl:when test="$saltare">
		</xsl:when>
		<xsl:otherwise>		
			<xsl:variable name="idNoPound">
				<xsl:value-of select="../@id" />
			</xsl:variable>
			<xsl:variable name="id">
				<xsl:value-of select="concat('#',$idNoPound)"/>
			</xsl:variable>
			<xsl:variable name="numeronota">
				<xsl:value-of select="position()" />
			</xsl:variable>		
			
					<xsl:variable name="stato">
						<xsl:value-of select="../@status" />
					</xsl:variable>
					<xsl:variable name="inizio_id">
						<xsl:value-of select="../@iniziovigore"/>
					</xsl:variable>
					<xsl:variable name="fine_id">
						<xsl:value-of select="../@finevigore"/>
					</xsl:variable>
					<xsl:variable name="data_inizio">
						<xsl:value-of select="id($inizio_id)/@data"/>
					</xsl:variable>
					<xsl:variable name="data_fine">
						<xsl:value-of select="id($fine_id)/@data"/>
					</xsl:variable>
					<xsl:variable name="giornoprima">		
						<xsl:call-template name="finevigenza">
							<xsl:with-param name="datafinevigenza" select="$data_fine" />
						</xsl:call-template>
					</xsl:variable>		
					<xsl:variable name="fonte">
						<xsl:choose>
							<xsl:when test="$fine_id!=''">
								<xsl:value-of select="id($fine_id)/@fonte"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="id($inizio_id)/@fonte"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="urn">
						<xsl:value-of select="id($fonte)/@xlink:href"/>
					</xsl:variable>
									
			<xsl:choose>
				<xsl:when test="$numeronota=1">
			   		<br/><h2>Note sulla vigenza</h2>
   				</xsl:when>
			</xsl:choose>
			<p>
			<xsl:choose>
				<xsl:when test="/*[name()='NIR']/*/*[name()='meta']/*[name()='disposizioni']/*[name()='modifichepassive']/*/*/*[name()='dsp:pos'][@xlink:href=$id]/../../*[name()='dsp:norma']">
					<!--	ho le informazione nei metadati	-->
					<xsl:for-each select="/*[name()='NIR']/*/*[name()='meta']/*[name()='disposizioni']/*[name()='modifichepassive']/*/*/*[name()='dsp:pos'][@xlink:href=$id]/../../*[name()='dsp:norma']">
						<xsl:variable name="implicita">
							<xsl:value-of select="../@implicita"/>
						</xsl:variable>	
						<xsl:variable name="urn_meta">
							<xsl:value-of select="../*[name()='dsp:norma']/*[name()='dsp:pos']/@xlink:href"/>
						</xsl:variable>	
						<xsl:variable name="autonota">
							<xsl:value-of select="../*[name()='dsp:norma']/*[name()='dsp:subarg']/*[name()='ittig:notavigenza']/@auto"/>
						</xsl:variable>	
						<xsl:variable name="novella">
							<xsl:value-of select="../*[name()='dsp:novella']/*[name()='dsp:pos']/@xlink:href"/>
						</xsl:variable>	
						<xsl:variable name="novellando">
							<xsl:value-of select="../*[name()='dsp:novellando']/*[name()='dsp:pos']/@xlink:href"/>
						</xsl:variable>	

						<xsl:if test="position()=1">
							<a name="n{$idNoPound}" href="#t{$idNoPound}">[<xsl:value-of select="$numeronota"/>]</a>
		   				</xsl:if>

						<xsl:text> - </xsl:text>
						<xsl:choose>
							<xsl:when test="$novellando">
							<xsl:choose>
								<xsl:when test="$novella">
									<!--	sostituzione	-->
									Sostituzione
		   						</xsl:when>
		   						<xsl:otherwise>
   									<!--	abrogazione		-->
									Abrogazione
								</xsl:otherwise>			
							</xsl:choose>
   						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="$novella">
									<!--	integrazione	-->
									Integrazione
   								</xsl:when>
							</xsl:choose>
						</xsl:otherwise>			   				
					</xsl:choose>			
					<xsl:if test="$implicita!='no'"> 
						<xsl:text> implicita</xsl:text>
					</xsl:if>
					
					<xsl:if test="$novellando">
						<xsl:if test="$novella">
							<!--	sostituzione	-->
							<xsl:if test="$novella=$id"> (testo inserito)</xsl:if>
		   					<xsl:if test="$novellando=$id"> (testo eliminato)</xsl:if>
	   					</xsl:if>
   					</xsl:if>					
					<xsl:text> da: </xsl:text>
					<a href="urnResolver.xql?urn={$urn_meta}" title="URN = {$urn_meta}"><xsl:value-of select="$autonota"/></a>
					<xsl:text>. </xsl:text>
			      </xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<!--	NON ho le informazione nei metadati -->			
					<a name="n{$idNoPound}" href="#t{$idNoPound}">[<xsl:value-of select="$numeronota"/>]</a>
					<xsl:text> - Modificato da: </xsl:text>
					<a href="urnResolver.xql?urn={$urn}" title="URN = {$urn}"> <xsl:value-of select="$urn" /> </a>
					<xsl:text>. </xsl:text>
				</xsl:otherwise>			
			</xsl:choose>
				<xsl:choose>
					<!-- ================= data_fine!='' =========-->
						<xsl:when test="$data_fine!=''">
								In vigore
						 		<xsl:choose>
									<xsl:when test="$data_inizio!=''">
										dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>fino</xsl:text>
									</xsl:otherwise>
								</xsl:choose>	
								al <xsl:value-of select="$giornoprima"/>
								
								<!--	xsl:choose>			
									<xsl:when test="$stato!=''">
										(<xsl:value-of select="$stato"/>)
									</xsl:when>
								</xsl:choose	-->		
								
						</xsl:when>
						<!-- ================= data_inizio!='' =========-->
						<xsl:when test="$data_inizio!=''">
								&#160;In vigore	dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/>
						</xsl:when>
					</xsl:choose>
			
	      </p>
		</xsl:otherwise>
		</xsl:choose>		
	  </xsl:for-each>		      
   </xsl:template>
 
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template TimeLine						-->
	<!--                                                          -->
	<!-- ======================================================== -->
 
   <xsl:template name="TimeLine">
	<div style="font-weight: bold; font-style: normal; font-size: medium; text-align: right">
		<xsl:call-template name="urnvigente"/>
	</div><hr/>
	<xsl:choose>
		<xsl:when test="//*[name()='NIR']/@tipo!='originale'">	
   	<ul id="choosedata">
   		<xsl:text></xsl:text>
   		<xsl:for-each select="//*[name()='eventi']/*[@data!='']">
		<xsl:sort select="@data" data-type="number" order="ascending"/>


		<xsl:if test="substring(@fonte,1,2)!='ra'">
		
			<xsl:variable name="pos">
				<xsl:value-of select="position()"/>
			</xsl:variable>
   			<xsl:variable name="data">
   				<xsl:value-of select="concat(substring(@data,7,2),'/',substring(@data,5,2),'/',substring(@data,1,4))" />
   			</xsl:variable>
			<xsl:variable name="fonte">
				<xsl:value-of select="@fonte"/>
			</xsl:variable>
			<xsl:variable name="urnlegge">
				<xsl:value-of select="//*[name()='passiva'][@id=$fonte]/@xlink:href"/>
			</xsl:variable>
			<xsl:variable name='emanantecc' select='substring-after(substring-after($urnlegge,":"),":")'/>
			<xsl:variable name='emanante' select="substring-before($emanantecc,':')"/>
			<xsl:variable name='leggecc' select='substring-after($emanantecc,":")'/>
			<xsl:variable name='legge' select='substring-before($leggecc,":")'/>
			<xsl:variable name='dataecc' select='substring-after($leggecc,":")'/>
			<xsl:variable name='tempdata' select='substring-before($dataecc,";")'/>
			<xsl:variable name='anno' select='substring-before(concat($tempdata,"-"),"-")'/>
			<xsl:variable name='numero' select='substring-after($dataecc,";")'/>		

			<xsl:choose>
			<!--	questo serviva quando si vedevano solo le date 
				xsl:when test="@data=preceding-sibling::*/@data">
			</xsl:when	-->
			<xsl:when test="$datafine=@data">
   				<li>
						<xsl:choose>
						<xsl:when test="$pos=1">
							<span style="float: right;">Mostra documento: 
							<xsl:choose>
								<xsl:when test="$datafine=''"> multivigente</xsl:when>
								<xsl:otherwise><a href="?doc={$doc}&amp;xml={$xml}"  title="vedi documento multivigente"> multivigente</a></xsl:otherwise>
							</xsl:choose>
							</span>
							<xsl:text>Testo originale in vigore dal: </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> - </xsl:text>
							<a href="urnResolver.xql?urn={$urnlegge}" title="URN = {$urnlegge}">
								<xsl:value-of select="$legge"/><xsl:text> </xsl:text><xsl:value-of select="$emanante"/><xsl:text> n.</xsl:text><xsl:value-of select="$numero"/>/<xsl:value-of select="$anno"/>
							</a>
							<xsl:text> dal: </xsl:text>
						</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="$data" /><br/>
						<xsl:if test="$pos=1">
							<br/>Testo <b>multivigente</b> con le modifiche apportate da:
						</xsl:if>
				</li>
			</xsl:when>
			<xsl:otherwise>
		 		<li>	
					<xsl:choose>
					<xsl:when test="$pos=1">
						<span style="float: right;">Mostra documento:
						<xsl:choose>
							<xsl:when test="$datafine=''"> multivigente</xsl:when>
							<xsl:otherwise><a href="?doc={$doc}&amp;xml={$xml}"  title="vedi documento multivigente"> multivigente</a></xsl:otherwise>
						</xsl:choose>
						</span>
						<xsl:text>Testo originale in vigore dal: </xsl:text>
						
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> - </xsl:text>
						<a href="urnResolver.xql?urn={$urnlegge}" title="URN = {$urnlegge}">
							<xsl:value-of select="$legge"/><xsl:text> </xsl:text><xsl:value-of select="$emanante"/><xsl:text> n.</xsl:text><xsl:value-of select="$numero"/>/<xsl:value-of select="$anno"/>
						</a>
						<xsl:text> dal: </xsl:text>
					</xsl:otherwise>
					</xsl:choose>
					<a href="?doc={$doc}&amp;xml={$xml}&amp;datafine={@data}" title="vedi documento vigente a {$data}">
						<xsl:value-of select="$data" />
					</a><br/>
					<xsl:if test="$pos=1">
						<br/>Testo <b>multivigente</b> con le modifiche apportate da:
					</xsl:if>
				</li>
			</xsl:otherwise>
			</xsl:choose>
			
		</xsl:if>			
   		</xsl:for-each>
   	</ul>
	</xsl:when>
	<xsl:otherwise>
		<xsl:text>Atto in vigore dal: </xsl:text>
		<xsl:variable name="data">
			<xsl:value-of select="//*[name()='NIR']/*/*[name()='meta']/*[name()='descrittori']/*[name()='entratainvigore']/@norm" />   				
   		</xsl:variable>
		<xsl:value-of select="concat(substring($data,7,2),'/',substring($data,5,2),'/',substring($data,1,4))" />
	</xsl:otherwise>
  </xsl:choose>
			


   </xsl:template>
 
	<!-- ======================================================== -->
	<!--  REPLACE		              			  -->
	<!-- ======================================================== -->


	<xsl:template name="replace-string">
		<xsl:param name="text"/>
		<xsl:param name="replace"/>
		<xsl:param name="with"/>
		<xsl:choose>
			<xsl:when test="contains($text,$replace)">
				<xsl:value-of select="substring-before($text,$replace)"/>
				<xsl:value-of select="$with"/>
				<xsl:call-template name="replace-string">
					<xsl:with-param name="text" select="substring-after($text,$replace)"/>
					<xsl:with-param name="replace" select="$replace"/>
					<xsl:with-param name="with" select="$with"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ======================================================== -->
	<!--  Calcola -1 giorno				              			  -->
	<!-- ======================================================== -->

	<xsl:template name="finevigenza">
		<xsl:param name="datafinevigenza" />
		<xsl:variable name="giornofinevigenza">
			<xsl:value-of select="substring($datafinevigenza,7,2)"/>
		</xsl:variable>
		<xsl:variable name="mesefinevigenza">
			<xsl:value-of select="substring($datafinevigenza,5,2)"/>
		</xsl:variable>
		<xsl:variable name="annofinevigenza">
			<xsl:value-of select="substring($datafinevigenza,1,4)"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$giornofinevigenza='01'">
				<xsl:choose>
					<xsl:when test="$mesefinevigenza='01'">
						<xsl:value-of select="concat('31','/','12','/',format-number(number(number($annofinevigenza)-1), '0000'))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="mesevigenza">
							<xsl:value-of select="number(number($mesefinevigenza)-1)"/>
						</xsl:variable>
						<xsl:variable name="giornovigenza">
						    <xsl:choose>
						      <xsl:when test="$mesevigenza=1">31</xsl:when>
						      <xsl:when test="$mesevigenza=2">28</xsl:when>
						      <xsl:when test="$mesevigenza=3">31</xsl:when>
						      <xsl:when test="$mesevigenza=4">30</xsl:when>
						      <xsl:when test="$mesevigenza=5">31</xsl:when>
						      <xsl:when test="$mesevigenza=6">30</xsl:when>
						      <xsl:when test="$mesevigenza=7">31</xsl:when>
						      <xsl:when test="$mesevigenza=8">31</xsl:when>
						      <xsl:when test="$mesevigenza=9">30</xsl:when>
						      <xsl:when test="$mesevigenza=10">31</xsl:when>
						      <xsl:when test="$mesevigenza=11">30</xsl:when>
						      <xsl:when test="$mesevigenza=12">31</xsl:when>
						    </xsl:choose>					
						</xsl:variable>
						<xsl:value-of select="concat($giornovigenza,'/',format-number(number(number($mesefinevigenza)-1),'00'),'/',$annofinevigenza)"/>
					</xsl:otherwise>							
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(format-number(number(number($giornofinevigenza)-1),'00'),'/',$mesefinevigenza,'/',$annofinevigenza)"/>
			</xsl:otherwise>							
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
