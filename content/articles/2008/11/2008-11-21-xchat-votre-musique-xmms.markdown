--- 
title: "Xchat : Votre musique XMMS !"
---

Voici un petit script écrit en Perl qui affiche en tant qu'emote (/me) votre
musique en cours de lecture sur XMMS. Pour l'installer, téléchargez-le (lien
en bas de la page), placez le dans un répertoire (genre `~/.xchat2/` chez
moi), lancez Xchat. Allez dans **Fenêtre -> Greffons et scripts**. Cliquez sur
**Charger**, puis sélectionnez votre script. C''est bon =). Pour l'utiliser,
tapez /kxmms dans le canal où vous souhaitez afficher votre musique. Voici le
[lien de
téléchargement](http://devellinux.free.fr/pub/scripts/xchat2/kxmms.pl).

~~~ perl
use POSIX qw(ceil floor);
use Xmms::Remote;
use MP3::Tag;
#------------- XCHAT VARIABLES
$script_name = "KXMMS";
$script_version = "0.1";
$script_creator = "Kizlum";
$script_homepage = "http://devellinux.free.fr";
$script_command = "kxmms";

#------------- XCHAT LOAD UP
Xchat::register($script_name, $script_version);
Xchat::hook_command($script_command, "kxmms_handler");
Xchat::printf($script_name . "v" . $script_version . " by " . $script_creator . " successfully loaded. Use /" . $script_command . ".");

#------------- FUNCTIONS
sub get_xmms_tags{
    $xmms_remote = Xmms::Remote->new();
    $position = $xmms_remote->get_playlist_pos;
    #On recupere le nom de fichier correspondant
    $file_name = $xmms_remote->get_playlist_file($position);

    #On creer un nouveau fichier mp3
    $file_mp3 = MP3::Tag->new($file_name);

    #On charge les tags presents dans le fichier MP3
    $file_mp3->get_tags();

   #Creation d''un tableau qui va contenir les tags
   $tags = {};

   #Si il existe des infos ID3V1, alors on les exploites
   if(exists $file_mp3->{ID3v1}){
        my $id3v1 = $file_mp3->{ID3v1}; #On recupere les tags dans la variable id3v1
        #On remplit la variable $tags avec les infos des tags
        $tags->{COMM} = $id3v1->comment();
        $tags->{TIT2} = $id3v1->song();
        $tags->{TPE1} = $id3v1->artist();
        $tags->{TALB} = $id3v1->album();
        $tags->{TYER} = $id3v1->year();
        $tags->{TRCK} = $id3v1->track();
        $tags->{TIT1} = $id3v1->genre();
    }
    return $tags;
}

sub get_avancement{
    $xmms_remote = Xmms::Remote->new();
    $position = $xmms_remote->get_playlist_pos;
    #On recupere le temps et l''avancement, on met le tout en pourcentages
    $current_time = $xmms_remote->get_output_time();
    $total_time = $xmms_remote->get_playlist_time($position);
    $avancement_percent = floor(($current_time*100)/$total_time);
    return $avancement_percent;
}

sub kxmms_handler{
    #On recupere les tags avec notre fonction
    $xmms_tags = get_xmms_tags();

    #On recupere l'avancement
    $xmms_avan = get_avancement();

    #On creer la chaine qui va etre ecrite
    $output_string = "ecoute [" . $xmms_tags->{TIT2} . "] interprete par [" . $xmms_tags->{TPE1} . "] extrait de l''album [" . $xmms_tags->{TALB} . "]. Avancement : [" . $xmms_avan . "%].";

    #On l''affiche en emote
    Xchat::commandf("me %s", $output_string);
}
~~~
