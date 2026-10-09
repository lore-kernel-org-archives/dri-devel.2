Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2061CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3248810FE42;
	Fri,  9 Oct 2026 03:20:19 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 116C510FE3E;
 Fri,  9 Oct 2026 03:20:16 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515901t4ada0de9
X-QQ-Originating-IP: xGKYoId2p8i5SQCboydz4Awc7nsTmpRW6JM3oIHy48c=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:18:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17029949889969259388
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:16:12 +0800
Subject: [PATCH v2 20/20] drm/msm/dp: Add static HDR metadata support for
 DP and eDP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-20-1835d4966da3@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16002; i=sophon@radxa.com;
 h=from:subject:message-id; bh=Yp5+PAKas8kqXJlGRMgTP9Z0Xs/+sCFXM7nj2OHPhGo=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlZ3S3dWzTh0373MNfXoz5DQOV/mstZmXbOStuLer
 fTR/3t/RykLgxgXg6yYIotCPMNc9srca0/FSvVg5rAygQxh4OIUgIlcdWVk2PkvLzWi8kdjvIb3
 15V+k+VrDNa6flt4eIKP8v6d9zdJ1jMydBzN6PMU4Eo5mLhelq+xRHm6xk41032tGzZmqbWIcRs
 wAgA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OCFGt05vYz7Y1S1tpBR8nDGxqYPKgngZ5Z+U2TeiAhd/RWO2SSb4ojox
 YdjguYrNnp3gTvt8wOdd6IKU6xBtAWgPR1QnGGj3CrcbgTltm7PQCBU2OR4ObPw3kwbS/JH
 uie0/xRwORDdtriBE1wjUAfqBk0n5dlrDyg+ktHLceINQL4ZQS2XakeyU6T4Asd5yP1H5GB
 raNGbZ2ZhWTJetnL2Z3kxaNgFLEpI9zNupq1AQN6oSh7C4HJfwiw1Ih2hUTDpsA8mVRBVPM
 w8Ju+wN52c7cNzMOTsLO0zLCo/4dOzeZVLq1V7uhibcnynQi3tQifohYQFuOBP06NODC+3G
 3SL1KIGrUq82oUA9ED/vS1K9clRivCNrss6hnr/7zFfxU5Ge68inqXOzcvPo3ORcNRiDz3f
 egfXH2KBG+h1iVOAzEi4FVzB49oIrNz+Ur7g4T6z59TRfZpo8RrQin4jEi/v5G4KNgvrSLC
 kWIip2IZULbDV70G574ffjBEgzbjPOR6ApAnJvpCvIUqe5VDL6oTFb/2S3qnL1yzyzseVPs
 xhXGeAYyGojuaL9ZNAv+pwylYlJp7IPwAv8PYfp1wXw+hiM9cIeTWRG7Dx02t9LCbhTo+DF
 PukLZM9KfSWcg/YrUm7f7oBK+fUQ/rmXbVYnAxCtbMHeSwgGsAPZDJ/6s7zYwJSf6ogkglS
 +l2vp6zUIQrXOZPppNgY/dlsZucMgAVX72aYVu34UMZafKg5aAuBFQ6MerStZRvS+9jOHYh
 GFZ7q3uub8csW8Wqbi74NE5cgys0GriDwM5DlvXKfk8TlKqAg078KGOl6sot6JxER/ICb//
 UlT8fXFgQcUhEwywoHJqIZx35Zzb2BiQdC7b5DiZBwuwkRXQcitia7Au4cLp9NAwqXOgrQy
 IEqzkdbGgB69DoQxip3su1gFp9ucel8JkWYCueof6N4oOeABlHC/rO0THRMKCqwlc4UtFpo
 VVUB4NDl70ycYM3ih/hnL6syfFUbdLxpWshLpc7ClW6fw8YE3pGwpUM7rgwlR7IYvgAkHEE
 wswytI22gT10O+YiYWdWyFa/yvaRH3rdrmi56qzjDcYFMUd/u+cmAKI43uJ3cUfWllNZLbz
 w==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

Check the cached controller revision and sink HDR capabilities before
accepting the atomic state. Require 10 bpc for HDR transfer functions
and validate link bandwidth during atomic check. Training must preserve
that depth; report a link failure if the trained link cannot carry the
stream.

Force a modeset for metadata changes and include metadata enable and
disable in peripheral flush requests. Keep HDR streams out of PSR and
clear Generic2 enable state when disabling the stream. Preserve the
checked metadata in bridge state so every stream rebuild restores its
packets. Pass state through stream programming without copying the
configuration into the panel.

