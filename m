Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05D1CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0660D10FE33;
	Fri,  9 Oct 2026 03:19:50 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D5910FE33;
 Fri,  9 Oct 2026 03:19:47 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515874t6745428c
X-QQ-Originating-IP: ISKGB3N9ww0B4T197i+uj+bopdv7/aejHUrX1eOox3s=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9782716897286075627
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:16:05 +0800
Subject: [PATCH v2 13/20] drm/msm/dp: Track output bit depth in bridge
 atomic state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-13-1835d4966da3@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20383; i=sophon@radxa.com;
 h=from:subject:message-id; bh=zAWb8Glhddd6Vv1wBVo/Tvg1bgNDLXlYGvg69s8uu4w=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlZpBlW7KxkvZL+3uLFSTMilXPQ2d8u3A0cL9A5fV
 akQV1jRUcrCIMbFICumyKIQzzCXvTL32lOxUj2YOaxMIEMYuDgFYCLfmBj+F7h2dnQJrPvHdXz9
 BD9P+aBrXF0ZVa73H78uie/pzsiQY/gfuKp2v9glwdmbiraVPD0VorlwfsqrWeXMB39Fu1R/Wnm
 TGwA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MmPNY57tR1Xni486jsHOja4JG/eRbi6wx5chBO1/dIK8OH+pIgE1xWF2
 CwWVJgJlCCzV6OEomLMwq4cYw/HIYeUF6IXvjONdP6g/eZwvg3MgSdUP2oTqEYHSBOJ7CZf
 w1CJyJrGViIc3vlRSCGOLNBrsZ1VlfALftFmg3VFNNJ55nFumDHRxY4L5Pm1GqmvCDG54u+
 iLQWgvv8KVfdrWc59UC2sjJAWijwRUp7Gl6NkZgcWs8+peM8j5FxYU3P2p/XIRD3jfKPHj4
 ra1gEOk9j16zZvlEdf8fwfJBfFAb9eLIcKDI2u+WqSrbr+HRb2/+J07AExm1226Idj3c5K0
 JpR/W7rQFOZ+Lsw3BRGnt16xkYP96NJNuRXs65InlYXVoYDjwvSgHnBNmfnczeMgtvoq231
 fCFrMqbG1q0uv4DcZU68UU7CKvkxWFITzd5MDanKBo8t9OuU4xwpsozozeZ1l082hCP1/eQ
 mCLednjHb1xo0e0JFjOoQx07N37loY60WqSaI0ep5X7PPxVcmuqsD0cwaiddBTsc4X9ANLC
 e+YLHNhcTco8zz6kJdfXGKV6WIQIec17mkDrq0qtekAl63YeyxofKV7PFFNux/JSetzRyoQ
 oHT1ghutcruBjDV0ukS6GA++mhHZTSBOOHGMZ9+JbbpnxqoNFD1VMyIGaxFoqvdjIY9RLqy
 monJTG49lY5OyuM5xQxpJpi5WtU2w5m/c1nEN/YGl3elrKGEcQzbTf21S6p0S9hsfWideqO
 oH9PLyK+AbfH7fkzv4TiQdsOSlY6aaWOtgt36gaYdD1pMoFEqPybyJHnVa8nZjXgDKgpXeA
 q5cotLGoq5n6+2tYSVyFIBTK5phgnyx5bOwasu4oslFd/bj1UAWkCxLnryq1N4cOxj2hDca
 n9jO4+RubK0Ita0V04tBftgXc9zwv8Oi50Sf87xV4FVilFfuBktnuB4Y/xtMi4EuznwfoMO
 L0ejDrssKWx5FpW1VB+tMaNc9P4sX64uE/EChjE42Y4Cr1jpWIuh+4AHXFJm5G6DuzB598V
 hfwQU8jVPfCNIZbnhGTf1JrBfN4cOBrP5XieqVBSEcaqpqkq8weeW8H5vv9lEemhuJLO1ia
 g==
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

