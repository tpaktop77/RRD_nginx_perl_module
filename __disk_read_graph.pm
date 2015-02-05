#!/usr/bin/perl -w
use RRDs;

do "/usr/local/etc/scripts/rrd/__disklist2.pl";
do "/usr/local/etc/scripts/rrd/__periods.pl";

my @timeData = localtime(time);
my $minute   = $timeData[1];
my $hour     = $timeData[2];

my $iDrive  = 0;
my $iPeriod = 0;

sub GenerateImg__ZFS_Read_Short()
{

    for ($iPeriod = 0; $iPeriod < (int @periods); $iPeriod++)
    {
    #    my $periodName          = $periods[$iPeriod][$ePeriodName];
    #    my $periodDescription   = $periods[$iPeriod][$ePeriodDescription];
    my $periodName          = $periods[$iPeriod][0];
    my $periodDescription   = $periods[$iPeriod][1];

        my @DEF     = ();
        my @GRAPH   = ();
        my @array   = ();

        push @array,"/gs/www/mrtg/img_disk_read_short.png";
        push @array,"--title=Disk read ".$periodDescription;
        push @array,"--imgformat=PNG";
        push @array,"--width=800";
        push @array,"--height=150";
        push @array,"--vertical-label=MegaBytes per second";
        push @array,"--start=-1d";
        push @array,"--end=now";
        push @array,"--rigid";
        push @array,"--slope-mode";
        push @array,"--lower-limit=0";
        
        for ($iDrive = 0; $iDrive < (int @drives); $iDrive++)
        {
            my $driveName = $drives[$iDrive][$eDrivesName];
            my $driveColor = $drives[$iDrive][$eDrivesColor];
            
            push @DEF, "DEF:".$driveName."read=/gs/www/mrtg/rrd/localhost/gstat-".$driveName."/gdisk_mbytes.rrd:read:AVERAGE";
            push @GRAPH, "LINE1:".$driveName."read#".$driveColor.":".$driveName.(" " x (5-length($driveName)));
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




GenerateImg__ZFS_Read_Details()        
{
        my @DEF     = ();
        my @GRAPH   = ();
        my @array   = ();

        push @array,"/gs/www/mrtg/img_disk_read_".$periodDescription.".png";
        push @array,"--title=Disk read ".$periodDescription;
        push @array,"--imgformat=PNG";
        push @array,"--width=800";
        push @array,"--height=150";
        push @array,"--vertical-label=MegaBytes per second";
        push @array,"--start=-".$periodName;
        push @array,"--end=now";
        push @array,"--rigid";
        push @array,"--slope-mode";
        # push @array,"--upper-limit=100";
        push @array,"--lower-limit=0";

        for ($iDrive = 0; $iDrive < (int @drives); $iDrive++)
        {
        
            
            my $driveName = $drives[$iDrive][$eDrivesName];
            my $driveColor = $drives[$iDrive][$eDrivesColor];
            
            push @DEF, "DEF:".$driveName."read=/gs/www/mrtg/rrd/localhost/gstat-".$driveName."/gdisk_mbytes.rrd:read:AVERAGE";
            push @GRAPH, "LINE1:".$driveName."read#".$driveColor.":".$driveName.(" " x (5-length($driveName)));
            push @GRAPH, "GPRINT:".$driveName."read:MIN: Min\\:%6.2lf MBytes";
            push @GRAPH, "GPRINT:".$driveName."read:MAX: Max\\:%6.2lf MBytes";
            push @GRAPH, "GPRINT:".$driveName."read:AVERAGE: Avrg\\:%6.2lf MBytes";
            push @GRAPH, "GPRINT:".$driveName."read:LAST: Last\\:%6.2lf MBytes";
            push @GRAPH, "COMMENT:\\n";
        }

        push @array, @DEF;
        push @array, @GRAPH;
        push @array, "COMMENT:\\n";
        RRDs::graph(@array);
        
}
