Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D9ECA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA8E10FE35;
	Fri,  9 Oct 2026 03:19:58 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDA710FE35;
 Fri,  9 Oct 2026 03:19:56 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515890tbe75e6c5
X-QQ-Originating-IP: iOxnA/33wl/ox8swuoJUlLf8zrJhQu+k7kHFlnQQSIk=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:18:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14557963115015056107
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:16:09 +0800
Subject: [PATCH v2 17/20] drm/msm/dp: Track VSC packets in bridge atomic state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-17-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
In-Reply-To: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=20352; i=sophon@radxa.com;
 h=from:subject:message-id; bh=OuQNAhUl5X+Lv8dFOInZqW0Ip8IWvhylKeVd4dzVIYo=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlYdn/+dZfaHTMdXz3/yL3hxWYVp8WnOeyXrAo9u6
 +hmVa8u6ihlYRDjYpAVU2RRiGeYy16Ze+2pWKkezBxWJpAhDFycAjCR2ZGMDFsPp8Zefzefdf7E
 hb4SX/ic22Vm8e7N9/D6eI9bw3Y9vwUjw5OalYE/I68b1E9MbTBp137Cyevy8YgM067XAeZp3M9
 tuAE=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N3l5ASPewLWqFJqQf6puTtGF5IKiJJCjnPmTwYLRsA6801klj3KMLzUV
 OL8aCkygF3lTW6lclV2qbq/5IcDklgkhli2NnAywLoZ6RSD5NKf24AzoMK/6zv4v5hQeSZW
 gw812NDCJzzb6wr8UFbfwCfUAWgDQZ/uJUJQaUZv11mZdPLCPJXE/9edHyYvXg7s1eX198f
 D81GXrK/4lknDzAvv+RtzMfWFp4d5L2Vz4fV3twDN/LDpzcBJxfvY74oCpJLCYE4Pvn7mFV
 +vgCOrlFmXL1DgZ/fR7oS45OgCBE1fT6e8W12YY2rc/J8g2u86bLxSCJSSL32JIbAaUKPGi
 RIYfQbxLn9B06A5xL4W/cX+5ghMGHg3N3ShiNamyJ6mWfcmg6jkfqc9D0gYTKVKcaynGevG
 zcqBAExjoC9u5xZ9Zh8WfxvjzVp0VqerQZrcS9NxziEQc3OAFxwq9URNEWivpaUBIkmc10k
 UXwFdzauCTM35oAzwuNNE62OZn8yq6sNWtybzsoQZD+Xb1kdlgJAxCBGV9VywqyjUNG9yHD
 69u48YL4KGu6ZYkUWqC164kwyHFt6ZLaMbS4EyK/853K7S8sgQY5FYeLcct4GO0ck63mRbe
 w0P9KNmFPnKF/M8HtSHQtMc+XHsoX1VSuOmXqM04H3NMs4Z5sKxhmS/1GvxXtFIAKs4PBr4
 9lMx15s7ZVbwCQ/MWd4y27bEhdAi3ZERW4YEgr7L39+gqSlMOWNTrPkbqy5ZF/eUL5SQ3x7
 Dk2kTilFwY8DQ+QQbkuK40ZY+XtSJj0RZ0DI8xXt4k51BWDdPZUwq2EEJSEFmtJmSlTlrWY
 Uzu/VIhOx4Vx292Zvj05BOf7SdnmNct0ofJFtFv9F0NEFfHTUKComacX0LacQ1ZfD9Xlf7N
 HoTJbbDgyaMJyPA55v9/zCbrQAvcWNW4DIOHrGsaqQTCckHxAywxurs4XO3QVuYrf9xtKq6
 GIcQwxwpEy8+BNIXn1B8ENAWmunT/hzNcaL1KFB+bXoWFvbQ80js3KmwJWbc9ANb2yNE6lj
 5yH3DFBFqMHPzxgiDXcJ1Wr8SdwAsfW2Cfhk4J0fPRdfEIDMDrPuMeaz5nx6k=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
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