Advertise the 10 bpc DP and eDP capability through bridge->max_bpc so
the bridge connector helper attaches the max bpc property. Select a
supported component depth from the new connector state. Keep the result
in a private bridge state so TEST_ONLY atomic commits do not modify the
running stream. Force a modeset when max bpc changes to apply the new
depth to the stream.

Require valid cached bandwidth limits during atomic check. The preceding
eDP discovery change supplies them before the first modeset. Reject
unknown limits instead of accepting a configuration for validation during
enable. Retain support for 6 bpc SDR panels and use an 8 bpc ceiling when
the bridge chain does not expose max bpc.

Keep the selected depth throughout enable. Filter link training fallback
candidates against the checked stream bandwidth, including YUV420, and
retain a final bandwidth check before starting video. A lower-rate link
may be used only if it carries the unchanged stream. Otherwise unwind
and report the link failure rather than silently lowering the depth.
PHY and video compliance tests retain their specified parameters.

Continue searching when a candidate lacks bandwidth: reducing the lane
count restores the maximum rate and can yield a viable combination.
Only successful link training completes the search; successful PHY
reinitialization on the final retry must not masquerade as training
success. Keep sink training cleanup on the failure path.

Retain the generic bridge helper's missing-state guard in the custom
duplicate callback. Initial state allocation can fail at bridge attach;
return NULL in that case so atomic state acquisition reports -ENOMEM
instead of copying from a NULL pointer.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 117 ++++++++++++++++++++++--------------
 drivers/gpu/drm/msm/dp/dp_display.c |  39 +++++++++++-
 drivers/gpu/drm/msm/dp/dp_display.h |   6 ++
 drivers/gpu/drm/msm/dp/dp_drm.c     |  82 ++++++++++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_drm.h     |   7 +++
 drivers/gpu/drm/msm/dp/dp_panel.c   |   5 --
 drivers/gpu/drm/msm/dp/dp_utils.c   |  33 ++++++++++
 drivers/gpu/drm/msm/dp/dp_utils.h   |   6 ++
 8 files changed, 232 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index f633f6cf5764..791bb3af2cad 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -23,6 +23,7 @@
 
 #include "dp_reg.h"
 #include "dp_ctrl.h"
+#include "dp_utils.h"
 #include "dp_link.h"
 
 #define POLLING_SLEEP_US			1000
@@ -2365,10 +2366,56 @@ static bool msm_dp_ctrl_channel_eq_ok(struct msm_dp_ctrl_private *ctrl)
 	return drm_dp_channel_eq_ok(link_status, num_lanes);
 }
 
+static bool msm_dp_ctrl_link_fits(struct msm_dp_ctrl_private *ctrl,
+				  const struct msm_dp_panel *panel)
+{
+	return msm_dp_utils_link_fits(panel->msm_dp_mode.drm_mode.clock,
+				      panel->msm_dp_mode.bpp,
+				      ctrl->link->link_params.rate,
+				      ctrl->link->link_params.num_lanes,
+				      panel->msm_dp_mode.out_fmt_is_yuv_420);
+}
+
+static int msm_dp_ctrl_next_link_params(struct msm_dp_ctrl_private *ctrl,
+					struct msm_dp_panel *panel,
+					unsigned int training_step,
+					const u8 *link_status, bool check_bw)
+{
+	unsigned int lanes;
+	int ret;
+
+	do {
+		lanes = ctrl->link->link_params.num_lanes;
+		if (training_step == DP_TRAINING_1) {
+			ret = msm_dp_ctrl_link_rate_down_shift(ctrl);
+			if (ret) {
+				if (!msm_dp_ctrl_clock_recovery_any_ok(link_status, lanes))
+					return ret;
+				ret = msm_dp_ctrl_link_lane_down_shift(ctrl, panel);
+			}
+		} else if (training_step == DP_TRAINING_2) {
+			if (!drm_dp_clock_recovery_ok(link_status, lanes))
+				ret = msm_dp_ctrl_link_rate_down_shift(ctrl);
+			else
+				ret = msm_dp_ctrl_link_lane_down_shift(ctrl, panel);
+		} else {
+			return -EIO;
+		}
+		if (ret)
+			return ret;
+
+		/* Reducing lanes restores the maximum rate; keep looking. */
+	} while (check_bw && !msm_dp_ctrl_link_fits(ctrl, panel));
+
+	return 0;
+}
+
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			struct msm_dp_panel *panel)
 {
 	int rc = 0;
+	bool trained = false;
+	bool check_bw;
 	struct msm_dp_ctrl_private *ctrl;
 	u32 rate;
 	int link_train_max_retries = 5;
@@ -2382,6 +2429,8 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
+	check_bw = !(ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN) &&
+		   !panel->video_test;
 	rate = panel->link_info.rate;
 	pixel_rate = panel->msm_dp_mode.drm_mode.clock;
 
@@ -2404,6 +2453,9 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 		ctrl->link->link_params.rate, ctrl->link->link_params.num_lanes,
 		pixel_rate);
 
