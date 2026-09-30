Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A957CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 052E710EA14;
	Wed, 30 Sep 2026 12:44:12 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5548110E9FB;
 Wed, 30 Sep 2026 12:44:09 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772166t3c8d8d6e
X-QQ-Originating-IP: HuzNNRXksHILypNs4egIcx911oCoKFStxW7Ns3EsDXU=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6986564242609081348
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:54 +0800
Subject: [PATCH 10/13] drm/msm/dp: Signal BT.2020 RGB on DP and eDP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-10-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
In-Reply-To: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15612; i=sophon@radxa.com;
 h=from:subject:message-id; bh=WMYfJqOUfC+XPhMZWI14Po2aqW8O0scjxKEl6enR/D8=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZeJ/D/wTOvBvsmMpq97XZ/uLgvbufGGj5xtUnegv
 MQDp8tLO0pZGMS4GGTFFFkU4hnmslfmXnsqVqoHM4eVCWQIAxenAEyk8R0jQ9eStOffjK8u9+9d
 LnVP/ODP9UGXF9w78orD+ncgm8/0qGBGhgOzO9ZqvDe4qxF9tSAz/buyyNZbSSLH327WPbX4e21
 dBj8A
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MorwW1vbY5Cir8vDNhuUazXRFM3wbLGADaf9caG11pXBAFqNzeBKXmZa
 z632YY7Q41QOr5Qo+q+Hfk2itzXH5Q1ED5VIKJb0ZS6jgusxTp35yoyGh3WlNN05UAA1YiP
 jkSPhUDRhf0ndndE6PZXqZY0usgNeYZvshyMkmviTfIilvdSgCncUv1YdAwZATb8agEQDrM
 0U8gYdOW3hnTGTiYA+5/ac1EiehPoD3XVums23DywVlQqigcV590dZK0HVKsDptWDPyxur3
 m2dAim7accq4olIw+qDmWiKulquvCf1Pk1Bu6DLQ6dzWJFNE/OyoIipmdnMHARFZ12XxpJC
 yCKbK/T7olgX9msVpn+r7O0IDQf9ylfLAIlslLzpzAdn29PDbiOE9BNP6BGS7myYCI1zD8x
 6ro5BiyHXyViI02UijQ7QAEt+07PzIRHYhQf+j+IuqbLXXyig5/7to5kO3vptWp8oAqJ2VJ
 9yquHNmDfQrLcuDXj1rgaPBFPqBqF/eix7Qt9LyjIAOhdjaD3PnaoWBXSv18JcsHSa2VkTD
 35/dEtu9tdTQABrOm4TR2vxMXbZ7Q4Ly+rQgxriNnDQG/J/oEnj9GCjoOmNXMTR/pTxp8SL
 DyyouNMuFjZNz1yJmtIJaG+/J2dl5ogyg9nOq4thPCPugpTtHcWAgxHtxQIKqEPmM9Hn3Cw
 mgtuRbzYnc2JFRrXsH4eJ8hLa47M911vs1R/aKvoQIyr674O+ft5WgBdYyhCmbmNsO8Q09x
 4TDUkWL8j2OCNVFiveoK6OA/HInHBGN7MJwNATpzzsDazvFfpxRMq+HxZ0bRb2y50utN9d1
 yLH2FqGmxnUJr177grefFVk37rhvliNvYAFp4LLEqKD3gQlWqhzRBe9KCpbI+iJYXiIaqSG
 73rAefRLiSx0Kn8QtcMtWl82ADhZWG2gpx1TejTfOBe9lQ1PMMzd1bC9I9HklJIT0WZNFTf
 NLt6bb2STg2SrCxvShIMduYHKn0Z67pK4ijQP0iTnjWzJdId5wftLUylW7wa/klKcliXE1Z
 +KnG7hobHWc7p+0sTuTiRZdtG0J7iT7v0HlxRYRDAMywvC2bpeUMr8KBC0nAV//FfRBfmuo
 sA+dK1tne+z
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

Expose the DP Colorspace property and carry VSC packets in bridge atomic
state. Validate VSC support against cached sink capabilities and check it
again after powering up the sink. Regenerate the packet if link training
changes the SDR bit depth.

Signal full-range RGB, matching the existing pixel path, and retain CTA
range for YUV420. Reject BT2020_RGB with a YUV420-only mode. Clear stale
MSA colorimetry bits and include VSC removal in peripheral flush requests.

