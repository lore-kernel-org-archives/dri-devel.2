Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63ADCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C98010FE24;
	Fri,  9 Oct 2026 03:18:38 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9970A10FE24;
 Fri,  9 Oct 2026 03:18:36 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515866t71e3d01b
X-QQ-Originating-IP: XlFUefbhl4sAMn3DfDDBDLIyYAHUFnugasG9yn66LTA=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17315983410666108048
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:16:03 +0800
Subject: [PATCH v2 11/20] drm/msm/dp: Cache eDP link capabilities after
 successful discovery
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-11-1835d4966da3@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14005; i=sophon@radxa.com;
 h=from:subject:message-id; bh=0cZWchgsYeC8owEtTjQ8YPdkgt7kIw+pWVFaJqPAWfY=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlZ6q1S0maQxvN78PfvBqYfrch4vdfL9ryt/UHFBh
 NKhW18DO0pZGMS4GGTFFFkU4hnmslfmXnsqVqoHM4eVCWQIAxenAEzk3AZGhpV5YuwdO0vmP8lU
 NH92OKl9eq3L8WVX/8p/v5HO2XKgppzhn+qDKUviPnM9Mz2nL/DA8s9rxr6EVq99sTn69b9ve+y
 0ZwAA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M/RruYb5Tpz7LXQeVwJ/BIMWThpuGkwnhoIMPDlFp0FLiaKpzaWg5m/v
 rxAVJ9bAWUdbJ2rzi9CPM9UnqDoV+qL/jfPMNJyrzSsFDk7sSB5d8nvYk/F+958UB5XstKp
 4UN16KAvmVCvJUlEQIxt3FVQ/4vMlEA5xCHaW2LP5o1zqyfCZooZU6k8Ii+IP/KtR35S91Y
 06qFScAhHc1xtSNlpnKnExeAnThmugJ4jBXqe4Epj8EdH2Ryz05wj7VxaRwnwTLctoCcNko
 Xtyam9h82f/aRw/4dLFuvp5ooe2Kl2Y244NI2woZpYC0ojuBbClvZ418qcLih8kQLpgfCBS
 cAkTRcILpSOqliSju4vlqJKDCtq/cVzUJ2ARbGu0iD5zxqr/5HKPgq9QVb2iIb4q8JzC67w
 5LCZHNP0woGYzVR5tu/C0X52g+WNg1VmQvwAiNcm5Jyfpo58BMUlIDXFso4Vgop4LI4Lasc
 3776/s2FXDv+e9UrWBPYWxtxFHhv+FBgfDQG2KFSUJqGQAmJONSm+T3mAfnMCm846fwe0uG
 awHJjt6mukF1jh4XdLaxFzMf3vgmQSgfll+azupKztb+A8CFiIFjNRnYWu8vJYwZsam2YZP
 EUS2nSBIpdpmMkOAbDlJchJMhft15xPYmCWM4/emQ37r+ALmLShoXx9MQzc5nayZ4S5Nocn
 3MhG5Dts+pQm06KeaBUU9pnSbXb3vHUtwKk3G1mSzvH3++FACiFqu8cP2F4ApEOGt/UucGw
 gWeAdlJ5+0gPyGkqtqAR0qrgfEz7s6lg9l5w8qd0hS6B8J3Z/DkcytpW97bOy8dQGVru5ZL
 yVPlcS+uOsQto1FGDhckKJQqkP4l34JIIzZ+uWA97uhP+f4JjHYaRbjlsD8wvUpWgdcfV8G
 4a4X/OugRQh0ZG4iV/PaNFLz3uk4Vb/VlSHuLoEgBv4ARFRW78ZQY9/HhTySz2nboylZFB+
 SbtnRsODHeEw7mJU91kxJatHCWTJxB7pVUeCacKeM1Zyyco0Uu6CSv52CW1PF+37VDJFqnD
 N+V/e/Y7uBJ0zhpvvspdEVxrk8i0f97h7jUjTXR/56/jgZYWLqc5/HwEyE2e3f1hDaqmv0q
 w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

An eDP panel may be powered off during mode validation. Keep its link
capabilities after the first successful discovery so subsequent checks
can use them across disable and suspend. eDP's internal unplug handling
is a power transition, not a change of sink. Continue invalidating
external DP capabilities on unplug and refresh them on discovery.

Discover eDP capabilities from connector detect before the first modeset.
Resume the AUX controller and prepare the fixed panel for the read, then
balance the panel preparation and runtime PM reference. Keep the panel
connected on an AUX error and allow a later probe to retry. Detection
with valid bandwidth limits does not touch panel power.

Track valid bandwidth limits separately from a complete capability cache.
Optional VSC or PSR read failures retain the existing fallback but do not
invalidate known bandwidth limits or permanently cache missing features.
Clear parsed link information before fresh discovery to avoid retaining
rates or flags from a previous sink or partially completed attempt.

