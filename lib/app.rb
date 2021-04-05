require 'json'
require 'artii'

class App
    attr_accessor :activities
    
    def initialize
        @activities = []
        # @file_path = file_path
        # load_data(file_path)
    end

    # def run

    # end

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
            until @activities.length == 10 do
                system 'clear'
                display_add_activity
            end 
            run_normal
            #setup activity list
        when 2
            system 'clear'
            display_activities
            # puts 'OPTIONS:'
            display_menu
            #view activity list
        when 3
            system 'clear'
            display_activities
            puts 'Enter Your Choice Below for ACTIVITY TO EDIT'
            index = select_activity
            display_add_activity
            edit_activity(add_activity, index)
            #edit activities
        when 4
            #marked activities ticked
        when 5
            #see ticked progress
        when 6
            # File.write(@file_path, @activities.to_json)
            exit  
        end
    end

    def display_welcome
        puts "Welcome to:"
        a = Artii::Base.new
        puts a.asciify('KICK THE BUCKET!!')
        # puts "KICK THE BUCKET!!"
        bucket_logo
        puts "---" * 40
        puts "Your one stop destination for making"
        puts "10 POST COVID dreams come to life!"
        puts "---" * 40
    end

    def display_menu
        puts 'KICK THE BUCKET OPTIONS:'
        puts '1. Set Up Your 10 Activities'
        puts '2. View Your Activities List'
        puts '3. Edit Your Activites'
        puts '4. Mark Activities as TICKED OFF'
        puts '5. See Your Ticked Progress'
        puts '6. EXIT to REAL LIFE'
        puts "---" * 40
        puts 'ENTER THE NUMBER OF YOUR CHOICE BELOW'
        puts "---" * 40
    end

    def select_menu
        gets.to_i
    end

    # def load_data(file_path)
    #     json_data = JSON.parse(File.read(file_path))
    #     @activities = json_data.map do |activity|
    #         activity.transform_keys(&:to_sym)
    #     end
    # end
    
    # def add_activity(activity_input)
    #     @activities << { activity: activity_input, time_needed: activity_input, activity_reason: activity_input, ticked: false, }
    # end

    def display_add_activity
        puts "---" * 40
        puts 'NEW ACTIVITY'
        print 'Enter your Dream Bucket List Activity:  '
        activity_name = gets.chomp
        print 'Enter the TIME GOAL for your Bucket List Activity (ie. one year, five years):  '
        time_needed = gets.chomp
        print 'Enter the REAL REASON you have chosen this Activity:  '
        activity_reason = gets.chomp
        @activities << [
            activity: activity_name,
            time: time_needed,
            reason: activity_reason,
            ticked: false
        ]
    end

    # def activity_info
    #     gets.strip
    # end

    def display_activities
        puts 'YOUR BUCKET LIST ACTIVITIES:'
        @activities.each_with_index do |activity, index|
            puts "#{index}. #{activity[:activity]}, #{activity[:time]}, #{activity[:reason]}, [#{activity[:ticked] ? 'TICKED' : ' '}]"
        end
    end

    def edit_activity(edited_activity, index)
        @activities[index][:activity] = edited_activity
    end

    def select_activity
        gets.to_i - 1
    end

    def bucket_logo
        puts "
            _______
        _.-()______)-._
      .'               '.
     |                   |
    |.--```---------```--.|
    (                     )
    :`--..._________...--`:
    :                     :
     :                   :
     :                   :
      :                 :
      :                 :
       :               :
       :               :
        :             :
        :_           _:
          '''-----'''
        "
    end
end