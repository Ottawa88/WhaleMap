#!/bin/bash
# download live LFDCS detections, then process using R script

# Select app directory
DESTDIR=/srv/shiny-server/WhaleMap # server
#DESTDIR=/Users/hansenjohnson/Projects/WhaleMap # local

# initiate array
declare -A URL

# assign paths to detection data for each deployment
URL=(
	# live
	[2017-10-03_slocum_dal556]=http://dcs.whoi.edu/dal1017/dal1017_dal556_html/ptracks/manual_analysis.csv
	[2017-08-02_slocum_otn200]=http://dcs.whoi.edu/dal0817/dal0817_otn200_html/ptracks/manual_analysis.csv
	[2017-06-23_wave_crispusattucks]=http://dcs.whoi.edu/gom0717/gom0717_crispusattucks_html/ptracks/manual_analysis.csv
	[2016-09-28_buoy_nomans]=http://dcs.whoi.edu/nomans0916/dmon028_html/ptracks/manual_analysis.csv
	[2016-06-23_buoy_nybight]=http://dcs.whoi.edu/nyb0616/dmon009_html/ptracks/manual_analysis.csv		
)

# download data
for i in "${!URL[@]}"; do   	
	
	# define data directory
	DATADIR=${DESTDIR}/data/raw/dcs/live/${i}

	# make data directory
	mkdir -p ${DATADIR}

	# download glider detections
	wget -q -N ${URL[$i]} -P ${DATADIR}
		
done

# process data
( cd ${DESTDIR}; Rscript -e "source('update_live_dcs.R')" )