Reuse the eDP receiver capabilities without skipping LTTPR setup, EDID
reads, sink requests, power management or link training. Refresh
LINK_BW_SET when selecting LINK_RATE_SET because it is configuration
state and can change across power cycles. A failed configuration read
still fails the enable without discarding known static capabilities.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 73 +++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_drm.c     |  8 ++--
 drivers/gpu/drm/msm/dp/dp_drm.h     |  2 +
 drivers/gpu/drm/msm/dp/dp_panel.c   | 81 +++++++++++++++++++++++++++++--------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  4 ++
 5 files changed, 145 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 816f2dc11aea..9b7a1d18dfe0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -16,6 +16,7 @@
 #include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
 #include "msm_drv.h"
@@ -313,10 +314,16 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	const struct drm_edid *drm_edid = NULL;
 
-	rc = drm_dp_read_dpcd_caps(dp->aux, dpcd);
-	if (rc)
-		goto end;
+	if (dp->msm_dp_display.is_edp && dp->panel->caps_cached) {
+		memcpy(dpcd, dp->panel->dpcd, sizeof(dpcd));
+	} else {
+		dp->panel->link_caps_valid = false;
+		rc = drm_dp_read_dpcd_caps(dp->aux, dpcd);
+		if (rc)
+			goto end;
+	}
 
+	/* Reapply the LTTPR mode even when receiver capabilities are cached. */
 	dp->link->lttpr_count = msm_dp_display_lttpr_init(dp, dpcd);
 
 	rc = msm_dp_panel_read_link_caps(dp->panel, connector);
@@ -521,6 +528,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
+	/* eDP uses this path for power-down, not a change of sink. */
+	if (!dp->msm_dp_display.is_edp) {
+		dp->panel->link_caps_valid = false;
+		dp->panel->caps_cached = false;
+	}
 	if (!dp->plugged) {
 		mutex_unlock(&dp->plugged_lock);
 		return 0;
@@ -971,6 +983,61 @@ void msm_dp_display_set_psr(struct msm_dp *msm_dp_display, bool enter)
 	msm_dp_ctrl_set_psr(dp->ctrl, dp->panel, enter);
 }
 
