# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Ring.instance.position(22.5,52.2)
#lt = Ring.instance.latitude
#lg = Ring.instance.longitude
#
#creatures = Creature.create([{name: 'Creatuer1', latitude: lt, longitude: lg, has_ring: 1}, {name: 'Creatuer2', latitude: lt, longitude: lg}])

Ring.create(name: "Precious", latitude: 22.5, longitude: 52.2, updated_by: -1)