+	if (check_bw && !msm_dp_ctrl_link_fits(ctrl, panel))
+		return -ENOSPC;
+
 	rc = msm_dp_ctrl_enable_mainlink_clocks(ctrl, panel);
 	if (rc)
 		return rc;
@@ -2411,55 +2463,22 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	while (--link_train_max_retries) {
 		training_step = DP_TRAINING_NONE;
 		rc = msm_dp_ctrl_setup_main_link(ctrl, panel, &training_step);
-		if (rc == 0) {
-			/* training completed successfully */
+		if (!rc) {
+			trained = true;
 			break;
-		} else if (training_step == DP_TRAINING_1) {
-			/* link train_1 failed */
-			if (!msm_dp_aux_is_link_connected(ctrl->aux))
-				break;
-
-			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
-
-			rc = msm_dp_ctrl_link_rate_down_shift(ctrl);
-			if (rc < 0) { /* already in RBR = 1.6G */
-				if (msm_dp_ctrl_clock_recovery_any_ok(link_status,
-					ctrl->link->link_params.num_lanes)) {
-					/*
-					 * some lanes are ready,
-					 * reduce lane number
-					 */
-					rc = msm_dp_ctrl_link_lane_down_shift(ctrl, panel);
-					if (rc < 0) { /* lane == 1 already */
-						/* end with failure */
-						break;
-					}
-				} else {
-					/* end with failure */
-					break; /* lane == 1 already */
-				}
-			}
-		} else if (training_step == DP_TRAINING_2) {
-			/* link train_2 failed */
-			if (!msm_dp_aux_is_link_connected(ctrl->aux))
-				break;
-
-			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
+		}
 
-			if (!drm_dp_clock_recovery_ok(link_status,
-					ctrl->link->link_params.num_lanes))
-				rc = msm_dp_ctrl_link_rate_down_shift(ctrl);
-			else
-				rc = msm_dp_ctrl_link_lane_down_shift(ctrl, panel);
+		if (!msm_dp_aux_is_link_connected(ctrl->aux))
+			break;
 
-			if (rc < 0) {
-				/* end with failure */
-				break; /* lane == 1 already */
-			}
+		if (drm_dp_dpcd_read_link_status(ctrl->aux, link_status) < 0)
+			break;
 
-			/* stop link training before start re training  */
-			msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);
-		}
+		msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);
+		rc = msm_dp_ctrl_next_link_params(ctrl, panel, training_step,
+						  link_status, check_bw);
+		if (rc)
+			break;
 
 		rc = msm_dp_ctrl_reinitialize_mainlink(ctrl, panel);
 		if (rc) {
@@ -2468,6 +2487,10 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 		}
 	}
 
+	/* Reinitializing the PHY is not a successful training attempt. */
+	if (!trained && !rc)
+		rc = -EIO;
+
 	if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN)
 		return rc;
 
