$DBversion = 'XXX';
if( CheckVersion( $DBversion ) ) {
    if( !column_exists( 'branches', 'branchillemail' ) ) {
        $dbh->do( q| ALTER TABLE branches ADD branchillemail LONGTEXT AFTER branchemail | );
    }
    # Add new sysprefs
    $dbh->do( q| INSERT IGNORE INTO systempreferences (variable, value, explanation, options, type) VALUES ('ILLDefaultStaffEmail', '', 'Fallback email address for staff ILL notices to be sent to in the absence of a branch address', NULL, 'Free'); | );
    $dbh->do( q| INSERT IGNORE INTO systempreferences (variable, value, explanation, options, type) VALUES ('ILLSendStaffNotices', NULL, 'Send these ILL notices to staff', NULL, 'multiple'); | );
    # Add new notices
    $dbh->do( q| INSERT IGNORE INTO letter(module, code, branchcode, name, is_html, title, content, message_transport_type, lang) VALUES ('ill', 'ILL_PICKUP_READY', '', 'ILL request ready for pickup', 0, "Interlibrary loan request ready for pickup", "Dear <<borrowers.firstname>> <<borrowers.surname>>,\n\nThe Interlibrary loans request number <<illrequests.illrequest_id>> you placed for:\n\n- <<ill_bib_title>> - <<ill_bib_author>>\n\nis ready for pick up from <<branches.branchname>>.\n\nKind Regards\n\n<<branches.branchname>>\n<<branches.branchaddress1>>\n<<branches.branchaddress2>>\n<<branches.branchaddress3>>\n<<branches.branchcity>>\n<<branches.branchstate>>\n<<branches.branchzip>>\n<<branches.branchphone>>\n<<branches.branchillemail>>\n<<branches.branchemail>>", 'email', 'default'); | );
    $dbh->do( q| INSERT IGNORE INTO letter(module, code, branchcode, name, is_html, title, content, message_transport_type, lang) VALUES ('ill', 'ILL_REQUEST_UNAVAIL', '', 'ILL request unavailable', 0, "Interlibrary loan request unavailable", "Dear <<borrowers.firstname>> <<borrowers.surname>>,\n\nThe Interlibrary loans request number <<illrequests.illrequest_id>> you placed for\n\n- <<ill_bib_title>> - <<ill_bib_author>>\n\nis unfortunately unavailable.\n\nKind Regards\n\n<<branches.branchname>>\n<<branches.branchaddress1>>\n<<branches.branchaddress2>>\n<<branches.branchaddress3>>\n<<branches.branchcity>>\n<<branches.branchstate>>\n<<branches.branchzip>>\n<<branches.branchphone>>\n<<branches.branchillemail>>\n<<branches.branchemail>>", 'email', 'default'); | );
    $dbh->do( q| INSERT IGNORE INTO letter(module, code, branchcode, name, is_html, title, content, message_transport_type, lang) VALUES ('ill', 'ILL_REQUEST_CANCEL', '', 'ILL request cancelled', 0, "Interlibrary loan request cancelled", "The patron for interlibrary loans request <<illrequests.illrequest_id>>, with the following details, has requested cancellation of this ILL request:\n\n<<ill_full_metadata>>", 'email', 'default'); | );
    $dbh->do( q| INSERT IGNORE INTO letter(module, code, branchcode, name, is_html, title, content, message_transport_type, lang) VALUES ('ill', 'ILL_REQUEST_MODIFIED', '', 'ILL request modified', 0, "Interlibrary loan request modified", "The patron for interlibrary loans request <<illrequests.illrequest_id>>, with the following details, has modified this ILL request:\n\n<<ill_full_metadata>>", 'email', 'default'); | );
    $dbh->do( q| INSERT IGNORE INTO letter(module, code, branchcode, name, is_html, title, content, message_transport_type, lang) VALUES ('ill', 'ILL_PARTNER_REQ', '', 'ILL request to partners', 0, "Interlibrary loan request to partners", "Dear Sir/Madam,\n\nWe would like to request an interlibrary loan for a title matching the following description:\n\n<<ill_full_metadata>>\n\nPlease let us know if you are able to supply this to us.\n\nKind Regards\n\n<<branches.branchname>>\n<<branches.branchaddress1>>\n<<branches.branchaddress2>>\n<<branches.branchaddress3>>\n<<branches.branchcity>>\n<<branches.branchstate>>\n<<branches.branchzip>>\n<<branches.branchphone>>\n<<branches.branchillemail>>\n<<branches.branchemail>>", 'email', 'default'); | );
    $dbh->do( q| INSERT IGNORE INTO letter(module, code, branchcode, name, is_html, title, content, message_transport_type, lang) VALUES ('ill', 'ILL_PICKUP_READY', '', 'ILL request ready for pickup', 0, "Interlibrary loan request ready for pickup", "Dear <<borrowers.firstname>> <<borrowers.surname>>,\n\nThe Interlibrary loans request number <<illrequests.illrequest_id>> you placed for:\n\n- <<ill_bib_title>> - <<ill_bib_author>>\n\nis ready for pick up from <<branches.branchname>>.\n\nKind Regards\n\n<<branches.branchname>>\n<<branches.branchaddress1>>\n<<branches.branchaddress2>>\n<<branches.branchaddress3>>\n<<branches.branchcity>>\n<<branches.branchstate>>\n<<branches.branchzip>>\n<<branches.branchphone>>\n<<branches.branchillemail>>\n<<branches.branchemail>>", 'sms', 'default'); | );
    $dbh->do( q| INSERT IGNORE INTO letter(module, code, branchcode, name, is_html, title, content, message_transport_type, lang) VALUES ('ill', 'ILL_REQUEST_UNAVAIL', '', 'ILL request unavailable', 0, "Interlibrary loan request unavailable", "Dear <<borrowers.firstname>> <<borrowers.surname>>,\n\nThe Interlibrary loans request number <<illrequests.illrequest_id>> you placed for\n\n- <<ill_bib_title>> - <<ill_bib_author>>\n\nis unfortunately unavailable.\n\nKind Regards\n\n<<branches.branchname>>\n<<branches.branchaddress1>>\n<<branches.branchaddress2>>\n<<branches.branchaddress3>>\n<<branches.branchcity>>\n<<branches.branchstate>>\n<<branches.branchzip>>\n<<branches.branchphone>>\n<<branches.branchillemail>>\n<<branches.branchemail>>", 'sms', 'default'); | );
    $dbh->do( q| INSERT IGNORE INTO letter(module, code, branchcode, name, is_html, title, content, message_transport_type, lang) VALUES ('ill', 'ILL_REQUEST_CANCEL', '', 'ILL request cancelled', 0, "Interlibrary loan request cancelled", "The patron for interlibrary loans request <<illrequests.illrequest_id>>, with the following details, has requested cancellation of this ILL request:\n\n<<ill_full_metadata>>", 'sms', 'default'); | );
    $dbh->do( q| INSERT IGNORE INTO letter(module, code, branchcode, name, is_html, title, content, message_transport_type, lang) VALUES ('ill', 'ILL_REQUEST_MODIFIED', '', 'ILL request modified', 0, "Interlibrary loan request modified", "The patron for interlibrary loans request <<illrequests.illrequest_id>>, with the following details, has modified this ILL request:\n\n<<ill_full_metadata>>", 'sms', 'default'); | );
    $dbh->do( q| INSERT IGNORE INTO letter(module, code, branchcode, name, is_html, title, content, message_transport_type, lang) VALUES ('ill', 'ILL_PARTNER_REQ', '', 'ILL request to partners', 0, "Interlibrary loan request to partners", "Dear Sir/Madam,\n\nWe would like to request an interlibrary loan for a title matching the following description:\n\n<<ill_full_metadata>>\n\nPlease let us know if you are able to supply this to us.\n\nKind Regards\n\n<<branches.branchname>>\n<<branches.branchaddress1>>\n<<branches.branchaddress2>>\n<<branches.branchaddress3>>\n<<branches.branchcity>>\n<<branches.branchstate>>\n<<branches.branchzip>>\n<<branches.branchphone>>\n<<branches.branchillemail>>\n<<branches.branchemail>>", 'sms', 'default'); | );
    # Add patron messaging preferences
    $dbh->do( q| INSERT IGNORE INTO message_attributes (message_name, takes_days) VALUES ('Ill_ready', 0); | );
    my $ready_id = $dbh->{mysql_insertid};
    if (defined $ready_id) {
        $dbh->do( qq(INSERT IGNORE INTO message_transports (message_attribute_id, message_transport_type, is_digest, letter_module, letter_code) VALUES ($ready_id, 'email', 0, 'ill', 'ILL_PICKUP_READY');) );
        $dbh->do( qq(INSERT IGNORE INTO message_transports (message_attribute_id, message_transport_type, is_digest, letter_module, letter_code) VALUES ($ready_id, 'sms', 0, 'ill', 'ILL_PICKUP_READY');) );
        $dbh->do( qq(INSERT IGNORE INTO message_transports (message_attribute_id, message_transport_type, is_digest, letter_module, letter_code) VALUES ($ready_id, 'phone', 0, 'ill', 'ILL_PICKUP_READY');) );
    }
    $dbh->do( q| INSERT IGNORE INTO message_attributes (message_name, takes_days) VALUES ('Ill_unavailable', 0); | );
    my $unavail_id = $dbh->{mysql_insertid};
    if (defined $unavail_id) {
        $dbh->do( qq(INSERT IGNORE INTO message_transports (message_attribute_id, message_transport_type, is_digest, letter_module, letter_code) VALUES ($unavail_id, 'email', 0, 'ill', 'ILL_REQUEST_UNAVAIL');) );
        $dbh->do( qq(INSERT IGNORE INTO message_transports (message_attribute_id, message_transport_type, is_digest, letter_module, letter_code) VALUES ($unavail_id, 'sms', 0, 'ill', 'ILL_REQUEST_UNAVAIL');) );
        $dbh->do( qq(INSERT IGNORE INTO message_transports (message_attribute_id, message_transport_type, is_digest, letter_module, letter_code) VALUES ($unavail_id, 'phone', 0, 'ill', 'ILL_REQUEST_UNAVAIL');) );
    }

    SetVersion( $DBversion );
    print "Upgrade to $DBversion done (Bug 22818 - Add ILL notices)\n";
}