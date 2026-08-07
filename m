Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B34C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEECD10F3AE;
	Fri,  7 Aug 2026 04:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z35jwQDR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F4B510F3A0;
 Fri,  7 Aug 2026 04:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077147; x=1817613147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uitXKFM4ZquTWwmhEYKRYBv7oS49ufCyCLyJ0BrjRaw=;
 b=Z35jwQDR9mvDvf77LJCvR89xjR4DtUzmQjps7V0pJCDxbDvMkR5bHfxE
 yP+0qFOW5Qq8Db9/HuqT694qYG7PjoAX4WTI5ZvkPKizgia0V2uXxWIt+
 3sGWkYO+DcSFp8Yht+/upb+Ff01e0r9nWSJaVRCjTsatjNAqCqF0WCydB
 eF0SXmXyl17OLv6Do5VbTCBEnZhSQGGHZ44U6J1hHCVSCcR1x6FjAIRrG
 yaz1pNoAn37VJahAtKN49hVEbaOj9o0FbuLqo/RmClW8Bl6eVdzpI8MFt
 VHX2PI8RJKJcHeVJjExSFFWWX+IC5o1TY6CC70+gzkHvXxFBN4kK7oXD9 Q==;
X-CSE-ConnectionGUID: DQkZfCy/QI6QeMnn7GEZsw==
X-CSE-MsgGUID: HrQe40fPSUqNtLuhRIgjfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619342"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619342"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:27 -0700
X-CSE-ConnectionGUID: /DL2sFYVS1qQYEAcUV9TqQ==
X-CSE-MsgGUID: xuRQUQomSaOfOJ4s92rZdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666343"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:24 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 23/44] drm/i915/ddi_buf: Add Vswing table for HDMI FRL
Date: Fri,  7 Aug 2026 09:44:08 +0530
Message-ID: <20260807041430.229038-24-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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
 .../drm/i915/display/intel_ddi_buf_trans.c    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c b/drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c
index 4cd1e4d76c7a..e7f40f1a7eac 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c
@@ -10,6 +10,7 @@
 #include "intel_display_types.h"
 #include "intel_display_utils.h"
 #include "intel_dp.h"
+#include "intel_hdmi.h"
 #include "intel_lt_phy.h"
 
 /* HDMI/DVI modes ignore everything but the last 2 items. So we share
@@ -1164,6 +1165,22 @@ static const union intel_ddi_buf_trans_entry _xe3plpd_lt_trans_edp[] = {
 	{ .lt = { 1, 3, 0, 26, 0 } },
 };
 
+static const union intel_ddi_buf_trans_entry _xe3plpd_lt_trans_hdmi_frl[] = {
+	{ .lt = { 0, 0, 0, 48, 0  } },
+	{ .lt = { 0, 0, 4, 38, 6  } },
+	{ .lt = { 0, 0, 0, 42, 6  } },
+	{ .lt = { 0, 0, 4, 44, 0  } },
+	{ .lt = { 0, 0, 4, 36, 8  } },
+	{ .lt = { 0, 0, 0, 40, 8  } },
+	{ .lt = { 0, 0, 4, 44, 0  } },
+	{ .lt = { 0, 0, 4, 34, 10 } },
+	{ .lt = { 0, 0, 0, 38, 10 } },
+	{ .lt = { 0, 0, 4, 44, 0  } },
+	{ .lt = { 0, 0, 4, 32, 12 } },
+	{ .lt = { 0, 0, 0, 36, 12 } },
+	{ .lt = { 0, 0, 4, 44, 0  } },
+};
+
 static const struct intel_ddi_buf_trans xe3plpd_lt_trans_dp14 = {
 	.entries = _xe3plpd_lt_trans_dp14,
 	.num_entries = ARRAY_SIZE(_xe3plpd_lt_trans_dp14),
@@ -1179,6 +1196,11 @@ static const struct intel_ddi_buf_trans xe3plpd_lt_trans_edp = {
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
@@ -1780,6 +1802,9 @@ xe3plpd_get_lt_buf_trans(struct intel_encoder *encoder,
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

