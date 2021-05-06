class Plan
  PLANS = {
    free: ENV['STRIPE_FREE_PLAN'],
    moderate: ENV['STRIPE_MODERATE_PLAN'],
    unlimited: ENV['STRIPE_UNLIMITED_PLAN'],
  }
  
  def self.options
    PLANS.keys.map { |plan| plan.capitalize }
  end
end
