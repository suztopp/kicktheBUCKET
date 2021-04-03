class App
    attr_accessor :activities
    
    def initialize
        @activities = []
    end

    def run

    end

    def run_normal
        loop do
            system 'clear'
            display_welcome
            puts "---" * 30
            display_menu
            menu_selector(select_menu)
        end
    end

    def menu_selector(option_select)
        case option_select
        when 1
            #setup activity list
        when 2
            #view activity list
        when 3
            #edit activities
        when 4
            #marked activities ticked
        when 5
            #see ticked progress
        when 6
            #exit  
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

    def display_menu
        puts 'KICK THE BUCKET OPTIONS:'
        puts '1. Set Up Your 10 Activities'
        puts '2. View Your Activities List'
        puts '3. Edit Your Activites'
        puts '4. Mark Activities as TICKED OFF'
        puts '5. See Your Ticked Progress'
        puts '6. EXIT to REAL LIFE'
    end

    def select_menu
        gets.to_i
    end

    def add_activity(activity_input)
        @activities << { activity: activity_input, ticked: false, }
    end

    def display_add_activity
        puts 'Enter your Bucket List Activity'
    end

    def add_activity
        gets.strip
    end
end