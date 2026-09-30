Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904DACA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25D010F39E;
	Wed, 30 Sep 2026 12:44:36 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE04510F385
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:44:29 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772174ta32d3171
X-QQ-Originating-IP: cvbtagFVldLf1cxkwPqKGdlGX28MIe1Zfv5Repufqlw=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15937371401357380825
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:57 +0800
Subject: [PATCH 13/13] drm/msm/dp: Add static HDR metadata support for DP
 and eDP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-13-dbbf8b2b42bc@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15976; i=sophon@radxa.com;
 h=from:subject:message-id; bh=SMbBEo5d286bZUUNOmjsact23FtsbuI2zEHc/+9Bj2A=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZfHbZdY9OCllnjNRsa8Ru8j8gJ733BeyP4y/enej
 81LNzE5dZSyMIhxMciKKbIoxDPMZa/MvfZUrFQPZg4rE8gQBi5OAZjIVj1Ghq5L+oulw042l99a
 pjL1svVWIYUZZz0nvdY+V9sf0nZ8z1eGf8Z32Ljme27Wc6h7wpGlc0qx1q9g/7GKz37/6hedDzs
 XzAYA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OYpbVsTx4C81YrmfP9LqTjRx78a+LxUqW5KBHjD4G86cFxNRnsBoChxP
 h3wjuyzvEaYq64molhm/tzBldFtk2PcD60fzmGeXO3T4SFQ6ELh1RNSdN5cFZGcPpafM8in
 l6lYcdb49JC11sWyUN5iva62jFqj8/qg9JVPPi4iKFXsuPrmWxSU4GsjT7Ws9Vc+gdLBw+1
 12FvIIaysnn859X4PD43gU2LC+Rugli6sHIbcigqX+V68Rg5gKL1T/g2DZ9ir7xgccXo8TL
 MXU/jvDGZ4/fc550aqE2Zxx+1GnzmHUdJwVYhhscb7wDCg2A7vjusSocR6kS+whocq3x9pO
 2SFWa5vlMbhwkHyv/gnFOV1XekZezEZ9wqQihwzDTS1kMxSn16qatb3XjYoKRcSIVLufu4v
 6W7zA7Z99dvL9L105B/rbzZHoVyc14um19JF6PTKY5JBHnGJ6a0npRM93Yo728BG3NK5U38
 mk5cWYEKV39VbQLEpC4IYlStAtAV01y5g/fmRNLJliNqom6s6DwWEDe32QDio6SLlTBkCv0
 amKbp3UZeYKwShAv1uRHXvs17kl5WWW89dBLdx9U147FPMgE4ZCstQpFjgHoD7dyWcPfu8n
 F8g/av4/pqVyM0RwKvMkWjG2vvpbP68l+85wqkWFXXTZ3RR6k2Dgm7+I8lrnIqxQlCeMtqK
 dcAb4mA2CStmlroGb5E2ZGs+uqF0E52u78VAb65nXKWTghRWoGwwHEL9/rmVBabK4keQrWr
 5b+YwRjG36V6ew8TTc3zcf1yegNvXpMqeWedGIQ1hhJEh3IK7gq5n3ItlwfGo9cf5keuJEp
 MiEYJny7PD7XLoCxp+j+VnxrJxzt2kyeRyaBofmYyzEnbC3EAN1/pm0qrTjlkJJrhI/to9O
 Q4z/gAsgdnkUKnb3pnj4phhziLY6n2dCFq3KMVoR0pqe4lx87geDfZvxJMFhPneKYfkGvom
 /vS64IUZRRh/3lgG+G5Qq7U8jlGyHDgyjCTk212CPm/tOXgowAuDED2XCCyWuJ7ddW+kFkD
 qUCLC/Ox6cHi/LtxKJu/7wyOy+9jtUsZlLz24zeo+/WqhVZh5H
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

Expose HDR_OUTPUT_METADATA and validate and pack it during atomic check.
Program Generic2 from the checked bridge state on every stream enable.
Reuse the DRM metadata conversion and infoframe packing helpers, omit
the HDMI checksum when constructing the DP SDP, and zero reserved bytes.

