class Factory
 def self.new *fields,&block
   raise ArgumentError, "wrong number of arguments" if fields.length < 1

   Class.new do
      fields.each  do |i|
      attr_accessor i
      end

     define_method :initialize do |*init_fields|
       init_fields.each_with_index do |val,index|
        instance_variable_set "@#{fields[index]}", val
       end
     end


      def [](key)
       return instance_variable_get(instance_variables[key]) if key.kind_of?(Integer)
       return self.send(key)
      end
      
      class_eval &block if block_given?
   end


  end
end
Customer = Factory.new(:name,:address,:age) do

  def greeting
    "Hello #{name}!"
  end
end
jo = Customer.new("jp","jo",23)
puts jo.name
puts jo["name"]
puts jo[:age]
puts jo.greeting
