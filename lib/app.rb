class App
    attr_accessor :activities
    
    def initialize
        @activities = []
    end

    # def run

    # end

    def run_normal
        loop do
            system 'clear'
            display_welcome
            puts "---" * 30
            display_menu
            select_menu
        end
    end

    def display_welcome
        puts "Welcome to:"
        puts "KICK THE BUCKET!!"
        puts "---" * 30
        puts "Your one stop destination for making"
        puts "10 POST COVID dreams come to life!"
        puts "---" * 30
    end

    # def display_menu

    # end

    # def select_menu

    # end

    def add_activity(activity_input)
        @activities << { activity: activity_input, ticked: false, }
    end

    def display_add_activity
        puts 'Enter your Bucket List Activity'
    end
end