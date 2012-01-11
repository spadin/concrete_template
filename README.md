Concrete5 Package Template
==========================

A template for a Concrete5 package with some utilities that help with building 
CoffeeScript & LESS files. Plus a Rake build task that will compress the 
package into a zipfile for easy distribution.

Getting Started
---------------

Even though Concrete5 is a PHP CMS, this template uses some Rubygems for 
helping with the non-package specific tools. 

You will need:

  * Ruby 1.9.2
  * Rubygems
  * Bundler
  
### Bundle gems

    $ bundle install

### Building and packaging the project

    $ bundle exec rake build

### Running the CoffeeScript and LESS watcher

    $ bundle exec foreman start

Developing your package
-----------------------

You can develop your Concrete5 package as you normally would. Add your files to 
the directories that Concrete5 expects, including:

  * blocks
  * controllers
  * css
  * elements
  * images
  * js
  * models
  * single_pages
  * themes
  * tools

CoffeeScripts and LESS files should be added into the `lib/src` directory under 
the `js` or `css` directories respectively.

Configuring the build task
--------------------------

If you need to edit the way files are being packaged, take a look inside the 
`lib/tasks` directory. You may need to add your configuration in the 
`lib/tasks/config/build.yml` file.