Force a modeset when colorspace changes. Disable PSR in the controller and
sink while colorimetry VSC packets are active, since they cannot share the
automatic PSR packet generator. Restore PSR configuration when returning
to a stream that does not need colorimetry VSC packets.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 33 ++++++++++++++++------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_drm.c     | 13 +++++++--
 drivers/gpu/drm/msm/dp/dp_drm.h     |  3 ++
 drivers/gpu/drm/msm/dp/dp_panel.c   | 56 +++++--------------------------------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  4 +++
 drivers/gpu/drm/msm/dp/dp_utils.c   | 38 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_utils.h   |  7 +++++
 9 files changed, 118 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index f41924e75854..3362d65ee4e2 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -411,7 +411,7 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
 
 	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
 
-	if (msm_dp_panel->psr_cap.version)
+	if (msm_dp_panel->psr_cap.version && !msm_dp_panel->vsc_enabled)
 		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
 
 	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
@@ -476,7 +476,8 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
 
 	/* clear bpp bits */
-	misc_val &= ~(0x07 << DP_MISC0_TEST_BITS_DEPTH_SHIFT);
+	misc_val &= ~((0x07 << DP_MISC0_TEST_BITS_DEPTH_SHIFT) |
+		      GENMASK(4, 1));
 	misc_val |= colorimetry_cfg << DP_MISC0_COLORIMETRY_CFG_SHIFT;
 	misc_val |= test_bits_depth << DP_MISC0_TEST_BITS_DEPTH_SHIFT;
 	/* Configure clock to synchronous mode */
@@ -1913,7 +1914,7 @@ static void msm_dp_ctrl_psr_exit(struct msm_dp_ctrl_private *ctrl)
 }
 
 void msm_dp_ctrl_config_psr(struct msm_dp_ctrl *msm_dp_ctrl,
-			    struct msm_dp_panel *panel)
+			    struct msm_dp_panel *panel, bool enable)
 {
 	struct msm_dp_ctrl_private *ctrl = container_of(msm_dp_ctrl,
 			struct msm_dp_ctrl_private, msm_dp_ctrl);
@@ -1922,15 +1923,20 @@ void msm_dp_ctrl_config_psr(struct msm_dp_ctrl *msm_dp_ctrl,
 	if (!panel->psr_cap.version)
 		return;
 
-	/* enable PSR1 function */
+	/* Colorimetry VSC packets cannot share the PSR packet generator. */
 	cfg = msm_dp_read_link(ctrl, REG_PSR_CONFIG);
-	cfg |= PSR1_SUPPORTED;
+	if (enable)
+		cfg |= PSR1_SUPPORTED;
+	else
+		cfg &= ~PSR1_SUPPORTED;
 	msm_dp_write_link(ctrl, REG_PSR_CONFIG, cfg);
 
-	msm_dp_ctrl_config_psr_interrupt(ctrl);
-	msm_dp_ctrl_enable_sdp(ctrl);
+	if (enable) {
+		msm_dp_ctrl_config_psr_interrupt(ctrl);
+		msm_dp_ctrl_enable_sdp(ctrl);
+	}
 
-	cfg = DP_PSR_ENABLE;
+	cfg = enable ? DP_PSR_ENABLE : 0;
 	drm_dp_dpcd_write(ctrl->aux, DP_PSR_EN_CFG, &cfg, 1);
 }
 
@@ -2635,6 +2641,17 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 		panel->msm_dp_mode.bpp = ret;
 	}
 
