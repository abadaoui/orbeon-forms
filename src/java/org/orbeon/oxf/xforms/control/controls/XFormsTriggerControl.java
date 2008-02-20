/**
 *  Copyright (C) 2006 Orbeon, Inc.
 *
 *  This program is free software; you can redistribute it and/or modify it under the terms of the
 *  GNU Lesser General Public License as published by the Free Software Foundation; either version
 *  2.1 of the License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 *  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *  See the GNU Lesser General Public License for more details.
 *
 *  The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
 */
package org.orbeon.oxf.xforms.control.controls;

import org.orbeon.oxf.xforms.control.XFormsControl;
import org.orbeon.oxf.xforms.control.XFormsSingleNodeControl;
import org.orbeon.oxf.xforms.XFormsContainingDocument;
import org.orbeon.oxf.xforms.XFormsConstants;
import org.dom4j.Element;

/**
 * Represents an xforms:trigger control.
 *
 * TODO: Use inheritance to make this a single-node control that doesn't hold a value.
 */
public class XFormsTriggerControl extends XFormsSingleNodeControl {
    public XFormsTriggerControl(XFormsContainingDocument containingDocument, XFormsControl parent, Element element, String name, String id) {
        super(containingDocument, parent, element, name, id);
    }

    public boolean isSupportHTMLLabels() {
        final String appearance = getAppearance();
        if (appearance != null && (XFormsConstants.XFORMS_MINIMAL_APPEARANCE_QNAME.equals(appearance) || XFormsConstants.XXFORMS_LINK_APPEARANCE_QNAME.equals(appearance))) {
            // Minimal or link appearance
            return true;
        } else if (appearance != null && XFormsConstants.XXFORMS_IMAGE_APPEARANCE_QNAME.equals(appearance)) {
            // Image appearance
            return false;
        } else {
            // Default appearance (button)
            return true;
        }
    }

    protected boolean isSupportHTMLHints() {
        return false;
    }
}
