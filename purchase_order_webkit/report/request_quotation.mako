## -*- coding: utf-8 -*-
<html>
<head>
    <style type="text/css">
        ${css}
    </style>
</head>
<body>
    <%page expression_filter="entity"/>
    <%
    def carriage_returns(text):
        return text.replace('\n', '<br />')

    %>

    %for purch in objects :
        <% setLang(purch.partner_id.lang) %>
        <div class="address">
            <table class="recipient">
                <tr><td class="name">${purch.partner_id.title and purch.partner_id.title.name or ''}  ${purch.partner_id.name }</td></tr>
                <tr><td>${purch.partner_address_id.street or ''}</td></tr>
                <tr><td>${purch.partner_address_id.street2 or ''}</td></tr>
                <tr><td>${purch.partner_address_id.zip or ''} ${purch.partner_address_id.city or ''}</td></tr>
                %if purch.partner_address_id.country_id :
                <tr><td>${purch.partner_address_id.country_id.name or ''} </td></tr>
                %endif
                %if purch.partner_address_id.phone :
                <tr><td>${_("Tel")}: ${purch.partner_address_id.phone}</td></tr>
                %endif
                %if purch.partner_address_id.fax :
                <tr><td>${_("Fax")}: ${purch.partner_address_id.fax}</td></tr>
                %endif
                %if purch.partner_address_id.email :
                <tr><td>${_("E-mail")}: ${purch.partner_address_id.email}</td></tr>
                %endif
                %if purch.partner_id.vat :
                <tr><td>${_("VAT")}: ${purch.partner_id.vat}</td></tr>
                %endif
            </table>

            <table class="shipping">
                <tr><td class="address_title">${_("Expected Delivery address:")}</td></tr>
                %if purch.dest_address_id:
                    <tr><td>${purch.partner_id.title and purch.partner_id.title.name or ''}  ${purch.partner_id.name }</td></tr>
                    <tr><td>${purch.dest_address_id.street or ''}</td></tr>
                    <tr><td>${purch.dest_address_id.street2 or ''}</td></tr>
                    <tr><td>${purch.dest_address_id.zip or ''} ${purch.dest_address_id.city or ''}</td></tr>
                    %if purch.dest_address_id.state_id:
                    <tr><td>${purch.dest_address_id.state_id.name or ''} </td></tr>
                    %endif
                    %if purch.dest_address_id.country_id:
                    <tr><td>${purch.dest_address_id.country_id.name or ''} </td></tr>
                    %endif
                %elif purch.warehouse_id:
                    <tr><td>${purch.warehouse_id.name }</td></tr>
                    %if purch.warehouse_id.partner_address_id:
                        <tr><td>${purch.warehouse_id.partner_address_id.street or ''}</td></tr>
                        <tr><td>${purch.warehouse_id.partner_address_id.street2 or ''}</td></tr>
                        <tr><td>${purch.warehouse_id.partner_address_id.zip or ''} ${purch.warehouse_id.partner_address_id.city or ''}</td></tr>
                        %if purch.warehouse_id.partner_address_id.state_id:
                        <tr><td>${purch.warehouse_id.partner_address_id.state_id.name or ''} </td></tr>
                        %endif
                        %if purch.warehouse_id.partner_address_id.country_id:
                        <tr><td>${purch.warehouse_id.partner_address_id.country_id.name or ''} </td></tr>
                        %endif
                    %endif
                %endif
            </table>
        </div>

        <h1 style="clear:both; padding-top: 20px;">${_("Request for Quotation:")} ${purch.name}</h1>

        <table class="list_table" width="100%" style="margin-top: 40px;">
            <thead>
                <tr>
                    <th>${_("Description")}</th>
                    <th>${_("Expected Date")}</th>
                    <th class="amount">${_("Qty")}</th>
                </tr>
            </thead>
            <tbody>
            %for line in purch.order_line :
                <tr class="line">
                    <td>${line.name}</td>
                    <td>${formatLang(line.date_planned, date=True)}</td>
                    <td class="amount">${line.product_qty} ${line.product_uom and line.product_uom.name or ''}</td>
                </tr>
                %if line.notes :
                    <tr class="line">
                        <td colspan="6" class="note">${line.notes  | carriage_returns}</td>
                    </tr>
                %endif
            %endfor
            </tbody>
        </table>

        <p style="margin-top: 20px;">${purch.notes or '' | carriage_returns}</p>

        <p style="margin-top: 20px;">
            ${_("Regards,")}
        </p>

        <p style="margin-top: 20px;">${user.signature or ''}</p>

        <p style="page-break-after:always"/>
        <br/>
	%endfor
</body>
</html>