@@ -2617,6 +2640,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
+	/* Never change the stream depth selected by atomic check. */
+	if (!panel->video_test && !msm_dp_ctrl_link_fits(ctrl, panel))
+		return -ENOSPC;
+
 	pixel_rate_orig = panel->msm_dp_mode.drm_mode.clock;
 	pixel_rate = pixel_rate_orig;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9b7a1d18dfe0..1f9595ff5fd9 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -28,6 +28,7 @@
 #include "dp_panel.h"
 #include "dp_display.h"
 #include "dp_drm.h"
+#include "dp_utils.h"
 #include "dp_audio.h"
 #include "dp_debug.h"
 
@@ -677,7 +678,8 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 
 static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 				   const struct drm_display_mode *adjusted_mode,
-				   struct msm_dp_panel *msm_dp_panel)
+				   struct msm_dp_panel *msm_dp_panel,
+				   const struct msm_dp_bridge_state *state)
 {
 	struct msm_dp_display_private *dp;
 	u32 bpp;
@@ -687,7 +689,7 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	if (msm_dp_display_check_video_test(msm_dp_display))
 		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
 	else
-		bpp = msm_dp_panel->connector->display_info.bpc * 3;
+		bpp = state->bpp;
 
 	msm_dp_panel_init_panel_info(msm_dp_panel, adjusted_mode, bpp ? bpp : 24);
 
@@ -697,6 +699,34 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	return 0;
 }
 
+int msm_dp_display_atomic_check(struct msm_dp *msm_dp_display,
+				struct msm_dp_bridge_state *state,
+				const struct drm_display_mode *mode,
+				const struct drm_connector_state *conn_state)
+{
+	const struct drm_display_info *info = &conn_state->connector->display_info;
+	struct msm_dp_display_private *dp;
+	unsigned int clock = mode->clock;
+	int bpp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	guard(mutex)(&dp->plugged_lock);
+
+	if (!dp->panel->link_caps_valid)
+		return -EINVAL;
+
+	bpp = msm_dp_utils_select_bpp(info->bpc, conn_state->max_requested_bpc ?: 8,
+				      clock, dp->panel->link_info.rate,
+				      dp->panel->link_info.num_lanes,
+				      drm_mode_is_420_only(info, mode));
+	if (bpp < 0)
+		return bpp;
+
+	state->bpp = bpp;
+	return 0;
+}
+
 static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
@@ -1593,6 +1623,7 @@ void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
 	struct msm_dp_display_private *dp;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
+	struct drm_bridge_state *bridge_state;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
@@ -1600,13 +1631,15 @@ void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
 	if (!crtc)
 		return;
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	bridge_state = drm_atomic_get_new_bridge_state(state, msm_dp_display->bridge);
 
 	/*
 	 * The DPU encoder's .atomic_enable() reads the mode's YUV420 / wide bus
 	 * state and runs before the bridge's .atomic_enable(), so the mode must
 	 * be programmed here, in .atomic_pre_enable().
 	 */
-	msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp->panel);
+	msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp->panel,
+				to_dp_bridge_state(bridge_state));
 }
 
 static void msm_dp_display_abort_enable_locked(struct msm_dp_display_private *dp)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 83117e7619f3..6a77e5952530 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -11,6 +11,8 @@
 
 #define DP_MAX_PIXEL_CLK_KHZ	675000
 
+struct msm_dp_bridge_state;
+
 struct msm_dp {
 	struct drm_device *drm_dev;
 	struct platform_device *pdev;
@@ -43,4 +45,8 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_info *info,
 					       const struct drm_display_mode *mode);
 
+int msm_dp_display_atomic_check(struct msm_dp *dp, struct msm_dp_bridge_state *state,
+				const struct drm_display_mode *mode,
+				const struct drm_connector_state *conn_state);
+
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index df224ae46d9d..9f1aa87a3687 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/string_choices.h>
+#include <linux/slab.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_bridge.h>
@@ -116,10 +117,71 @@ static enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *drm_brid
 	return msm_dp_display_mode_valid(dp, info, mode);
 }
 
