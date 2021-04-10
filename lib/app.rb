require 'artii'
require 'progress_bar'
require 'tty-prompt'
require 'colorize'
require 'csv'

$activities = []                        #global

class Activities

    attr_accessor :activity_name, :time_needed, :activity_reason, :ticked
    def initialize (activity_name, time_needed, activity_reason, ticked=false)
        @activity_name = activity_name
        @time_needed = time_needed
        @activity_reason = activity_reason
        @ticked = ticked                        #starts each instance of activity as FALSE - not ticked off - so it can be changed as they decide to change them
    end

end

class App

    def initialize
        @bar = ProgressBar.new(100, :bar, :percentage)
        @prompt = TTY::Prompt.new
        @file_name = 'data/bucket.csv'
    end

    def run
        if ARGV.empty?
            run_normal
        else    
            runargv
        end
    end

    def runargv
        first, *other = ARGV
        ARGV.clear
        case first
        when '--help'
            display_help
        else
            puts "Invalid Command Line Argument, only --help currently available, please try again (or just run ruby kickthebucket.rb) :)"
        end
    end

    def run_normal
        load_activities
        loop do
            display_welcome
            puts "---" * 30
            display_menu
        end
    end

    def menu_selector(option_select)
        system 'clear'

        case option_select
        when 1
            until $activities.length == 10 do
                system 'clear'
                display_add_activity
            end
            system 'clear'
            puts "BUCKET ACTIVITIES FULL AND READY TO BE DONE!!!!!".green.bold
            puts "---" * 30
            puts "---" * 30
            a = Artii::Base.new
            puts a.asciify('OPTIONS').green.bold
            display_menu
            #setup activity list
        when 2
            display_activities
            puts "---" * 30
            puts 'OPTIONS:'
            display_menu
            #view activity list
        when 3
            display_activities
            puts 'Enter Your Number Choice Below for ACTIVITY TO EDIT - only enter numbers between 1 and 10'
            index = select_activity
            while index < 0 || index > 10
                puts "Sorry that activity doesn't exist!  Please input a number from 1 to 10"
                index = select_activity
            end
            edit_activity(build_activity, index)
            system 'clear'
            puts "ACTIVITY SUCCESSFULLY UPDATED".green.bold
            a = Artii::Base.new
            puts a.asciify('OPTIONS').green.bold
            puts "---" * 30
            display_menu
            #edit activities
        when 4
            display_activities
            puts 'Enter Your Number Choice Below for ACTIVITY TO DELETE FOREVER!  - only enter numbers between 1 and 10'
            index = select_activity
            while index < 0 || index > 10
                puts "Sorry that activity doesn't exist!  Please input a number from 1 to 10"
                index = select_activity
            end
            delete_activity(index)
            system 'clear'
            puts "ACTIVITY DELETED FOREVER MWA HA HA HA".green.bold
            a = Artii::Base.new
            puts a.asciify('OPTIONS').green.bold
            puts "---" * 30
            display_menu
            #delete activity - added extra
        when 5
            display_activities
            puts 'Enter Your Number Choice Below for ACTIVITY TO TICK OFF YOUR LIST - only enter numbers between 1 and 10'
            index = select_activity
            while index < 0 || index > 10
                puts "Sorry that activity doesn't exist!  Please input a number from 1 to 10"
                index = select_activity
            end
            ticked_off(index)
            system 'clear'
            puts "#{index+1}. Activity: #{$activities[index].activity_name} is now TICKED OFF WOO!!!!!!!!!".green.bold
            puts "---" * 30
            display_menu
            #marked activities ticked
        when 6
            progress_bar
            puts "---" * 30
            display_menu
            #see ticked progress
        when 7
            save_activities                                             #call method below outlining how to save and where to
            a = Artii::Base.new
            puts a.asciify('GO LIVE YOUR LIFE!').green.bold
            puts "\u00A9 Copyright Suz Topp 2021".green
            puts " "
            exit 
        end
    end

    def display_welcome
        puts "Welcome to:"
        a = Artii::Base.new
        puts a.asciify('KICK THE BUCKET!!').green.bold
        bucket_logo
        puts "---" * 30
        puts "Your one stop destination for making"
        puts "10 POST COVID dreams come to life!"
        puts "---" * 30
    end

    def display_menu
        input = @prompt.select('BUCKET OPTIONS:') do |menu|
            menu.choice 'Set Up Your 10 Activities', 1
            menu.choice 'View Your Bucket Activities', 2
            menu.choice 'Edit Your Existing Activities', 3
            menu.choice 'Delete Your Activities Forever', 4
            menu.choice 'Mark Activities as TICKED OFF your list', 5
            menu.choice 'See Your Ticked Progress', 6
            menu.choice 'EXIT to REAL LIFE', 7
        end
        menu_selector(input)
        puts "---" * 30
    end

    def build_activity
        puts "---" * 30
        a = Artii::Base.new
        puts a.asciify('ACTIVITY INFO').green.bold

        print 'Enter your Dream Bucket List Activity:  '
        activity_name = gets.chomp
        while activity_name.empty?
            puts "You have to enter something here for it actually mean something buddy! Try again :)"
            activity_name = gets.chomp
        end

        print 'Enter the TIME GOAL for your Bucket List Activity (ie. one year, five years):  '
        time_needed = gets.chomp
        while time_needed.empty?
            puts "You have to enter something here for it actually mean something buddy! Try again :)"
            time_needed = gets.chomp
        end

        print 'Enter the REAL REASON you have chosen this Activity:  '
        activity_reason = gets.chomp
        while activity_reason.empty?
            puts "You have to enter something here for it actually mean something buddy! Try again :)"
            activity_reason = gets.chomp
        end

        activity = Activities.new(activity_name,time_needed,activity_reason)
    end

    # def input_fix                                                     #need to come back and fix this method to apply to above method
    #     while input.empty? do
    #         input = gets.chomp
    #         puts "You have to enter something here for it to actually mean something buddy! Try again :)"
    #     end
    # end

    def display_add_activity
        activity = build_activity
        $activities <<  activity                                        #push new instances of activity into Activities array
    end

    def display_activity(activity,index)
        puts "#{index+1}. Activity: " + "#{activity.activity_name} - Time Needed: #{activity.time_needed.green} - Reason: #{activity.activity_reason.green} - Ticked Off?: [#{activity.ticked ? 'TICKED' : ' '}]"
    end

    def display_activities
        a = Artii::Base.new
        puts a.asciify('BUCKET ACTIVITIES').green.bold
        
        for i in 0...$activities.length                     #index 0 to last index including
            display_activity($activities[i],i)              #uses display_activity method to output each index for the Activities array, along with details
        end
    end

    def edit_activity(edited_activity, index)
        $activities[index] = edited_activity
    end

    def delete_activity(index)
        $activities.delete_at(index)
    end

    def ticked_off(index)
        $activities[index].ticked = !$activities[index].ticked
    end

    def select_activity
        gets.to_i - 1
    end

    def progress_bar
        puts "---" * 30
        a = Artii::Base.new
        puts a.asciify('ACTIVITY PROGRESS').green.bold
        bar = ProgressBar.new(100, :bar, :percentage)
        bar.puts "YOU CAN DO IT!!!!!!!!!!!!!"
        number = $activities.count {|activity| activity.ticked}
        number.times do
            sleep 0.1
            bar.increment! 10
        end
    end

    def save_activities 
        column_header = ["activity_name","time_needed","activity_reason","ticked"]                                                          #create headers in csv to match keys
        CSV.open(@file_name, "w",:write_headers=>true,:headers=>column_header) do |csv|                                                     #opens my created (blank first time) csv file bucket.csv, and fills the headers via column set up
            for i in 0...$activities.length                                                                                                 #for each array in activities, push to csv
                csv << [$activities[i].activity_name,$activities[i].time_needed,$activities[i].activity_reason,$activities[i].ticked]       #pushes the $activities arrays in by index
            end
        end
    end

    def load_activities
        CSV.foreach(@file_name, headers: true) do |row|                                                                                     #when loading the csv for each row do
            ticked=row["ticked"]=="true"                                                                                                    #look for ticked in ticked, and convert to boolean true, else false
            $activities.push(Activities.new(row["activity_name"],row["time_needed"],row["activity_reason"],ticked))                         #telling ruby how to push the info into the array for each row
        end
    rescue Errno::ENOENT
        File.open(@file_name, "w")
        retry
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
        ".green.bold
    end

    def display_help
        puts " "
        puts "WELCOME TO THE KICK THE BUCKET HELP FILE".green.bold
        puts "FIRST THING - Installation"
        puts "Install

        1. Clone the Repo from GitHub - https://github.com/suztopp/kicktheBUCKET
        1. CD into kicktheBUCKET
        2. run in terminal - ./run_bucket.sh
        
        This will install the gem bundler, then install all the dependent gems, then run Kick the Bucket (ruby kickthebucket.rb - how to run if you don't need to install gems)
        "
        puts "What does this app do you might be asking yourself? Answer - It allows you to enter 10 Bucket Activities that you can check off over time."
        puts "HOW TO USE THE APP".green.bold
        puts "When opening the app for the first time you can use the handy dandy menu to navigate to the options"
        puts "SET UP YOUR 10 ACTIVITIES".green.bold
        puts "You run through the 10 entry options for your Bucket Activities.  Each item has a NAME, the TIME NEEDED (as a constant reminder of what you need to get done and when) and the" 
        puts "ACTIVITY REASON.  This is where you might put 'because COVID ruined everything and I miss travelling and my parents' or something of the like. These 10 Bucket Activities are"
        puts "then stored for all time for you to reference and tick off over time."
        puts "VIEW YOUR BUCKET ACTIVIIES".green.bold
        puts "You can use this option to look at your list any time you want after setup.  The Activities will be saved on exit each time you use the app."
        puts "EDIT YOUR EXISTING ACTIVITIES".green.bold
        puts "If you select edit, you will be presented with the full Activities list again.  You can select an item with it's line number (simply type in '2' for instance) and you will be"
        puts "taken to the Activity setup page again, enter info for each section again and then it will return you to the menu.  View Activities to see your changed entry."
        puts "DELETE YOUR ACTIVITIES".green.bold
        puts "You can delete an entry with this menu option, using the same technique as edit.  Type in the number of the Activity and it will be deleted forever."
        puts "MARK YOUR ACTIVITES AS TICKED OFF YOUR LIST".green.bold
        puts "As you physically complete the Activities in real life, you can change them to TICKED OFF in your Activities list in Kick The Bucket.  You can use this to keep tabs on where"
        puts "you're at and how much you have left to get done."
        puts "SEE YOUR TICKED PROGRESS".green.bold
        puts "This one is a cool one!  If you select this option you can see a Percentage Progress Bar with your list progress, use this as motivation for getting things done!"
        puts "EXIT TO REAL LIFE".green.bold
        puts "This one if self explanatory, select it when you're done and to head out there and TICK OFF YOUR LIFE GOALS!"
        puts " "
        exit
    end
end