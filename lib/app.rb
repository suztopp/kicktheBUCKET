require 'json'
require 'artii'
require 'progress_bar'
require 'tty-prompt'
require 'colorize'
require 'csv'

$activities = []                        #global

class Activities

    attr_accessor :activity_name, :time_needed, :activity_reason, :ticked
    def initialize (activity_name, time_needed, activity_reason)
        @activity_name = activity_name
        @time_needed = time_needed
        @activity_reason = activity_reason
        @ticked = false                        #starts each instance of activity as FALSE - not ticked off - so it can be changed as they do them
    end

end

class App

    def initialize
        @bar = ProgressBar.new(100, :bar, :percentage)
        @prompt = TTY::Prompt.new
    end

    # def run

    # end

    def run_normal
        loop do
            display_welcome
            puts "---" * 40
            display_menu
        end
    end

    def menu_selector(option_select)
        system 'clear'

        case option_select
        when 1
            until $activities.length == 3 do
                system 'clear'
                display_add_activity
            end
            system 'clear'
            puts "---" * 30
            puts "---" * 30
            a = Artii::Base.new
            puts a.asciify('OPTIONS').green.on_black
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
            puts 'Enter Your Number Choice Below for ACTIVITY TO EDIT'
            index = select_activity

            edit_activity(build_activity ,index)
            system 'clear'
            a = Artii::Base.new
            puts a.asciify('OPTIONS').green.on_black
            puts "---" * 30
            display_menu
            #edit activities
        when 4
            display_activities
            puts 'Enter Your Number Choice Below for ACTIVITY TO TICK OFF YOUR LIST'
            index = select_activity
            ticked_off(index)
            puts "#{index+1}. Activity: #{$activities[index].activity_name} is now TICKED OFF WOO!!!!!!!!!"
            puts "---" * 30
            display_menu
            #marked activities ticked
        when 5
            progress_bar
            puts "---" * 30
            display_menu
            #see ticked progress
        when 6
            a = Artii::Base.new
            puts a.asciify('GO LIVE YOUR LIFE!').green
            exit 
        end
    end

    def display_welcome
        puts "Welcome to:"
        a = Artii::Base.new
        puts a.asciify('KICK THE BUCKET!!').green.on_black
        bucket_logo
        puts "---" * 30
        puts "Your one stop destination for making"
        puts "10 POST COVID dreams come to life!"
        puts "---" * 30
    end

    def display_menu
        input = @prompt.select('BUCKET OPTIONS:') do |menu|
            menu.choice 'Set Up Your 10 Activities', 1
            menu.choice 'View Your Activities List', 2
            menu.choice 'Edit Your Activities', 3
            menu.choice 'Mark Activities as TICKED OFF', 4
            menu.choice 'See Your Ticked Progress', 5
            menu.choice 'EXIT to REAL LIFE', 6
        end
        menu_selector(input)
        puts "---" * 30
    end

    def build_activity
        puts "---" * 30
        a = Artii::Base.new
        puts a.asciify('ACTIVITY INFO').green.on_black

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
        $activities <<  activity                #push new instances of activity into Activities array
    end

    def display_activity(activity,index)
        puts "#{index+1}. Activity: #{activity.activity_name} - Time Needed: #{activity.time_needed} - Reason: #{activity.activity_reason} - Ticked Off?: [#{activity.ticked ? 'TICKED' : ' '}]"
    end

    def display_activities
        a = Artii::Base.new
        puts a.asciify('BUCKET ACTIVITIES').green.on_black
        
        for i in 0...$activities.length                     #index 0 to last index including
            display_activity($activities[i],i)              #uses display_activity method to output each index for the Activities array, along with details
        end
    end

    def edit_activity(edited_activity, index)
        $activities[index] = edited_activity
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
        puts a.asciify('ACTIVITY PROGRESS').green.on_black
        bar = ProgressBar.new(100, :bar, :percentage)
        bar.puts "YOU CAN DO IT!!!!!!!!!!!!!"
        number = $activities.count {|activity| activity.ticked}
        number.times do
            sleep 0.1
            bar.increment! 10
        end
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