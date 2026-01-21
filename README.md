# homeProfile
a dotfile profile manager with backups written in bash

sub-commands:

    help
        - get this help message

    new  <profile_name>
        - create a new profile

    edit <profile_name>
        - edit a profile config
        
    save <profile_name>
        - save a profile
    
    clear <profile_name>
        - deletes the currently saved profile
        - (Added because of a bug: https://github.com/xAEmiloetjex/homeProfile/issues/1#issue-3837962863)

    load <profile_name>
        - load a profile

    save_from <profile_name> <path>
        - save a profile from a specific directory

    load_to <profile_name> <path>
        - load a profile to a specific directory

    save_backup <profile_name> <backup_name> 
        - make a backup of a profile

    clear_backup <profile_name> <backup_name> 
        - deletes the backup

    load_backup <profile_name> <backup_name> 
        - load a backup of a profile

    diff_backup <profile_name> <backup_name> <diff_name>
        - make a diff between a backup and the currently loaded backup

    diff_backups <profile_name> <backup1_name> <backup2_name> <diff_name>
        - make a diff between 2 backups