class ComplimentGenerator
  # A list of complement formats
  # Maybe it could even read a sentence and figure some on its own.
  #
  # Compliments
  # [Everyone] # [He/She] # [I] # [We]
  #   [believe(s)] # [think(s)]
  #     you are <adj>
  #     you are <adj> <noun> of <adj>
  #     You are a(n) <adj> <noun>
  # [You make]
  #   [me] # [everyone] # [others] # [him/her]
  #     [verb] in [state of being]
  #     [adjective]
  #
  # Intros:
  # [Did anyone ever tell you,]
  # [I overheard someone say that,]
  # [Did you know,]
  # [Sometimes, secretly, I think that,]
  # [I read a fortune cookie that said]
  #
  # Follow ups:
  # [it's true]
  # [i am not kidding]
  # [seriously. you are/do]
  # [i <verb> you.]

  FORMS =   [
              [:cause, :person, :adj_state],
              [:are, :adj_okay],
              [:are, :adj_mod, :adj],
              [:are, :adj_great],
              [:are, :adj_mod, :adj_great],
            ]
  INTROS =  [
              "But, ",
              "Did anyone ever tell you that ?",
              "Did you know that ?",
              "Earlier I was thinking about you and ",
              "I can't remember when I didn't think that ",
              "I forgot to mention it before, but ",
              "I hope I'm not repeating myself, but ",
              "In all sincerity, ",
              "I never got around to telling you, but ",
              "I overheard someone say that ",
              "Sometimes, I secretly think ",
              "Thinking about it, !",
              "This whole time, I've thought that ",
              "When I think about you, I think that ",
              [ "One day, ", :obj_tp_pl, "will realize that " ],

            ]

  FLAIR =
            [
              "^___^",
              "o_O",
              ";P",
              "<3",
              "d-(~_~)",
              "(^-^)v",
              ":-D",
              "<.<",
              ">.>",
            ]
  FOLLOWUPS =
            [
              "it's true",
              "no joke",
              "seriously",
              "i wouldn't lie to you",
              "trust me",
              "you know?",
              "you've inspired me",
              "you're my hero",
              [ "I ", :verb_i, "you."],
              [ "and ", :are, :adj, ", too!"],
              [ "and sometimes, ", :are, :adj_mod, :adj, ", too!"],
            ]

  OBJECTS_FP_SINGLE =
            [ "I", "We", "Others" ]
  OBJECTS_TP_PLURAL =
            [ "He", "She", "Everyone", "They" ]
  SUBJECTS =
            [ "me", "him", "her", "everyone", "others" ]
  VERBS_THINKING =
            [
              "think",
              "know",
              "believe",
              "can tell",
            ]

  ADJS_COOL = [
                "cool",
                "nice",
              ]
  ADJS_OKAY =
            [
              "all right",
              "fine",
#              "not bad",
              "okay",
            ]
  ADJS_GREAT =
            [
              "charming",
              "dandy",
              "great",
              "groovy",
              "keen",
              "neat",
              "nifty",
              "peachy",
              "superb",
              "swell",
            ]
  ADJS_MOD =
            [
              "super",
              "really",
              "very",
              "especially",
              "quite",
              "unusually",
              "totally",
              "mildly",
              "truly",
              "positively",
            ]

  ADJS_STATE =
            [
              "better",
              "happy",
              "jump with joy",
              [ :verb_feel, :adj_great ]
            ]
  VERBS_I = [
              "<3",
              "admire",
              "envy",
              "like",
              "love",
              "respect",
              "wanna be",
              "wish I was more like",
            ]
  VERBS_MAKE =
            [
              "make",
            ]
  VERBS_ARE =
            [
              "can be",
              "are",
              "'re",
              "have always been",
              "will always be",
              "are definitely",
            ]

  VERBS_FEEL =
            [
              "feel",
              "want to be",
            ]

  def self.intro
    puts "intro"
    parse_form(INTROS.rand)
  end

  def self.compliment
    # Either "you are" or "you <cause>"
    parse_form(FORMS.rand)

  end

  def self.flair
    puts "flair"
    parse_form(FLAIR.rand)
  end

  def self.followup
    puts "followup"
    parse_form(FOLLOWUPS.rand)
  end

  # the first compliment doesn't have an intro.
  def self.first_compliment
    c = ""
    c += compliment
    c = "#{end_sentence(c)} "
    c += " #{flair} " if rand > 0.85
    # Add a followup and some flair, 1/4 of the time
    if rand > 0.75
      c += end_sentence(followup)
      c += " #{flair} " if rand > 0.85
    end
    c.strip

  end

  def self.full_compliment
    c = ""
    c += intro if rand > 0.5
    c += compliment
    c = "#{end_sentence(c)} "
    c += " #{flair} " if rand > 0.85
    # Add a followup and some flair, 1/4 of the time
    if rand > 0.75
      c += end_sentence(followup)
      c += " #{flair} " if rand > 0.85
    end
    c.strip
  end

  def self.end_sentence(str)
    str.strip!
    has_punctuation = false
    [ ".", "?", "!" ].each do |ender|
      if str.index(ender)
        str.delete!(ender)
        str += ender
        has_punctuation = true
      end
    end

    str += "." if !has_punctuation
    str
  end

  def self.parse_form(form)
    return form if form.is_a?(String)
    c = ""
    form.each do |clause|
      puts clause
      c += clause if clause.is_a?(String)
      c += parse_form(clause) if clause.is_a?(Array)
      if clause.is_a?(Symbol)
        case clause
          when :adj
            c += pick_form(ADJS_GREAT + ADJS_COOL)
          when :adj_great
            c += "#{pick_form(ADJS_GREAT)} "
          when :adj_mod
            c += "#{pick_form(ADJS_MOD)} "
          when :adj_okay
            c += "#{pick_form(ADJS_OKAY)} "
          when :adj_state
            c += "#{pick_form(ADJS_STATE)} "
          when :are
            c += "you #{pick_form(VERBS_ARE)} "
          when :cause
            c += "you #{pick_form(VERBS_MAKE)} "
          when :obj_tp_pl
            c += "#{pick_form(OBJECTS_TP_PLURAL)} "
          when :person
            c += "#{pick_form(SUBJECTS)} "
          when :verb_i
            c += "#{pick_form(VERBS_I)} "
          when :verb_feel
            c += "#{pick_form(VERBS_FEEL)} "
          end
        end
    end
    c
  end

  def self.pick_form(arr)
    parse_form(arr.rand)
  end
end
