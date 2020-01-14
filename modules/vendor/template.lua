local t = {
  -- Variables can be either string for a function
  -- The Variable name needs to match the replacement flags in the template
  -- Note the double % is required for escaping purpose.
  globals = {
    -- Variables applying to any template types
    ["<%%ADDRESS%%>"] = [[
      Exosite &nbsp;&nbsp;275 Market St, Suite 535 &nbsp;
      &nbsp;Minneapolis, &nbsp;MN &nbsp;&nbsp;55405
      &nbsp;&nbsp;United States
      ]],
    ["<%%CONTACT_US%%>"] = function (context)
      if context.contactUs then
        return string.match(context.contactUs, '^https?://.*') or ("https://" .. context.contactUs)
      end
      return "https://info.exosite.com/contact-us"
    end,
    ["<%%LOGO%%>"] = function (context)
      return (string.match(context.domain, '^https?://.*') or ("https://" .. context.domain)) .. "/vendor/brandlogo.png"
    end,
    ["<%%LOGO_LINK%%>"] = function (context)
      return string.match(context.domain, '^https?://.*') or ("https://" .. context.domain)
    end
  },
  types = {
    -- Instance types & specific variables
    signup = {
      ["<%%BODY%%>"] = function (context)
        local link = "https://".. context.domain .. "/#/login?activate=" .. context.token
        return [[
          <p style="margin-bottom: 1em; font-size: 24px;">
            <b>IoT Connector Registration</b>
          </p>
          <p style="margin-bottom: 1em; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%">
            Hello,
          </p>
          <p style="margin-bottom: 1em; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%">
            Thank you for signing up for IoT Connector!
            Please click the button below to confirm
            your email address and proceed to set a
            password.
          </p>
          <p style="margin: 1.7em 0; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; text-align:center" align="center">
            <span><a
              id="iot-connector-confirm-button-link" href="]] .. link .. [[" target="_blank"
              style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%">
              <img
                style="vertical-align:bottom; -ms-interpolation-mode:bicubic; border-width:0px; width:auto !important; max-width:100% !important"
                src="https://cdn2.hubspot.net/hubfs/508291/cta-button-1.png"
                alt="Confirm Account"
                width="auto"/></a>
            </span>
            <p style="font-size: 12px;"><span style="font-size: 13px; color: #999999;">
              Or follow this link
              <a id="iot-connector-confirm-link" href="]] .. link .. [[" rel=" noopener" style="color: #999999;">]]
                .. link ..
              [[</a>
              </span><span style="font-size: 13px; color: #999999;"></span>
            </p>
          </p>
          <p style="margin-top: 25px;">Sincerely,</p>
          <p style="margin-top: -10px;">IoT Connector Team</p>
        ]]
      end
    }
  }
}

-- Function to get the template content
function t.get(name, context)
  local current = t.types[name]
  if not current then
    return nil
  end
  local content = t.TEMPLATE
  local variables = {}
  for k, v in pairs(current) do
    if type(v) == "function" then
      v = v(context)
    end
    content = content:gsub(k, v)
  end
  for k, v in pairs(t.globals) do
    if type(v) == "function" then
      v = v(context)
    end
    content = content:gsub(k, v)
  end
  return content
end

