xquery version "1.0" encoding "iso-8859-15";

(: $Id: admin.xql 6739 2007-10-19 14:24:20Z deliriumsky $ :)
(:
    Main module of the database administration interface.
:)

declare namespace admin = "http://xmlgroup.iit.cnr.it/nir";

declare namespace request = "http://exist-db.org/xquery/request";
declare namespace session = "http://exist-db.org/xquery/session";
declare namespace util = "http://exist-db.org/xquery/util";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";

import module namespace search = "http://xmlgroup.iit.cnr.it/nir/search" at "search.xqm";
import module namespace browse = "http://xmlgroup.iit.cnr.it/nir/browse" at "browse.xqm";
import module namespace clustering = "http://xmlgroup.iit.cnr.it/nir/clustering" at "clustering.xqm";

(:
    Select the page to show. Every page is defined in its own module 
:)
declare function admin:panel() as element()
{
    let $panel := request:get-parameter("panel", "search") return
         if($panel eq "search") then
        (
            search:main()
        )
		else  if($panel eq "browse") then
		(
            browse:main()
		)
		else  
        (
            clustering:main()
        ) 
};

(:~  
    Display the login form.
:)
declare function admin:display-login-form() as element()
{
   <DIV id="contenuto">
      <DIV class="spazioPiccolo">.</DIV>
      <H3>Norme In Rete</H3><IMG class="pallainterna" height="50" alt="" src="./img/palla_elearning.gif" width="45"/> 
      
      <TABLE cellSpacing="0" cellPadding="0" border="0">
        <TBODY>
        <TR>
          <TD>
	  <div class="panel">
        <div class="panel-head">Login</div>
        <p>Questa è una risorsa protetta. Solo gli utenti registrati possono accedervi. 
		Per ogni problema contattare l'<a href="mailto:pietro.roselli.lorenzini@cnipa.it">amministratore</a> del sito.
        </p>

        <form action="{session:encode-url(request:get-uri())}" method="post">
            <table class="login" cellpadding="5">
                <tr>
                    <th colspan="2" align="left">Login</th>
                </tr>
                <tr>
                    <td align="left">Username:</td>
                    <td><input name="user" type="text" size="20"/></td>
                </tr>
                <tr>
                    <td align="left">Password:</td>
                    <td><input name="pass" type="password" size="20"/></td>
                </tr>
                <tr>
                    <td colspan="2" align="left"><input type="submit"/></td>
                </tr>
            </table>
        </form>
    </div>
     </TD></TR></TBODY></TABLE></DIV>
};

let $tmp := session:set-current-user("admin", "")
(: main entry point :)
let $isLoggedIn :=  true() 
(: 
	if(xdb:get-current-user() eq "guest")then
    (
        (: is this a login attempt? :)
        if(request:get-parameter("user", ()) and not(empty(request:get-parameter("pass", ()))))then
        (
            if(request:get-parameter("user", ()) eq "guest")then
            (
                (: prevent the guest user from accessing the admin webapp :)
                false()
            )
            else
            (
                (: try and log the user in :)
                xdb:login("/db", request:get-parameter("user", ()), request:get-parameter("pass", ()))
            )
        )
        else
        (
            (: prevent the guest user from accessing the admin webapp :)
            false()
        )
    )
    else
    (
        (: if we are already logged in, are we logging out - i.e. set permissions back to guest :)
        if(request:get-parameter("logout",()))then
        (
        	let $null := xdb:login("/db", "guest", "guest") return
        	    false()
        )
        else
        (
             (: we are already logged in and we are not the guest user :)
            true()
        )
    )
   :)
return

    <html>
        <head>
            <title>CNIPA - Raccolta normativa ICT </title>
           	 <link type="text/css" href="css/cmsNIR.css" rel="stylesheet"/>
           	 <link type="text/css" href="css/tables.css" rel="stylesheet"/>
			<script src="js/jquery-1.2.3.js" type="text/javascript" ><!-- jquery library --></script>
			<script src="js/main.js" type="text/javascript"><!-- main code --></script>

			<script type="text/javascript" language="JavaScript"><!--
			function ReverseContentDisplay(d) {
					if(d.length < 1) { return; }
					if(document.getElementById(d).style.display == "none") { document.getElementById(d).style.display = "block"; }
					else { document.getElementById(d).style.display = "none"; }
			}
			//--></script>
			
        </head>
        <body>

	<!--servono per la fare la finestra modale -->
   		<div id="background">.</div>
		<div id="modalContainer">.</div>

	<!--inizio head -->

