<p:pipeline version='1.0' xmlns:p="http://www.w3.org/ns/xproc"
            xmlns:db="http://docbook.org/ns/docbook">
<p:serialization port="result" method="xhtml"/>

<p:xinclude/>

<p:choose>
  <p:when test="/db:slides">
    <p:xslt>
      <p:input port="stylesheet">
        <p:document href="dbslides.xsl"/>
      </p:input>
    </p:xslt>
  </p:when>
  <p:otherwise>
    <p:xslt>
      <p:input port="stylesheet">
        <p:document href="exercises.xsl"/>
      </p:input>
    </p:xslt>
  </p:otherwise>
</p:choose>

</p:pipeline>