Move YUV420 VSC construction from panel programming to atomic check.
Validate receiver support and retain the packed packet in private bridge
state. Pass the checked state through stream programming instead of
copying its configuration into the panel.

Program that packet unchanged for normal streams. Only regenerate it for
video compliance tests, which can override the checked bit depth. Keep
hardware PSR configuration and self-refresh eligibility tied to the same
VSC enable state. Derive peripheral flush from the old and new states,
and keep compliance packets local so tests cannot modify atomic state.

Provide a shared packet builder for subsequent colorimetry support. This
change does not expose additional connector colorspaces.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 42 ++++++++++++++++++++++++-----
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 +++-
 drivers/gpu/drm/msm/dp/dp_display.c | 54 ++++++++++++++++++++++++++-----------
 drivers/gpu/drm/msm/dp/dp_drm.c     |  5 ++--
 drivers/gpu/drm/msm/dp/dp_drm.h     |  2 ++
 drivers/gpu/drm/msm/dp/dp_panel.c   | 53 ++----------------------------------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  3 +--
 drivers/gpu/drm/msm/dp/dp_utils.c   | 26 ++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_utils.h   |  4 +++
 9 files changed, 114 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 82ef8e405543..2fd8dd456852 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -23,6 +23,7 @@
 
 #include "dp_reg.h"
 #include "dp_ctrl.h"
+#include "dp_drm.h"
 #include "dp_utils.h"
 #include "dp_link.h"
 
@@ -390,7 +391,8 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
 }
 
 static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
-					    struct msm_dp_panel *msm_dp_panel)
+					    struct msm_dp_panel *msm_dp_panel,
+					    bool psr)
 {
 	u32 config = 0, tbd;
 
@@ -411,7 +413,7 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
 
 	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
 
-	if (msm_dp_panel->psr_cap.version && !msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
+	if (msm_dp_panel->psr_cap.version && psr)
 		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
 
 	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
@@ -488,13 +490,20 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 }
 
 static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl,
-						struct msm_dp_panel *panel)
+						struct msm_dp_panel *panel,
+						const struct msm_dp_bridge_state *state,
+						const struct dp_sdp *vsc_sdp)
 {
-	msm_dp_ctrl_config_ctrl_streams(ctrl, panel);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, panel, !state->vsc_enabled);
 
 	msm_dp_ctrl_config_misc1_misc0(ctrl, panel);
 
 	msm_dp_panel_timing_cfg(panel, ctrl->msm_dp_ctrl.wide_bus_en);
+
+	if (state->vsc_enabled)
+		msm_dp_panel_enable_vsc_sdp(panel, vsc_sdp);
+	else
+		msm_dp_panel_disable_vsc_sdp(panel);
 }
 
 /*
@@ -1664,7 +1673,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
 	struct msm_dp_link_info link_info = {0};
 
 	msm_dp_ctrl_config_ctrl_link(ctrl, panel);
-	msm_dp_ctrl_config_ctrl_streams(ctrl, panel);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, panel, false);
 
 	link_info.num_lanes = ctrl->link->link_params.num_lanes;
 	link_info.rate = ctrl->link->link_params.rate;
@@ -2633,9 +2642,12 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 	return ret;
 }
 
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel)
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel,
+			  const struct msm_dp_bridge_state *state)
 {
 	int ret = 0;
+	struct dp_sdp test_vsc_sdp;
+	const struct dp_sdp *vsc_sdp = &state->vsc_sdp;
 	bool mainlink_ready = false;
 	struct msm_dp_ctrl_private *ctrl;
 	unsigned long pixel_rate;
@@ -2650,6 +2662,22 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 	if (!panel->video_test && !msm_dp_ctrl_link_fits(ctrl, panel))
 		return -ENOSPC;
 
+	if (state->vsc_enabled) {
+		if (!panel->vsc_sdp_supported)
+			return -EINVAL;
+
+		/* Compliance tests may override the checked stream depth. */
+		if (panel->video_test) {
+			ret = msm_dp_utils_pack_vsc_sdp(&test_vsc_sdp,
+							DRM_MODE_COLORIMETRY_DEFAULT,
+							panel->msm_dp_mode.bpp / 3,
+							panel->msm_dp_mode.out_fmt_is_yuv_420);
+			if (ret)
+				return ret;
+			vsc_sdp = &test_vsc_sdp;
+		}
+	}
+
 	pixel_rate_orig = panel->msm_dp_mode.drm_mode.clock;
 	pixel_rate = pixel_rate_orig;
 