Give checked HDR modesets precedence over SDR video-pattern tests.
Reject new test requests with NAK while HDR is pending or active and
return -EBUSY from the debugfs test control. Clear the test override
under plugged_lock when applying HDR so that a request arriving after
atomic check cannot replace the checked output depth. Keep pending test
colorimetry from overriding HDR signalling. Release the test exclusion
on disable or enable failure. Atomic checks leave the running test state
untouched.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/Kconfig         |  1 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 15 +++++++--
 drivers/gpu/drm/msm/dp/dp_display.c | 35 ++++++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_drm.c     |  1 +
 drivers/gpu/drm/msm/dp/dp_drm.h     |  2 ++
 drivers/gpu/drm/msm/dp/dp_panel.c   | 29 ++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_panel.h   |  3 ++
 drivers/gpu/drm/msm/dp/dp_utils.c   | 61 ++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_utils.h   |  5 ++-
 9 files changed, 140 insertions(+), 12 deletions(-)

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
index a1a649c636c7..cc1914f7cf18 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -467,13 +467,16 @@ static void msm_dp_ctrl_lane_mapping(struct msm_dp_ctrl_private *ctrl)
 }
 
 static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
-					   struct msm_dp_panel *msm_dp_panel)
+					   struct msm_dp_panel *msm_dp_panel,
+					   const struct msm_dp_bridge_state *state)
 {
 	u32 colorimetry_cfg, test_bits_depth, misc_val;
 
 	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link,
 							  msm_dp_panel->msm_dp_mode.bpp);
-	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
+	/* A video test request must not override the HDR quantization range. */
+	colorimetry_cfg = state->hdr_enabled ? DP_MISC0_COLORIMERY_CFG_LEGACY_RGB :
+		msm_dp_link_get_colorimetry_config(ctrl->link);
 
 	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
 
