# hack-or-emergency-response
This repository contains my Jupyter notebooks for exploring and working with Portland crime and Fire & Rescue Dept data as part of 
[Hack Oregon's](http://www.hackoregon.org/) 2016 data projects with the City of Portland. The notebooks use the Python 3.6 kernel.

For the crime data, I have imported [data](https://www.nij.gov/funding/pages/fy16-crime-forecasting-challenge.aspx#data) from the NIJ into Postgres on an Ubuntu environment using Vagrant. You can see my provision scripts [here](https://github.com/sky-t/hack-or-emergency-response/blob/master/provision_script.sh) and [here](https://github.com/sky-t/hack-or-emergency-response/blob/master/provision_script_vagrant.sh).

For the fire dispatch data, a sample dataset was provided by Portland Fire & Rescue to Hack Oregon's Emergency Response Team. This was also piped to PostgreSQL and queries run from Jupyter notebooks.

1) [Crime data EDA notebook](https://github.com/sky-t/hack-or-emergency-response/blob/master/NIJ%20EDA.ipynb)

2) [EDA on types of incidents in the incident table](https://github.com/sky-t/hack-or-emergency-response/blob/master/fire_dispatch_eda_incidents.ipynb)

3) [EDA on response time deltas on inctimes table]https://github.com/sky-t/hack-or-emergency-response/blob/master/fire_dispatch_eda_inctimes.ipynb)



I have also added some [notes](https://github.com/sky-t/hack-or-emergency-response/blob/master/database.md) on importing crime data into the EC2 db.
