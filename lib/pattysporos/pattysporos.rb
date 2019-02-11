class Building 
  attr_accessor :id, :name, :address, :height, :construction_date, :architect
  def initialize(input_options)
    @id = input_options['id']
    @name = input_options['name']
    @address = input_options['address']
    @height = input_options['height']
    @construction_date = input_options['construction_date']
    @architect = input_options['architect']
  end

  def self.all
    response = HTTP.get("http://localhost:3000/api/buildings")
    buildings = response.parse
    obj_buildings = []

    buildings.each do |building|
      obj_buildings << Building.new(building)
    end

    obj_buildings
  end

  def self.create(input_options)
    response = HTTP.post("http://localhost:3000/api/buildings", 
                         form: input_options
                        )
    building = response.parse
    new_obj = Building.new(building)
    new_obj
  end

  def self.find(building_id)
    response = HTTP.get("http://localhost:3000/api/buildings/#{ building_id }")
    building = response.parse
    building_obj = Building.new(building)
    building_obj
  end

  def update(params_hash)
    response = HTTP.patch(
                          "http://localhost:3000/api/buildings/#{id}", 
                          form: params_hash
                          )
  end

  def destroy
    response = HTTP.delete("http://localhost:3000/api/buildings/#{id}")
  end
end