@@ -496,7 +499,7 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 {
 	msm_dp_ctrl_config_ctrl_streams(ctrl, panel, !state->vsc_enabled);
 
-	msm_dp_ctrl_config_misc1_misc0(ctrl, panel);
+	msm_dp_ctrl_config_misc1_misc0(ctrl, panel, state);
 
 	msm_dp_panel_timing_cfg(panel, ctrl->msm_dp_ctrl.wide_bus_en);
 
@@ -504,6 +507,11 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 		msm_dp_panel_enable_vsc_sdp(panel, vsc_sdp);
 	else
 		msm_dp_panel_disable_vsc_sdp(panel);
+
+	if (state->hdr_enabled)
+		msm_dp_panel_enable_hdr_sdp(panel, &state->hdr_sdp);
+	else
+		msm_dp_panel_disable_hdr_sdp(panel);
 }
 
 /*
@@ -2747,6 +2755,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	/* Link startup may have failed before enabling the link clocks. */
 	if (ctrl->link_clks_on) {
 		msm_dp_panel_disable_vsc_sdp(panel);
+		msm_dp_panel_disable_hdr_sdp(panel);
 		msm_dp_ctrl_mainlink_disable(ctrl);
 	}
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c51d033598a5..7104822b03e0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -58,6 +58,8 @@ struct msm_dp_display_private {
 	bool audio_supported;
 	/* Pending DPU peripheral flush, set before encoder enable. */
 	bool sdp_needs_flush;
+	/* Block asynchronous video tests while an HDR stream is pending or active. */
+	bool video_test_blocked;
 	bool stream_pm_active;
 	bool stream_link_attempted;
 	struct work_struct link_status_work;
@@ -440,6 +442,9 @@ static int msm_dp_display_set_video_test_locked(struct msm_dp_display_private *d
 {
 	lockdep_assert_held(&dp->plugged_lock);
 
+	if (enable && dp->video_test_blocked)
+		return -EBUSY;
+
 	dp->panel->video_test = enable;
 	return 0;
 }
@@ -701,12 +706,19 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 
 	guard(mutex)(&dp->plugged_lock);
 
+	dp->video_test_blocked = state->hdr_enabled;
+
+	/* A checked HDR modeset supersedes any intervening video test request. */
+	if (state->hdr_enabled)
+		dp->panel->video_test = false;
+
 	if (dp->panel->video_test)
 		bpp = msm_dp_link_bit_depth_to_bpp(dp->link->test_video.test_bit_depth);
 	else
 		bpp = state->bpp;
 
-	dp->sdp_needs_flush = old_state->vsc_enabled || state->vsc_enabled;
+	dp->sdp_needs_flush = old_state->vsc_enabled || state->vsc_enabled ||
+		old_state->hdr_enabled || state->hdr_enabled;
 	msm_dp_panel_init_panel_info(msm_dp_panel, adjusted_mode, bpp ? bpp : 24);
 
 	/* populate wide_bus_support to different layers */
@@ -723,7 +735,7 @@ int msm_dp_display_atomic_check(struct msm_dp *msm_dp_display,
 	const struct drm_display_info *info = &conn_state->connector->display_info;
 	struct msm_dp_display_private *dp;
 	unsigned int clock = mode->clock;
-	int bpp;
+	int bpp, ret;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
@@ -732,17 +744,28 @@ int msm_dp_display_atomic_check(struct msm_dp *msm_dp_display,
 	if (!dp->panel->link_caps_valid)
 		return -EINVAL;
 
+	ret = msm_dp_utils_pack_hdr_sdp(conn_state, &state->hdr_sdp);
+	if (ret)
+		return ret;
+
+	state->hdr_enabled = !!conn_state->hdr_output_metadata;
+	if (state->hdr_enabled && dp->panel->hw_revision < DP_HW_VERSION_1_0)
+		return -EINVAL;
+
 	bpp = msm_dp_utils_select_bpp(info->bpc, conn_state->max_requested_bpc ?: 8,
 				      clock, dp->panel->link_info.rate,
 				      dp->panel->link_info.num_lanes,
-				      drm_mode_is_420_only(info, mode));
+				      drm_mode_is_420_only(info, mode),
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
 
@@ -880,10 +903,13 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 
 	lockdep_assert_held(&dp->plugged_lock);
 
+	dp->video_test_blocked = false;
+
 	if (!msm_dp_display->power_on)
 		return 0;
 
 	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
+	msm_dp_panel_disable_hdr_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
@@ -1774,6 +1800,7 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 		msm_dp_hpd_unplug_handle(dp);
 	msm_dp_display_unprepare(dp);
 	scoped_guard(mutex, &dp->plugged_lock) {
+		dp->video_test_blocked = false;
 		dp->link_failed = true;
 		/* Keep reporting BAD, but notify only once until recovery. */
 		schedule_work(&dp->link_status_work);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 0d17536f02fd..16c9bd3afc1b 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -467,6 +467,7 @@ struct drm_connector *msm_dp_drm_connector_init(struct msm_dp *msm_dp_display,
 	if (ret)
 		return ERR_PTR(ret);
 	drm_connector_attach_colorspace_property(connector);
+	drm_connector_attach_hdr_output_metadata_property(connector);
 
 	if (!msm_dp_display->is_edp)
 		drm_connector_attach_dp_subconnector_property(connector);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index 0e85a1a55c88..89c0123af641 100644
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
index bbbe7dc62550..78ab2d280e11 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -572,6 +572,35 @@ void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel)
 	msm_dp_panel_update_sdp(panel);
 }
 
+void msm_dp_panel_enable_hdr_sdp(struct msm_dp_panel *msm_dp_panel,
+				 const struct dp_sdp *hdr_sdp)
+{
+	struct msm_dp_panel_private *panel =
+		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
+	u32 cfg, cfg2;
+
+	msm_dp_panel_send_sdp(panel, hdr_sdp, MMSS_DP_GENERIC2_0);
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
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 9b81042e1036..58a5f846f788 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -64,6 +64,9 @@ void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel);
 
 void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, const struct dp_sdp *vsc_sdp);
 void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel);
+void msm_dp_panel_enable_hdr_sdp(struct msm_dp_panel *msm_dp_panel,
+				 const struct dp_sdp *hdr_sdp);
+void msm_dp_panel_disable_hdr_sdp(struct msm_dp_panel *msm_dp_panel);
 
 /**
  * is_link_rate_valid() - validates the link rate
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.c b/drivers/gpu/drm/msm/dp/dp_utils.c
index 431c18aa2096..c7a42f130d42 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.c
+++ b/drivers/gpu/drm/msm/dp/dp_utils.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/types.h>
+#include <drm/display/drm_hdmi_helper.h>
+#include <drm/drm_property.h>
 #include <drm/drm_crtc.h>
 
 #include "dp_utils.h"
@@ -105,16 +107,19 @@ bool msm_dp_utils_link_fits(unsigned int clock, unsigned int bpp,
 
 int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
 			    unsigned int clock, unsigned int rate,
-			    unsigned int lanes, bool yuv420)
+			    unsigned int lanes, bool yuv420, bool hdr)
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
 		if (msm_dp_utils_link_fits(clock, bpp, rate, lanes, yuv420))
 			return bpp;
 	}
@@ -153,11 +158,59 @@ int msm_dp_utils_pack_vsc_sdp(struct dp_sdp *sdp, enum drm_colorspace colorspace
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
index 81773db75c60..397a40a58e1c 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.h
+++ b/drivers/gpu/drm/msm/dp/dp_utils.h
@@ -41,11 +41,14 @@ bool msm_dp_utils_link_fits(unsigned int clock, unsigned int bpp,
 			    unsigned int rate, unsigned int lanes, bool yuv420);
 int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
 			    unsigned int clock, unsigned int rate,
-			    unsigned int lanes, bool yuv420);
+			    unsigned int lanes, bool yuv420, bool hdr);
 
 int msm_dp_utils_pack_vsc_sdp(struct dp_sdp *sdp, enum drm_colorspace colorspace,
 			      unsigned int bpc, bool yuv420);
 
+int msm_dp_utils_pack_hdr_sdp(const struct drm_connector_state *conn_state,
+			      struct dp_sdp *sdp);
+
 bool msm_dp_utils_needs_modeset(struct drm_connector_state *old_state,
 				struct drm_connector_state *new_state);
 

-- 
2.56.0