@@ -2672,7 +2700,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 	msm_dp_setup_peripheral_flush(ctrl);
 	msm_dp_ctrl_config_ctrl_link(ctrl, panel);
 
-	msm_dp_ctrl_configure_source_params(ctrl, panel);
+	msm_dp_ctrl_configure_source_params(ctrl, panel, state, vsc_sdp);
 
 	msm_dp_ctrl_config_msa(ctrl,
 		ctrl->link->link_params.rate,
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 4dd604ef9f1b..e4494a3f4b23 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -10,6 +10,8 @@
 #include "dp_panel.h"
 #include "dp_link.h"
 
+struct msm_dp_bridge_state;
+
 struct msm_dp_ctrl {
 	bool wide_bus_en;
 };
@@ -18,7 +20,8 @@ struct phy;
 
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			struct msm_dp_panel *panel);
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel);
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel,
+			  const struct msm_dp_bridge_state *state);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 				  struct msm_dp_panel *panel,
 				  bool force_link_train);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 234cb2373451..5a9162712540 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -56,6 +56,8 @@ struct msm_dp_display_private {
 	bool core_initialized;
 	bool phy_initialized;
 	bool audio_supported;
+	/* Pending DPU peripheral flush, set before encoder enable. */
+	bool sdp_needs_flush;
 	bool stream_pm_active;
 	bool stream_link_attempted;
 	struct work_struct link_status_work;
@@ -679,7 +681,8 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 				   const struct drm_display_mode *adjusted_mode,
 				   struct msm_dp_panel *msm_dp_panel,
-				   const struct msm_dp_bridge_state *state)
+				   const struct msm_dp_bridge_state *state,
+				   const struct msm_dp_bridge_state *old_state)
 {
 	struct msm_dp_display_private *dp;
 	u32 bpp;
@@ -691,8 +694,7 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	else
 		bpp = state->bpp;
 
-	msm_dp_panel->sdp_needs_flush = msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ||
-		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode);
+	dp->sdp_needs_flush = old_state->vsc_enabled || state->vsc_enabled;
 	msm_dp_panel_init_panel_info(msm_dp_panel, adjusted_mode, bpp ? bpp : 24);
 
 	/* populate wide_bus_support to different layers */
@@ -726,7 +728,15 @@ int msm_dp_display_atomic_check(struct msm_dp *msm_dp_display,
 		return bpp;
 
 	state->bpp = bpp;
-	return 0;
+	state->vsc_enabled = drm_mode_is_420_only(info, mode);
+	if (!state->vsc_enabled)
+		return 0;
+
+	if (dp->panel->link_caps_valid && !dp->panel->vsc_sdp_supported)
+		return -EINVAL;
+
+	return msm_dp_utils_pack_vsc_sdp(&state->vsc_sdp, DRM_MODE_COLORIMETRY_DEFAULT,
+					bpp / 3, drm_mode_is_420_only(info, mode));
 }
 
 static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
@@ -751,7 +761,8 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
 	return 0;
 }
 
-static int msm_dp_display_prepare_link_locked(struct msm_dp_display_private *dp)
+static int msm_dp_display_prepare_link_locked(struct msm_dp_display_private *dp,
+					      const struct msm_dp_bridge_state *state)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 	int rc = 0;
@@ -761,6 +772,9 @@ static int msm_dp_display_prepare_link_locked(struct msm_dp_display_private *dp)
 
 	lockdep_assert_held(&dp->plugged_lock);
 
