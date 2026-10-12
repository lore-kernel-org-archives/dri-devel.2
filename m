Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BE1CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FACE10E44F;
	Mon, 12 Oct 2026 04:14:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B167210E400;
 Mon, 12 Oct 2026 04:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778472; x=1823314472;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/sqvIbiqohLThDXEnvUmuMzUIg7CErDjbAhquHJNSCY=;
 b=Q99ss9dHtq7nRGfwmrIhSmDsAtOFNFNFLrMPq8lf2yC/fmPALqftxpB8
 GqdmWU88hGuMSHfQ98hwvI7PbiQS37spif/2GzqgjZrjZcExUEJS5z/4T
 riAEH2gDWKXaRJrf3qIK7fRFhJVeIHf3U46HhoAlRkkXMFRYNPFEevVlu
 aLXRlnJiuBJDwmarNswM4csW97JcSupY9ZACXMWcrJwKqB1+K1E6hUHav
 n8lx2PIXpfkwZOSD1CPxVWBC14FT9vJcrox3EVyvczhMoikMiVXpdXSIw
 Bvs1OasVOWDkx5OHxizYY7jwkIh5q/Mv+f/IEoiCKvr2I+eF4m/ydw83m w==;
X-CSE-ConnectionGUID: icqbtH1fQcedZZybsTPb9A==
X-CSE-MsgGUID: rH7glr5qTaKIjntDbRWGMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380836"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380836"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:32 -0700
X-CSE-ConnectionGUID: Pdw2N65BQra+oRALF4xHGA==
X-CSE-MsgGUID: JWHwVfQZT12nuMASKXFAmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256356"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:31 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 08/56] drm/i915/ddi: Update Transcoder/DDI registers with
 the frl bits
Date: Mon, 12 Oct 2026 09:27:17 +0530
Message-ID: <20261012035806.3361439-9-ankit.k.nautiyal@intel.com>
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
index a46ab5d3d70f..576e66774678 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3121,12 +3121,20 @@ static void intel_ddi_buf_disable(struct intel_encoder *encoder,
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
@@ -3496,8 +3504,9 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
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
@@ -3513,8 +3522,18 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
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