+enum drm_connector_status msm_edp_bridge_detect(struct drm_bridge *bridge,
+						struct drm_connector *connector)
+{
+	struct msm_dp *display = to_dp_bridge(bridge)->msm_dp_display;
+	struct msm_dp_display_private *dp = container_of(display,
+			struct msm_dp_display_private, msm_dp_display);
+	struct drm_panel *panel;
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+	bool prepared;
+	int ret;
+
+	/* The fixed panel's bandwidth capabilities survive power cycles. */
+	scoped_guard(mutex, &dp->plugged_lock) {
+		if (dp->panel->link_caps_valid)
+			return connector_status_connected;
+	}
+
+	/* Discovery precedes the first modeset; do not power up in atomic check. */
+	panel = of_drm_find_panel(display->next_bridge->of_node);
+	if (IS_ERR(panel))
+		return connector_status_unknown;
+
+	ret = pm_runtime_resume_and_get(&display->pdev->dev);
+	if (ret < 0)
+		goto put_panel;
+
+	prepared = panel->prepared;
+	if (!prepared)
+		drm_panel_prepare(panel);
+	if (!panel->prepared) {
+		ret = -EIO;
+		goto put_pm;
+	}
+
+	scoped_guard(mutex, &dp->plugged_lock) {
+		ret = drm_dp_read_dpcd_caps(dp->aux, dpcd);
+		if (!ret) {
+			dp->link->lttpr_count = msm_dp_display_lttpr_init(dp, dpcd);
+			ret = msm_dp_panel_read_link_caps(dp->panel, connector);
+		}
+	}
+
+	if (!prepared)
+		drm_panel_unprepare(panel);
+put_pm:
+	pm_runtime_put_sync(&display->pdev->dev);
+put_panel:
+	drm_panel_put(panel);
+	if (ret < 0)
+		drm_dbg_dp(dp->drm_dev, "eDP capability discovery failed: %d\n", ret);
+
+	/* A failed AUX access does not mean the fixed panel was disconnected. */
+	return connector_status_connected;
+}
+
 /**
  * msm_dp_bridge_detect - callback to determine if connector is connected
  *
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index c1e4147bfef1..8c4446b12925 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -276,6 +276,7 @@ static void msm_edp_bridge_debugfs_init(struct drm_bridge *bridge, struct dentry
 }
 
 static const struct drm_bridge_funcs msm_edp_bridge_ops = {
+	.detect = msm_edp_bridge_detect,
 	.atomic_pre_enable = msm_dp_bridge_atomic_pre_enable,
 	.atomic_enable = msm_edp_bridge_atomic_enable,
 	.atomic_disable = msm_edp_bridge_atomic_disable,
@@ -311,9 +312,8 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	 * Many ops only make sense for DP. Why?
 	 * - Detect/HPD are used by DRM to know if a display is _physically_
 	 *   there, not whether the display is powered on / finished initting.
-	 *   On eDP we assume the display is always there because you can't
-	 *   know until power is applied. If we don't implement the ops DRM will
-	 *   assume our display is always there.
+	 *   On eDP the fixed panel is always connected. Detect powers it briefly
+	 *   to cache link capabilities before the first modeset.
 	 * - Currently eDP mode reading is driven by the panel driver. This
 	 *   allows the panel driver to properly power itself on to read the
 	 *   modes.
@@ -327,6 +327,8 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 		bridge->hdmi_audio_dev = &msm_dp_display->pdev->dev;
 		bridge->hdmi_audio_max_i2s_playback_channels = 8;
 		bridge->hdmi_audio_dai_port = -1;
+	} else {
+		bridge->ops = DRM_BRIDGE_OP_DETECT;
 	}
 
 	rc = devm_drm_bridge_add(dev->dev, bridge);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index da412c788503..d37e2ff95f4b 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -25,6 +25,8 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 		   struct drm_encoder *encoder,
 		   bool yuv_supported);
 
+enum drm_connector_status msm_edp_bridge_detect(struct drm_bridge *bridge,
+						struct drm_connector *connector);
 enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 					       struct drm_connector *connector);
 void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index fdf1a3f437ba..d144af2fe008 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -65,7 +65,7 @@ static inline u32 msm_dp_read_p0(struct msm_dp_panel_private *panel,
 	return readl_relaxed(panel->p0_base + offset);
 }
 
-static void msm_dp_panel_read_psr_cap(struct msm_dp_panel_private *panel)
+static bool msm_dp_panel_read_psr_cap(struct msm_dp_panel_private *panel)
 {
 	ssize_t rlen;
 	struct msm_dp_panel *msm_dp_panel;
@@ -81,12 +81,18 @@ static void msm_dp_panel_read_psr_cap(struct msm_dp_panel_private *panel)
 				"psr version: 0x%x, psr_cap: 0x%x\n",
 				msm_dp_panel->psr_cap.version,
 				msm_dp_panel->psr_cap.capabilities);
-		} else
+		} else {
+			memset(&msm_dp_panel->psr_cap, 0, sizeof(msm_dp_panel->psr_cap));
 			DRM_ERROR("failed to read psr info, rlen=%zd\n", rlen);
+			return false;
+		}
 	}
+
+	return true;
 }
 
-static int msm_dp_panel_read_dpcd(struct msm_dp_panel *msm_dp_panel)
+static int msm_dp_panel_read_dpcd(struct msm_dp_panel *msm_dp_panel,
+				  bool *caps_valid)
 {
 	int rc, max_lttpr_lanes, max_lttpr_rate;
 	struct msm_dp_panel_private *panel;
@@ -100,7 +106,20 @@ static int msm_dp_panel_read_dpcd(struct msm_dp_panel *msm_dp_panel)
 	if (rc)
 		return rc;
 
-	msm_dp_panel->vsc_sdp_supported = drm_dp_vsc_sdp_supported(panel->aux, dpcd);
+	*caps_valid = true;
+	if (dpcd[DP_DPCD_REV] >= DP_DPCD_REV_13) {
+		u8 rx_feature;
+
+		rc = drm_dp_dpcd_read_byte(panel->aux, DP_DPRX_FEATURE_ENUMERATION_LIST,
+					   &rx_feature);
+		if (rc) {
+			/* Retry discovery rather than caching a failed optional read. */
+			*caps_valid = false;
+		} else {
+			msm_dp_panel->vsc_sdp_supported =
+				rx_feature & DP_VSC_SDP_EXT_FOR_COLORIMETRY_SUPPORTED;
+		}
+	}
 	link_info = &msm_dp_panel->link_info;
 	link_info->revision = dpcd[DP_DPCD_REV];
 	major = (link_info->revision >> 4) & 0x0f;
