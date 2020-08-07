class Employee
    attr_reader :name, :salary, :title
    attr_accessor :boss

    def initialize(name, title, salary, boss = nil)
        @name = name
        @title = title
        @salary = salary
        @boss = boss

        if @boss
            @boss.add_direct_report(self)
        end
    end

    def bonus(multiplier)
        @salary * multiplier
    end
end

class Manager < Employee
    attr_reader :direct_reports    

    def initialize(name, salary, title, boss = nil)
        super(name, salary, title, boss)
        @direct_reports = []
    end

    def add_direct_report(employee)
        @direct_reports << employee
    end

    def bonus(multiplier)
        self.subsalaries * multiplier
    end

    def subsalaries
        total = 0
        self.direct_reports.each do |employee|
            if employee.is_a?(Manager)
                total += employee.salary + employee.subsalaries
            else
                total += employee.salary
            end
        end

        total
    end 
end

ned = Manager.new('Ned', 'Founder', 1000000)
darren = Manager.new('Darren', 'TA Manager', 78000, ned)
shawna = Employee.new('Shawna', 'TA', 12000, darren)
david = Employee.new('David', 'TA', 10000, darren)

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000