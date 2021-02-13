class PassengerTrain < Train
  TYPE = :passenger
   def initialize(number)
     super(number, TYPE)
   end
end   