Require 10 bpc for HDR transfer functions and reject insufficient
bandwidth after link training instead of silently reducing color depth.
Revalidate sink HDR capabilities after powering up an eDP panel, using
the stream enable failure path if the requested output is unsupported.

Force a modeset for metadata changes and include metadata enable and
disable in peripheral flush requests. Keep HDR streams out of PSR and
clear Generic2 enable state when disabling the stream. Preserve the
software metadata across teardown so that every stream rebuild restores
the checked packets.

Give checked HDR modesets precedence over SDR video-pattern tests. Reject
new test requests with NAK while HDR is configured and return -EBUSY from
the debugfs test control. Clear the test override under plugged_lock when
applying HDR so that a request arriving after atomic check cannot replace
the checked output depth. Keep pending test colorimetry from overriding
HDR signalling. Atomic checks leave the running test state untouched.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/Kconfig         |  1 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  9 ++++--
 drivers/gpu/drm/msm/dp/dp_display.c | 39 +++++++++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_drm.c     |  4 ++-
 drivers/gpu/drm/msm/dp/dp_drm.h     |  2 ++
 drivers/gpu/drm/msm/dp/dp_panel.c   | 33 ++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_panel.h   |  3 ++
 drivers/gpu/drm/msm/dp/dp_utils.c   | 61 ++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_utils.h   |  5 ++-
 9 files changed, 145 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index ed1c4775d1e9..e988e6509ec8 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -119,6 +119,7 @@ config DRM_MSM_DP
 	depends on DRM_MSM
 	depends on DRM_MSM_KMS
 	select DRM_DISPLAY_HDMI_AUDIO_HELPER
+	select DRM_DISPLAY_HDMI_HELPER
 	select RATIONAL
 	select DRM_DISPLAY_DP_AUX_BUS
 	select DRM_DISPLAY_DP_HELPER
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 3362d65ee4e2..56a18fdb9d18 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -471,7 +471,9 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 
 	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link,
 							  msm_dp_panel->msm_dp_mode.bpp);
-	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
+	/* A video test request must not override the HDR quantization range. */
+	colorimetry_cfg = msm_dp_panel->hdr_enabled ? DP_MISC0_COLORIMERY_CFG_LEGACY_RGB :
+		msm_dp_link_get_colorimetry_config(ctrl->link);
 
 	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
 
@@ -2635,7 +2637,9 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 			clock /= 2;
 		ret = msm_dp_utils_select_bpp(panel->msm_dp_mode.bpp / 3, 10,
 					      clock, ctrl->link->link_params.rate,
-					      ctrl->link->link_params.num_lanes);
+					      ctrl->link->link_params.num_lanes,
+					      panel->hdr_enabled && panel->hdr_sdp.db[2] !=
+					      HDMI_EOTF_TRADITIONAL_GAMMA_SDR);
 		if (ret < 0)
 			return ret;
 		panel->msm_dp_mode.bpp = ret;
