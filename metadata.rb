name             'ssl'
maintainer       'Wanelo, Inc.'
maintainer_email 'ops@wanelo.com'
license          'MIT'
description      'Installs/Configures ssl'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.2'

supports 'smartos'
supports 'ubuntu', '= 12.04'

depends 'build-essential'
depends 'paths'
