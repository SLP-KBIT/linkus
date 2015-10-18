%w(CEM ETR GMV WSP).each do |group|
  Group.create(name: group)
end
