require 'resolv'

module Puppet::Parser::Functions
  newfunction(:dnslookup, :type => :rvalue) do |arguments|

    res = Resolv.new
    if arguments[0].nil?
      raise Puppet::ParseError, "Nothing to resolve given"
    end

    addresses = res.getaddresses(arguments[0]).collect { |r| r.to_s }
    if addresses.length == 0
      raise Puppet::ParseError, "Can not resolve hostname '#{arguments[0]}'"
    end
    return addresses
  end
end
