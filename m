Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E322CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D46110FE32;
	Fri,  9 Oct 2026 03:18:52 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66B410FE29;
 Fri,  9 Oct 2026 03:18:48 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515870t69f91405
X-QQ-Originating-IP: nHOD05SkEyMVfrOgKznxlEQq6/k5vIGyj/c/FhbiQhI=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11386624745954632910
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:16:04 +0800
Subject: [PATCH v2 12/20] drm/msm/dp: Rebuild the eDP stream on modesets
 leaving self refresh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-12-1835d4966da3@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4291; i=sophon@radxa.com;
 h=from:subject:message-id; bh=sr4aO+I/entmMZ8JCT+QlWp2I4E0ZCpUfm9WN2ZSTd4=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlYqWP44a65XaCs05dpNocKLe7ff3nQ+bkd6X+Utj
 p2T4xcd7ihlYRDjYpAVU2RRiGeYy16Ze+2pWKkezBxWJpAhDFycAjARiQOMDCvrn6pG14Uc4H7u
 V3f+o+fe845Lalvuht76fnbpu/8+NU2MDHvf9M/gqXUu3bPpj4lIycPfL/d1fbkQYKoZk3s2bl7
 Ech4A
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OfARS1tHiMjeCdiFtnndNl85VhaPeQ9RDwOH5gJB8wchScWV3uVn6gAz
 yaKSP7ZJQ0nZtfmfQE3/io8F7RZ3McHc9UZIYbHfFFCFt32xhjNmkQEj4bqhlzRrVlUXfIk
 /7VFRKz35rKnT5c/T0DhZrfDGbeV9xoZTuyfYK8L81RSICwWGUBHwMsQwErQ1DguNFz79/r
 q+4m5ZsK1FLIV8OwFlKB3QyJS9AUsH/L0cj0+QTMgSQj/Wts+e1aGyLFaB5qDjSkiSiHUTd
 BW6ueEx7fzie4i9aOOXAnt/wnEU//mRqsLg51Bp3/QkRin03EhoPrmqhF1gsK3fP8TsmsCJ
 62J96lx42wxjzkXNrnrwMXJ7Qyz3iD1hUru19GJ1TnrfdG5eutVfAL4sRspvlS6U0+nzYZ0
 Uvq3sOvlbtEFOWCJOQ/qPx+WUTuyMOiL4omv5cDPsqllWdt4Cm3uSm69CwarTNm59UuOuw9
 wPBDLIX9BGhs0DJMFT2NwjOt+skSLMYLDiSigavK0J2qz0F3C9KpKoV+5JY0A+S2dX+xV6D
 oxVw0crMt2+0aZcXc9GVBEIsY76B+3qnEqNux6W0q1veUTdf8MI2P1F+GW20a7wgNqGDQAp
 ZCsST0pEySmTjeKSfDxuIZWlm/H5S8rGVGdlTgDM9IPcJCBJvLAg7wJBcmtBNJ8INsrfJTA
 9gKEPbDZeS9+7zT0jttX34TuDB+luueM7awUQn7QM3ZETf/cfiapnMXTa8uG85cpCpDcHq9
 OVoo5s0w/oMpyvIt8wVm7iYdwQQo+8jTyMEE8gV/eEQ4S9YMdAN61LvKkovfxpGUSbca0iN
 iTE5rsMdMgpoIz0SKW3w8Pnlxd6RKbB/vsCwGsIm1APtfxG+STov6iTsM+o3B0cxRleanD7
 zkcuttaRHPRF25/JGE7Cj/uyFyBN7rwGzBw1ztLvXF5Z0/CgSOq8ZfRRPuLEMkmps7GNFKo
 1Sm8XlaZCS+7xBcKv2cYAarOtX6q2d5cvSBA4slAJKHZdckX3QxXUxnqKm5vGMdiwpPiCSk
 EEh0NzMnQm616OlBIT6u0xGsjxyXHuWrQUQdPqh+wONei8OL4USWql7xPyk4XWlj1Rp9BvZ
 A==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
index 8c4446b12925..df224ae46d9d 100644
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
2.56.0

