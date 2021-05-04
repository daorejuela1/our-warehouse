class Plan
  PLANS = {
    free: "price_1In8DjJJ94VEgqjcTjtpdlDt",
    moderate: "price_1In8mYJJ94VEgqjcKjR6pjp3",
    unlimited: "price_1In9GyJJ94VEgqjcf2KUPwfP"
  }
  
  def self.options
    PLANS.keys.map { |plan| plan.capitalize }
  end
end