<!--inizio loghi -->
<DIV id="Contieneheader">
<DIV id="header"><A href="http://www.cnipa.gov.it/"><IMG height="94" alt="CNIPA:Centro Nazionale per l'Informatica nella Pubblica Amministrazione" src="./img/logo_aipa_new.gif" width="317"/></A></DIV></DIV>
<!--fine loghi -->
 
<!--inizio path -->
<HR/>
<DIV id="path">
<UL>
  <LI><A href="http://www.cnipa.gov.it/site/it-IT/">Home</A> :: </LI>
  <LI>Normativa ::</LI>
  <LI>Raccolta normativa ICT ::</LI></UL></DIV>
<!--fine path -->
  
<!--inizio menu Horizzontale alto -->
<A name="menu_utility"></A>
<DIV id="menuHor">
<UL>
 <LI> <A href="http://www.cnipa.gov.it/site/it-IT/menuservizio/Guida/">Guida</A> </LI>
 <LI><A href="http://www.cnipa.gov.it/site/it-IT/menuservizio/Mappa/">Mappa</A> </LI>
 <LI><A  href="http://www.cnipa.gov.it/site/it-IT/menuservizio/Ricerca/">Ricerca</A> </LI>
 <LI><A href="http://www.cnipa.gov.it/site/it-IT/menuservizio/Area_riservata/">Area riservata</A></LI>
 <LI><A href="index.xql?panel=browse">CMS</A></LI></UL></DIV>
<!--fine menu Horizzontale alto -->

<!--fine head -->  
	   
<!--inizio corpo centrale -->
<DIV id="corpo">
<TABLE class="tabellaMenuSx" cellSpacing="0" cellPadding="0" width="100%" summary="" border="0">
  <TBODY>
  <TR>
    <TD  vAlign="top"></TD>
    <TD vAlign="top" rowSpan="2">
<!--inizio body -->
      <DIV id="contieneLinkinterniDx">
<!--div che contiene tutto -->

<!--inizio contenuti -->
      
		 {
                    if($isLoggedIn)then
                    (
                        admin:panel()
                    )
                    else
                    (
                        admin:display-login-form()
                    )
                }           
		

           
					
<!--inizio menu destra -->
      <HR/>

      
<!--fine menu destra -->
</DIV>

<!--chiusura div che contiene tutto -->
</TD></TR>

<!--fine body -->

  <TR>
    <TD class="tdMenuSx" vAlign="top">
<!--inizio menu sinistra -->

<!-- Menu Sx -->
<DIV class="spazioPiccolo">.</DIV>
      <H3 class="titoloMenuPrimo">Il <SPAN class="capoletteraMenuSxPrimo">C</SPAN>entro Nazionale</H3>
      <DIV id="menuSxPrimo">
      <UL>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Il_Centro_Nazionale/Chi_siamo/">Chi siamo</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Il_Centro_Nazionale/Struttura/">Struttura</A> </LI>

        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Il_Centro_Nazionale/Contatti/">Contatti</A> </LI>

        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Il_Centro_Nazionale/URP/">URP</A> </LI>

        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Il_Centro_Nazionale/SALA_STAMPA/">SALA 
        STAMPA</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Il_Centro_Nazionale/Trasparenza_degli_atti_del_Cnipa/">Trasparenza 
        degli atti del Cnipa</A> </LI></UL></DIV>
		
<!--da qui nuovo sottomenu aree operative-->
      <H3 class="titoloMenuSecondo"><SPAN class="capoletteraMenuSxSecondo">Aree 
      operative</SPAN></H3>
      <DIV id="menuSxSecondoTer">
      <UL>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Aree_operative/Indirizzo,_supporto_e_verifica_PAC/">Indirizzo, 
        supporto e verifica PAC</A>  </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Aree_operative/Infrastrutture_nazionali_condivise/">Infrastrutture 
        nazionali condivise</A>  </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Aree_operative/Progetti,_applicazioni_e_servizi/">Progetti, 
        applicazioni e servizi</A>  </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Aree_operative/Innovazione_per_le_Regioni_e_gli_Enti_locali/">Innovazione 
        per le Regioni e gli Enti locali</A> </LI> 
        <LI ><A href="http://www.cnipa.gov.it/site/it-IT/Aree_operative/Regolazione_e_Formazione/">Regolazione 
        e Formazione</A>  </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Aree_operative/Governo_e_monitoraggio_delle_forniture_ICT/">Governo 
        e monitoraggio delle forniture ICT</A>  </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Aree_operative/Organizzazione_e_risorse_umane/">Organizzazione 
        e risorse umane</A>  </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Aree_operative/Funzionamento/">Funzionamento</A> 
        </LI></UL></DIV>
      <DIV class="spazio1em"></DIV>

