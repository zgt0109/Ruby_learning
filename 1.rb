class Test
  def pro
    p "pro"
  end
  protected :pro
  def pub
    p "pub function"
  end
  public :pub

  private
    def pri
      p "private function"
    end
end

t = Test.new
t.pub
t.pri
