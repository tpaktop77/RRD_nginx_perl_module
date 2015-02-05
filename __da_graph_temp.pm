#use RRDs;

#do "/usr/local/etc/scripts/rrd/__disklist2.pl";
#do "/usr/local/etc/scripts/rrd/__periods.pl";


sub GenerateImg__ZFS_Temp_Short()
{
    use constant pathRRDFiles => "/var/db/collectd/rrd/nasbox/hddtemp/";
    use constant pathWWWFiles => "/usr/local/www/cts/";

    my @timeData = localtime(time);
    my $minute   = $timeData[1];
    my $hour     = $timeData[2];

    my $iDrive  = 0;
    my $iPeriod = 0;

    $iPeriod = 5;

    my $periodName          = $periods[$iPeriod][0];
    my $periodDescription   = $periods[$iPeriod][1];

    my @DEF     = ();
    my @GRAPH   = ();
    my @array   = ();

    push @array,pathWWWFiles."img_disk_all_temp_".$periodDescription.".png";
    push @array,"--title=HDD temperature ".$periodDescription." ".localtime(time);
    push @array,"--imgformat=PNG";
    push @array,"--width=800";
    push @array,"--height=250";
    push @array,"--vertical-label=degree Celsius (C)";
    push @array,"--start=-".$periodName;
    push @array,"--end=now";
    push @array,"--rigid";
    push @array,"--slope-mode";
    push @array,"--upper-limit=60";
    push @array,"--lower-limit=0";
    push @array,"HRULE:60#FF0000::dashes";
    push @array,"HRULE:45#00AA00::dashes";
    push @array,"HRULE:30#00AA00::dashes";
    push @array,"HRULE:15#FF0000::dashes";
            
    for ($iDrive = 0; $iDrive < (int @drives); $iDrive++)
    {
#        my ee == "";

        my $driveName = $drives[$iDrive][$eDrivesName];
        my $driveColor = $drives[$iDrive][$eDrivesColor];
                
        push @DEF, "DEF:".$driveName."=".pathRRDFiles."temperature-".$driveName.".rrd:value:AVERAGE";
        push @GRAPH, "LINE1:".$driveName."#00008080:".$driveName.(" " x (5-length($driveName)));
        if ( $iDrive > 0 && (!($iDrive % 12)))
        {
            push @GRAPH, "COMMENT:\\n";
        }
    }

    push @array, @DEF;
    push @array, @GRAPH;
    push @array, "COMMENT:\\n";

    RRDs::graph(@array);

}