t.TEMPLATE = [[
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
  ><!-- start coded_template: id:3754122393 path:custom/email/2016_Generic_Email/Plain_Blue_no_Image.html -->
  <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title></title>
      <meta property="og:title" content="" />
      <meta name="twitter:title" content="" />
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

      <style type="text/css" id="hs-inline-css">
        /*<![CDATA[*/
        /* everything in this node will be inlined */

        /* ==== Page Styles ==== */

        body,
        #backgroundTable {
          background-color: #f2f2f2; /* Use body to determine background color */
          font-family: sans-serif;
        }

        #templateTable {
          width: 600px;
          background-color: #ffffff;
          -webkit-font-smoothing: antialiased;
        }

        h1,
        .h1,
        h2,
        .h2,
        h3,
        .h3,
        h4,
        .h4,
        h5,
        .h5,
        h6,
        .h6 {
          color: #444444;
          display: block;
          font-family: sans-serif;
          font-weight: bold;
          line-height: 100%;
          margin-top: 0;
          margin-right: 0;
          margin-bottom: 10px;
          margin-left: 0;
          text-align: left;
        }

        h1,
        .h1 {
          font-size: 26px;
        }

        h2,
        .h2 {
          font-size: 20px;
        }

        h3,
        .h3 {
          font-size: 15px;
        }

        h4,
        .h4 {
          font-size: 13px;
        }

        h5,
        .h5 {
          font-size: 11px;
        }

        h6,
        .h6 {
          font-size: 10px;
        }

        /* ==== Header Styles ==== */

        #headerTable {
          background-color: #f2f2f2;
          color: #444444;
          font-family: sans-serif;
          font-size: 10px;
          line-height: 120%;
          text-align: right;
          border-collapse: separate !important;
          padding-right: 0px;
        }

        #headerTable a:link, #headerTable a:visited, /* Yahoo! Mail Override */ #headerTable a .yshortcuts /* Yahoo! Mail Override */ {
          font-weight: normal;
          text-decoration: underline;
        }

        /* ==== Template Wrapper Styles ==== */

        #contentCell {
          padding: 10px 20px;
          background-color: #f2f2f2;
        }

        #contentTableOuter {
          border-collapse: separate !important;

          background-color: #ffffff;

          box-shadow: 0px 1px rgba(0, 0, 0, 0.1);

          padding: 0px;
        }

        #contentTableInner {
          width: 600px;
        }

        /* ==== Body Styles ==== */

        .bodyContent {
          color: #444444;
          font-family: sans-serif;
          font-size: 15px;
          line-height: 150%;
          text-align: left;
        }

        /* ==== Column Styles ==== */

        table.columnContentTable {
          border-collapse: separate !important;
          border-spacing: 0;

          background-color: #ffffff;
        }

        td[class~='columnContent'] {
          color: #444444;
          font-family: sans-serif;
          font-size: 15px;
          line-height: 120%;
          padding-top: 20px;
          padding-right: 20px;
          padding-bottom: 20px;
          padding-left: 20px;
        }

        /* ==== Footer Styles ==== */

        #footerTable {
          background-color: #f2f2f2;
        }

        #footerTable a {
          color: #999999;
        }

        #footerTable {
          color: #999999;
          font-family: sans-serif;
          font-size: 12px;
          line-height: 120%;
          padding-top: 20px;
          padding-right: 20px;
          padding-bottom: 20px;
          padding-left: 20px;
          text-align: center;
        }

        #footerTable a:link, #footerTable a:visited, /* Yahoo! Mail Override */ #footerTable a .yshortcuts /* Yahoo! Mail Override */ {
          font-weight: normal;
          text-decoration: underline;
        }

        .hs-image-social-sharing-24 {
          max-width: 24px;
          max-height: 24px;
        }

        /* ==== Standard Resets ==== */
        .ExternalClass {
          width: 100%;
        } /* Force HM to display emails at full width */
        .ExternalClass,
        .ExternalClass p,
        .ExternalClass span,
        .ExternalClass font,
        .ExternalClass td,
        .ExternalClass div {
          line-height: 100%;
        } /* Force HM to display normal line spacing */
        body,
        table,
        td,
        p,
        a,
        li,
        blockquote {
          -webkit-text-size-adjust: 100%;
          -ms-text-size-adjust: 100%;
        } /* Prevent WebKit and Windows mobile changing default text sizes */
        table,
        td {
          mso-table-lspace: 0pt;
          mso-table-rspace: 0pt;
        } /* Remove spacing between tables in Outlook 2007 and up */
        img {
          vertical-align: bottom;
          -ms-interpolation-mode: bicubic;
        } /* Allow smoother rendering of resized image in Internet Explorer */

        /* Reset Styles */
        body {
          margin: 0;
          padding: 0;
        }
        table {
          border-collapse: collapse !important;
        }
        body,
        #backgroundTable,
        #bodyCell {
          height: 100% !important;
          margin: 0;
          padding: 0;
          width: 100% !important;
        }
        a:link,
        a:visited {
          border-bottom: none;
        }

        /* iOS automatically adds a link to addresses */
        /* Style the footer with the same color as the footer text */
        #footer a {
          color: #999999;
          -webkit-text-size-adjust: none;
          text-decoration: underline;
          font-weight: normal;
        }

        /* Hide preview text on rendering */
        #preview_text {
          display: none;
        }
      </style>
      <style type="text/css">
        /*<![CDATA[*/
        /* ==== Mobile Styles ==== */

        /* Constrain email width for small screens */
        @media screen and (max-width: 650px) {
          table[id='backgroundTable'] {
            width: 95% !important;
          }

          table[id='templateTable'] {
            max-width: 600px !important;
            width: 100% !important;
          }

          table[id='contentTableInner'] {
            max-width: 600px !important;
            width: 100% !important;
          }

          /* Makes image expand to take 100% of width*/
          img {
            width: 100% !important;
            height: auto !important;
          }

          #contentCell {
            padding: 10px 10px !important;
          }

          #headerTable {
            padding-right: 0px !important;
          }

          #contentTableOuter {
            padding: 0 !important;
          }
        }

        @media only screen and (max-width: 480px) {
          /* ==== Client-Specific Mobile Styles ==== */
          body,
          table,
          td,
          p,
          a,
          li,
          blockquote {
            -webkit-text-size-adjust: none !important;
          } /* Prevent Webkit platforms from changing default text sizes */
          body {
            width: 100% !important;
            min-width: 100% !important;
          } /* Prevent iOS Mail from adding padding to the body */

          /* ==== Mobile Reset Styles ==== */
          td[id='bodyCell'] {
            padding: 10px !important;
          }

          /* ==== Mobile Template Styles ==== */

          #hs_cos_wrapper_logo_image,
          #hs_cos_wrapper_Social_Sharing {
            padding: 10px !important;
          }

          table[id='templateTable'] {
            max-width: 600px !important;
            width: 100% !important;
          }

          table[id='contentTableInner'] {
            max-width: 600px !important;
            width: 100% !important;
          }

          /* ==== Image Alignment Styles ==== */

          h1,
          .h1 {
            font-size: 26px !important;
            line-height: 125% !important;
          }

          h2,
          .h2 {
            font-size: 20px !important;
            line-height: 125% !important;
          }

          h3,
          .h3 {
            font-size: 15px !important;
            line-height: 125% !important;
          }

          h4,
          .h4 {
            font-size: 13px !important;
            line-height: 125% !important;
          }

          h5,
          .h5 {
            font-size: 11px !important;
            line-height: 125% !important;
          }

          h6,
          .h6 {
            font-size: 10px !important;
            line-height: 125% !important;
          }

          .hide {
            display: none !important;
          } /* Hide to save space */

          /* ==== Body Styles ==== */

          td[class='bodyContent'] {
            font-size: 16px !important;
            line-height: 145% !important;
          }

          /* ==== Footer Styles ==== */

          td[id='footerTable'] {
            padding-left: 0px !important;
            padding-right: 0px !important;
            font-size: 12px !important;
            line-height: 145% !important;
          }

          /* ==== Image Alignment Styles ==== */

          table[class='alignImageTable'] {
            width: 100% !important;
          }

          td[class='imageTableTop'] {
            display: none !important;
            /*padding-top: 10px !important;*/
          }
          td[class='imageTableRight'] {
            display: none !important;
          }
          td[class='imageTableBottom'] {
            padding-bottom: 10px !important;
          }
          td[class='imageTableLeft'] {
            display: none !important;
          }

          /* ==== Column Styles ==== */

          td[class~='column'] {
            display: block !important;
            width: 100% !important;
            padding-top: 0 !important;
            padding-right: 0 !important;
            padding-bottom: 0 !important;
            padding-left: 0 !important;
          }

          td[class~='columnContent'] {
            font-size: 14px !important;
            line-height: 145% !important;

            padding-top: 10px !important;
            padding-right: 10px !important;
            padding-bottom: 10px !important;
            padding-left: 10px !important;
          }

          #contentCell {
            padding: 10px 0px !important;
          }

          #headerTable {
            padding-right: 0px !important;
          }

          #contentTableOuter {
            padding: 0px !important;
          }
        }

        #preview_text {
          display: none;
        }
      </style>
    </head>

    <body
      leftmargin="0"
      marginwidth="0"
      topmargin="0"
      marginheight="0"
      offset="0"
      style="background-color:#f2f2f2; font-family:sans-serif; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; height:100% !important; margin:0; padding:0; width:100% !important"
      bgcolor="#f2f2f2"
    >
      <!-- Preview text (text which appears right after subject) -->

      <!--  The  backgroundTable table manages the color of the background and then the templateTable maintains the body of
          the email template, including preheader & footer. This is the only table you set the width of to, everything else is set to
          100% and in the CSS above. Having the width here within the table is just a small win for Lotus Notes. -->

      <!-- Begin backgroundTable -->
      <table
        align="center"
        bgcolor="#f2f2f2"
        border="0"
        cellpadding="0"
        cellspacing="0"
        height="100%"
        width="100%"
        id="backgroundTable"
        style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:collapse !important; background-color:#f2f2f2; font-family:sans-serif; height:100% !important; margin:0; padding:0; width:100% !important"
      >
        <tbody>
          <tr>
            <td
              align="center"
              valign="top"
              id="bodyCell"
              style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; height:100% !important; margin:0; padding:0; width:100% !important"
              height="100%"
              width="100%"
            >
              <!-- When nesting tables within a TD, align center keeps it well, centered. -->
              <!-- Begin Template Container -->
              <!-- This holds everything together in a nice container -->
              <table
                border="0"
                cellpadding="0"
                cellspacing="0"
                id="templateTable"
                style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:collapse !important; width:600px; background-color:#ffffff; -webkit-font-smoothing:antialiased"
                width="600"
                bgcolor="#ffffff"
              >
                <tbody>
                  <tr>
                    <td
                      align="center"
                      valign="top"
                      style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt"
                    >
                      <!-- Begin Template Preheader -->
                      <div class="header-container-wrapper"></div>
                      <table
                        border="0"
                        cellpadding="0"
                        cellspacing="0"
                        width="100%"
                        id="headerTable"
                        style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; background-color:#f2f2f2; color:#444444; font-family:sans-serif; font-size:10px; line-height:120%; text-align:right; border-collapse:separate !important; padding-right:0px"
                        bgcolor="#f2f2f2"
                        align="right"
                      >
                        <tbody>
                          <tr>
                            <td
                              align="left"
                              valign="top"
                              class="bodyContent"
                              width="100%"
                              colspan="12"
                              style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; color:#444444; font-family:sans-serif; font-size:15px; line-height:150%; text-align:left"
                            >
                              <table
                                cellpadding="0"
                                cellspacing="0"
                                border="0"
                                width="100%"
                                class="templateColumnWrapper"
                                style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:collapse !important"
                              >
                                <tbody>
                                  <tr>
                                    <td
                                      align="left"
                                      valign="top"
                                      colspan="12"
                                      width="100.0%"
                                      class="column"
                                      style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; text-align:left; font-family:sans-serif; font-size:15px; line-height:1.5em; color:#444444"
                                    >
                                      <div
                                        class="widget-span widget-type-email_view_as_web_page "
                                        style=""
                                        data-widget-type="email_view_as_web_page"
                                      ></div>
                                      <!--end widget-span -->
                                    </td>
                                  </tr>
                                </tbody>
                              </table>
                            </td>
                          </tr>
                          <!--end header wrapper -->
                        </tbody>
                      </table>
                      <!-- End Template Preheader -->
                    </td>
                  </tr>
                  <tr>
                    <td
                      align="center"
                      valign="top"
                      id="contentCell"
                      style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; padding:10px 20px; background-color:#f2f2f2"
                      bgcolor="#f2f2f2"
                    >
                      <!-- Begin Template Wrapper -->
                      <!-- This separates the preheader which usually contains the "open in browser, etc" content
                                  from the actual body of the email. Can alternatively contain the footer too, but I choose not
                                  to so that it stays outside of the border. -->
                      <table
                        border="0"
                        cellpadding="0"
                        cellspacing="0"
                        width="100%"
                        id="contentTableOuter"
                        style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:separate !important; background-color:#ffffff; box-shadow:0px 1px rgba(0, 0, 0, 0.1); padding:0px; border:1px solid #cccccc; border-bottom:1px solid #acacac"
                        bgcolor="#ffffff"
                      >
                        <tbody>
                          <tr>
                            <td
                              align="center"
                              valign="top"
                              style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt"
                            >
                              <div class="body-container-wrapper"></div>
                              <table
                                border="0"
                                cellpadding="0"
                                cellspacing="0"
                                id="contentTableInner"
                                style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:collapse !important; width:600px"
                                width="600"
                              >
                                <tbody>
                                  <tr>
                                    <td
                                      align="left"
                                      valign="top"
                                      class="bodyContent"
                                      width="100%"
                                      colspan="12"
                                      style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; color:#444444; font-family:sans-serif; font-size:15px; line-height:150%; text-align:left"
                                    >
                                      <table
                                        cellpadding="0"
                                        cellspacing="0"
                                        border="0"
                                        width="100%"
                                        class="templateColumnWrapper"
                                        style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:collapse !important"
                                      >
                                        <tbody>
                                          <tr>
                                            <td
                                              align="center"
                                              valign="top"
                                              colspan="12"
                                              width="100.0%"
                                              class=" column"
                                              style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; text-align:left; font-family:sans-serif; font-size:15px; line-height:1.5em; color:#444444; text-align:center; padding:20px 20px 20px 20px; background-color:#222736"
                                              bgcolor="#222736"
                                            >
                                              <table
                                                cellpadding="0"
                                                cellspacing="0"
                                                border="0"
                                                width="100%"
                                                style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:collapse !important"
                                              >
                                                <tbody>
                                                  <tr>
                                                    <td
                                                      align="left"
                                                      valign="top"
                                                      class="bodyContent"
                                                      width="100%"
                                                      colspan="12"
                                                      style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; color:#444444; font-family:sans-serif; font-size:15px; line-height:150%; text-align:left"
                                                    >
                                                      <table
                                                        cellpadding="0"
                                                        cellspacing="0"
                                                        border="0"
                                                        width="100%"
                                                        class="templateColumnWrapper"
                                                        style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:collapse !important"
                                                      >
                                                        <tbody>
                                                          <tr>
                                                            <td
                                                              align="left"
                                                              valign="top"
                                                              colspan="12"
                                                              width="100.0%"
                                                              class="column"
                                                              style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; text-align:left; font-family:sans-serif; font-size:15px; line-height:1.5em; color:#444444"
                                                            >
                                                              <div
                                                                class="widget-span widget-type-logo"
                                                                style=""
                                                                data-widget-type="logo"
                                                              >
                                                                <div class="layout-widget-wrapper">
                                                                  <div
                                                                    id="hs_cos_wrapper_logo_image"
                                                                    class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_logo"
                                                                    style="color: inherit; font-size: inherit; line-height: inherit;"
                                                                    data-hs-cos-general-type="widget"
                                                                    data-hs-cos-type="logo"
                                                                  >
                                                                    <a
                                                                      href="<%LOGO_LINK%>"
                                                                      id="hs-link-logo_image"
                                                                      style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; border-width:0px; border:0px"
                                                                      target="_blank"
                                                                      ><img
                                                                        src="<%LOGO%>"
                                                                        class="hs-image-widget "
                                                                        style="vertical-align:bottom; -ms-interpolation-mode:bicubic; max-height:32px; max-width:170px; border-width:0px; border:0px"
                                                                        width="170"
                                                                        alt="vendor.png"
                                                                        title="vendor.png"
                                                                    /></a>
                                                                  </div>
                                                                </div>
                                                                <!--end layout-widget-wrapper -->
                                                              </div>
                                                              <!--end widget-span -->
                                                            </td>
                                                          </tr>
                                                        </tbody>
                                                      </table>
                                                    </td>
                                                  </tr>
                                                </tbody>
                                              </table>
                                            </td>
                                          </tr>
                                        </tbody>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td
                                      align="left"
                                      valign="top"
                                      class="bodyContent"
                                      width="100%"
                                      colspan="12"
                                      style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; color:#444444; font-family:sans-serif; font-size:15px; line-height:150%; text-align:left"
                                    >
                                      <table
                                        cellpadding="0"
                                        cellspacing="0"
                                        border="0"
                                        width="100%"
                                        class="templateColumnWrapper"
                                        style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:collapse !important"
                                      >
                                        <tbody>
                                          <tr>
                                            <td
                                              align="left"
                                              valign="top"
                                              colspan="12"
                                              width="100.0%"
                                              class="column"
                                              style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; text-align:left; font-family:sans-serif; font-size:15px; line-height:1.5em; color:#444444"
                                            >
                                              <table
                                                border="0"
                                                cellpadding="0"
                                                cellspacing="0"
                                                width="100%"
                                                style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:separate !important; border-spacing:0; background-color:#ffffff"
                                                class=" columnContentTable"
                                                bgcolor="#ffffff"
                                              >
                                                <tbody>
                                                  <tr>
                                                    <td
                                                      align="left"
                                                      valign="top"
                                                      class="columnContent widget-span widget-type-email_body"
                                                      style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; text-align:left; padding:0; font-family:sans-serif; font-size:15px; line-height:1.5em; color:#444444; padding:15px 30px 15px 30px"
                                                      data-widget-type="email_body"
                                                    >
                                                      <div
                                                        id="hs_cos_wrapper_hs_email_body"
                                                        class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_rich_text"
                                                        style="color: inherit; font-size: inherit; line-height: inherit;"
                                                        data-hs-cos-general-type="widget"
                                                        data-hs-cos-type="rich_text"
                                                      >
                                                        <%BODY%>
                                                      </div>
                                                    </td>
                                                  </tr>
                                                </tbody>
                                              </table>
                                              <!--end widget-table -->
                                            </td>
                                          </tr>
                                        </tbody>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td
                                      align="left"
                                      valign="top"
                                      class="bodyContent"
                                      width="100%"
                                      colspan="12"
                                      style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; color:#444444; font-family:sans-serif; font-size:15px; line-height:150%; text-align:left"
                                    >
                                      <table
                                        cellpadding="0"
                                        cellspacing="0"
                                        border="0"
                                        width="100%"
                                        class="templateColumnWrapper"
                                        style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:collapse !important"
                                      >
                                        <tbody>
                                          <tr>
                                            <td
                                              align="left"
                                              valign="top"
                                              colspan="12"
                                              width="100.0%"
                                              class="column"
                                              style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; text-align:left; font-family:sans-serif; font-size:15px; line-height:1.5em; color:#444444"
                                            >
                                            </td>
                                          </tr>
                                        </tbody>
                                      </table>
                                    </td>
                                  </tr>
                                  <!--end body wrapper -->
                                </tbody>
                              </table>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                      <!-- End Template Wrapper -->
                    </td>
                  </tr>
                  <tr>
                    <td
                      align="center"
                      valign="top"
                      style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt"
                    >
                      <!-- Begin Template Footer -->
                      <div class="footer-container-wrapper"></div>
                      <table
                        border="0"
                        cellpadding="0"
                        cellspacing="0"
                        width="100%"
                        id="footerTable"
                        style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:collapse !important; background-color:#f2f2f2; color:#999999; font-family:sans-serif; font-size:12px; line-height:120%; padding-top:20px; padding-right:20px; padding-bottom:20px; padding-left:20px; text-align:center"
                        bgcolor="#f2f2f2"
                        align="center"
                      >
                        <tbody>
                          <tr>
                            <td
                              align="left"
                              valign="top"
                              class="bodyContent"
                              width="100%"
                              colspan="12"
                              style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; color:#444444; font-family:sans-serif; font-size:15px; line-height:150%; text-align:left"
                            >
                              <table
                                cellpadding="0"
                                cellspacing="0"
                                border="0"
                                width="100%"
                                class="templateColumnWrapper"
                                style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; border-collapse:collapse !important"
                              >
                                <tbody>
                                  <tr>
                                    <td
                                      align="left"
                                      valign="top"
                                      colspan="12"
                                      width="100.0%"
                                      class="column"
                                      style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt; text-align:left; font-family:sans-serif; font-size:15px; line-height:1.5em; color:#444444"
                                    >
                                      <div
                                        class="widget-span widget-type-email_can_spam "
                                        style=""
                                        data-widget-type="email_can_spam"
                                      >
                                        <p
                                          id="footer"
                                          style="margin-bottom: 1em; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; font-family:Geneva, Verdana, Arial, Helvetica, sans-serif; text-align:center; font-size:12px; line-height:1.34em; color:#999999; display:block"
                                          align="center"
                                        >
                                          <%ADDRESS%>
                                          <br /><br />
                                          For more information
                                          <a
                                            class="hubspot-mergetag"
                                            data-unsubscribe="true"
                                            href="<%CONTACT_US_LINK%>"
                                            style="-ms-text-size-adjust:100%; -webkit-text-size-adjust:none; font-weight:normal; text-decoration:underline; whitespace:nowrap; color:#999999"
                                            target="_blank"
                                            >contact us</a
                                          >.
                                        </p>
                                      </div>
                                      <!--end widget-span -->
                                    </td>
                                  </tr>
                                </tbody>
                              </table>
                            </td>
                          </tr>
                          <!--end footer wrapper -->
                          <tr>
                            <td
                              style="-webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; mso-table-lspace:0pt; mso-table-rspace:0pt"
                            ></td>
                          </tr>
                        </tbody>
                      </table>
                      <!-- End Template Footer -->
                    </td>
                  </tr>
                </tbody>
              </table>
              <!-- End Template Container -->
            </td>
          </tr>
        </tbody>
      </table>

      <!-- end coded_template: id:3754122393 path:custom/email/2016_Generic_Email/Plain_Blue_no_Image.html -->
    </body>
  </html>
]]

return t
