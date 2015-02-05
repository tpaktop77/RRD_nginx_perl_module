use RRDs;

sub GenerateZFS()
{

do "/usr/local/etc/scripts/rrd/__disklist2.pl";
do "/usr/local/etc/scripts/rrd/__periods.pl";


do "/etc/nginx/perl/lib/__da_graph_temp.pm";
do "/etc/nginx/perl/lib/__disk_read_graph.pm";

    my $localHtmlContent = "";

    GenerateImg__ZFS_Temp_Short();
#    GenerateImg__ZFS_Read_Short();

    $localHtmlContent = $localHtmlContent.$h->div( $_ );
    $localHtmlContent = $localHtmlContent.$h->div( { class => 'inline' },
        [
            $h->ul( $h->li( $h->a( { href => 'temp' }, $h->img( {src => 'http://cts.tpaktop.com/img_disk_all_temp_short.png' } )))) ,
            $h->ul( $h->li( $h->a( { href => 'read' }, $h->img( {src => 'http://cts.tpaktop.com/img_disk_read_short.png' } )))) ,
            $h->ul( $h->li( $h->a( { href => 'write' }, $h->img( {src => 'http://cts.tpaktop.com/img_disk_write_short.png' } )))) ,
            $h->ul( $h->li( $h->a( { href => 'busy' }, $h->img( {src => 'http://cts.tpaktop.com/img_disk_busy_short.png' } )))) ,
            $h->ul( $h->li( $h->a( { href => 'realloc' }, $h->img( {src => 'http://cts.tpaktop.com/img_disk_all_realloc_short.png' } )))), 
            $h->ul( $h->li( $h->a( { href => 'df' }, $h->img( {src => 'http://cts.tpaktop.com/img_poolsize_short.png' } )))) 
        ]
    );


    return $localHtmlContent;
}