@@ -126,7 +145,6 @@ static int msm_dp_panel_read_dpcd(struct msm_dp_panel *msm_dp_panel)
 		/* For eDP v1.4+, parse the SUPPORTED_LINK_RATES table */
 		if (edp_rev >= DP_EDP_14) {
 			__le16 rates[DP_MAX_SUPPORTED_RATES];
-			u8 bw_set;
 			int i;
 
 			rc = drm_dp_dpcd_read_data(panel->aux, DP_SUPPORTED_LINK_RATES,
@@ -134,10 +152,6 @@ static int msm_dp_panel_read_dpcd(struct msm_dp_panel *msm_dp_panel)
 			if (rc)
 				return rc;
 
-			rc = drm_dp_dpcd_read_byte(panel->aux, DP_LINK_BW_SET, &bw_set);
-			if (rc)
-				return rc;
-
 			/* Find index of max supported link rate that does not exceed dtsi limits */
 			for (i = 0; i < ARRAY_SIZE(rates); i++) {
 				/*
@@ -168,10 +182,6 @@ static int msm_dp_panel_read_dpcd(struct msm_dp_panel *msm_dp_panel)
 				link_info->supported_rates[i] = rate;
 				link_info->rate_set = i;
 			}
-
-			/* Only use LINK_RATE_SET if LINK_BW_SET hasn't already been written to */
-			if (!bw_set && link_info->rate)
-				link_info->use_rate_set = true;
 		}
 	}
 
@@ -201,15 +211,34 @@ static int msm_dp_panel_read_dpcd(struct msm_dp_panel *msm_dp_panel)
 	drm_dbg_dp(panel->drm_dev, "version: %d.%d\n", major, minor);
 	drm_dbg_dp(panel->drm_dev, "link_rate=%d\n", link_info->rate);
 	drm_dbg_dp(panel->drm_dev, "link_rate_set=%d\n", link_info->rate_set);
-	drm_dbg_dp(panel->drm_dev, "use_rate_set=%d\n", link_info->use_rate_set);
 	drm_dbg_dp(panel->drm_dev, "lane_count=%d\n", link_info->num_lanes);
 
 	if (drm_dp_enhanced_frame_cap(dpcd))
 		link_info->capabilities |= DP_LINK_CAP_ENHANCED_FRAMING;
 
-	msm_dp_panel_read_psr_cap(panel);
+	if (!msm_dp_panel_read_psr_cap(panel))
+		*caps_valid = false;
 
-	return rc;
+	return 0;
+}
+
+static int msm_dp_panel_read_link_rate_set(struct msm_dp_panel_private *panel)
+{
+	struct msm_dp_link_info *link_info = &panel->msm_dp_panel.link_info;
+	u8 bw_set;
+	int ret;
+
+	if (!link_info->supported_rates[0])
+		return 0;
+
+	/* LINK_BW_SET is configuration state, not a cached capability. */
+	ret = drm_dp_dpcd_read_byte(panel->aux, DP_LINK_BW_SET, &bw_set);
+	if (ret)
+		return ret;
+
+	link_info->use_rate_set = !bw_set;
+	drm_dbg_dp(panel->drm_dev, "use_rate_set=%d\n", link_info->use_rate_set);
+	return 0;
 }
 
 static u32 msm_dp_panel_get_supported_bpp(struct msm_dp_panel *msm_dp_panel,
@@ -238,6 +267,7 @@ int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
 {
 	int rc, bw_code;
 	int count;
+	bool caps_valid;
 	struct msm_dp_panel_private *panel;
 
 	if (!msm_dp_panel || !connector) {
@@ -247,7 +277,16 @@ int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
 
 	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
 
-	rc = msm_dp_panel_read_dpcd(msm_dp_panel);
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
+	    msm_dp_panel->caps_cached)
+		return msm_dp_panel_read_link_rate_set(panel);
+
+	msm_dp_panel->link_caps_valid = false;
+	msm_dp_panel->caps_cached = false;
+	memset(&msm_dp_panel->link_info, 0, sizeof(msm_dp_panel->link_info));
+	memset(&msm_dp_panel->psr_cap, 0, sizeof(msm_dp_panel->psr_cap));
+	msm_dp_panel->vsc_sdp_supported = false;
+	rc = msm_dp_panel_read_dpcd(msm_dp_panel, &caps_valid);
 	if (rc) {
 		DRM_ERROR("read dpcd failed %d\n", rc);
 		return rc;
@@ -272,6 +311,14 @@ int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
 
 	rc = drm_dp_read_downstream_info(panel->aux, msm_dp_panel->dpcd,
 					 msm_dp_panel->downstream_ports);
+	if (rc)
+		return rc;
+
+	rc = msm_dp_panel_read_link_rate_set(panel);
+	if (!rc) {
+		msm_dp_panel->link_caps_valid = true;
+		msm_dp_panel->caps_cached = caps_valid;
+	}
 	return rc;
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 4519ac374220..a5cb8a4a9498 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -38,6 +38,10 @@ struct msm_dp_panel {
 	struct msm_dp_panel_psr psr_cap;
 	bool video_test;
 	bool vsc_sdp_supported;
+	/* Valid bandwidth limits, independent of optional feature reads. */
+	bool link_caps_valid;
+	/* All capability reads completed; eDP can reuse the full cache. */
+	bool caps_cached;
 	u32 hw_revision;
 
 	u32 max_bw_code;

-- 
2.56.0

