<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
		<html>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			<head>
			<title>Data Dictionary - Librabrary Management System</title>
			<link rel="stylesheet" href="style/css/base/jquery-ui.css"/>
			<link rel="stylesheet" href="style/css/ui-lightness/jquery-ui-1.10.4.custom.css"/>
			<link rel="stylesheet" type="text/css" href="style/dd_xslt.css"/>
			<script src="js/jquery-1.10.2.js"></script>
			<script src="js/jquery-ui-1.10.4.custom.min.js"></script>
			<script>
				$(function() {
					
					
					<xsl:for-each select="tables">
						<xsl:for-each select="table">
							<xsl:for-each select="@name">
								$("#<xsl:value-of select="."/>").dialog({
									 modal: true,
									buttons: {
										Ok: function() {
											$( this ).dialog( "close" );
										}
									},
									autoOpen: false,
									"width": 960,
								});

								$(".<xsl:value-of select="."/>_open").click(function() {
									$("#<xsl:value-of select="."/>").dialog(
										"open"
									);
								});
							</xsl:for-each>
						</xsl:for-each>
					</xsl:for-each>

					//alert('a');
				});


			</script>
			</head>
			<body>
				<span>
			

				</span>
				<xsl:for-each select="tables">
					<xsl:for-each select="table">
						<div class="table_name">
							<xsl:for-each select="@name">
								<xsl:value-of select="."/>
							</xsl:for-each>
							<span class="desc">
								<xsl:for-each select="@DESC">
									<xsl:value-of select="."/>
								</xsl:for-each>
							</span>
						</div>
						<div id="">
							<table class="Nisar">
							<tr>
								<td>Field</td>
								<td>ColumnName</td>
								<td>DataType</td>
								<td>Prec</td>
								<td>Cons</td>
								<td>Ref</td>
								<td>Coded</td>
								<td>Def</td>
								<td>Description</td>
							</tr>
							<xsl:for-each select="row">
							<tr>
							<td>
					 	   <xsl:choose>
						     <xsl:when test="system-property('xsl:vendor')='Transformiix'">
						       <xsl:for-each select="Field">
								<xsl:apply-templates />			
								</xsl:for-each>
						     </xsl:when>
						     <xsl:otherwise>
						      <xsl:for-each select="ColumnName">
								<script>
									document.write("<xsl:apply-templates />".replace(/([A-Z])/g, ' $1').replace(/^./, function(str){ return str.toUpperCase(); }));
								</script>			
								</xsl:for-each>
						     </xsl:otherwise>
						   </xsl:choose>
							</td>
							<td>
							<xsl:for-each select="ColumnName">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="DataType">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="Prec">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="Cons">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
								
							<xsl:for-each select="Ref">
								<span class="{.}_open">
							<xsl:apply-templates />
								</span>
							</xsl:for-each>
								
							</td>
							<td>
							<xsl:for-each select="Coded">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="Def">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="Description">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							</tr>
							</xsl:for-each>
							</table>
						</div>
						<br/>
					</xsl:for-each>
				</xsl:for-each>
				<xsl:for-each select="tables">
					<xsl:for-each select="table">
						<xsl:for-each select="@name">
						<div id="{.}" title="{.}">
							<table class="Nisar">
							<tr>
								<td>Field</td>
								<td>ColumnName</td>
								<td>DataType</td>
								<td>Prec</td>
								<td>Cons</td>
								<td>Ref</td>
								<td>Coded</td>
								<td>Def</td>
								<td>Description</td>
							</tr>
							<xsl:for-each select="../row">
							<tr>
							<td>
							<xsl:for-each select="Field">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="ColumnName">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="DataType">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="Prec">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="Cons">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="Ref">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="Coded">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="Def">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							<td>
							<xsl:for-each select="Description">
							<xsl:apply-templates />
							</xsl:for-each>
							</td>
							</tr>
							</xsl:for-each>
							</table>
						</div>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>