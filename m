Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B1ACA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A728210F37D;
	Wed, 30 Sep 2026 12:45:00 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A779D10F385;
 Wed, 30 Sep 2026 12:44:54 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772163t07ddc1c2
X-QQ-Originating-IP: HH3deTPG2oeB7yf67F2S1AMFUkldv1DBKOV6BqlS2/g=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 702636443561893348
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:53 +0800
Subject: [PATCH 09/13] drm/msm/dp: Track output bit depth in bridge atomic
 state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-9-dbbf8b2b42bc@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14198; i=sophon@radxa.com;
 h=from:subject:message-id; bh=RQTW9FqPueCQSZPHJ76XPxFed33TC+kZy34ScyyRoYg=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZcJFPrOzHfcuuZuXvRfa/WkRYlNtlEsx2a6GEsFf
 /2pc1O/o5SFQYyLQVZMkUUhnmEue2XutadipXowc1iZQIYwcHEKwETMzjEy/Nv7LFnr+bL22y+v
 dKhasU7cLHt46drrvZsVo6akhT33rWT47y60fO+K3xzlGjNzrjJbaai3TCo8wPxrUsjya1e+puu
 Z8AAA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MdEqvkd2kWCgdw8B7aMFjMtYaFfLXuF+2PvWDryFVd20JwRgZTZ97t0n
 YwYYdV93WfmR+68/+hkCzLKksq5Yij32GUlXawirWHkASs1ekaqG5LR2AbGMtn4PmFVNxb1
 TTn6kCiGkRdDJ5nrxK0p3VpBSrFSCvOedn59JzyiBnaNXVxTHIQneIZqRqQGOc1JI77sQx1
 d2+y0fsKjGUKdwGCiDtT7MaG6XtqZMdFSfC68quhj4FHwBVRAQiToGX1WXv1LvpY2cs6sgR
 GBJDyl1n6uk3A1QINsbPS6a3kgDNpsaj43t/+DrsY+6yMLO1qR2L8zHYNoqdvKqqGV0xHgu
 Laib0RNqA0aVwuNtGDydZUQ0/jgq57hUkmuWwtSpb2CeT7tKn4nBx0m0Miq23um9yia2MuJ
 mWfQNUZzm0sfzVGZ8rhRavi2LwE5GfbxPni1amuxQqsHEP/o+L0JCwr/6nldXMLEJm5I353
 V984bmL440E0TxHW8T8gqLVLYzCl3W83bzplvlsvKqY7TajsosBdCwVgqDB3ASiwZGWqEHd
 QMLMy+F0Yq17P7MD384K91iHh+elny/pwONcjAUsYQwUOzJvoTfpC3v1OwMlK+tNTP1+zcK
 igtkXzBhurWtRr1hp9jdDeWiVQ1i3uHZdYHAUK662Q2lSq9jWh8k5EoZSlpnzikUddnZm/P
 xtFZCzDDZE8sNINvzahcrTe08XpdWSc8sD5Kc5lM5LZ9yFrYRz89gFCNu1FqM3cMmn58EP0
 JYN8a5x7bghqp+0toLVs5rGtZo8MzmerEZqz9k7PUSpH3/2VQDzU428yK/cqhRJtbEd3WFx
 Xcls4bMKY2BtsCnpX+cZZ+tmxV+B4li03GwzVK/mpjwGtK7Sbhy8KH64tld9Cg7+mwNSyKB
 /z7DUytILTgVtI9CFP7z2gr4Epx9kBYlMwCF/u17t3Vfaop3ClEqalMy9dKBlufiP5Tj3Rf
 VCSQ7oXgVpmUhbSdJsDRdxsBPFwK3gcGTe3fa3Ekv0wgxAHWZpZojSf0jJGJBCv91dYY6W/
 Nvns7DMi6EPXSNB9Vz6XLXkh7jsdKYCrnj+6TwTc674UjnQzDiGCPD18fNeqpiiz3EF8M6Y
 TqSSP0mIVjw
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

Expose max bpc on DP and eDP and select a supported component depth from
the new connector state. Keep the result in a private bridge state so
TEST_ONLY atomic commits do not modify the running stream. Force a modeset
when max bpc changes to apply the new depth to the stream.

Read cached capabilities under the plugged lock and defer the bandwidth
check if they are not yet valid. Recheck the selected depth against the
trained link before enabling video, including the reduced pixel rate of
YUV420. Retain support for 6 bpc SDR panels.

Retain the generic bridge helper's missing-state guard in the custom
duplicate callback. Initial state allocation can fail at bridge attach;
return NULL in that case so atomic state acquisition reports -ENOMEM
instead of copying from a NULL pointer.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 15 +++++++
 drivers/gpu/drm/msm/dp/dp_display.c | 39 ++++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_display.h |  6 +++
 drivers/gpu/drm/msm/dp/dp_drm.c     | 81 +++++++++++++++++++++++++++++++++----
 drivers/gpu/drm/msm/dp/dp_drm.h     |  7 ++++
 drivers/gpu/drm/msm/dp/dp_panel.c   |  5 ---
 drivers/gpu/drm/msm/dp/dp_utils.c   | 20 +++++++++
 drivers/gpu/drm/msm/dp/dp_utils.h   |  4 ++
 8 files changed, 162 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 16c9165b5f31..f41924e75854 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -23,6 +23,7 @@
 
 #include "dp_reg.h"
 #include "dp_ctrl.h"
