class SpaceAge
  Earth_Orbit = 31557600.to_f
  Planet_Conversion_Factors =
    { "earth": 1,
    "mercury": 0.2408467,
    "venus": 0.61519726,
    "mars": 1.8808158,
    "jupiter": 11.862615,
    "saturn": 29.447498,
    "uranus": 84.016846,
    "neptune": 164.79132
    }

  attr_reader :seconds

  def initialize(seconds)
    @seconds = seconds
  end

  def method_missing(name)
    @seconds/(Planet_Conversion_Factors[:"#{name.to_s.split('_').last}"]*Earth_Orbit)
  end

def respond_to_missing?(name, *)
  true
end

end
