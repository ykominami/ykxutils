module Ykxutils
  class Bookmark
    attr_reader :groups

    class Group
      attr_reader :title, :url, :items

      def initialize
        @title = nil
        @url = nil
        @items = []
      end

      def ==(other)
        count = 0
        count += 1 unless @title == other.title
        count += 1 unless @url == other.url
        @items.each do |item|
          count += 1 unless item == other
        end
        count > 0 ? false : true
      end
    
      def set_title(title)
        @title = title
      end
  
      def set_url(url)
        @url = url
      end
  
      def add_item()
        @items << Item.new
      end
  
      def set_item_title(title)
        add_item if @items.size.zero?

        @items.last.set_title(title)
      end
  
      def set_item_url(url)
        @items.last.set_url(url)
      end
  
      def dump_tree
        puts "group title=#{@title}"
        puts "group url=#{@url}"
        @items.each do |item| item.dump_tree end
      end
    end
  
    class Item
      attr_reader :title, :url

      def ==(other)
        count = 0
        count += 1 unless @title == other.title
        count += 1 unless @url == other.url
        count > 0 ? false : true
      end

      def set_title(title)
        @title = title
      end
  
      def set_url(url)
        @url = url
      end
  
      def dump_tree
        puts "item title=#{@title}"
        puts "item url=#{@url}"
      end
    end
  
    class State
      def initialize
        @current_state = [:NONE, :DO_NOTHING]
  
        @state = { 
          NONE:{
            GROUP_START: [:GROUP_DEF_HEAD, :CREATE_GROUP],
            URL: [:ERROR, :DO_ERROR],
            BLANK: [:NONE, :DO_NOTHING],
            TITLE: [:ERROR, :DO_ERROR]
          },
          GROUP_DEF_HEAD: {
            GROUP_START: [:ERROR, :DO_ERROR],
            URL: [:ERROR, :DO_ERROR],
            BLANK: [:GROUP_DEF_HEAD, :DO_NOTHING],
            TITLE: [:GROUP_DEF_HEAD_TITLE, :SET_GROUP_TITLE]
          },
          GROUP_DEF_HEAD_TITLE: {
            GROUP_START: [:ERROR, :DO_ERROR],
            URL: [:GROUP_ITEM_DEF_HEAD, :SET_GROUP_URL],
            BLANK: [:GROUP_DEF_HEAD_TITLE, :DO_NOTHING],
            TITLE: [:ERROR, :DO_ERROR],
          },
          GROUP_ITEM_DEF_HEAD: {
            GROUP_START: [:GROUP_DEF_HEAD, :DO_GROUP_DEF_END_AND_CREATE_GROUP],
            URL: [:ERROR, :DO_ERROR],
            BLANK: [:GROUP_ITEM_DEF_HEAD, :DO_NOTHING],
            TITLE: [:GROUP_ITEM_DEF_TITLE, :SET_GOUP_ITEM_TITLE]
          },
          GROUP_ITEM_DEF_TITLE: {
            GROUP_START: [:ERROR, :DO_ERROR],
            URL: [:GROUP_ITEM_DEF_HEAD, :SET_GROUP_ITEM_URL],
            BLANK: [:GROUP_ITEM_DEF_TITLE, :DO_NOTHING],
            TITLE: [:ERROR, :DO_ERROR],
          }
        }
  
        def next_state(token)
          # puts "@current_state=#{@current_state}"
          current_state = @current_state.first
          @current_state = @state[current_state][token]
        end
     end
    end
  
    def initialize(infile: nil, outfile: nil)
      @infile = infile
      @outfile = outfile
      @lines = File.readlines(@infile) if infile
      @line_index = 0
  
      @state = State.new
      @groups = []
      @current_group = nil
    end
  
    def ==(other)
      count = 0
      mine_size = @groups.size
      other_size = other.groups.size
      diff_size = mine_size - other_size
      if diff_size.positive?
        count += diff_size

        other_size.times{|index|
          count += 1 unless @groups[index] == other.groups[index]    
        }
      elsif diff_size.negative?
        count += -diff_size

        mine_size.times{|index|
          count += 1 unless @groups[index] == other.groups[index]
    
        } 
      else
        other_size.times { |index|
          count += 1 unless @groups[index] == other.groups[index]
        }
      end

      (count > 0)
    end

    def add_group
      @groups << Group.new
    end
  
    def set_group_title(title)
      @groups.last.set_title(title)
    end
  
    def set_group_url(url)
      @groups.last.set_url(url)
    end
  
    def add_item
      @groups.last.add_item
    end
      
    def set_item_title(title)
      @groups.last.set_item_title(title)
    end
  
    def set_item_url(url)
      @groups.last.set_item_url(url)
    end
  
    def next_token
      return [:END, nil] if @line_index >= @lines.size
  
      line = @lines[@line_index]
      @line_index += 1
   
      line.chomp!

      case line
      when /^#/
        [:GROUP_START, line]
      when /^https/
        [:URL, line]
      when /^\s*$/
        [:BLANK, line]
      else
        [:TITLE, line]
      end
    end
  
    def parse
      while (token = next_token).first != :END
        # puts "----====="
        # puts "token=#{token}"
        # puts ""
        state = @state.next_state(token.first)
        # puts ""
        # puts "state=#{state.first}"
        # puts "action=#{state.last}"
        # puts "----"

        action = state.last
        case action
        when :CREATE_GROUP
          # puts "## add_group"
          add_group
        when :SET_GROUP_TITLE
          # puts "### set_group_title"
          set_group_title(token.last)
        when :SET_GOUP_ITEM_TITLE
          # puts "#### set_item_title"
          set_item_title(token.last)
        when :SET_GROUP_URL
          # puts "##### A1 set_group_url"
          set_group_url(token.last)
          # puts "##### A2 add_item"
          # add_item
        when :DO_GROUP_DEF_END_AND_CREATE_GROUP
          # puts "####### add_group"
          add_group
        when :SET_GROUP_ITEM_URL
          # puts "######## C1 set_item_url"
          set_item_url(token.last)
          # puts "######## C2 add_item"
          # add_item
        when :DO_ERROR
          raise
        when :DO_NOTHING
          #
        else
          # puts "Can't find #{action}"
          raise
        end
      end
    end
  
    def to_array_2d
      head = ["title", "url"]
      @groups.map { |group|
        group_row = [group.title, group.url]
        item_rows = group.items.map{| item |
          ["#{group.title}>#{item.title}", item.url]
        }
        item_rows.unshift( group_row)
      }.flatten(1)
    end

    def dump_tree
      @groups.each do |group| group.dump_tree end
    end
  end
end
