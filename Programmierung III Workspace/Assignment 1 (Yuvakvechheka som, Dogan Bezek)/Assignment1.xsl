<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" 
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Laborinventar der Hochschule Bremerhaven</title>
                <link
                    href="https://fonts.googleapis.com/css?family=Open+Sans|Raleway"
                    rel="stylesheet"/>
                <style>
                        <!-- Font für das Document -->
                    body{
                        font-family: 'Raleway', sans-serif;
                        font-family: 'Open Sans', sans-serif;
                    }
                    table{
                        border: 0;
                        background-color: #f4f6df;
                    }
                    th{
                        font-weight: normal;
                    }
        
                </style>
            </head>
            <body>
                <xsl:element name="h1">Laborinventar der Hochschule Bremerhaven</xsl:element>
                <xsl:call-template name="content"/>
                <xsl:call-template name="overview"/>
                <xsl:call-template name="laborListe"/>
                <xsl:call-template name="software"/>
                <xsl:call-template name="softwaresorted"/>
                <xsl:call-template name="geräte"/>
                <xsl:call-template name="gerätesorted"/>
                <xsl:call-template name="hersteller"/>
                <xsl:call-template name="statistik"/>
            </body>
        </html>
    </xsl:template>
    
     <!-- Content Template für Inhaltsverzeichnis anlegen-->
    <xsl:template name="content">
        <h2>Inhaltsverzeichnis</h2>
        <p>1. <a href="#tbOverview">Labore</a>
        </p>
        
        <!-- Alle Labore im Inhaltverzeichnis anzeigen lassen -->
        <xsl:variable name="labor" select="//labor"/>
        <xsl:for-each select="$labor">
            <xsl:sort select="@name"/>
            
            <!--Erstellung der Links zu den Listen-->
            <p>1. <!-- Automatische Erhöhung der Nummern -->
                <xsl:number value="position()" format="1 "/>
                <a href="#tbOverview"><xsl:value-of select="@name"/></a>
            </p>
        </xsl:for-each>
        <p>2. 
            <a href="#tbLaborListe">LaborListe</a>
        </p>
        <p>3. 
            <a href="#tbSoftware">Softwareliste mit Infos</a>
        </p>
        <p>4. 
            <a href="#tbGeräte">Geräteliste mit Infos</a>
        </p>
        <p>5. 
            <a href="#tbHersteller">Herstellerliste</a>
        </p>
        <p>6. 
            <a href="#tbStatistik">Statistik</a>
        </p>
    </xsl:template>
    
    <!-- Overview template anlegen -->
    <xsl:template name="overview">
        <!-- Hinzufügen der Links -->
        <h2 id="tbOverview">Labore</h2>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Labor</th>
                <th>Raumnummer</th>
                <th>Rechner</th>
                <th>Betriebsystem</th>
                <th>Anschaffungsdatum</th>
                <th>Anwendungssoftware</th>
                <th>Beschreibung</th>
            </tr>
            <!--Jedes Labor nach doppelten Elementen durchsuchen -->
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
                            <xsl:value-of select="@key"/>
                        </td>
                        <td>
                            <xsl:value-of select="betriebssystem"/>
                        </td>
                        <td>
                            <xsl:value-of select="anschaffungsdatum"/>
                        </td>
                        <td>
                            <xsl:for-each select="anwendungssoftware">
                             <xsl:value-of select="self::node()"/>; 
                    </xsl:for-each>
                        </td>
                        <td>Festplatte: <xsl:value-of
                                select="erweiterung/beschreibung/festplatte/@size"/>; Ram:
                                <xsl:value-of select="erweiterung/beschreibung/speicher/@size"/>;
                            Hersteller: <xsl:value-of select="erweiterung/beschreibung/hersteller"/>; <br/>
                            <xsl:value-of select="erweiterung/besonderheit"/>
                        </td>
                        <tr/>
                        <td/>
                        <td/>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
   
    <!--LaborListe Template erstellen-->
    <xsl:template name="laborListe">
        <h2 id="tbLaborListe">LaborListe</h2>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Labor</th>
                <th>Rechner</th>
            </tr>
            <!--Jedes Labor nach doppelten Elementen durchsuchen-->
            <xsl:for-each select="//rechner">
                <tr>
                    <td>
                        <xsl:value-of select="ancestor::labor/@name"/>
                    </td>
                    <td>
                        <xsl:value-of select="@key"/>
                    </td>
                </tr>
            </xsl:for-each>

        </table>
    </xsl:template>
    
    <!-- Software Template anlegen -->
    <xsl:template name="software">
        <h2 id="tbSoftware">Labor-Software Informationen</h2>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Labor</th>
                <th>Raumnummer</th>
                <th>Software</th>
                <th>Schlüssel</th>
                <th>Lizenz</th>
                <th>Hersteller</th>
                <th>Besonderheit</th>
            </tr>
            <!--Jedes Labor nach doppelten Elementen durchsuchen-->
            <xsl:for-each select="//labor">
                <tr>
                    <td>
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
                            <xsl:value-of select="@key"/>
                        </td>
                        <td>
                            <xsl:value-of select="@lizenz"/>
                        </td>
                        <td>
                            <xsl:value-of select="beschreibung/hersteller"/>
                        </td>
                        <td>
                            <xsl:value-of select="besonderheit"/>
                        </td>
                        <tr/>
                        <td/>
                        <td/>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <!--Softwaresorted Template anlegen-->
    <xsl:template name="softwaresorted">
        <h2 id="tbSoftwareSorted">Softwareliste</h2>
        <xsl:variable name="softwares"
            select="//software/@name"/>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Nummer</th>
                <th>Software</th>
            </tr>
            <xsl:for-each select="$softwares">
                <!--Sortierverfahren-->
                <xsl:sort select="."/>
                <xsl:element name="p">
                    <td>
                        <!-- Automatische Erhöhung der Nummern-->
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
    
    <!--Geräteliste Template anlegen-->
    <xsl:template name="geräte">
        <h2 id="tbGeräte">Geräte Informationen</h2>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Labor</th>
                <th>Raumnummer</th>
                <th>Model</th>
                <th>Hersteller</th>
                <th>Besonderheit</th>
            </tr>
            <!--Jedes Labor nach doppelten Elementen durchsuchen-->
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
                            <xsl:value-of select="besonderheit"/>
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
                            <xsl:value-of select="besonderheit"/>
                        </td>
                        <tr/>
                        <td/>
                        <td/>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <!--Gerätesorted Template anlegen-->
    <xsl:template name="gerätesorted">
        <h2 id="tbGeräteSorted">Geräteliste</h2>
        <xsl:variable name="gerätes"
            select="//model[not(text() = (ancestor::model/text() | preceding::model/text()))]"/>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Nummer</th>
                <th>Model</th>
            </tr>
            <xsl:for-each select="$gerätes">
                <!--Sortierverfahren-->
                <xsl:sort select="."/>
                <xsl:element name="p">
                    <td>
                        <!--Automatische Erhöhung der Nummern-->
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
    
    <!--Herstellerliste Template anlegen-->
    <xsl:template name="hersteller">
        <h2 id="tbHersteller">Hersteller</h2>
        <xsl:variable name="hersteller"
            select="//hersteller[not(text() = (ancestor::hersteller/text() | preceding::hersteller/text()))]"/>
        <table>
            <tr bgcolor="#2196F3" style="color:white">
                <th>Nummer</th>
                <th>Hersteller</th>
            </tr>
            <xsl:for-each select="$hersteller">
                <!--Sortierverfahren-->
                <xsl:sort select="."/>
                <xsl:element name="p">
                    <td>
                        <!--Automatische Erhöhung der Nummern-->
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
    
    <!-- Statistik Template anlegen-->
    <xsl:template name="statistik">
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
                    <!--Aufzählen ALLER labor Elemente-->
                    <xsl:value-of select="count(//labor)"/>
                </td>
                <td>
                    <!-- Aufzählen ALLER rechner Elemente -->
                    <xsl:value-of select="count(//rechner)"/>
                </td>
                <td>
                    <!-- Rechnerelemente/labor Elemente = durchschnitt -->
                    <xsl:value-of select="count(//rechner) div count(//labor)"/>
                </td>
                <td>
                    <!--Aufzählen ALLER software Elemente -->
                    <xsl:value-of select="count(//software)"/>
                </td>
                <td>
                    <!--Aufzählen ALLER scanner Elemente -->
                    <xsl:value-of select="count(//scanner) + count(//drucker)"/>
                </td>
                <td>
                    <!--Aufzählen ALLER unique hersteller Element -->
                    <xsl:value-of
                        select="count(//hersteller[not(text() = (ancestor::hersteller/text() | preceding::hersteller/text()))])"
                    />
                </td>
            </tr>
        </table>
    </xsl:template>
</xsl:stylesheet>