<!--fine sottomenu aree-->

	  
	  <H3 class="titoloMenuSecondo"><SPAN class="capoletteraMenuSxSecondo">In primo 
      piano</SPAN></H3>
      <DIV id="menuSxSecondo">
      <UL>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/In_primo_piano/Progetto_AU.G.U.STO/">Progetto 
        AU.G.U.STO</A>  </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/In_primo_piano/Sistema_Pubblico_di_Connettivit%c3%a0_(SPC)/">Sistema 
        Pubblico di Connettività (SPC)</A>  </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/In_primo_piano/Posta_Elettronica_Certificata__(PEC)/">Posta 
        Elettronica Certificata (PEC)</A>  </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/In_primo_piano/Progetto_SEPA/">Progetto 
        SEPA</A> </LI></UL></DIV>
      <DIV class="spazio1em"></DIV>
      <H3 class="titoloMenuSecondo">Attività</H3>

<!--	<div id="menuSxSecondo"> -->
      <DIV id="menuSxSecondoBis">
      <UL>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Accessibilit%c3%a0/">Accessibilità</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Certificatori_accreditati/">Certificatori 
        accreditati</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Codice_Amministrazione_Digitale/">Codice 
        Amministrazione Digitale</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Dematerializzazione/">Dematerializzazione</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/E-gov__per_Regioni_ed_Enti_locali/">E-gov 
        per Regioni ed Enti locali</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Efficienza_interna_della_PA/">Efficienza 
        interna della PA</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Elenco_monitori_qualificati/">Elenco 
        monitori qualificati</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Elenco_valutatori_accessibilit%c3%a0/">Elenco 
        valutatori accessibilità</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Firma_digitale/">Firma 
        digitale</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Formazione/">Formazione</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Grandi_reti_della_PA/">Grandi 
        reti della PA</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Informatizzazione_della_PA/">Informatizzazione 
        della PA</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Laboratorio_sperimentale/">Laboratorio 
        sperimentale</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Osservatorio_Open_Source/">Osservatorio 
        Open Source</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Pianificazione_e_Razionalizzazione/">Pianificazione 
        e Razionalizzazione</A></LI> 
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Protocollo_informatico/">Protocollo 
        informatico</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Qualit%c3%a0_delle_forniture_ICT/">Qualità 
        delle forniture ICT</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Riusabilit%c3%a0_del_software_nella_PA_(Portale_del_riuso)/">Riusabilità 
        del software nella PA (Portale del riuso)</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Riuso_dei_dati_pubblici/">Riuso 
        dei dati pubblici</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Servizi_ai_cittadini/">Servizi 
        ai cittadini</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Servizi_per_la_PA/">Servizi 
        per la PA</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Sicurezza_informatica/">Sicurezza 
        informatica</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Sistemi_Informativi_Territoriali/">Sistemi 
        Informativi Territoriali</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Attivit%c3%a0/Tecnologie_innovative_per_la_PA/">Tecnologie 
        innovative per la PA</A> </LI></UL></DIV>
      <DIV class="spazio1em"></DIV>
      <H3 class="titoloMenuTerzo">Bandi e Avvisi</H3>
      <DIV id="menuSxTerzo">
      <UL>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Bandi_e_Avvisi/Bandi/">Bandi</A> </LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Bandi_e_Avvisi/Avvisi/">Avvisi</A></LI>
        <LI><A href="http://www.cnipa.gov.it/site/it-IT/Bandi_e_Avvisi/Banca_dati_collaboratori_a_progetto/">Banca 
        dati collaboratori a progetto</A> </LI></UL></DIV>
      <DIV class="spazio1em"></DIV>
      <DIV class="hr">
      <HR/>
      </DIV>
     
<!--Fine menu sinistra -->

</TD></TR></TBODY></TABLE></DIV>

<!--inizio footer-->
<DIV class="hrpiepagina"><A href="http://www.cnipa.gov.it/Site/it-IT/menuservizio/Guida/#copyr">Copyright</A> 
- <A href="http://www.cnipa.gov.it/Site/it-IT/menuservizio/Guida/#respo">Responsabilità</A></DIV>
<DIV class="spazioPiccolo">.</DIV>
<!--fine footer-->
        </body>
    </html>