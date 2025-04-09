module OrdersHelper
    def tax_rates_for_province(province)
      case province
      when "ON"
        { gst: 0.0, pst: 0.0, hst: 0.13 } # Ontario
      when "NS", "NB", "NL", "PE"
        { gst: 0.0, pst: 0.0, hst: 0.15 } # Atlantic HST provinces
      when "MB"
        { gst: 0.05, pst: 0.07, hst: 0.0 } # Manitoba
      when "BC"
        { gst: 0.05, pst: 0.07, hst: 0.0 } # British Columbia
      when "SK"
        { gst: 0.05, pst: 0.06, hst: 0.0 } # Saskatchewan
      when "AB", "NT", "NU", "YT"
        { gst: 0.05, pst: 0.0, hst: 0.0 } # GST only
      else
        { gst: 0.05, pst: 0.0, hst: 0.0 } # Fallback
      end
    end
  
    def calculate_total_with_tax(subtotal, province)
      rates = tax_rates_for_province(province)
      gst = subtotal * rates[:gst]
      pst = subtotal * rates[:pst]
      hst = subtotal * rates[:hst]
      
      {
        subtotal: subtotal.round(2),
        gst: gst.round(2),
        pst: pst.round(2),
        hst: hst.round(2),
        total: (subtotal + gst + pst + hst).round(2)
      }
    end
  end