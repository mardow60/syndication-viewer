<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output encoding="UTF-8" method="html" />
    <xsl:variable name="articlePath">https://school.eb.com/levels/high/article//</xsl:variable>
    <xsl:variable name="assemblyPath">https://school.eb.com/levels/high</xsl:variable>
    <xsl:variable name="mediaPath">https://cdn.britannica.com/eb-media</xsl:variable>
    <xsl:template match="*">
        <span class="unknown">&lt;<xsl:value-of select="local-name()"/> Error: unkown element&gt;</span>
        <xsl:apply-templates />
        <span class="unknown">&lt;/<xsl:value-of select="local-name()"/>&gt;</span>
    </xsl:template>
    
    <xsl:template match="/article">
        <div id="content"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="title">
        <div id="title"><xsl:apply-templates/></div>
    </xsl:template>

    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="e[@type='smallcap']"><span class="smcaps"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="e[@type='itallic']"><em><xsl:apply-templates/></em></xsl:template>
    <xsl:template match="e[@type='bold']"><strong><xsl:apply-templates/></strong></xsl:template>
    <xsl:template match="e[@type='bolditalic']"><strong><em><xsl:apply-templates/></em></strong></xsl:template>
    <xsl:template match="e[@type='underline']"><span class="underline"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="e">
        <xsl:if test="descendant::text()">
            <em><xsl:apply-templates/></em>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="assembly">
        <xsl:variable name="imgpath" select="concat($mediaPath, @id)"/>
        <xsl:variable name="asmpath" select="concat($assemblyPath, @url)"/>
        <div class="assembly_med">
            <a href="{$asmpath}">
                <xsl:apply-templates select="media"/>
            </a>
            <div class="assembly_text">
                <xsl:apply-templates select="caption"/>
                <xsl:apply-templates select="credit"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="media">
        <xsl:variable name="imgpath" select="concat($mediaPath, @url)"/>
        <img src="{$imgpath}"/>
    </xsl:template>
    
    <xsl:template match="caption">
        <div class="caption"><xsl:apply-templates/></div>
    </xsl:template>

    <xsl:template match="credit">
        <div class="credit"><xsl:apply-templates/></div>
    </xsl:template>

    <xsl:template match="assemblyref">
        <xsl:if test="descendant::text()">
            <span class="assemblyref"><xsl:apply-templates/></span>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="xref">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="concat($articlePath, @articleid)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <xsl:template match="signature">
        <div class="author">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="copyright">
        <div id="copyright"><xsl:text>©2021 </xsl:text><xsl:apply-templates/></div>
    </xsl:template>
    
</xsl:stylesheet>