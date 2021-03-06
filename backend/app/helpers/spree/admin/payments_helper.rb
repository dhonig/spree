module Spree
  module Admin
    module PaymentsHelper
      def payment_action_icon action
        return "ok" if action == "capture"
        return "remove" if action == "void"
      end

      def payment_method_name(payment)
        # hack to allow us to retrieve the name of a "deleted" payment method
        id = payment.payment_method_id
        Spree::PaymentMethod.find_with_destroyed(id).name
      end
    end
  end
end
