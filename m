Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D882CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C6610E421;
	Mon, 12 Oct 2026 04:15:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE4E10E4A2;
 Mon, 12 Oct 2026 04:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778514; x=1823314514;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0UBHLUhcIs38xkh6U4Jk9ZVSRR+5zpx3KpJP/W8+IIs=;
 b=T49I09fQ6LwFgK5zWAwcFUvDoFdv/jHBpbUfDxIC8RbcXyoAzBabfSLa
 euVc0IDHpArdCFM2KJABjdyzeo/CN6mZu9i1XgDVSdeBrSPWXgsMtpq3w
 Ff4+ZLLfeDJlCCaSRy4eM8JDT1ezKnhcuaUgjHf5WVRD8on/qE9iyQXaX
 Roq50KEgTBvyLsiLD1ugGZHGu2Q7C7nZtiYwi04q6WrGLBZmH4h0QXMB2
 JBdmz/rnbSTu72aD5/xfl7COf04wHcAdo/RrTrSD4i9/uQO1TOZUEJ+W5
 YEhKSMQ9AeSiPUS0xrSzQNUhBohKoD/34UqpurQb/tYOHseKtm3sf9igu w==;
X-CSE-ConnectionGUID: mbrE64jTQma9uJPCcyBZ5A==
X-CSE-MsgGUID: ha9SsKJcQMeSMv6pJ3NFOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380897"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380897"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:06 -0700
X-CSE-ConnectionGUID: M+alyC5iThWgLKb9RVNq/Q==
X-CSE-MsgGUID: C+RcQWiMQDCiV/Cvdo5x2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256483"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:05 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 23/56] drm/i915/ddi_buf: Add Vswing table for HDMI FRL
Date: Mon, 12 Oct 2026 09:27:32 +0530
Message-ID: <20261012035806.3361439-24-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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

From: Suraj Kandpal <suraj.kandpal@intel.com>

Define Vswing table for HDMI FRL to set the signal levels.
This is done for LT PHY which is Xe3PLPD onwards.

Bspec: 74493
Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 .../gpu/drm/i915/display/intel_ddi_buf_trans.c  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c b/drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c
index cc5912178d9c..597bf1c78104 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c
@@ -10,6 +10,7 @@
 #include "intel_display_types.h"
 #include "intel_display_utils.h"
 #include "intel_dp.h"
+#include "intel_hdmi.h"
 #include "intel_lt_phy.h"
 
 /* HDMI/DVI modes ignore everything but the last 2 items. So we share
@@ -1164,6 +1165,14 @@ static const union intel_ddi_buf_trans_entry _xe3plpd_lt_trans_edp[] = {
 	{ .lt = { 1, 3, 0, 26, 0 } },
 };
 
+static const union intel_ddi_buf_trans_entry _xe3plpd_lt_trans_hdmi_frl[] = {
+	{ .lt = { 0, 0, 0, 48, 0  } },
+	{ .lt = { 0, 0, 4, 38, 6  } },
+	{ .lt = { 0, 0, 4, 36, 8  } },
+	{ .lt = { 0, 0, 4, 34, 10 } },
+	{ .lt = { 0, 0, 4, 32, 12 } },
+};
+
 static const struct intel_ddi_buf_trans xe3plpd_lt_trans_dp14 = {
 	.entries = _xe3plpd_lt_trans_dp14,
 	.num_entries = ARRAY_SIZE(_xe3plpd_lt_trans_dp14),
@@ -1179,6 +1188,11 @@ static const struct intel_ddi_buf_trans xe3plpd_lt_trans_edp = {
 	.num_entries = ARRAY_SIZE(_xe3plpd_lt_trans_edp),
 };
 
+static const struct intel_ddi_buf_trans xe3plpd_lt_trans_hdmi_frl = {
+	.entries = _xe3plpd_lt_trans_hdmi_frl,
+	.num_entries = ARRAY_SIZE(_xe3plpd_lt_trans_hdmi_frl),
+};
+
 bool is_hobl_buf_trans(const struct intel_ddi_buf_trans *table)
 {
 	return table == &tgl_combo_phy_trans_edp_hbr2_hobl;
@@ -1780,6 +1794,9 @@ xe3plpd_get_lt_buf_trans(struct intel_encoder *encoder,
 		return intel_get_buf_trans(&xe3plpd_lt_trans_uhbr, n_entries);
 	else if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP))
 		return intel_get_buf_trans(&xe3plpd_lt_trans_edp, n_entries);
+	else if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI) &&
+		 intel_hdmi_is_frl(crtc_state->port_clock))
+		return intel_get_buf_trans(&xe3plpd_lt_trans_hdmi_frl, n_entries);
 	else
 		return intel_get_buf_trans(&xe3plpd_lt_trans_dp14, n_entries);
 }
-- 
2.50.1