+	if (panel->vsc_enabled) {
+		if (!panel->vsc_sdp_supported)
+			return -EINVAL;
+
+		ret = msm_dp_utils_pack_vsc_sdp(&panel->vsc_sdp, panel->colorspace,
+						panel->msm_dp_mode.bpp / 3,
+						panel->msm_dp_mode.out_fmt_is_yuv_420);
+		if (ret)
+			return ret;
+	}
+
 	pixel_rate_orig = panel->msm_dp_mode.drm_mode.clock;
 	pixel_rate = pixel_rate_orig;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 42c5f847cb02..4dd604ef9f1b 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -46,7 +46,7 @@ void msm_dp_ctrl_irq_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_set_psr(struct msm_dp_ctrl *msm_dp_ctrl,
 			 struct msm_dp_panel *panel, bool enable);
 void msm_dp_ctrl_config_psr(struct msm_dp_ctrl *msm_dp_ctrl,
-			    struct msm_dp_panel *panel);
+			    struct msm_dp_panel *panel, bool enable);
 
 int msm_dp_ctrl_core_clk_enable(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_core_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index af6bc179723c..65ac35e41ed8 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -676,6 +676,10 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	else
 		bpp = state->bpp;
 
+	msm_dp_panel->sdp_needs_flush = msm_dp_panel->vsc_enabled || state->vsc_enabled;
+	msm_dp_panel->colorspace = state->colorspace;
+	msm_dp_panel->vsc_enabled = state->vsc_enabled;
+	msm_dp_panel->vsc_sdp = state->vsc_sdp;
 	msm_dp_panel_init_panel_info(msm_dp_panel, adjusted_mode, bpp ? bpp : 24);
 
 	/* populate wide_bus_support to different layers */
@@ -709,7 +713,17 @@ int msm_dp_display_atomic_check(struct msm_dp *msm_dp_display,
 		return bpp;
 
 	state->bpp = bpp;
-	return 0;
+	state->colorspace = conn_state->colorspace;
+	state->vsc_enabled = drm_mode_is_420_only(info, mode) ||
+			     state->colorspace != DRM_MODE_COLORIMETRY_DEFAULT;
+	if (!state->vsc_enabled)
+		return 0;
+
+	if (dp->panel->link_caps_valid && !dp->panel->vsc_sdp_supported)
+		return -EINVAL;
+
+	return msm_dp_utils_pack_vsc_sdp(&state->vsc_sdp, state->colorspace,
+					bpp / 3, drm_mode_is_420_only(info, mode));
 }
 
 static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
@@ -734,6 +748,9 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 
 	dp->stream_pm_active = true;
 
+	if (dp->panel->vsc_enabled && !dp->panel->vsc_sdp_supported)
+		return -EINVAL;
+
 	if (dp->link->sink_count == 0)
 		return -ENOTCONN;
 
@@ -791,7 +808,7 @@ static int msm_dp_display_post_enable(struct msm_dp *msm_dp_display)
 	msm_dp_display_handle_plugged_change(msm_dp_display, true);
 
 	if (msm_dp_display->psr_supported)
-		msm_dp_ctrl_config_psr(dp->ctrl, dp->panel);
+		msm_dp_ctrl_config_psr(dp->ctrl, dp->panel, !dp->panel->vsc_enabled);
 
 	return 0;
 }
