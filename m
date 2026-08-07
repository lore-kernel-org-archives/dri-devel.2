Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483F6C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB32D10F3EC;
	Fri,  7 Aug 2026 04:33:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RA06VbBR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E582D10F3E4;
 Fri,  7 Aug 2026 04:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077187; x=1817613187;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bP8d8roSvuCRm4x48ZG34pZ6Vsycp8lnKRcLvGDD97w=;
 b=RA06VbBRSyjrWwjDDENbLnEar2LW2OZYFKB9pvU272u2YYM62l+RxANb
 fOwWCYnpIZDmK77Lb1asq8YEK2Eu21x2cKsxbekTcAWl2C3KHcOAutvSt
 g+RsXeB4UWdwEn+a4pIHTzJsGS84UBCMb8ZstEaukIoLjdzgPY0szQfv1
 GL6nN8yYnu2XWDbtKNVBkIueWjBNhgCo1kCsvkfsVG5CsqVRx6VaH0JOO
 sneDt7aHXq6AkOCzwMNq1Jpj2sY0c7DtYpMSejSBweNSZoYvgtUZyOISQ
 B5xWfFqcWmmJIP6cLYpfFj8/HZB9U1udie84DfgVT+oIFYm+KxVRVVNT1 Q==;
X-CSE-ConnectionGUID: pYaLW6p1T8KmqfMXUQ3dxA==
X-CSE-MsgGUID: El4opM1PRFm00zd+BCbj/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619390"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619390"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:07 -0700
X-CSE-ConnectionGUID: nDWJKKYyTVWoys4+6Dibnw==
X-CSE-MsgGUID: m3H23htnT6S435Iv0XH3QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666572"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:04 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 39/44] drm/i915/ddi: Wire FRL into the HDMI DDI enable/disable
 path
Date: Fri,  7 Aug 2026 09:44:24 +0530
Message-ID: <20260807041430.229038-40-ankit.k.nautiyal@intel.com>
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

Enable HDMI FRL in the DDI enable and disable sequences for MTL+:

Enable path (intel_ddi_enable_hdmi):
-Prepare for FRL mode before enabling D2D link.
-After the DDI buffer is enabled, run FRL link training. If FRL link
training fails, disable FRL and notify userspace. On success, write
DFM registers and enable the transcoder.

Disable path (intel_ddi_post_disable_hdmi):
Call intel_hdmi_disable_frl() after the DDI buffer is disabled to perform
LTS:L teardown and clear the FRL function registers.

Bspec:65750
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index d1a60cdf55fa..6ee2c3119c9b 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -70,6 +70,7 @@
 #include "intel_gmbus.h"
 #include "intel_hdcp.h"
 #include "intel_hdmi.h"
+#include "intel_hdmi_frl_dfm.h"
 #include "intel_hotplug.h"
 #include "intel_hti.h"
 #include "intel_lspcon.h"
@@ -3217,6 +3218,8 @@ static void intel_ddi_post_disable_hdmi(struct intel_atomic_state *state,
 		intel_ddi_disable_transcoder_clock(old_crtc_state);
 
 	intel_ddi_buf_disable(encoder, old_crtc_state);
+	if (intel_crtc_has_type(old_crtc_state, INTEL_OUTPUT_HDMI))
+		intel_hdmi_disable_frl(encoder, old_crtc_state);
 
 	if (DISPLAY_VER(display) >= 12)
 		intel_ddi_disable_transcoder_clock(old_crtc_state);
@@ -3471,6 +3474,9 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 	struct intel_display *display = to_intel_display(encoder);
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
 	struct drm_connector *connector = conn_state->connector;
+	struct intel_hdmi *intel_hdmi = &dig_port->hdmi;
+	struct intel_connector *intel_connector =
+		intel_hdmi->attached_connector;
 	enum port port = encoder->port;
 	u32 buf_ctl = 0;
 
@@ -3491,6 +3497,9 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 	if (has_buf_trans_select(display))
 		hsw_prepare_hdmi_ddi_buffers(encoder, crtc_state);
 
+	if (DISPLAY_VER(display) >= 14 && crtc_state->frl.enable)
+		intel_hdmi_prepare_for_frl_mode(crtc_state);
+
 	/* e. Enable D2D Link for C10/C20 Phy */
 	mtl_ddi_enable_d2d(encoder);
 
@@ -3582,8 +3591,18 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 
 	intel_ddi_buf_enable(encoder, buf_ctl);
 
-	if (DISPLAY_VER(display) >= 14)
+	if (DISPLAY_VER(display) >= 14) {
+		if (crtc_state->frl.enable &&
+		    intel_hdmi_start_frl(encoder, crtc_state) < 0) {
+			intel_hdmi_disable_frl(encoder, crtc_state);
+			schedule_work(&intel_connector->modeset_retry_work);
+
+			return;
+		}
+		intel_hdmi_frl_cfg_write(crtc_state);
+		intel_hdmi_frl_dfm_write(crtc_state);
 		intel_ddi_enable_transcoder_and_vblank(state, encoder, crtc_state);
+	}
 
 	intel_hdmi_poll_for_scrambling_enable(crtc_state, connector);
 }
-- 
2.50.1

