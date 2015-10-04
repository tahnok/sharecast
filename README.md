# SHARECAST

Sharecast is a little web app that will turn an OPML file from a podcast client into a pretty page you can share with your buddies.

## SETUP

Sharecast depends on Redis to store the information about podcasts that have been shared. You can configure the server by setting the REDISCLOUD_URL environment variable

## HOW IT WORKS

Sharecast walks an opml file looking for urls, then fetches each of those urls so it can grab the album art. It uses REXML to parse the file, and it checks for the <itunes:image> tag to use as the cover art.

The url, the name and the cover image are stored as json objects in a json array and shoved into redis. The key is the md5 sum of the opml that was uploaded.

Some javascript checks the share page for a script tag that contains the podcasts json, and then builds out the grid

## License

Copyright (C) 2015 Wesley Ellis

Sharecast is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Sharecast is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

