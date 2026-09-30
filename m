Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65F5CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D36910E265;
	Wed, 30 Sep 2026 12:47:38 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFBB110E265;
 Wed, 30 Sep 2026 12:47:35 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772160t1bf1ccbe
X-QQ-Originating-IP: EEFNbyufz4t4oGcF2h6wvs59l8IohGSawwKeAu5M4AU=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7675296171041416644
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:52 +0800
Subject: [PATCH 08/13] drm/msm/dp: Rebuild the eDP stream on modesets
 leaving self refresh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-8-dbbf8b2b42bc@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4291; i=sophon@radxa.com;
 h=from:subject:message-id; bh=UI8MWclcna3i912ApYu3ZkEYCbnyI0/V3H5NaAfD5xk=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZcFPNY8yD9NbvK8Bdn8TSqTC8xW5Z68+ylTT7Ni7
 w/pn6tYO0pZGMS4GGTFFFkU4hnmslfmXnsqVqoHM4eVCWQIAxenAEzkQzDDX9mG/8WKN17/fmXw
 TV7+88kf5RF9pqr7f5qabnAx3h8nf5Thf1bNVIFjbLpXpm5cI133xeq/senP8oK5cp8V8m97Su9
 KYQUA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MIAHdi1iQo+z5eZeSbEIWKPrzVGWsVhGOTp/49m4Ks+5ksObkP6hNa4m
 eaZP/WF0++/7EVuNCgdazGhbFXwMiZ7H3d9jaWMaDFhhMXsS2TGey1PJSBKL4NaUf+SV2xI
 Z0MPStzx/OxpB7SuF2AfK+QeHVIZI3k2et4br/FNM+p/9JlLhTnpt89gAPTIOL91bQcxFur
 opekRMrZ6KAkA1ZI41H40J5q/ZfFLPX1XOv9D9zWm3OgSNP6ucxRk+u64SZF17BytHQLUHj
 gK51+i5hl5BVSe0XPng7kChcuWJyh6oRXpRpQuvO8mgLf+CWaCc0k5ERykED+EZIGr0ewPv
 phvF0fulvbeH2QB59SGf6jmvQgyvAY8xXmvrAdFamRpGPUt0K6+SPQM0haU/WEy8JRpAES/
 ks1zxipoUye5hwLwQ8IocjKnUX4nMbLmp4UhFlfl7r61BDaxnUrLtF6xdqdtcWLcG/SwwRl
 9OBt75O69ZCFJOnwOU+zxB0JwFarNZj94gy/XMiFt6YeAXUYk57oQupYFVr9IbjyGHHUgQM
 mvSdqX8grtNcaC8zqPInws6skuZtjY+ggelyjSARv/0+NPmnFN2e8H55iXljZ/js43QrlkI
 MLXMwv+6gsMHB5Zic6thP9XSDn1m9CQb4uQrP5hlKm6dXM/4+uHMK+rQhZz8QnSSp3Ac1sH
 sS6AzKb5yFHMHa/juCYoW3DLXPbx8k0/uRxkqFEGDc/1Ul+st15V9XgqLqTAzG+YJx4DGiL
 guWMdaXxgc0GfCx41Zf9TCttrA6oU2xMjp2Zgviq7GQm90FcEoImJCYp45Pb0qcMK711Jmo
 f0plQSSNarFgbhkNiOhQIEg4PIaueqIJiO+nRGbefBemluc/V0kpbnyWhJGo5ayviv3oaX7
 rssgXAcm/n+V9Hw2D49K9jzJvjb4x3BIPNE5XW1X++P8WNktppDqY1achHtzxLSkURvNXy4
 G1qUA+R6mC+cji2TZ7/1MBR9CWv+tZFDy0mMFkERj2J+scdNXIyQfqvgDN11xKaTfeTMgK3
 kgDoVsD1hqXOvY4DdP0N008sfG2eK8Erlk2ip8Xtk7fJg2K6j6EC+KyLpOz5I/LXCmgNN1t
 g==
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

