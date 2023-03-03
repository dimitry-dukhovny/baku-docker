# baku-docker
Dockerization of a [Baku](https://github.com/vladris/baku) blog generator by [Vlad Riscutia](https://github.com/vladris).

## Environment variables

| Name                | default     | Purpose                         |
|---------------------|-------------|---------------------------------|
| imagename           | baku        | docker image name               |
| EDITOR              | vi          | Text editor; ideally vi         |
| defaultblogdir      | ${HOME}/blog| path to the blog                | 
| blogdir             | *None*      | overwrite path to the blog      |
| defaultparms        | " -h"       | default parameter if none given |
| defaulttitle        | "My blog"   | default name of the blog        |
| defaultauthor       | "Dimitry"   | default blog author             |
| defaulturl          | "https://gnomon.securitystandard.org" | URL   |
| defaultdescription  | "Example description" | default description   |
| defaultstyle        | "dark.css"  | default CSS:  light or dark     |

## Usage

### Build the image or download one.

* Build...

`bash buildimage.sh`

* ...or pull.

`docker pull gnomon/baku-docker`

### Use the image

* Edit the environment file called `baku.env` .
* Make your first blog post.

  * `baku.sh "My first blog post"`
  * It will open your chose ${EDITOR} for you.
  * If your designated blog directory is blank, it will initialize the path for you.