+#include "dp_utils.h"
 #include "dp_link.h"
 
 #define POLLING_SLEEP_US			1000
@@ -2620,6 +2621,20 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
+	/* Link training may have reduced the available bandwidth. */
+	if (!panel->video_test) {
+		u32 clock = panel->msm_dp_mode.drm_mode.clock;
+
+		if (panel->msm_dp_mode.out_fmt_is_yuv_420)
+			clock /= 2;
+		ret = msm_dp_utils_select_bpp(panel->msm_dp_mode.bpp / 3, 10,
+					      clock, ctrl->link->link_params.rate,
+					      ctrl->link->link_params.num_lanes);
+		if (ret < 0)
+			return ret;
+		panel->msm_dp_mode.bpp = ret;
+	}
+
 	pixel_rate_orig = panel->msm_dp_mode.drm_mode.clock;
 	pixel_rate = pixel_rate_orig;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9c5b1cd200f8..af6bc179723c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -28,6 +28,7 @@
 #include "dp_panel.h"
 #include "dp_display.h"
 #include "dp_drm.h"
+#include "dp_utils.h"
 #include "dp_audio.h"
 #include "dp_debug.h"
 
@@ -662,7 +663,8 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 
 static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 				   const struct drm_display_mode *adjusted_mode,
-				   struct msm_dp_panel *msm_dp_panel)
+				   struct msm_dp_panel *msm_dp_panel,
+				   const struct msm_dp_bridge_state *state)
 {
 	struct msm_dp_display_private *dp;
 	u32 bpp;
@@ -672,7 +674,7 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	if (msm_dp_display_check_video_test(msm_dp_display))
 		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
 	else
-		bpp = msm_dp_panel->connector->display_info.bpc * 3;
+		bpp = state->bpp;
 
 	msm_dp_panel_init_panel_info(msm_dp_panel, adjusted_mode, bpp ? bpp : 24);
 
@@ -682,6 +684,34 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
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
+	if (drm_mode_is_420_only(info, mode))
+		clock /= 2;
+
+	guard(mutex)(&dp->plugged_lock);
+
+	bpp = msm_dp_utils_select_bpp(info->bpc, conn_state->max_requested_bpc,
+				      clock, dp->panel->link_caps_valid ?
+				      dp->panel->link_info.rate : 0,
+				      dp->panel->link_info.num_lanes);
+	if (bpp < 0)
+		return bpp;
+
+	state->bpp = bpp;
+	return 0;
+}
+
 static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
@@ -1497,6 +1527,7 @@ void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
 	struct msm_dp_display_private *dp;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
+	struct drm_bridge_state *bridge_state;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
@@ -1504,13 +1535,15 @@ void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
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
 
 static void msm_dp_display_abort_enable(struct msm_dp_display_private *dp)
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
index 7332fbfe1644..7c18ddcdd19b 100644
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
@@ -303,9 +365,9 @@ static const struct drm_bridge_funcs msm_edp_bridge_ops = {
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
@@ -385,11 +447,16 @@ struct drm_connector *msm_dp_drm_connector_init(struct msm_dp *msm_dp_display,
 					    struct drm_encoder *encoder)
 {
 	struct drm_connector *connector = NULL;
+	int ret;
 
 	connector = drm_bridge_connector_init(msm_dp_display->drm_dev, encoder);
 	if (IS_ERR(connector))
 		return connector;
 
+	ret = drm_connector_attach_max_bpc_property(connector, 6, 10);
+	if (ret)
+		return ERR_PTR(ret);
+
 	if (!msm_dp_display->is_edp)
 		drm_connector_attach_dp_subconnector_property(connector);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index da412c788503..cd755f7205ef 100644
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
index f7aac0d25c87..f288571798d3 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -690,11 +690,6 @@ int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel,
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
index 72bae48a1fe0..3e49854d73fb 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.c
+++ b/drivers/gpu/drm/msm/dp/dp_utils.c
@@ -89,6 +89,26 @@ void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
 		FIELD_PREP(PARITY_3_MASK, msm_dp_utils_calculate_parity(sdp_header->HB3));
 }
 
+/* A zero link rate means that a powered-down eDP panel has not been probed. */
+int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
+			    unsigned int clock, unsigned int rate,
+			    unsigned int lanes)
+{
+	unsigned int bpp;
+
+	bpc = min3(bpc ? bpc : 8, max_bpc, 10U);
+	bpc = round_down(bpc, 2);
+	if (bpc < 6)
+		return -EINVAL;
+
+	for (bpp = bpc * 3; bpp >= 18; bpp -= 6) {
+		if (!rate || (u64)clock * bpp <= (u64)rate * lanes * 8)
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
index 5d86c978dffd..a32e313d910d 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.h
+++ b/drivers/gpu/drm/msm/dp/dp_utils.h
@@ -36,6 +36,10 @@ u8 msm_dp_utils_calculate_parity(u32 data);
 void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
 				  u32 header_buff[2]);
 
+int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
+			    unsigned int clock, unsigned int rate,
+			    unsigned int lanes);
+
 bool msm_dp_utils_psr_needs_modeset(const struct drm_crtc_state *state);
 
 #endif /* _DP_UTILS_H_ */

-- 
2.55.0

