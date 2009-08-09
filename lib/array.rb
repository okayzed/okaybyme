class Array
  def pick_form
    ComplimentGenerator.parse_form(self.rand)
  end
end
