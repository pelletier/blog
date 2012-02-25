# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

require 'cgi'
require 'nanoc/cachebuster'

include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::XMLSitemap
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::CacheBusting

$render_time = Time.now
