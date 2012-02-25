--- 
title: Script Perl Edition de ID3 massive
---

Je le met là comme mémo, même si il ne sert jamais à personne dans son
intégralité.  C'est un script Perl qui m'a servit à renommé toute ma playlist
d'XMMS, dont les fichiers étaient sous forme `nn_cccc_cccc_ccc.mp3` (où nn est
un nombre et ccc_cccc_ccc le titre de la chanson). Le nom de l'auteur et
l'album sont des données fixes. Bien sûr, il y a sûrement mieux comme méthode
pour effectuer cette tâche, mais cela m'a permis d'en apprendre un peu plus sur
la programmation en langage Perl. La prochaine fois, j'essayerais en Python ;)

~~~ perl
#!/usr/bin/perl
use Xmms::Remote;
use MP3::Tag;

sub set_tag {
    my $file = shift @_;
    my $tag  = shift @_;
    my $mp3 = MP3::Tag->new($file);
    print Dumper $tag;
    my $tags = $mp3->get_tags();
    my $id3v2?

    if (ref $tags eq ''HASH'' && exists $tags->{ID3v2}) {
        $id3v2 = $tags->{ID3v2};
    }
    else {
        $id3v2 = $mp3->new_tag("ID3v2");
    }

    my %old_frames = %{$id3v2->get_frame_ids()};
    foreach my $fname (keys %$tag) {
        $id3v2->remove_frame($fname)
        if exists $old_frames{$fname};
        if ($fname eq ''WXXX''){
            $id3v2->add_frame(''WXXX'', ''ENG'', ''FreeDB URL'', $tag->{WXXX}) ;
        }
        elsif ($fname eq ''COMM'') {
            $id3v2->add_frame(''COMM'', ''ENG'', ''Comment'', $tag->{COMM}) ;
        }
        else {
            $id3v2->add_frame($fname, $tag->{$fname});
        }
    }

    $id3v2->write_tag();
    return 0;
}

$xmms_remote = Xmms::Remote->new();
@list = @{$xmms_remote->get_playlist_files};
foreach $el (@list){
    $orig = $el;
    $file_mp3 = MP3::Tag->new($el);
    $file_mp3->get_tags();
    if(!exists $file_mp3->{ID3v1}){
        #On prend que les fichiers qui n''ont pas de tags
    }
    if($el =~ /^[\/[a-z0-9_]+\/]*([0-9_]){2}_(.+)\.mp3$/i){
        $track_num = $1;
        $name = $2;
        @tmp = split(/_/,$name);
        $counter = 0;
        foreach $mot (@tmp){
            @tmp[$counter] = ucfirst($mot);
            $counter++;
        }
        $name = join(" ",@tmp);
        print $name . "\n";
        $artist = "Nobuo Uematsu";
        $album = "Final Fantasy X";
        $tags = {};
        $tags->{TIT2} = $name;
        $tags->{TPE1} = $artist;
        $tags->{TALB} = $album;
        $tags->{TRCK} = $track_num;
        set_tag($orig,$tags);
    }

    $count++;
}
~~~
