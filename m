Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D4CC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C162610F365;
	Fri,  7 Aug 2026 04:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z+FjzNcc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D657910F349;
 Fri,  7 Aug 2026 04:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077108; x=1817613108;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7zf9RQZDaUpAg5HRo1QWTMQFt1yL/ie2s8IulSGsRRc=;
 b=Z+FjzNcc6S8xqnTTT15ViownuoV4/VmXOS2HnWNjRmJRJhond4Xj6Hh1
 QItWHf1zehFJ4ITVuLndbd32rJcsYMNl6ovOYXIH9gUdSOOKnIb7d4vN4
 MOCEmk2JEeUtxLcheo8GMzQRY+ph5VNOhtJkOmP5xhevXAGHOF1RiFnSd
 VKVrcdOk++LLYv/hfJrtaF1ORzTnRq8cwWWGgtoS2EOWIX+qZbVnMqJsO
 Boex1xqx3RipE8zjNbuSuT8bppz0+NhaHdvDJRy6QdLDuH8Eh1oinpaWi
 TS5zQ0T1D+4udnxnxx7H/6XG6pJuy2yHzn5FM9eDyvTLg9cMc+VfRVEbV A==;
X-CSE-ConnectionGUID: 6nE/Vm7jRNKpO0LcIzRFDw==
X-CSE-MsgGUID: hE0NMu4CQzuQRDH+1qm1Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619254"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619254"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:48 -0700
X-CSE-ConnectionGUID: JSw0AE6/Q0yHxFdZpdUPQA==
X-CSE-MsgGUID: fCoHs/vnRYCkSNzgZb/6aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666101"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:45 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 08/44] drm/i915/ddi: Update Transcoder/DDI registers with the
 frl bits
Date: Fri,  7 Aug 2026 09:43:53 +0530
Message-ID: <20260807041430.229038-9-ankit.k.nautiyal@intel.com>
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

For platforms supporting HDMI FRL we need to fill the lane count
in Transcoder and DDI/PORT registers for FRL mode.
Similarly, FRL SHIFTER ENABLE, and DATA_WIDTH bits are to be set
in FRL mode. These bits are written in both the DDI_BUF_CTL and
PORT_BUF_CTL registers.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 25 +++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index bf5788c5bbd3..48411a4d30c3 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3099,12 +3099,20 @@ static void intel_ddi_buf_disable(struct intel_encoder *encoder,
 {
 	struct intel_display *display = to_intel_display(encoder);
 	enum port port = encoder->port;
+	u32 val;
 
 	intel_de_rmw(display, DDI_BUF_CTL(port), DDI_BUF_CTL_ENABLE, 0);
 
 	if (DISPLAY_VER(display) >= 14)
 		intel_wait_ddi_buf_idle(display, port);
 
+	/* Clear PORT_BUF_CTL HDMI FRL Shifter Enable to 0 */
+	if (crtc_state->frl.enable) {
+		val = intel_de_read(display, XELPDP_PORT_BUF_CTL1(display, port));
+		intel_de_write(display, XELPDP_PORT_BUF_CTL1(display, port),
+			       val & ~XELPDP_PORT_HDMI_FRL_SHFTR_EN);
+	}
+
 	mtl_ddi_disable_d2d(encoder);
 
 	if (intel_crtc_has_dp_encoder(crtc_state)) {
@@ -3473,8 +3481,9 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 	 * On ADL_P the PHY link rate and lane count must be programmed but
 	 * these are both 0 for HDMI.
 	 *
-	 * But MTL onwards HDMI2.1 is supported and in TMDS mode this
-	 * is filled with lane count, already set in the crtc_state.
+	 * But MTL onwards HDMI FRL is supported and in FRL mode, port width
+	 * needs to be filled with either 3 or 4 lanes. For TMDS mode this
+	 * is always filled with 4 lanes, already set in the crtc_state.
 	 * The same is required to be filled in PORT_BUF_CTL for C10/20 Phy.
 	 */
 	if (dig_port->lane_reversal)
@@ -3490,8 +3499,18 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 		if (dig_port->lane_reversal)
 			port_buf |= XELPDP_PORT_REVERSAL;
 
+		if (crtc_state->frl.enable) {
+			port_buf |= XELPDP_PORT_HDMI_FRL_SHFTR_EN;
+			port_buf |= XELPDP_PORT_BUF_PORT_DATA_20BIT;
+			buf_ctl |= DDI_BUF_PORT_DATA_20BIT;
+		} else {
+			buf_ctl &= ~DDI_BUF_PORT_DATA_MASK;
+		}
+
 		intel_de_rmw(display, XELPDP_PORT_BUF_CTL1(display, port),
-			     XELPDP_PORT_WIDTH_MASK | XELPDP_PORT_REVERSAL, port_buf);
+			     XELPDP_PORT_WIDTH_MASK | XELPDP_PORT_REVERSAL |
+			     XELPDP_PORT_BUF_PORT_DATA_WIDTH_MASK |
+			     XELPDP_PORT_HDMI_FRL_SHFTR_EN, port_buf);
 
 		buf_ctl |= DDI_PORT_WIDTH(crtc_state->lane_count);
 
-- 
2.50.1

