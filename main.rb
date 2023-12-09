use_bpm 60

# Function to play chords with inversions
define :play_chord_inv do |root_note, type, inv|
  use_synth :piano
  play invert_chord(chord(root_note, type), inv), amp: 3.0, attack: 2, release: 4
  sleep 2
end

define :play_ambient_chord do |root_note, synth_type, inversion=0, amp_val=1|
  use_synth synth_type
  chord_to_play = chord(root_note, :major7)
  if inversion > 0
    chord_to_play = invert_chord(chord_to_play, inversion)
  end
  play chord_to_play, attack: 4, release: 8, amp: amp_val
  sleep 8
end

live_loop :nature_sounds do
  sample :ambi_soft_wind, rate: 0.5, amp: 0.1
  sleep 20
  sample :ambi_lunar_land, rate: 0.5, amp: 0.1
  sleep 20
end

# pre-introduction
in_thread do
  start_time = Time.now
  loop do
    elapsed_time = Time.now - start_time
    break if elapsed_time >= 12  # Stop after 12 seconds
    play_chord_inv :c4, :minor, 0
    play_chord_inv :g3, :major, 0  # Added relative major
    play_chord_inv :ab3, :major, 1
    play_chord_inv :eb3, :minor7, 2
  end
end

# Section 1: Beginning
sleep 12
5.times do
  play_ambient_chord :e3, :hollow
  play_ambient_chord :a3, :hollow  # I-IV-V progression in E
  play_ambient_chord :b3, :hollow
  play_ambient_chord :d3, :hollow, 1  # First inversion
  play_ambient_chord :g3, :hollow, 1
  play_ambient_chord :a3, :hollow, 1
  play_ambient_chord :c3, :hollow
  play_ambient_chord :f3, :hollow
  play_ambient_chord :g3, :hollow
  play_ambient_chord :g2, :hollow, 2  # Second inversion
  play_ambient_chord :c3, :hollow, 2
  play_ambient_chord :d3, :hollow, 2
end

# Section 2: Expansion
5.times do
  play_ambient_chord :c3, :dark_ambience
  play_ambient_chord :ab3, :dark_ambience  # i-VI-III-VII progression
  play_ambient_chord :eb3, :dark_ambience
  play_ambient_chord :bb3, :dark_ambience
  play_ambient_chord :g2, :dark_ambience, 2
end

# Section 3: Variation with Lower Amplitude
pedal_tone = :a2  # Pedal tone for section 3 and 4
2.times do
  play pedal_tone, amp: 0.1
  play_ambient_chord :a3, :pretty_bell, 0, 0.1  # Lower amplitude
  play_ambient_chord :f3, :pretty_bell, 1, 0.1  # Lower amplitude
end

# Section 4: Development
1.times do
  play pedal_tone, amp: 0.1
  play_ambient_chord :g3, :pnoise, 0, 0.1
  play_ambient_chord :e3, :pnoise, 2, 0.1
end

# Section 5: Climax
1.times do
  play_ambient_chord :f3, :subpulse, 0, 0.1
  play_ambient_chord :db3, :subpulse, 0, 0.1 # VI-VII-I progression in F minor
  play_ambient_chord :eb3, :subpulse, 0, 0.1
  play_ambient_chord :d3, :subpulse, 1, 0.1
end

# Section 6: Conclusion
5.times do
  play_ambient_chord :a2, :hollow, 0
  play_ambient_chord :d3, :hollow  # IV-V-I progression in C minor
  play_ambient_chord :e3, :hollow
  play_ambient_chord :e2, :hollow, 1
end