@@ -1461,7 +1478,10 @@ void __exit msm_dp_unregister(void)
 bool msm_dp_needs_periph_flush(const struct msm_dp *msm_dp_display,
 			       const struct drm_display_mode *mode)
 {
-	return drm_mode_is_420_only(&msm_dp_display->connector->display_info, mode);
+	struct msm_dp_display_private *dp = container_of(msm_dp_display,
+					struct msm_dp_display_private, msm_dp_display);
+
+	return dp->panel->sdp_needs_flush;
 }
 
 bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 7c18ddcdd19b..48f2b7e79683 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -171,7 +171,7 @@ static int msm_dp_bridge_atomic_check(struct drm_bridge *bridge,
 
 	old_conn_state = drm_atomic_get_old_connector_state(conn_state->state,
 							    conn_state->connector);
-	if (old_conn_state->max_requested_bpc != conn_state->max_requested_bpc)
+	if (msm_dp_utils_needs_modeset(old_conn_state, conn_state))
 		crtc_state->mode_changed = true;
 
 	return 0;
@@ -208,12 +208,13 @@ static int msm_edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
 	if (WARN_ON(!conn_state))
 		return -ENODEV;
 
-	conn_state->self_refresh_aware = dp->psr_supported;
+	conn_state->self_refresh_aware = dp->psr_supported &&
+		conn_state->colorspace == DRM_MODE_COLORIMETRY_DEFAULT;
 
 	if (!conn_state->crtc || !crtc_state)
 		return 0;
 
-	if (crtc_state->self_refresh_active && !dp->psr_supported)
+	if (crtc_state->self_refresh_active && !conn_state->self_refresh_aware)
 		return -EINVAL;
 
 	return msm_dp_bridge_atomic_check(drm_bridge, bridge_state, crtc_state, conn_state);
@@ -453,6 +454,12 @@ struct drm_connector *msm_dp_drm_connector_init(struct msm_dp *msm_dp_display,
 	if (IS_ERR(connector))
 		return connector;
 
+	ret = drm_mode_create_dp_colorspace_property(connector,
+						     BIT(DRM_MODE_COLORIMETRY_BT2020_RGB));
+	if (ret)
+		return ERR_PTR(ret);
+	drm_connector_attach_colorspace_property(connector);
+
 	ret = drm_connector_attach_max_bpc_property(connector, 6, 10);
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index cd755f7205ef..c9bd79949f79 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -20,6 +20,9 @@ struct msm_dp_bridge {
 struct msm_dp_bridge_state {
 	struct drm_bridge_state base;
 	u32 bpp;
+	enum drm_colorspace colorspace;
+	bool vsc_enabled;
+	struct dp_sdp vsc_sdp;
 };
 
 #define to_dp_bridge_state(x) container_of((x), struct msm_dp_bridge_state, base)
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index f288571798d3..69327333f7f1 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -482,14 +482,14 @@ void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sd
 	cfg2 = msm_dp_read_link(panel, MMSS_DP_SDP_CFG2);
 	misc = msm_dp_read_link(panel, REG_DP_MISC1_MISC0);
 
+	msm_dp_panel_send_sdp(panel, vsc_sdp, MMSS_DP_GENERIC0_0);
+
 	cfg |= GEN0_SDP_EN;
 	msm_dp_write_link(panel, MMSS_DP_SDP_CFG, cfg);
 
 	cfg2 |= GENERIC0_SDPSIZE_VALID;
 	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2, cfg2);
 
-	msm_dp_panel_send_sdp(panel, vsc_sdp, MMSS_DP_GENERIC0_0);
-
 	/* indicates presence of VSC (BIT(6) of MISC1) */
 	misc |= DP_MISC1_VSC_SDP;
 
@@ -528,49 +528,6 @@ void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel)
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
@@ -640,8 +597,10 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 
 	msm_dp_write_p0(panel, MMSS_DP_INTF_CONFIG, reg);
 
-	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
-		msm_dp_panel_setup_vsc_sdp_yuv_420(msm_dp_panel);
+	if (msm_dp_panel->vsc_enabled)
+		msm_dp_panel_enable_vsc_sdp(msm_dp_panel, &msm_dp_panel->vsc_sdp);
+	else
+		msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	panel->panel_on = true;
 
@@ -664,8 +623,7 @@ int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel,
 	msm_dp_panel->msm_dp_mode.h_active_low =
 		!!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
 	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
-		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode) &&
-		msm_dp_panel->vsc_sdp_supported;
+		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode);
 
 	drm_mode = &msm_dp_panel->msm_dp_mode.drm_mode;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 4fe6af8b304e..4b3403b7a300 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -39,6 +39,10 @@ struct msm_dp_panel {
 	bool video_test;
 	bool vsc_sdp_supported;
 	bool link_caps_valid;
+	bool vsc_enabled;
+	bool sdp_needs_flush;
+	enum drm_colorspace colorspace;
+	struct dp_sdp vsc_sdp;
 	u32 hw_revision;
 
 	u32 max_bw_code;
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.c b/drivers/gpu/drm/msm/dp/dp_utils.c
index 3e49854d73fb..657d376d32da 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.c
+++ b/drivers/gpu/drm/msm/dp/dp_utils.c
@@ -109,6 +109,44 @@ int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
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
+	case DRM_MODE_COLORIMETRY_BT2020_RGB:
+		if (yuv420)
+			return -EINVAL;
+		vsc.colorimetry = DP_COLORIMETRY_BT2020_RGB;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = drm_dp_vsc_sdp_pack(&vsc, sdp);
+	return ret < 0 ? ret : 0;
+}
+
+bool msm_dp_utils_needs_modeset(struct drm_connector_state *old_state,
+				struct drm_connector_state *new_state)
+{
+	return old_state->max_requested_bpc != new_state->max_requested_bpc ||
+	       old_state->colorspace != new_state->colorspace;
+}
+
 bool msm_dp_utils_psr_needs_modeset(const struct drm_crtc_state *state)
 {
 	/* active_changed alone also describes a normal self-refresh exit. */
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.h b/drivers/gpu/drm/msm/dp/dp_utils.h
index a32e313d910d..146c652e995e 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.h
+++ b/drivers/gpu/drm/msm/dp/dp_utils.h
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <drm/display/drm_dp_helper.h>
+#include <drm/drm_connector.h>
 
 struct drm_crtc_state;
 
@@ -40,6 +41,12 @@ int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
 			    unsigned int clock, unsigned int rate,
 			    unsigned int lanes);
 
+int msm_dp_utils_pack_vsc_sdp(struct dp_sdp *sdp, enum drm_colorspace colorspace,
+			      unsigned int bpc, bool yuv420);
+
+bool msm_dp_utils_needs_modeset(struct drm_connector_state *old_state,
+				struct drm_connector_state *new_state);
+
 bool msm_dp_utils_psr_needs_modeset(const struct drm_crtc_state *state);
 
 #endif /* _DP_UTILS_H_ */

-- 
2.55.0