sub GenerateImg__ZFS_Temp_Details()
{

    for ($iPeriod = 0; $iPeriod < (int @periods); $iPeriod++)
    {
        # my $periodName          = $periods[$iPeriod][$ePeriodName];
        # my $periodDescription   = $periods[$iPeriod][$ePeriodDescription];
        my $periodName          = $periods[$iPeriod][0];
        my $periodDescription   = $periods[$iPeriod][1];

        if (
                (($iPeriod == 0) | ($iPeriod == 1) | ($iPeriod == 5)) |
                ($iPeriod == 2 && (($minute == 0) | ($minute == 15) | ($minute == 30) | ($minute == 45))) |
                ($iPeriod == 3 && $minute == 0) |
                ($iPeriod == 4 && $hour == 0 && $minute == 0)
            )
        {
            if ($iPeriod == 5)
            {
    # --- SHORT
                my @DEF     = ();
                my @GRAPH   = ();
                my @array   = ();

                push @array,"/gs/www/mrtg/img_disk_all_temp_".$periodDescription.".png";
                push @array,"--title=HDD temperature ".$periodDescription;
                push @array,"--imgformat=PNG";
                push @array,"--width=800";
                push @array,"--height=250";
                push @array,"--vertical-label=degree Celsius (C)";
                push @array,"--start=-".$periodName;
                push @array,"--end=now";
                push @array,"--rigid";
                push @array,"--slope-mode";
                push @array,"--upper-limit=60";
                push @array,"--lower-limit=0";
                push @array,"HRULE:60#FF0000::dashes";
                push @array,"HRULE:45#00AA00::dashes";
                push @array,"HRULE:30#00AA00::dashes";
                push @array,"HRULE:15#FF0000::dashes";

                for ($iDrive = 0; $iDrive < (int @drives); $iDrive++)
                {
                    my $driveName = $drives[$iDrive][$eDrivesName];
                    my $driveColor = $drives[$iDrive][$eDrivesColor];

                    push @DEF, "DEF:".$driveName."=/gs/www/mrtg/rrd_disk_".$driveName.".rrd:temp:AVERAGE";
                    push @GRAPH, "LINE1:".$driveName."#00008080:".$driveName.(" " x (5-length($driveName)));
                    if ( $iDrive > 0 && (!($iDrive % 12)))
                    {
                        push @GRAPH, "COMMENT:\\n";
                    }
                }

                push @array, @DEF;
                push @array, @GRAPH;
                push @array, "COMMENT:\\n";

                RRDs::graph(@array);

            }
            else
            {
                my @DEF     = ();
                my @GRAPH   = ();
                my @array   = ();

                push @array,"/gs/www/mrtg/img_disk_all_temp_".$periodDescription.".png";
                push @array,"--title=HDD temperature ".$periodDescription;
                push @array,"--imgformat=PNG";
                push @array,"--width=800";
                push @array,"--height=250";
                push @array,"--vertical-label=degree Celsius (C)";
                push @array,"--start=-".$periodName;
                push @array,"--end=now";
                push @array,"--rigid";
                push @array,"--slope-mode";
                push @array,"--upper-limit=60";
                push @array,"--lower-limit=0";
                push @array,"HRULE:60#FF0000::dashes";
                push @array,"HRULE:45#00AA00::dashes";
                push @array,"HRULE:30#00AA00::dashes";
                push @array,"HRULE:15#FF0000::dashes";

                for ($iDrive = 0; $iDrive < (int @drives); $iDrive++)
                {
                    my $driveName = $drives[$iDrive][$eDrivesName];
                    my $driveColor = $drives[$iDrive][$eDrivesColor];

                    push @DEF, "DEF:".$driveName."=/gs/www/mrtg/rrd_disk_".$driveName.".rrd:temp:AVERAGE";
                    push @GRAPH, "LINE1:".$driveName."#00008080:".$driveName.(" " x (5-length($driveName)));
                    push @GRAPH, "GPRINT:".$driveName.":MIN: Min\\:%2.0lf %s";
                    push @GRAPH, "GPRINT:".$driveName.":MAX: Max\\:%2.0lf %s";
                    push @GRAPH, "GPRINT:".$driveName.":AVERAGE: Avrg\\:%2.0lf %s";
                    push @GRAPH, "GPRINT:".$driveName.":LAST: Last\\:%2.0lf %s";
                    push @GRAPH, "COMMENT:\\n";
                }

                push @array, @DEF;
                push @array, @GRAPH;
                push @array, "COMMENT:\\n";
                RRDs::graph(@array);


                for (my $iDrive = 0; $iDrive < (int @drives); $iDrive++) 
                {
                    my @DEF     = ();
                    my @GRAPH   = ();
                    my @array   = ();

                    my $driveName = $drives[$iDrive][$eDrivesName];

                    push @array,"/gs/www/mrtg/img_disk_".$driveName."_temp_".$periodDescription.".png";
                    push @array,"--title= ".$driveName." ".$periodDescription." temperature";
                    push @array,"--imgformat=PNG";
                    push @array,"--width=300";
                    push @array,"--height=100";
                    push @array,"--vertical-label=degree Celsius (C)";
                    push @array,"--start=-".$periodName;
                    push @array,"--end=now";
                    push @array,"--rigid";
                    push @array,"--slope-mode";
                    push @array,"--upper-limit=75";
                    push @array,"--lower-limit=0";

                    push @DEF, "DEF:".$driveName."=/gs/www/mrtg/rrd_disk_".$driveName.".rrd:temp:AVERAGE";
                    push @GRAPH, "LINE1:".$driveName."#004000";
                    push @GRAPH, "GPRINT:".$driveName.":MIN: Min\\: %2.0lf %s";
                    push @GRAPH, "GPRINT:".$driveName.":MAX: Max\\: %2.0lf %s";
                    push @GRAPH, "GPRINT:".$driveName.":LAST: Last\\: %2.0lf %s";
                    push @GRAPH, "GPRINT:".$driveName.":AVERAGE: Avrg\\: %2.0lf %s";
                    push @GRAPH, "HRULE:60#FF0000::dashes";
                    push @GRAPH, "HRULE:45#00AA0060::dashes";
                    push @GRAPH, "HRULE:30#00AA0060::dashes";
                    push @GRAPH, "HRULE:15#FF0000::dashes";

                    push @array, @DEF;
                    push @array, @GRAPH;
                    # push @array, "COMMENT:\\n";
                    RRDs::graph(@array);        
                }
            }
        }
    }
}