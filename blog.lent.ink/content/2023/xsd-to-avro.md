---
title: "WDSL to XSD to avsc"
date: "2023-04-05"
draft: false
tags: ["coding"]
---

In this post we derive the schema from an XSD.
The
[package](https://github.com/databricks/spark-xml)
used also enables you to derive it from XML.

## WDSL

Get XSD from WDSL;
```
grep xs: input.wdsl > input.xml
```

## One schema

Check if there are more than one `schema` definitions;
```
grep '<xs:schema' input.xml
```
if there are more than one `schema` definitions and all are the same,
only keep the first opening tag and last closing tag,
all in the middle can go,
unifying it into one element.

## Format XSD

Make sure the format is correct;
```
apt install libxml2-utils
xmllint --format input.xml > xsd.xml
```

If this fails you likely need;
```
TMPFILE=/tmp/decoding.xml

echo '<wrapper>' > $TMPFILE
cat "$FILENAME" \
        | sed 's/^.*<RawData>//' \
        | sed 's_</RawData.*$__' \
        | base64 -d \
        >> $TMPFILE
echo '</wrapper>' >> $TMPFILE

xmllint --format $TMPFILE > xsd.xml
```

## Work env.

We will create a docker container with all tools in it;
```Dockerfile
FROM openjdk:21-jdk-bullseye

#RUN apt install -y openjdk-17-jdk-headless

WORKDIR /app
ENV SPARK_HOME=/opt/spark

RUN apt update \
  && apt install apt-transport-https curl gnupg -yqq \
  && echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" \
    | tee /etc/apt/sources.list.d/sbt.list \
  && echo "deb https://repo.scala-sbt.org/scalasbt/debian /" \
    | tee /etc/apt/sources.list.d/sbt_old.list \
  && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" \
    | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import \
  && chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg \
  && apt update \
  && apt install -y sbt gradle maven \
  && cd /tmp \
  && wget https://dlcdn.apache.org/spark/spark-3.3.2/spark-3.3.2-bin-hadoop3.tgz \
  && tar xvf *.tgz \
  && rm *.tgz \
  && mv spark-*/ /opt/spark \
  && echo "building from source to get the latest unreleased fix https://github.com/databricks/spark-xml/pull/631" \
  && git clone https://github.com/databricks/spark-xml.git \
  && cd /tmp/spark-xml \
  && sbt package \
  && mkdir -p /root/.ivy/jars \
  && mv target/scala*/spark-xml*.jar /root/.ivy/jars/com.databricks_spark-xml_2.12-0.16.0.jar \
  && cd /tmp \
  && rm -r /tmp/spark-xml \
  && wget https://archive.apache.org/dist/ws/xmlschema/2.3.0/xmlschema-2.3.0-source-release.zip \
  && unzip xmlschema*.zip \
  && rm *.zip \
  && mv xmlschema* $JAVA_HOME/lib/ \
  && ln -s /root/.ivy /root/.ivy2

ENTRYPOINT ["/opt/spark/bin/spark-shell", "--packages", "com.databricks:spark-xml_2.12:0.16.0,org.apache.spark:spark-avro_2.12:2.4.4,org.apache.ws.xmlschema:xmlschema-core:2.3.0"]

```

Start it;
```bash
docker build -t sbttest .
docker run --rm -it -v $PWD:/app sbttest
```

## XSD to avro

Now the [final](https://stackoverflow.com/questions/67281690/how-to-parse-xml-with-xsd-using-spark-xml-package) step;
```scala

import java.io.File;
import java.io.FileWriter;
import java.nio.file.Paths;
import org.apache.ws.commons.schema.XmlSchemaCollection;
import org.apache.ws._;
import com.databricks.spark.xml._;
import com.databricks.spark.xml.util.XSDToSchema;
import org.apache.spark.implicits._;
import com.databricks.spark.xml.schema_of_xml_array;
import java.nio.file.Files;
import com.databricks.spark.sqlContext.implicits._;
import org.apache.spark.sql.avro._;


val inputfile = "xsd.xml";
val outputfile = "out.avsc";
val schemaParsed = XSDToSchema.read(Paths.get(inputfile));
//System.out.println(schemaParsed);

//val df = spark.read.schema(schemaParsed).xml("test-data.xml");
//spark.read.schema(schemaParsed).format("com.databricks.spark.xml").option("rowTag","elementatt").option("rootTag","wrapper").load("test-data.xml").write.format("avro").save(outputfile);

//val outFile = new File(outputfile);
//val myWriter = new FileWriter(outputfile);
//myWriter.write(schemaParsed);
//myWriter.close();



val schemaParsed = schema_of_xml_array(Paths.get("test-data.xml"));
spark.read.schema(schemaParsed).format("com.databricks.spark.xml").option("rowTag","elementatt").option("rootTag","wrapper").load("test-data.xml");

val array_of_str = Files.readAllLines(Paths.get("test-data.xml"));
var dataset = org.apache.spark.sql.Dataset(array_of_str);
val schemaParsed = schema_of_xml_array(Files.readAllLines(Paths.get("test-data.xml")));

// identify the rootTag instead of a rowTag
val df = spark.read.option("rowTag","someInformation").xml("test-data.xml");
// since in this next step we will parse the whole set at once

// make sure the xml data is wrapped in '<wrapper> ... </wrapper>'
val one_row_df = spark.read.option("rowTag","wrapper").xml("wrapped-test-data.xml");
schema_of_xml(one_row_df[0].as[String])

val list_of_str = Files.readAllLines(Paths.get("test-data.xml"));
val payload_col = Seq(("payload", list_of_str.toArray().mkString("\n")));
val payload_df = payload_col.toDF();
val payloadSchema = schema_of_xml(payload_df.select("_2").as[String]);
val filled_df = spark.read.schema(payloadSchema).format("com.databricks.spark.xml").load("test-data.xml");
filled_df.write.format("org.apache.spark.sql.avro").save(outputfile);
to_avro(filled_df)

spark.read.schema(payloadSchema).format("com.databricks.spark.xml").option("rowTag","elementatt").option("rootTag","wrapper").load("test-data.xml").write.format("avro").save(outputfile);
spark.read.schema(payloadSchema).format("com.databricks.spark.xml").load("test-data.xml").write.format("org.apache.spark.sql.avro").save(outputfile);



```

Note that this might fail since
["support for XSDs is definitely not complete."](https://github.com/databricks/spark-xml/issues/477).


