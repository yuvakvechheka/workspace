<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:template match="/">
        <html>
            <head>
                <!--Title erstellen-->
                <title>Laborinventar der Hochschule Bremerhaven</title>

                <!-- Kostenlose Google Font API einzufugen-->
                <link
                    href="https://fonts.googleapis.com/css?family=Cormorant+Garamond|Open+Sans+Condensed:300"
                    rel="stylesheet"></link>
                <!-- CSS Stylesheet fangt hier an-->
                <style>
                        <!--Font auswählen für den ganzen Document-->
                    body{
                        font-family: 'Cormorant Garamond', serif;
                        font-family: 'Open Sans Condensed', sans-serif;
                    
                    }<!--Table bgcolor einstellen-->
                    table{
                        border: 0;
                        background-color: #E3F2FD;
                    }<!--Set Font style-->
                    th{
                        font-weight: normal;
                    }</style>
                <!-- CSS Stylesheet endet hier-->

            </head>
            <body>
                <!--Alle Template in Body aufrufen.-->
                <xsl:element name="h1">Laborinventar der Hochschule Bremerhaven</xsl:element>
                <xsl:call-template name="content"/>
                <xsl:call-template name="overview"/>
                <xsl:call-template name="rechnerlist"/>
                <xsl:call-template name="software"/>
                <xsl:call-template name="softwaresorted"/>
                <xsl:call-template name="geräte"/>
                <xsl:call-template name="gerätesorted"/>
                <xsl:call-template name="hersteller"/>
                <xsl:call-template name="statistik"/>
                <xsl:call-template name="footer"/>
            </body>
        </html>
    </xsl:template>

    <!--Inhaltsverzeichnis template erstellen-->
    <xsl:template name="content">
        <h2>Inhaltsverzeichnis</h2>
        <p>1. <a href="#tbOverview">Labore</a>
        </p>

        <!--Alle Labore in Inhaltverzeichnis anzeigen lassen -->
        <xsl:variable name="labor" select="//labor"/>
        <xsl:for-each select="$labor">
            <xsl:sort select="@name"/>
            <p>1. <!--Nummer wird selber erhört-->
                <xsl:number value="position()" format="1 "/>
                <a href="#tbOverview"><xsl:value-of select="@name"/></a>
            </p>
        </xsl:for-each>
        <p>2. <!--link to Rechnerlist-->
            <a href="#tbRechnerList">Rechnerliste</a>
        </p>
        <p>3. <!--link to Softwarelist-->
            <a href="#tbSoftware">Software Informationen und Liste</a>
        </p>
        <p>4. <!--link to Gerätelist-->
            <a href="#tbGeräte">Geräte Informationen und Liste</a>
        </p>

        <p>5. <!--link to Herstellerlist-->
            <a href="#tbHersteller">Herstellerliste</a>
        </p>
        
        <p>6. <!--link to Statistik-->
            <a href="#tbStatistik">Statistik</a>
        </p>
    </xsl:template>
    <!--Inhaltsverzeichnis template endet hier-->

    <!--Labor Info template erstellen-->
    <xsl:template name="overview">
        <!--Set ID, also kann man in Inhaltsverzeichnis aufrufen-->
        <h2 id="tbOverview">Hochschule</h2>
        <table>
            <!--Set Table row bgColor-->
            <tr bgcolor="#2196F3" style="color:white">
                <th>Labor</th>
                <th>Raumnummer</th>
                <th>Rechner</th>
                <th>Betriebsystem</th>
                <th>Anschaffungsdatum</th>
                <th>Anwendungssoftware</th>
                <th>Beschreibung</th>
            </tr>
            <!--Alle labor, suchen für jeder unnötige Element von einzelnen Laboren-->
            <xsl:for-each select="//labor">
                <tr>
                    <td>
                        <xsl:value-of select="@name"/>
                    </td>
                    <td>
                        <xsl:value-of select="@raumnummer"/>
                    </td>
                    <xsl:for-each select="rechner">

                        <td>
                            <xsl:value-of select="@schlüssel"/>
                        </td>
                        <td>
                            <xsl:value-of select="betriebsystem"/>
                        </td>
                        <td>
                            <xsl:value-of select="anschaffungsdatum"/>
                        </td>
                        <td>
                            <xsl:for-each select="anwendungssoftware"><xsl:value-of
                                    select="self::node()"/>; </xsl:for-each>
                        </td>
                        <td>Festplatte: <xsl:value-of
                                select="erweiterungen/beschreibung/festplatte/@size"/>; Ram:
                                <xsl:value-of select="erweiterungen/beschreibung/speicher/@size"/>;
                            Hersteller: <xsl:value-of select="erweiterungen/beschreibung/hersteller"
                            />; <br/>
                            <xsl:value-of select="erweiterungen/besonderheiten"/>
                        </td>
                        <tr/>
                        <td/>
                        <td/>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    <!--Labor Info template endet hier-->

    <!--Rechnerlist Template erstellen-->
    <xsl:template name="rechnerlist">
        <!--Set ID, also kann man in Inhaltsverzeichnis aufrufen-->
        <h2 id="tbRechnerList">Rechnerlist</h2>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Labor</th>
                <th>Rechner</th>
            </tr>
            <!--Alle labor, suchen für jeder nötige Element von einzelnen Laboren-->
            <xsl:for-each select="//labor">
                <tr>
                    <td>
                        <xsl:value-of select="@name"/>
                    </td>
                    <xsl:for-each select="rechner">
                        <td>
                            <xsl:value-of select="@schlüssel"/>
                        </td>
                        <tr/>
                        <td/>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    <!--Rechnerlist Template endet hier-->

    <!-- Software Template erstellen-->
    <xsl:template name="software">
        <!--Set ID, also kann man in Inhaltsverzeichnis aufrufen-->
        <h2 id="tbSoftware">Labor-Software Informationen</h2>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Labor</th>
                <th>Raumnummer</th>
                <th>Software</th>
                <th>Schlüssel</th>
                <th>Lizenz</th>
                <th>Hersteller</th>
                <th>Beschreibung</th>
            </tr>
            <!--Alle labor, suchen für jeder nötige Element von einzelnen Laboren-->
            <xsl:for-each select="//labor">
                <tr>
                    <td>
                        <xsl:attribute name="loc" select="@name"/>
                        <xsl:value-of select="@name"/>
                    </td>
                    <td>
                        <xsl:value-of select="@raumnummer"/>
                    </td>
                    <xsl:for-each select="software">
                        <td>
                            <xsl:value-of select="@name"/>
                        </td>
                        <td>
                            <xsl:value-of select="@schlüssel"/>
                        </td>
                        <td>
                            <xsl:value-of select="@lizenz"/>
                        </td>
                        <td>
                            <xsl:value-of select="beschreibung/hersteller"/>
                        </td>
                        <td>
                            <xsl:value-of select="besonderheiten"/>
                        </td>
                        <tr/>
                        <td/>
                        <td/>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    <!-- Software Template endet hier-->

    <!--Softwaresorted Template erstellen-->
    <xsl:template name="softwaresorted">
        <!--Set ID, also kann man in Inhaltsverzeichnis aufrufen-->
        <h2 id="tbSoftwareSorted">Sortierte Softwareliste</h2>
        <!--Set variable, also kann man später sortieren-->
        <xsl:variable name="softwares"
            select="//software/@name"/>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Nummer</th>
                <th>Software</th>
            </tr>
            <xsl:for-each select="$softwares">
                <!--Sortieren verfahren-->
                <xsl:sort select="."/>
                <xsl:element name="p">
                    <td>
                        <!--nummer wird selber erhört-->
                        <xsl:number value="position()" format="1"/>
                    </td>

                    <td>
                        <xsl:value-of select="."/>
                    </td>
                    <tr/>
                </xsl:element>
            </xsl:for-each>
        </table>
    </xsl:template>
    <!--Softwaresorted Template ended hier-->

    <!--Gerätelist Template erstellen-->
    <xsl:template name="geräte">
        <!--Set ID, also kann man in Inhaltsverzeichnis aufrufen-->
        <h2 id="tbGeräte">Geräte Informationen</h2>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Labor</th>
                <th>Raumnummer</th>
                <th>Model</th>
                <th>Hersteller</th>
                <th>Besonderheit</th>
            </tr>
            <!--Alle labor, suchen für jeder nötige Element von einzelnen Laboren-->
            <xsl:for-each select="//labor">
                <tr>
                    <td>
                        <xsl:value-of select="@name"/>
                    </td>
                    <td>
                        <xsl:value-of select="@raumnummer"/>
                    </td>
                    <xsl:for-each select="geräte/scanner">
                        <td>Scanner: <xsl:value-of select="model"/></td>
                        <td>
                            <xsl:value-of select="beschreibung/hersteller"/>
                        </td>
                        <td>
                            <xsl:value-of select="besonderheiten"/>
                        </td>
                        <tr/>
                        <td/>
                        <td/>
                    </xsl:for-each>
                    <xsl:for-each select="geräte/drucker">
                        <td>Drucker: <xsl:value-of select="model"/></td>
                        <td>
                            <xsl:value-of select="beschreibung/hersteller"/>
                        </td>
                        <td>
                            <xsl:value-of select="besonderheiten"/>
                        </td>
                        <tr/>
                        <td/>
                        <td/>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    <!--Gerätelist Template endet hier-->

    <!--Gerätesorted Template erstellen-->
    <xsl:template name="gerätesorted">
        <!--Set ID, also kann man in Inhaltsverzeichnis aufrufen-->
        <h2 id="tbGeräteSorted">Sortierte Geräteliste</h2>
        <!--Set variable, also kann man später sortieren und alle gleiche Geräte nur einmal genommen-->
        <xsl:variable name="gerätes"
            select="//model[not(text() = (ancestor::model/text() | preceding::model/text()))]"/>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Nummer</th>
                <th>Model</th>
            </tr>
            <xsl:for-each select="$gerätes">
                <!--Sortieren verfahren-->
                <xsl:sort select="."/>
                <xsl:element name="p">
                    <td>
                        <!--nummer wird selber erhört-->
                        <xsl:number value="position()" format="1"/>
                    </td>

                    <td>
                        <xsl:value-of select="."/>
                    </td>
                    <tr/>
                </xsl:element>
            </xsl:for-each>
        </table>
    </xsl:template>
    <!--Geratesorted Template ended hier-->

    <!--Herstellerlist Template erstellen-->
    <xsl:template name="hersteller">
        <!--Set ID, also kann man in Inhaltsverzeichnis aufrufen-->
        <h2 id="tbHersteller">Hersteller</h2>
        <!--Set variable, also kann man später sortieren und alle gleiche Herstellers nur einmal genommen-->
        <xsl:variable name="hersteller"
            select="//hersteller[not(text() = (ancestor::hersteller/text() | preceding::hersteller/text()))]"/>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Nummer</th>
                <th>Hersteller</th>
            </tr>
            <xsl:for-each select="$hersteller">
                <!--Sortieren verfahren-->
                <xsl:sort select="."/>
                <xsl:element name="p">
                    <td>
                        <!--nummer wird selber erhört-->
                        <xsl:number value="position()" format="1"/>
                    </td>

                    <td>
                        <xsl:value-of select="."/>
                    </td>
                    <tr/>
                </xsl:element>
            </xsl:for-each>
        </table>
    </xsl:template>
    <!--Herstellerlist Template endet hier-->

    <!-- Statistik Template erstellen-->
    <xsl:template name="statistik">
        <!--Set ID, also kann man in Inhaltsverzeichnis aufrufen-->
        <h2 id="tbStatistik">Statistik</h2>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Anzahl der Labore</th>
                <th>Anzahl der Rechner</th>
                <th>Anzahl durchnichlicher <br/> Rechner pro Labor</th>
                <th>Anzahl der Software</th>
                <th>Anzahl der Geräte</th>
                <th>Anzahl des Herstellers</th>
            </tr>
            <tr>
                <td>
                    <!--count alle labore Element, egal wo -->
                    <xsl:value-of select="count(//labor)"/>
                </td>
                <td>
                    <!--count alle rechner Element, egal wo -->
                    <xsl:value-of select="count(//rechner)"/>
                </td>
                <td>
                    <!--rechner dividiert durch labor für durchschnitt  -->
                    <xsl:value-of select="count(//rechner) div count(//labor)"/>
                </td>
                <td>
                    <!--count alle software Element, egal wo -->
                    <xsl:value-of select="count(//software)"/>
                </td>
                <td>
                    <!--count alle scanner Element und drucker Element, egal wo -->
                    <xsl:value-of select="count(//scanner) + count(//drucker)"/>
                </td>
                <td>
                    <!--count alle unique hersteller Element, egal wo -->
                    <xsl:value-of
                        select="count(//hersteller[not(text() = (ancestor::hersteller/text() | preceding::hersteller/text()))])"
                    />
                </td>

            </tr>
        </table>
    </xsl:template>
    <!-- Statistik Template endet hier-->

    <!--Footer Template erstellen-->
    <xsl:template name="footer">
        <br/><br/><br/><br/><br/><br/><br/><br/><br/>
        <br/><br/><br/><br/><br/><br/><br/><br/><br/>
        <sup>©Monivan Mao, 2016 All Right Reserved</sup>
        <br/><br/>
    </xsl:template>
    <!--Footer Template endet hier-->

</xsl:stylesheet>
