# Splunk TA for evaluating OpenSCAP OVAL definitions from Red Hat and SuSE Enterprise Linux

This Splunk TA is meant as a reporting control for patch management on Red Hat and SuSE Enterprise Linux servers.
Both Red Hat and SuSE provide OVAL definitions that can be used to enumerate patched and unpatched vulnerabilities:
* [http://www.redhat.com/security/data/oval/](http://www.redhat.com/security/data/oval/)
* [https://support.novell.com/security/oval/](https://support.novell.com/security/oval/)

This is a work in progress, currently only the data collection is working.

## Prerequisites on every Universal Forwarder:

* openscap-utils 
* wget
* libxslt

## Installation

1. Install this Splunk TA on your deployment server:

````
cd $SPLUNK_HOME/etc/deployment-apps
git clone https://github.com/jorritfolmer/splunk_ta_oscap_oval.git
````

2. Edit the RHELOVAL and SLESOVAL urls in bin/oscap_oval.sh 

3. Mirror the Red Hat and SuSE OVAL files to a local webserver

````
wget -q https://support.novell.com/security/oval/suse.linux.enterprise.server.11.xml
wget -q http://www.redhat.com/security/data/oval/com.redhat.rhsa-all.xml
````