+static struct drm_bridge_state *msm_dp_bridge_create_state(struct drm_bridge *bridge)
+{
+	struct msm_dp_bridge_state *state;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_bridge_state_init(&state->base, bridge);
+	return &state->base;
+}
+
+static struct drm_bridge_state *msm_dp_bridge_duplicate_state(struct drm_bridge *bridge)
+{
+	struct msm_dp_bridge_state *state;
+	struct drm_bridge_state *old_state;
+
+	if (WARN_ON(!bridge->base.state))
+		return NULL;
+
+	old_state = drm_priv_to_bridge_state(bridge->base.state);
+	state = kmemdup(to_dp_bridge_state(old_state), sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return NULL;
+
+	__drm_atomic_helper_bridge_duplicate_state(bridge, &state->base);
+	return &state->base;
+}
+
+static void msm_dp_bridge_destroy_state(struct drm_bridge *bridge,
+					struct drm_bridge_state *state)
+{
+	kfree(to_dp_bridge_state(state));
+}
+
+static int msm_dp_bridge_atomic_check(struct drm_bridge *bridge,
+				      struct drm_bridge_state *bridge_state,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	struct drm_connector_state *old_conn_state;
+	int ret;
+
+	if (!conn_state->crtc)
+		return 0;
+
+	ret = msm_dp_display_atomic_check(to_dp_bridge(bridge)->msm_dp_display,
+					  to_dp_bridge_state(bridge_state),
+					  &crtc_state->adjusted_mode, conn_state);
+	if (ret)
+		return ret;
+
+	old_conn_state = drm_atomic_get_old_connector_state(conn_state->state,
+							    conn_state->connector);
+	if (old_conn_state->max_requested_bpc != conn_state->max_requested_bpc)
+		crtc_state->mode_changed = true;
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs msm_dp_bridge_ops = {
-	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
-	.atomic_destroy_state   = drm_atomic_helper_bridge_destroy_state,
-	.atomic_create_state           = drm_atomic_helper_bridge_create_state,
+	.atomic_check           = msm_dp_bridge_atomic_check,
+	.atomic_duplicate_state = msm_dp_bridge_duplicate_state,
+	.atomic_destroy_state   = msm_dp_bridge_destroy_state,
+	.atomic_create_state           = msm_dp_bridge_create_state,
 	.atomic_pre_enable      = msm_dp_bridge_atomic_pre_enable,
 	.atomic_enable          = msm_dp_bridge_atomic_enable,
 	.atomic_disable         = msm_dp_bridge_atomic_disable,
@@ -154,7 +216,7 @@ static int msm_edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
 	if (crtc_state->self_refresh_active && !dp->psr_supported)
 		return -EINVAL;
 
-	return 0;
+	return msm_dp_bridge_atomic_check(drm_bridge, bridge_state, crtc_state, conn_state);
 }
 
 static void msm_edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
@@ -283,9 +345,8 @@ static enum drm_mode_status msm_edp_bridge_mode_valid(struct drm_bridge *bridge,
 		return MODE_CLOCK_HIGH;
 
 	/*
-	 * The eDP controller currently does not have a reliable way of
-	 * enabling panel power to read sink capabilities. So, we rely
-	 * on the panel driver to populate only supported modes for now.
+	 * Atomic check validates bandwidth for the selected component depth
+	 * against the capabilities cached during connector detection.
 	 */
 	return MODE_OK;
 }
@@ -304,9 +365,9 @@ static const struct drm_bridge_funcs msm_edp_bridge_ops = {
 	.atomic_disable = msm_edp_bridge_atomic_disable,
 	.atomic_post_disable = msm_edp_bridge_atomic_post_disable,
 	.mode_valid = msm_edp_bridge_mode_valid,
-	.atomic_create_state = drm_atomic_helper_bridge_create_state,
-	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_create_state = msm_dp_bridge_create_state,
+	.atomic_duplicate_state = msm_dp_bridge_duplicate_state,
+	.atomic_destroy_state = msm_dp_bridge_destroy_state,
 	.atomic_check = msm_edp_bridge_atomic_check,
 	.debugfs_init = msm_edp_bridge_debugfs_init,
 };
@@ -328,6 +389,7 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 
 	bridge = &msm_dp_bridge->bridge;
 	bridge->type = msm_dp_display->connector_type;
+	bridge->max_bpc = 10;
 	bridge->ycbcr_420_allowed = yuv_supported;
 
 	/*
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index d37e2ff95f4b..4c651cc40f4d 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -17,6 +17,13 @@ struct msm_dp_bridge {
 	struct msm_dp *msm_dp_display;
 };
 
+struct msm_dp_bridge_state {
+	struct drm_bridge_state base;
+	u32 bpp;
+};
+
+#define to_dp_bridge_state(x) container_of((x), struct msm_dp_bridge_state, base)
+
 #define to_dp_bridge(x)     container_of((x), struct msm_dp_bridge, bridge)
 
 struct drm_connector *msm_dp_drm_connector_init(struct msm_dp *msm_dp_display,
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index d144af2fe008..af05441bc32a 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -734,11 +734,6 @@ int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel,
 				drm_mode->clock);
 	drm_dbg_dp(panel->drm_dev, "bpp = %d\n", msm_dp_panel->msm_dp_mode.bpp);
 
-	msm_dp_panel->msm_dp_mode.bpp = msm_dp_panel_get_mode_bpp(msm_dp_panel, msm_dp_panel->msm_dp_mode.bpp,
-						      msm_dp_panel->msm_dp_mode.drm_mode.clock);
-
-	drm_dbg_dp(panel->drm_dev, "updated bpp = %d\n",
-				msm_dp_panel->msm_dp_mode.bpp);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.c b/drivers/gpu/drm/msm/dp/dp_utils.c
index 72bae48a1fe0..8b6ef2f6d7f4 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.c
+++ b/drivers/gpu/drm/msm/dp/dp_utils.c
@@ -89,6 +89,39 @@ void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
 		FIELD_PREP(PARITY_3_MASK, msm_dp_utils_calculate_parity(sdp_header->HB3));
 }
 
+bool msm_dp_utils_link_fits(unsigned int clock, unsigned int bpp,
+			    unsigned int rate, unsigned int lanes, bool yuv420)
+{
+	u64 available = (u64)rate * lanes * 8;
+
+	if (!clock || !bpp || !rate || !lanes)
+		return false;
+
+	if (yuv420)
+		available *= 2;
+
+	return (u64)clock * bpp <= available;
+}
+
+int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
+			    unsigned int clock, unsigned int rate,
+			    unsigned int lanes, bool yuv420)
+{
+	unsigned int bpp;
+
+	bpc = min3(bpc ? bpc : 8, max_bpc, 10U);
+	bpc = round_down(bpc, 2);
+	if (bpc < 6)
+		return -EINVAL;
+
+	for (bpp = bpc * 3; bpp >= 18; bpp -= 6) {
+		if (msm_dp_utils_link_fits(clock, bpp, rate, lanes, yuv420))
+			return bpp;
+	}
+
+	return -EINVAL;
+}
+
 bool msm_dp_utils_psr_needs_modeset(const struct drm_crtc_state *state)
 {
 	/* active_changed alone also describes a normal self-refresh exit. */
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.h b/drivers/gpu/drm/msm/dp/dp_utils.h
index 5d86c978dffd..c6b62e3900bb 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.h
+++ b/drivers/gpu/drm/msm/dp/dp_utils.h
@@ -36,6 +36,12 @@ u8 msm_dp_utils_calculate_parity(u32 data);
 void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
 				  u32 header_buff[2]);
 
+bool msm_dp_utils_link_fits(unsigned int clock, unsigned int bpp,
+			    unsigned int rate, unsigned int lanes, bool yuv420);
+int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
+			    unsigned int clock, unsigned int rate,
+			    unsigned int lanes, bool yuv420);
+
 bool msm_dp_utils_psr_needs_modeset(const struct drm_crtc_state *state);
 
 #endif /* _DP_UTILS_H_ */

-- 
2.56.0

