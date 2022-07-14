  method get_url_information.
    data: url_without_protocol type string,
          url_domain           type string,
          url_sub_domain       type string,
          lv_offset            type i,
          lv_offset_2          type i.
    rs_url_information-url = url.
    find first occurrence of '//' in url  match offset lv_offset.
*   Calculate the domain and subdomain values for check in the credentials for a possible match.
    try.
        if sy-subrc = 0.
          lv_offset = lv_offset + 2.
          url_without_protocol = url+lv_offset.
          find first occurrence of '/' in url_without_protocol  match offset lv_offset.
          if sy-subrc = 0.
            rs_url_information-sub_domain = url_without_protocol(lv_offset).
          else.
            rs_url_information-sub_domain = url_without_protocol.
          endif.
          data(reverse_sub_domain) = reverse( rs_url_information-sub_domain ).
          find first occurrence of '.' in reverse_sub_domain  match offset lv_offset.
          if sy-subrc = 0.
            lv_offset = lv_offset + 1.
            find first occurrence of '.' in reverse_sub_domain+lv_offset match offset lv_offset_2.
            if sy-subrc = 0.
              data(domain_offset) = lv_offset + lv_offset_2.
              rs_url_information-domain = reverse( reverse_sub_domain(domain_offset) ).
            else.
              rs_url_information-domain = reverse( reverse_sub_domain ).
            endif.
          endif.
        endif.
      catch cx_root.
    endtry.
  endmethod.