+	if (state->vsc_enabled && !dp->panel->vsc_sdp_supported)
+		return -EINVAL;
+
 	if (dp->link->sink_count == 0)
 		return -ENOTCONN;
 
@@ -782,7 +796,8 @@ static int msm_dp_display_prepare_link_locked(struct msm_dp_display_private *dp)
 }
 
 static int msm_dp_display_enable(struct msm_dp_display_private *dp,
-				 struct msm_dp_panel *msm_dp_panel)
+				 struct msm_dp_panel *msm_dp_panel,
+				 const struct msm_dp_bridge_state *state)
 {
 	int rc = 0;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
@@ -795,14 +810,15 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, state);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
 	return rc;
 }
 
-static int msm_dp_display_post_enable(struct msm_dp *msm_dp_display)
+static int msm_dp_display_post_enable(struct msm_dp *msm_dp_display,
+				      const struct msm_dp_bridge_state *state)
 {
 	struct msm_dp_display_private *dp;
 	u32 rate;
@@ -822,8 +838,7 @@ static int msm_dp_display_post_enable(struct msm_dp *msm_dp_display)
 	msm_dp_display_handle_plugged_change(msm_dp_display, true);
 
 	if (msm_dp_display->psr_supported)
-		msm_dp_ctrl_config_psr(dp->ctrl, dp->panel,
-				       !dp->panel->msm_dp_mode.out_fmt_is_yuv_420);
+		msm_dp_ctrl_config_psr(dp->ctrl, dp->panel, !state->vsc_enabled);
 
 	return 0;
 }
@@ -1563,7 +1578,7 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *msm_dp_display,
 	struct msm_dp_display_private *dp = container_of(msm_dp_display,
 					struct msm_dp_display_private, msm_dp_display);
 
-	return dp->panel->sdp_needs_flush;
+	return dp->sdp_needs_flush;
 }
 
 bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
@@ -1629,7 +1644,7 @@ void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
 	struct msm_dp_display_private *dp;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
-	struct drm_bridge_state *bridge_state;
+	struct drm_bridge_state *bridge_state, *old_bridge_state;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
@@ -1638,6 +1653,7 @@ void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
 		return;
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	bridge_state = drm_atomic_get_new_bridge_state(state, msm_dp_display->bridge);
+	old_bridge_state = drm_atomic_get_old_bridge_state(state, msm_dp_display->bridge);
 
 	/*
 	 * The DPU encoder's .atomic_enable() reads the mode's YUV420 / wide bus
@@ -1645,7 +1661,8 @@ void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
 	 * be programmed here, in .atomic_pre_enable().
 	 */
 	msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp->panel,
-				to_dp_bridge_state(bridge_state));
+				to_dp_bridge_state(bridge_state),
+				to_dp_bridge_state(old_bridge_state));
 }
 
 static void msm_dp_display_abort_enable_locked(struct msm_dp_display_private *dp)