@@ -2721,6 +2725,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	/* Link startup may have failed before enabling the link clocks. */
 	if (ctrl->link_clks_on) {
 		msm_dp_panel_disable_vsc_sdp(panel);
+		msm_dp_panel_disable_hdr_sdp(panel);
 		msm_dp_ctrl_mainlink_disable(ctrl);
 	}
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index ec65800f629a..ad2359818ff2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -431,6 +431,9 @@ static int msm_dp_display_set_video_test_locked(struct msm_dp_display_private *d
 {
 	lockdep_assert_held(&dp->plugged_lock);
 
+	if (enable && dp->panel->hdr_enabled)
+		return -EBUSY;
+
 	dp->panel->video_test = enable;
 	return 0;
 }
@@ -683,12 +686,19 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 
 	guard(mutex)(&dp->plugged_lock);
 
+	/* A checked HDR modeset supersedes any intervening video test request. */
+	if (state->hdr_enabled)
+		dp->panel->video_test = false;
+
 	if (dp->panel->video_test)
 		bpp = msm_dp_link_bit_depth_to_bpp(dp->link->test_video.test_bit_depth);
 	else
 		bpp = state->bpp;
 
-	msm_dp_panel->sdp_needs_flush = msm_dp_panel->vsc_enabled || state->vsc_enabled;
+	msm_dp_panel->sdp_needs_flush = msm_dp_panel->vsc_enabled || state->vsc_enabled ||
+		msm_dp_panel->hdr_enabled || state->hdr_enabled;
+	msm_dp_panel->hdr_enabled = state->hdr_enabled;
+	msm_dp_panel->hdr_sdp = state->hdr_sdp;
 	msm_dp_panel->colorspace = state->colorspace;
 	msm_dp_panel->vsc_enabled = state->vsc_enabled;
 	msm_dp_panel->vsc_sdp = state->vsc_sdp;
@@ -708,7 +718,7 @@ int msm_dp_display_atomic_check(struct msm_dp *msm_dp_display,
 	const struct drm_display_info *info = &conn_state->connector->display_info;
 	struct msm_dp_display_private *dp;
 	unsigned int clock = mode->clock;
-	int bpp;
+	int bpp, ret;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
@@ -717,17 +727,25 @@ int msm_dp_display_atomic_check(struct msm_dp *msm_dp_display,
 
 	guard(mutex)(&dp->plugged_lock);
 
+	ret = msm_dp_utils_pack_hdr_sdp(conn_state, &state->hdr_sdp);
+	if (ret)
+		return ret;
+
+	state->hdr_enabled = !!conn_state->hdr_output_metadata;
 	bpp = msm_dp_utils_select_bpp(info->bpc, conn_state->max_requested_bpc,
 				      clock, dp->panel->link_caps_valid ?
 				      dp->panel->link_info.rate : 0,
-				      dp->panel->link_info.num_lanes);
+				      dp->panel->link_info.num_lanes,
+				      state->hdr_enabled && state->hdr_sdp.db[2] !=
+				      HDMI_EOTF_TRADITIONAL_GAMMA_SDR);
 	if (bpp < 0)
 		return bpp;
 
 	state->bpp = bpp;
 	state->colorspace = conn_state->colorspace;
 	state->vsc_enabled = drm_mode_is_420_only(info, mode) ||
-			     state->colorspace != DRM_MODE_COLORIMETRY_DEFAULT;
+			     state->colorspace != DRM_MODE_COLORIMETRY_DEFAULT ||
+			     state->hdr_enabled;
 	if (!state->vsc_enabled)
 		return 0;
 
@@ -760,6 +778,18 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 
 	dp->stream_pm_active = true;
 
+	if (dp->panel->hdr_enabled) {
+		const struct drm_display_info *info = &msm_dp_display->connector->display_info;
+		const struct hdr_static_metadata *hdr = &info->hdr_sink_metadata.hdmi_type1;
+		u8 eotf = dp->panel->hdr_sdp.db[2];
+
+		if (dp->panel->hw_revision < DP_HW_VERSION_1_0 ||
+		    !(hdr->metadata_type & BIT(HDMI_STATIC_METADATA_TYPE1)) ||
+		    !(hdr->eotf & BIT(eotf)) ||
+		    (eotf != HDMI_EOTF_TRADITIONAL_GAMMA_SDR && info->bpc < 10))
+			return -EINVAL;
+	}
+
 	if (dp->panel->vsc_enabled && !dp->panel->vsc_sdp_supported)
 		return -EINVAL;
 
@@ -850,6 +880,7 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 		return 0;
 
 	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
+	msm_dp_panel_disable_hdr_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 48f2b7e79683..1ee57c7365ba 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -209,7 +209,8 @@ static int msm_edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
 		return -ENODEV;
 
 	conn_state->self_refresh_aware = dp->psr_supported &&
-		conn_state->colorspace == DRM_MODE_COLORIMETRY_DEFAULT;
+		conn_state->colorspace == DRM_MODE_COLORIMETRY_DEFAULT &&
+		!conn_state->hdr_output_metadata;
 
 	if (!conn_state->crtc || !crtc_state)
 		return 0;
@@ -459,6 +460,7 @@ struct drm_connector *msm_dp_drm_connector_init(struct msm_dp *msm_dp_display,
 	if (ret)
 		return ERR_PTR(ret);
 	drm_connector_attach_colorspace_property(connector);
+	drm_connector_attach_hdr_output_metadata_property(connector);
 
 	ret = drm_connector_attach_max_bpc_property(connector, 6, 10);
 	if (ret)
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index c9bd79949f79..42bf0566a736 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -23,6 +23,8 @@ struct msm_dp_bridge_state {
 	enum drm_colorspace colorspace;
 	bool vsc_enabled;
 	struct dp_sdp vsc_sdp;
+	bool hdr_enabled;
+	struct dp_sdp hdr_sdp;
 };
 
 #define to_dp_bridge_state(x) container_of((x), struct msm_dp_bridge_state, base)
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 69327333f7f1..cac63e14bee2 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -528,6 +528,34 @@ void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel)
 	msm_dp_panel_update_sdp(panel);
 }
 
+static void msm_dp_panel_enable_hdr_sdp(struct msm_dp_panel *msm_dp_panel)
+{
+	struct msm_dp_panel_private *panel =
+		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
+	u32 cfg, cfg2;
+
+	msm_dp_panel_send_sdp(panel, &msm_dp_panel->hdr_sdp, MMSS_DP_GENERIC2_0);
+
+	cfg2 = msm_dp_read_link(panel, MMSS_DP_SDP_CFG2);
+	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2, cfg2 | GENERIC2_SDPSIZE_VALID);
+	cfg = msm_dp_read_link(panel, MMSS_DP_SDP_CFG);
+	msm_dp_write_link(panel, MMSS_DP_SDP_CFG, cfg | GEN2_SDP_EN);
+	msm_dp_panel_update_sdp(panel);
+}
+
+void msm_dp_panel_disable_hdr_sdp(struct msm_dp_panel *msm_dp_panel)
+{
+	struct msm_dp_panel_private *panel =
+		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
+	u32 cfg, cfg2;
+
+	cfg = msm_dp_read_link(panel, MMSS_DP_SDP_CFG);
+	msm_dp_write_link(panel, MMSS_DP_SDP_CFG, cfg & ~GEN2_SDP_EN);
+	cfg2 = msm_dp_read_link(panel, MMSS_DP_SDP_CFG2);
+	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2, cfg2 & ~GENERIC2_SDPSIZE_VALID);
+	msm_dp_panel_update_sdp(panel);
+}
+
 int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 {
 	u32 data, total_ver, total_hor;
@@ -602,6 +630,11 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 	else
 		msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
+	if (msm_dp_panel->hdr_enabled)
+		msm_dp_panel_enable_hdr_sdp(msm_dp_panel);
+	else
+		msm_dp_panel_disable_hdr_sdp(msm_dp_panel);
+
 	panel->panel_on = true;
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 4b3403b7a300..fcf4315b6ac9 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -43,6 +43,8 @@ struct msm_dp_panel {
 	bool sdp_needs_flush;
 	enum drm_colorspace colorspace;
 	struct dp_sdp vsc_sdp;
+	bool hdr_enabled;
+	struct dp_sdp hdr_sdp;
 	u32 hw_revision;
 
 	u32 max_bw_code;
@@ -65,6 +67,7 @@ void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel);
 
 void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sdp *vsc_sdp);
 void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel);
