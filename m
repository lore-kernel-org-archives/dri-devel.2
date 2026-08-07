Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40D2C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB5010F524;
	Fri,  7 Aug 2026 15:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0LdUWPz5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE71610F524
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 15:25:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84802419E1;
 Fri,  7 Aug 2026 15:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60401F000E9;
 Fri,  7 Aug 2026 15:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1786116311;
 bh=z5IB6XTFKI35y5FdFqdbCMUdkuJsyMofSrKjy4C8jnw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=0LdUWPz5DoHc2D7vg7CPFQoJTR2RsD4DH9/ld8rDW2jESTIpoIWC6cwCEzSB9Ef9k
 w6aH0RJRr+XSdGbeuVzkAN9iXglblRFVVCXPS+WGnLebeCZdptfOWUUYzLtpQpNrsP
 f3/ZW7oU0M6tg7ze0Jx3T81Yk1ohJB4stfLyfSyI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org,
 Alexander Kaplan <alexander.kaplan@sms-medipool.de>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [PATCH 6.6 187/261] drm/dp: Read the PCON max FRL bandwidth only for
 HDMI DFPs
Date: Fri,  7 Aug 2026 16:39:04 +0200
Message-ID: <20260807143419.398710067@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807143415.358597922@linuxfoundation.org>
References: <20260807143415.358597922@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Kaplan <alexander.kaplan@sms-medipool.de>

commit e40e20ac089e32f1d910636155dc82e61e61dcf3 upstream.

The PCON max FRL bandwidth field lives in byte 2 of the DFP Detailed
Capability Info (DPCD 0x82 for the first DFP).
The DP standard defines the meaning of descriptor bytes 1-3 strictly
per DFP type, and for a DisplayPort type DFP all of them are
reserved, with "read all 0s" semantics (DP v2.0, section 2.12.3,
Table 2-183).
The FRL bandwidth field is an HDMI DFP extension added by the VESA
DP-to-HDMI PCON specification.
drm_dp_get_pcon_max_frl_bw() however parses the byte without checking
the DFP type, the branch presence or DETAILED_CAP_INFO_AVAILABLE.
Without the latter the port descriptors are one byte wide and
port_cap[2] is not even the right register.

All neighbouring helpers parsing the same descriptor are scoped by
the DFP type already, see for instance drm_dp_downstream_max_bpc()
reading the same byte and returning 0 for a DP type DFP.
amdgpu's DC parses the field only for HDMI(/DP++) detailed types as
well.

This is not theoretical.
A Synaptics VMM7100 based USB-C to HDMI adapter with a macOS targeted
firmware advertises a DisplayPort type DFP with the type byte
replicated across the whole descriptor (08 08 08 08).
i915 decodes that as "PCON limited to 18 Gbps FRL" and prunes every
mode above ~750 MHz dotclock, including all the 4k@100/120 modes the
sink EDID offers, while macOS drives 4k@120 through the same adapter
just fine via DP DSC (and amdgpu's type-scoped parser would ignore
the bogus field as well).

Only parse the field for an HDMI DFP behind a DPCD 1.1+ branch
device that reports detailed cap info, matching the type-scoped
field layout of the spec and the rest of the helpers.

Fixes: ce32a6239de6 ("drm/dp_helper: Add Helpers for FRL Link Training support for DP-HDMI2.1 PCON")
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Uma Shankar <uma.shankar@intel.com> (v2)
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.12+
Signed-off-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patch.msgid.link/20260610193825.2933-1-alexander.kaplan@sms-medipool.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/display/drm_dp_helper.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2930,6 +2930,18 @@ int drm_dp_get_pcon_max_frl_bw(const u8
 	int bw;
 	u8 buf;
 
+	if (!drm_dp_is_branch(dpcd))
+		return 0;
+
+	if (dpcd[DP_DPCD_REV] < 0x11)
+		return 0;
+
+	if ((dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE) == 0)
+		return 0;
+
+	if ((port_cap[0] & DP_DS_PORT_TYPE_MASK) != DP_DS_PORT_TYPE_HDMI)
+		return 0;
+
 	buf = port_cap[2];
 	bw = buf & DP_PCON_MAX_FRL_BW;
 


