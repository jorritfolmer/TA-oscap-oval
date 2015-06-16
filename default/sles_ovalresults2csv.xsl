<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:oval="http://oval.mitre.org/XMLSchema/oval-common-5"
        xmlns:oval-res="http://oval.mitre.org/XMLSchema/oval-results-5" xmlns:oval-sc="http://oval.mitre.org/XMLSchema/oval-system-characteristics-5"
        xmlns:oval-def="http://oval.mitre.org/XMLSchema/oval-definitions-5" xmlns:apache-def="http://oval.mitre.org/XMLSchema/oval-definitions-5#apache"
        xmlns:ind-def="http://oval.mitre.org/XMLSchema/oval-definitions-5#independent" xmlns:windows-def="http://oval.mitre.org/XMLSchema/oval-definitions-5#windows"
        xmlns:unix-def="http://oval.mitre.org/XMLSchema/oval-definitions-5#unix" xmlns:linux-def="http://oval.mitre.org/XMLSchema/oval-definitions-5#linux">
        <xsl:output method="text" encoding="iso-8859-1"/>

        <xsl:key name="definition-index" use="@id" match="/oval-res:oval_results/oval-def:oval_definitions/oval-def:definitions/oval-def:definition"/>

        <!-- Gets the top level node -->
        <xsl:template match="oval-res:oval_results">
                                <xsl:for-each select="./oval-res:results/oval-res:system">
                                        <!-- display definition results -->
                                        <xsl:call-template name="DefinitionsResults">
                                                <xsl:with-param name="definitionsElm" select="./oval-res:definitions"/>
                                        </xsl:call-template>
                                </xsl:for-each>
        </xsl:template>
        <xsl:template name="DefinitionsResults">
                <xsl:param name="definitionsElm"/>
                        <!-- process true results -->
                        <xsl:for-each select="$definitionsElm/oval-res:definition[@result='true']">
                                <xsl:sort select="@id" data-type="text" order="descending"/>
                                <xsl:call-template name="Definition">
                                        <xsl:with-param name="definitionElm" select="."/>
                                </xsl:call-template>
                        </xsl:for-each>
                        <!-- process unknown results -->
                        <xsl:for-each select="$definitionsElm/oval-res:definition[@result='unknown']">
                                <xsl:sort select="@id" data-type="text" order="descending"/>
                                <xsl:call-template name="Definition">
                                        <xsl:with-param name="definitionElm" select="."/>
                                </xsl:call-template>
                        </xsl:for-each>
                        <!-- process error results -->
                        <xsl:for-each select="$definitionsElm/oval-res:definition[@result='error']">
                                <xsl:sort select="@id" data-type="text" order="descending"/>
                                <xsl:call-template name="Definition">
                                        <xsl:with-param name="definitionElm" select="."/>
                                </xsl:call-template>
                        </xsl:for-each>
                        <!-- process not evaluated results -->
                        <xsl:for-each select="$definitionsElm/oval-res:definition[@result='not evaluated']">
                                <xsl:sort select="@id" data-type="text" order="descending"/>
                                <xsl:call-template name="Definition">
                                        <xsl:with-param name="definitionElm" select="."/>
                                </xsl:call-template>
                        </xsl:for-each>
                        <!-- process false results -->
                        <xsl:for-each select="$definitionsElm/oval-res:definition[@result='false']">
                                <xsl:sort select="@id" data-type="text" order="descending"/>
                                <xsl:call-template name="Definition">
                                        <xsl:with-param name="definitionElm" select="."/>
                                </xsl:call-template>
                        </xsl:for-each>
                        <!-- process not applicable results -->
                        <xsl:for-each select="$definitionsElm/oval-res:definition[@result='not applicable']">
                                <xsl:sort select="@id" data-type="text" order="descending"/>
                                <xsl:call-template name="Definition">
                                        <xsl:with-param name="definitionElm" select="."/>
                                </xsl:call-template>
                        </xsl:for-each>
        </xsl:template>
        <xsl:template name="Definition">
                <xsl:param name="definitionElm"/>
                        <!-- title -->
                                <xsl:for-each select="key('definition-index', @definition_id)">
                                        <xsl:value-of select="oval-def:metadata/oval-def:title"/>
                                </xsl:for-each>
            <xsl:text>,</xsl:text>
                        <!-- result -->
                                <xsl:value-of select="$definitionElm/@result"/>
            <xsl:text>
</xsl:text>
        </xsl:template>
</xsl:stylesheet>