@@ -1697,30 +1714,35 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 				  struct drm_atomic_commit *state)
 {
+	struct drm_bridge_state *bridge_state;
+	const struct msm_dp_bridge_state *dp_state;
 	int rc = 0;
 	struct msm_dp_display_private *dp;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	bridge_state = drm_atomic_get_new_bridge_state(state, msm_dp_display->bridge);
+	dp_state = to_dp_bridge_state(bridge_state);
+
 	rc = msm_dp_display_prepare(dp);
 	if (rc)
 		goto err_prepare;
 
 	mutex_lock(&dp->plugged_lock);
 
-	rc = msm_dp_display_prepare_link_locked(dp);
+	rc = msm_dp_display_prepare_link_locked(dp, dp_state);
 	if (rc) {
 		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
 		goto err;
 	}
 
-	rc = msm_dp_display_enable(dp, dp->panel);
+	rc = msm_dp_display_enable(dp, dp->panel, dp_state);
 	if (rc) {
 		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 		goto err;
 	}
 
-	rc = msm_dp_display_post_enable(msm_dp_display);
+	rc = msm_dp_display_post_enable(msm_dp_display, dp_state);
 	if (rc) {
 		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
 		goto err;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 6b01eeeb1aef..808b6fe3d650 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -204,6 +204,7 @@ static int msm_edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
 				   struct drm_connector_state *conn_state)
 {
 	struct msm_dp *dp = to_dp_bridge(drm_bridge)->msm_dp_display;
+	struct msm_dp_bridge_state *state = to_dp_bridge_state(bridge_state);
 	int ret;
 
 	if (WARN_ON(!conn_state))
@@ -218,9 +219,7 @@ static int msm_edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
 		return ret;
 
 	/* Match the PSR configuration applied when enabling this stream. */
-	conn_state->self_refresh_aware = dp->psr_supported &&
-		!drm_mode_is_420_only(&conn_state->connector->display_info,
-				    &crtc_state->adjusted_mode);
+	conn_state->self_refresh_aware = dp->psr_supported && !state->vsc_enabled;
 	if (crtc_state->self_refresh_active && !conn_state->self_refresh_aware)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index 4c651cc40f4d..122150d95bbb 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -20,6 +20,8 @@ struct msm_dp_bridge {
 struct msm_dp_bridge_state {
 	struct drm_bridge_state base;
 	u32 bpp;
+	bool vsc_enabled;
+	struct dp_sdp vsc_sdp;
 };
 
 #define to_dp_bridge_state(x) container_of((x), struct msm_dp_bridge_state, base)
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 026074cafc88..bbbe7dc62550 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -516,7 +516,7 @@ static void msm_dp_panel_update_sdp(struct msm_dp_panel_private *panel)
 	}
 }
 
-void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sdp *vsc_sdp)
+void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, const struct dp_sdp *vsc_sdp)
 {
 	struct msm_dp_panel_private *panel =
 		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
@@ -572,49 +572,6 @@ void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel)
 	msm_dp_panel_update_sdp(panel);
 }
 
-static int msm_dp_panel_setup_vsc_sdp_yuv_420(struct msm_dp_panel *msm_dp_panel)
-{
-	struct msm_dp_display_mode *msm_dp_mode;
-	struct drm_dp_vsc_sdp vsc_sdp_data;
-	struct dp_sdp vsc_sdp;
-	ssize_t len;
-
-	if (!msm_dp_panel) {
-		DRM_ERROR("invalid input\n");
-		return -EINVAL;
-	}
-
-	msm_dp_mode = &msm_dp_panel->msm_dp_mode;
-
-	memset(&vsc_sdp_data, 0, sizeof(vsc_sdp_data));
-
-	/* VSC SDP header as per table 2-118 of DP 1.4 specification */
-	vsc_sdp_data.sdp_type = DP_SDP_VSC;
-	vsc_sdp_data.revision = 0x05;
-	vsc_sdp_data.length = 0x13;
-
-	/* VSC SDP Payload for DB16 */
-	vsc_sdp_data.pixelformat = DP_PIXELFORMAT_YUV420;
-	vsc_sdp_data.colorimetry = DP_COLORIMETRY_DEFAULT;
-
-	/* VSC SDP Payload for DB17 */
-	vsc_sdp_data.bpc = msm_dp_mode->bpp / 3;
-	vsc_sdp_data.dynamic_range = DP_DYNAMIC_RANGE_CTA;
-
-	/* VSC SDP Payload for DB18 */
-	vsc_sdp_data.content_type = DP_CONTENT_TYPE_GRAPHICS;
-
-	len = drm_dp_vsc_sdp_pack(&vsc_sdp_data, &vsc_sdp);
-	if (len < 0) {
-		DRM_ERROR("unable to pack vsc sdp\n");
-		return len;
-	}
-
-	msm_dp_panel_enable_vsc_sdp(msm_dp_panel, &vsc_sdp);
-
-	return 0;
-}
-
 int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 {
 	u32 data, total_ver, total_hor;
@@ -684,11 +641,6 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 
 	msm_dp_write_p0(panel, MMSS_DP_INTF_CONFIG, reg);
 
-	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
-		msm_dp_panel_setup_vsc_sdp_yuv_420(msm_dp_panel);
-	else
-		msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
-
 	panel->panel_on = true;
 
 	return 0;
@@ -710,8 +662,7 @@ int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel,
 	msm_dp_panel->msm_dp_mode.h_active_low =
 		!!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
 	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
-		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode) &&
-		msm_dp_panel->vsc_sdp_supported;
+		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode);
 
 	drm_mode = &msm_dp_panel->msm_dp_mode.drm_mode;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 31752895f124..9b81042e1036 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -42,7 +42,6 @@ struct msm_dp_panel {
 	bool link_caps_valid;
 	/* All capability reads completed; eDP can reuse the full cache. */
 	bool caps_cached;
-	bool sdp_needs_flush;
 	u32 hw_revision;
 
 	u32 max_bw_code;
@@ -63,7 +62,7 @@ void msm_dp_panel_tpg_config(struct msm_dp_panel *msm_dp_panel, bool enable);
 
 void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel);
 
