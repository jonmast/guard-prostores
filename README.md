# Guard::Prostores

Watches for file changes and uploads files to ProStores

## Installation


Execute:

    $ gem install guard-prostores

Or add this line to your application's Gemfile:

    gem 'guard-prostores'

And then execute:

    $ bundle


Run `guard init prostores` to generate a Guardfile in the directory you would like to monitor.

Add your username and password to the Guardfile
Login to ProStores and go to Store Design/Page Template Manager and copy the address of the preview link (I recommend creating a new templateset).
The URL should look something like this:

http://store01.prostores.com/servlet/wholesomebookswholesale/Admin/SupportMgrTemplateSetPreview?tset=**storesense%3ATemplateSet%3A%2F%2Flocal%2F677560%3FTemplateSetID%3D126860%26Type%3D5**&smode=new

[Urldecode](http://meyerweb.com/eric/tools/dencoder/) the part in bold and put it in your guardfile

## Usage
Execute:

    $ guard

By default it watches for changes and if the file ends in css or js it uploads it. If it ends in tpl it will upload it to the template with that name. If you export the templates from ProStores they will have all the correct names.

If you have any problems please file an issue.