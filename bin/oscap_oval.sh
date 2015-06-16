#!/bin/bash

APPNAME=ta_oscap_oval
RHELOVAL=http://internal.web.server/oval/com.redhat.rhsa-all.xml
SLESOVAL=http://internal.web.server/oval/suse.linux.enterprise.server.11.xml

function mydeptest {
         if ! [ -x $(which oscap) ]; then >&2 echo "ERROR: please install oscap"; exit 1; fi
         if ! [ -x $(which xsltproc) ]; then >&2 echo "ERROR: please install xsltproc"; exit 1; fi
         if ! [ -x $(which wget) ]; then >&2 echo "ERROR: please install wget"; exit 1; fi
}

function mysleepdelay {
        sleep $(($RANDOM % 3600))
}

if [ -f /etc/redhat-release ]; then
        mydeptest
        mysleepdelay
        MYRESULTS=$(mktemp)
        MYOVAL=$(mktemp)
        wget -q -O $MYOVAL $RHELURL
        oscap oval eval --results $MYRESULTS $MYOVAL > /dev/null
        echo cve_id,cve_present
        xsltproc $SPLUNK_HOME/etc/apps/$APPNAME/default/rhel_ovalresults2csv.xsl $MYRESULTS |grep ^CVE | sort |uniq
        rm -f $MYRESULTS
        rm -f $MYOVAL
elif [ -f /etc/SuSE-release ]; then
        mydeptest
        mysleepdelay
        MYRESULTS=$(mktemp)
        MYOVAL=$(mktemp)
        wget -q -O $MYOVAL $SLESURL
        oscap oval eval --results $MYRESULTS $MYOVAL > /dev/null
        echo cve_id,cve_present
        xsltproc $SPLUNK_HOME/etc/apps/$APPNAME/default/sles_ovalresults2csv.xsl $MYRESULTS |grep ^CVE | sort |uniq
        rm -f $MYRESULTS
        rm -f $MYOVAL
else
        >&2 echo "ERROR: This doesn't seem to be Red Hat or Suse"
fi