-void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sdp *vsc_sdp);
+void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, const struct dp_sdp *vsc_sdp);
 void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel);
 
 /**
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.c b/drivers/gpu/drm/msm/dp/dp_utils.c
index 8b6ef2f6d7f4..bde627a6701b 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.c
+++ b/drivers/gpu/drm/msm/dp/dp_utils.c
@@ -122,6 +122,32 @@ int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
 	return -EINVAL;
 }
 
+int msm_dp_utils_pack_vsc_sdp(struct dp_sdp *sdp, enum drm_colorspace colorspace,
+			      unsigned int bpc, bool yuv420)
+{
+	struct drm_dp_vsc_sdp vsc = {
+		.sdp_type = DP_SDP_VSC,
+		.revision = 0x05,
+		.length = 0x13,
+		.pixelformat = yuv420 ? DP_PIXELFORMAT_YUV420 : DP_PIXELFORMAT_RGB,
+		.bpc = bpc,
+		.dynamic_range = yuv420 ? DP_DYNAMIC_RANGE_CTA : DP_DYNAMIC_RANGE_VESA,
+		.content_type = DP_CONTENT_TYPE_GRAPHICS,
+	};
+	ssize_t ret;
+
+	switch (colorspace) {
+	case DRM_MODE_COLORIMETRY_DEFAULT:
+		vsc.colorimetry = DP_COLORIMETRY_DEFAULT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = drm_dp_vsc_sdp_pack(&vsc, sdp);
+	return ret < 0 ? ret : 0;
+}
+
 bool msm_dp_utils_psr_needs_modeset(const struct drm_crtc_state *state)
 {
 	/* active_changed alone also describes a normal self-refresh exit. */
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.h b/drivers/gpu/drm/msm/dp/dp_utils.h
index c6b62e3900bb..e916de2a5929 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.h
+++ b/drivers/gpu/drm/msm/dp/dp_utils.h
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <drm/display/drm_dp_helper.h>
+#include <drm/drm_connector.h>
 
 struct drm_crtc_state;
 
@@ -42,6 +43,9 @@ int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
 			    unsigned int clock, unsigned int rate,
 			    unsigned int lanes, bool yuv420);
 
+int msm_dp_utils_pack_vsc_sdp(struct dp_sdp *sdp, enum drm_colorspace colorspace,
+			      unsigned int bpc, bool yuv420);
+
 bool msm_dp_utils_psr_needs_modeset(const struct drm_crtc_state *state);
 
 #endif /* _DP_UTILS_H_ */

-- 
2.56.0

