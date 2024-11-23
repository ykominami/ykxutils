RSpec.describe Ykxutils::Bookmark do
  # 有効なグループ定義の記述
  context 'with 1 valid group definition' do
    input_file = 'd2.txt'
    data_dir_pn = Pathname.new(__FILE__).join('../../test_data/bookmark')
    inputfile = data_dir_pn.join("d2.txt")
    file_pn = data_dir_pn.join(inputfile)
    bm = Ykxutils::Bookmark.new(infile: file_pn)
    bm.parse
    bm_ex = Ykxutils::Bookmark.new
    bm_ex.add_group 
    bm_ex.set_group_title("Ab") 
    bm_ex.set_group_url("https://d")
    bm_ex.add_item
    bm_ex.set_item_title("Ab>cd") 
    bm_ex.set_item_url("https://d/1")
    bm_ex.add_item
    bm_ex.set_item_title("Ab>ef") 
    bm_ex.set_item_url("https://d/2")
    
    it 'Group x 1, Item x 2' do
      p "bm="
      p bm
      p "bm_ex="
      p bm_ex
      expect(bm).to eq(bm_ex)
    end
  end 

  # 2個の有効なグループ定義の記述
  context 'with Group 1 , Item 2, Group 1 , Item 2' do
    input_file = 'd3.txt'
    data_dir_pn = Pathname.new(__FILE__).join('../../test_data/bookmark')
    inputfile = data_dir_pn.join("d3.txt")
    file_pn = data_dir_pn.join(inputfile)
    bm = Ykxutils::Bookmark.new(infile: file_pn)
    bm.parse
    bm_ex = Ykxutils::Bookmark.new
    bm_ex.add_group 
    bm_ex.set_group_title("Ab") 
    bm_ex.set_group_url("https://d")
    bm_ex.add_item
    bm_ex.set_item_title("Ab>cd") 
    bm_ex.set_item_url("https://d/1")
    bm_ex.add_item
    bm_ex.set_item_title("Ab>ef") 
    bm_ex.set_item_url("https://d/2")

    bm_ex.add_group 
    bm_ex.set_group_title("Cd") 
    bm_ex.set_group_url("https://e")
    bm_ex.add_item
    bm_ex.set_item_title("Cd>cd") 
    bm_ex.set_item_url("https://e/3")
    bm_ex.add_item
    bm_ex.set_item_title("Cd>ef") 
    bm_ex.set_item_url("https://e/4")

    it 'Group x 1, Item x 2' do
      p "bm="
      p bm
      p "bm_ex="
      p bm_ex
      expect(bm).to eq(bm_ex)
    end
  end 
  # 0個の有効なグループ定義の記述
  context 'with empty line' do
    data_dir_pn = Pathname.new(__FILE__).join('../../test_data/bookmark')
    inputfile = data_dir_pn.join("d0.txt")
    file_pn = data_dir_pn.join(inputfile)
    bm = Ykxutils::Bookmark.new(infile: file_pn)
    bm.parse
    bm_ex = Ykxutils::Bookmark.new
    it 'empty lines' do
      p "bm="
      p bm
      p "bm_ex="
      p bm_ex
      expect(bm).to eq(bm_ex)
    end
  end
end