+void msm_dp_panel_disable_hdr_sdp(struct msm_dp_panel *msm_dp_panel);
 
 /**
  * is_link_rate_valid() - validates the link rate
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.c b/drivers/gpu/drm/msm/dp/dp_utils.c
index 657d376d32da..33f5c349e89c 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.c
+++ b/drivers/gpu/drm/msm/dp/dp_utils.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/types.h>
+#include <drm/display/drm_hdmi_helper.h>
+#include <drm/drm_property.h>
 #include <drm/drm_crtc.h>
 
 #include "dp_utils.h"
@@ -92,16 +94,19 @@ void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
 /* A zero link rate means that a powered-down eDP panel has not been probed. */
 int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
 			    unsigned int clock, unsigned int rate,
-			    unsigned int lanes)
+			    unsigned int lanes, bool hdr)
 {
 	unsigned int bpp;
 
+	if (hdr && bpc < 10)
+		return -EINVAL;
+
 	bpc = min3(bpc ? bpc : 8, max_bpc, 10U);
 	bpc = round_down(bpc, 2);
-	if (bpc < 6)
+	if (bpc < (hdr ? 10 : 6))
 		return -EINVAL;
 
-	for (bpp = bpc * 3; bpp >= 18; bpp -= 6) {
+	for (bpp = bpc * 3; bpp >= (hdr ? 30 : 18); bpp -= 6) {
 		if (!rate || (u64)clock * bpp <= (u64)rate * lanes * 8)
 			return bpp;
 	}
@@ -140,11 +145,59 @@ int msm_dp_utils_pack_vsc_sdp(struct dp_sdp *sdp, enum drm_colorspace colorspace
 	return ret < 0 ? ret : 0;
 }
 
+int msm_dp_utils_pack_hdr_sdp(const struct drm_connector_state *conn_state,
+			      struct dp_sdp *sdp)
+{
+	const struct hdr_output_metadata *metadata;
+	const struct hdr_static_metadata *sink;
+	struct hdmi_drm_infoframe frame;
+	u8 buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFOFRAME_SIZE];
+	int ret;
+
+	memset(sdp, 0, sizeof(*sdp));
+	if (!conn_state->hdr_output_metadata)
+		return 0;
+
+	if (conn_state->hdr_output_metadata->length != sizeof(*metadata))
+		return -EINVAL;
+
+	metadata = conn_state->hdr_output_metadata->data;
+	sink = &conn_state->connector->display_info.hdr_sink_metadata.hdmi_type1;
+	if (metadata->metadata_type != HDMI_STATIC_METADATA_TYPE1 ||
+	    metadata->hdmi_metadata_type1.metadata_type != HDMI_STATIC_METADATA_TYPE1 ||
+	    metadata->hdmi_metadata_type1.eotf > HDMI_EOTF_BT_2100_HLG)
+		return -EINVAL;
+
+	if (!(sink->metadata_type & BIT(HDMI_STATIC_METADATA_TYPE1)) ||
+	    !(sink->eotf & BIT(metadata->hdmi_metadata_type1.eotf)))
+		return -EINVAL;
+
+	ret = drm_hdmi_infoframe_set_hdr_metadata(&frame, conn_state);
+	if (ret)
+		return ret;
+
+	ret = hdmi_drm_infoframe_pack_only(&frame, buffer, sizeof(buffer));
+	if (ret < 0)
+		return ret;
+
+	sdp->sdp_header.HB1 = HDMI_INFOFRAME_TYPE_DRM;
+	sdp->sdp_header.HB2 = 0x1d;
+	sdp->sdp_header.HB3 = 0x13 << 2;
+	sdp->db[0] = frame.version;
+	sdp->db[1] = frame.length;
+	/* DP carries the version and length, but no HDMI checksum. */
+	memcpy(&sdp->db[2], &buffer[HDMI_INFOFRAME_HEADER_SIZE],
+	       HDMI_DRM_INFOFRAME_SIZE);
+
+	return 0;
+}
+
 bool msm_dp_utils_needs_modeset(struct drm_connector_state *old_state,
 				struct drm_connector_state *new_state)
 {
 	return old_state->max_requested_bpc != new_state->max_requested_bpc ||
-	       old_state->colorspace != new_state->colorspace;
+	       old_state->colorspace != new_state->colorspace ||
+	       !drm_connector_atomic_hdr_metadata_equal(old_state, new_state);
 }
 
 bool msm_dp_utils_psr_needs_modeset(const struct drm_crtc_state *state)
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.h b/drivers/gpu/drm/msm/dp/dp_utils.h
index 146c652e995e..93b46ba186a2 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.h
+++ b/drivers/gpu/drm/msm/dp/dp_utils.h
@@ -39,11 +39,14 @@ void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
 
 int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
 			    unsigned int clock, unsigned int rate,
-			    unsigned int lanes);
+			    unsigned int lanes, bool hdr);
 
 int msm_dp_utils_pack_vsc_sdp(struct dp_sdp *sdp, enum drm_colorspace colorspace,
 			      unsigned int bpc, bool yuv420);
 
+int msm_dp_utils_pack_hdr_sdp(const struct drm_connector_state *conn_state,
+			      struct dp_sdp *sdp);
+
 bool msm_dp_utils_needs_modeset(struct drm_connector_state *old_state,
 				struct drm_connector_state *new_state);
 

-- 
2.55.0

