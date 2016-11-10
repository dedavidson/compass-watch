# Compass "watch" docker container

Based on https://github.com/antonienko/compass-watch-docker-container but using Alpine Linux instead of Ubuntu.

The purpose is to compile sass or scss files using the [compass open-source CSS Authoring Framework](http://compass-style.org/)

Developed as an addition to [Docker4Drupal](http://docker4drupal.org/) and intended to be left running on your development machine, so every changes to sass sources, CSS will be compiled to the output folder you configure in the __config.rb__ file.

## How to use this image

### Setup

First, you need to configure your folders in a __config.rb__ file, placed on the sass root folder. Here's an example folder structure, and its corresponding __config.rb__ file.

_Folder structure_:

    /src
      /compass
        /sass
        config.rb
      /app
      /public
        /css

_config.rb file_:

    # Require any additional compass plugins here.
    
    #Folder settings
    css_dir = "../public/css"          #where the CSS will saved
    sass_dir = "sass"           #where our .scss files are
    images_dir = "../public/img"    #the folder with your images
    
    # You can select your preferred output style here (can be overridden via the command line):
    output_style = :expanded # After dev :compressed
    
    # To disable debugging comments that display the original location of your selectors. Uncomment:
    line_comments = true
    
    # Obviously
    preferred_syntax = :scss

### Manual Compilation_
    docker run -v $(pwd):/src dedavidson/compass-watch compile /src/some-folder/another-folder --force

### Watching for Changes_

#### Using _docker run_
    docker run -d -v /src:/src dedavidson/compass-watch watch --poll /src/compass

#### Using _docker compose_

    compass:
      build: dedavidson/compass-watch
      command: watch --poll /src/compass
      volumes:
        - /src:/src