class CargoTrain < Train
  TYPE = :cargo
   def initialize(number)
     super(number, TYPE)
   end
end    
