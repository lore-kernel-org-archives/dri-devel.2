Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C556CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3EBD10E9F6;
	Mon, 12 Oct 2026 04:15:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4BC10E5D3;
 Mon, 12 Oct 2026 04:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778545; x=1823314545;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LRNA/pU0/k7yJWHpwfFQ3dkIp+XyUTdSAlyq5ecJ4Uw=;
 b=gHhxk8Jlqi3LyyBlxaP61aQkUifHAgNqHYUZoM1KGP+RKCWuP+g4ApJw
 bdbJt+P8I+WzmYoinAbslza3HMwWiFzscPFR2azSXKoWVi5QHCnBjQL4H
 GwdcKWw0jrXbyRSIoOv9bl0Q8W/2f1NoexCP6apIlpTyiSA6TQkth1pr6
 kEbHhDZRAU9S+FzDp9fMUcUDtXax8ckYYn3TbymtA0lxaCDTF3OiY27gT
 lBMAeVGwaT5sjl3r+/O0r3P8NSq7qZNrO6NjO8rh14dCTeZNqeUqg6f6A
 g8/2KgCnya/sGG/sYl15lxj7tw5zz/Bg+gFSfWqDZX0MqoL65znhOAzgW g==;
X-CSE-ConnectionGUID: nOjrm/eqRhyHLEZFoRrFtw==
X-CSE-MsgGUID: ER3HueFQSN+XpYjjbbWvAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380935"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380935"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:45 -0700
X-CSE-ConnectionGUID: 570JgNnXRxSI6NC7VC/ovw==
X-CSE-MsgGUID: plOrcK9RT+Wy70Acz0UfmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256648"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:43 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 40/56] drm/i915/ddi: Wire FRL into the HDMI DDI
 enable/disable path
Date: Mon, 12 Oct 2026 09:27:49 +0530
Message-ID: <20261012035806.3361439-41-ankit.k.nautiyal@intel.com>
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

Enable HDMI FRL in the DDI enable and disable sequences for MTL+:

Enable path (intel_ddi_enable_hdmi):
-Prepare for FRL mode before enabling D2D link.
-After the DDI buffer is enabled, run FRL link training. If FRL link
training fails, notify userspace. On success, write DFM registers and
enable the transcoder.

Disable path (intel_ddi_post_disable_hdmi):
Call intel_hdmi_disable_frl() after the DDI buffer is disabled to perform
LTS:L teardown and clear the FRL function registers.

Bspec:65750
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 53e889c0d022..22a49eb50b20 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -71,6 +71,7 @@
 #include "intel_gmbus.h"
 #include "intel_hdcp.h"
 #include "intel_hdmi.h"
+#include "intel_hdmi_frl_dfm.h"
 #include "intel_hotplug.h"
 #include "intel_hti.h"
 #include "intel_lspcon.h"
@@ -3240,6 +3241,8 @@ static void intel_ddi_post_disable_hdmi(struct intel_atomic_state *state,
 		intel_ddi_disable_transcoder_clock(old_crtc_state);
 
 	intel_ddi_buf_disable(encoder, old_crtc_state);
+	if (intel_crtc_has_type(old_crtc_state, INTEL_OUTPUT_HDMI))
+		intel_hdmi_disable_frl(encoder, old_crtc_state);
 
 	if (DISPLAY_VER(display) >= 12)
 		intel_ddi_disable_transcoder_clock(old_crtc_state);
@@ -3494,6 +3497,9 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 	struct intel_display *display = to_intel_display(encoder);
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
 	struct drm_connector *connector = conn_state->connector;
+	struct intel_hdmi *intel_hdmi = &dig_port->hdmi;
+	struct intel_connector *intel_connector =
+		intel_hdmi->attached_connector;
 	enum port port = encoder->port;
 	u32 buf_ctl = 0;
 
@@ -3514,6 +3520,9 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 	if (has_buf_trans_select(display))
 		hsw_prepare_hdmi_ddi_buffers(encoder, crtc_state);
 
+	if (DISPLAY_VER(display) >= 14 && crtc_state->frl.enable)
+		intel_hdmi_prepare_for_frl_mode(crtc_state);
+
 	/* e. Enable D2D Link for C10/C20 Phy */
 	mtl_ddi_enable_d2d(encoder);
 
@@ -3605,8 +3614,15 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 
 	intel_ddi_buf_enable(encoder, buf_ctl);
 
-	if (DISPLAY_VER(display) >= 14)
+	if (DISPLAY_VER(display) >= 14) {
+		if (crtc_state->frl.enable &&
+		    intel_hdmi_start_frl(encoder, crtc_state) < 0)
+			schedule_work(&intel_connector->modeset_retry_work);
+
+		intel_hdmi_frl_cfg_write(crtc_state);
+		intel_hdmi_frl_dfm_write(crtc_state);
 		intel_ddi_enable_transcoder_and_vblank(state, encoder, crtc_state);
+	}
 
 	intel_hdmi_poll_for_scrambling_enable(crtc_state, connector);
 }
-- 
2.50.1