The atomic helpers skip bridge disable when an active CRTC leaves self
refresh. The eDP enable callback also takes a fast path that only exits
PSR, so a concurrent modeset can leave the retained stream using its old
configuration, including the output depth.

Exit PSR and tear down the retained stream in pre-enable when leaving self
refresh with mode_changed or connectors_changed set. Install the new state
and run the normal stream enable sequence afterwards. Keep the fast path
for ordinary self-refresh exits: active_changed alone does not require
rebuilding the stream.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_drm.c   | 24 +++++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_utils.c |  7 +++++++
 drivers/gpu/drm/msm/dp/dp_utils.h |  4 ++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index c1e4147bfef1..7332fbfe1644 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -14,6 +14,7 @@
 #include "msm_kms.h"
 #include "dp_audio.h"
 #include "dp_drm.h"
+#include "dp_utils.h"
 
 /**
  * msm_dp_bridge_get_modes - callback to add drm modes via drm_mode_probed_add()
@@ -54,6 +55,26 @@ static void msm_dp_bridge_atomic_pre_enable(struct drm_bridge *drm_bridge,
 {
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = dp_bridge->msm_dp_display;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+
+	crtc = drm_atomic_get_new_crtc_for_encoder(state, drm_bridge->encoder);
+	if (!crtc)
+		return;
+
+	old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
+	new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	/*
+	 * The helpers skip bridge disable when waking an active CRTC from
+	 * self refresh, even when its color configuration requires a modeset.
+	 * Tear down the retained stream before installing the new state.
+	 */
+	if (dp->is_edp && dp->power_on && old_crtc_state->self_refresh_active &&
+	    new_crtc_state->active && msm_dp_utils_psr_needs_modeset(new_crtc_state)) {
+		msm_dp_display_set_psr(dp, false);
+		msm_dp_display_atomic_disable(dp);
+		msm_dp_display_atomic_post_disable(dp);
+	}
 
 	msm_dp_display_atomic_pre_enable(dp, state);
 }
@@ -157,7 +178,8 @@ static void msm_edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 
 	old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
 
-	if (old_crtc_state && old_crtc_state->self_refresh_active) {
+	if (dp->power_on && old_crtc_state && old_crtc_state->self_refresh_active &&
+	    !msm_dp_utils_psr_needs_modeset(drm_atomic_get_new_crtc_state(state, crtc))) {
 		msm_dp_display_set_psr(dp, false);
 		return;
 	}
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.c b/drivers/gpu/drm/msm/dp/dp_utils.c
index 226b370ce8fe..72bae48a1fe0 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.c
+++ b/drivers/gpu/drm/msm/dp/dp_utils.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/types.h>
+#include <drm/drm_crtc.h>
 
 #include "dp_utils.h"
 
@@ -87,3 +88,9 @@ void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
 		FIELD_PREP(HEADER_3_MASK, sdp_header->HB3) |
 		FIELD_PREP(PARITY_3_MASK, msm_dp_utils_calculate_parity(sdp_header->HB3));
 }
+
+bool msm_dp_utils_psr_needs_modeset(const struct drm_crtc_state *state)
+{
+	/* active_changed alone also describes a normal self-refresh exit. */
+	return state->mode_changed || state->connectors_changed;
+}
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.h b/drivers/gpu/drm/msm/dp/dp_utils.h
index 2fdb89efc57c..5d86c978dffd 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.h
+++ b/drivers/gpu/drm/msm/dp/dp_utils.h
@@ -10,6 +10,8 @@
 #include <linux/bits.h>
 #include <drm/display/drm_dp_helper.h>
 
+struct drm_crtc_state;
+
 #define HEADER_BYTE_0_BIT	 0
 #define PARITY_BYTE_0_BIT	 8
 #define HEADER_BYTE_1_BIT	16
@@ -34,4 +36,6 @@ u8 msm_dp_utils_calculate_parity(u32 data);
 void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
 				  u32 header_buff[2]);
 
+bool msm_dp_utils_psr_needs_modeset(const struct drm_crtc_state *state);
+
 #endif /* _DP_UTILS_H_ */

-- 
2.55.0

