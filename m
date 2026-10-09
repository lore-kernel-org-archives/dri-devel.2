Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB3DCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA28E10FE2F;
	Fri,  9 Oct 2026 03:19:53 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D9510FE3E;
 Fri,  9 Oct 2026 03:19:48 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515886ta7242542
X-QQ-Originating-IP: l+W6hRlVtBHQfDWT8V5zz4miNkGZI0SAE1TvYswxTT0=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:18:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9731896443966331316
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:16:08 +0800
Subject: [PATCH v2 16/20] drm/msm/dp: Disable PSR for YUV420 streams
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-16-1835d4966da3@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5080; i=sophon@radxa.com;
 h=from:subject:message-id; bh=UjFIXijNr1pzmNLWjNFf1sbanjbBvQlfCd9rr2qiLaU=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlZVBVVpuU+p3cWf4v31vXBZ2o2ZVZOu5KW/T5Lf2
 Kllzvu6o5SFQYyLQVZMkUUhnmEue2XutadipXowc1iZQIYwcHEKwEQezGBkuNjxsdN1b9v61IvP
 p8347R0Z2LJhgUqx5G7G5T+e2LCuqWH4Zx+yY1LK+o/czg7rD5ikq+X4mXud4tH/Gu8eftVm1vp
 ENgA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ONeCszOCk2GV0SA7qTJOahipV4CHXTflpXWQ1K0qi/CEbJVYGnnMm910
 JS04TaZN9lbqWM3BL3NOW0+doEext63YvV0QPJ2cDuE3xbtolU8QXett1Qs0Z+5kAjOEyoH
 zu+sjwl23NW8TJHcMo9V4d4ehPNB8szfrXVZspLM6yHa62KDM3loPvlEuVTzzlCDIAysyej
 FHqYrWNiL39Mf9NmVA61O05DZmPppxw5oLPvSmZJvgsvdYrHRxGxZMgGO00An0DdzmZjPBI
 FpC3HM50DHacqN8Hwq5KmjqBr8rLkF5AS6p9f5q5bsUf+PDKJikaqHxQ6WeqyhQTaPlT/EK
 5LX23hKUpOKHxIc6CyyMyZO9f8tNFlJx71u/zRokPUimMDZilACoJP/OyYT0KQsDSUUj03M
 V5yq073nVr0ibxttcL9SMz7b4T+uVXgPpm4vj1y4IZ5m6OFB4w82Vyw6+eyxVKHrVToG1EM
 KMb+bXxkV2Twn5fynw3Yeup5RgjBOL1xSHQrhHIHLat9wJBjCuFOpxS5lHtxpdQD7IpHEhF
 yyt6VDrFMy1hED6O4CYfP66t/V7dkOhQNeoQmbevqPd3yVGONSucLlLwoiIMgx3vx5VyW7j
 T4Z5KVyLu0s6b21ocsF+eB71Wu58sDvFMfr5ALpxSSuq3yXg99Nj61Hl2+9ow4Z4p8wUOQM
 CCCV9AmhZKeJTgOiPsSLdyLRyzGPrNAFDpt8UzDLmbHkjO5/7eXmpki4Vqf5Yh+uhQCqblr
 XAgf82dIZTplkMMDMGGBX4b9csb1J6DzUwhkj6LxwusrxQV/ALamnwk1I/RdMvYTA3H+CR0
 oXdqFLfw5Nci4it1eVSGgYs0Kukf0ae7n16i228490GW1uJfpvBQCiZ/JMbXXarVfUkepJ5
 o5qQFZZtALMHiXwmQLk75gNdj51BBmjgyFQG/TIwE/d8VZ6ukw1Vai07nVBWoAvttqAIGTY
 /Ag1vAuB3y5lDYXbK2fJXYOBH2jjw1PuZZl+jZ0quaDvF0em+yUbMuBB+5WWjbNHxAg9zii
 saY+iqdl75OWzObUGRd2O1Xr27dliMzVy5PqXqqwn4SCMuVxjrUDhRtWIje4QxX34XN+qPE
 JAt10GYpd31
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

YUV420 uses colorimetry VSC packets, which cannot share the automatic
PSR packet generator. Do not advertise self-refresh eligibility for
these streams while disabling PSR in the controller and sink.

Compute eligibility after the common atomic check and reject an
incompatible self-refresh entry. Clear the automatic VSC generation bit
for YUV420 and restore PSR configuration when returning to RGB.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 19 ++++++++++++-------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
 drivers/gpu/drm/msm/dp/dp_drm.c     | 16 ++++++++++++----
 4 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 783cafb22374..82ef8e405543 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -411,7 +411,7 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
 
 	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
 
-	if (msm_dp_panel->psr_cap.version)
+	if (msm_dp_panel->psr_cap.version && !msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
 		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
 
 	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
@@ -1914,7 +1914,7 @@ static void msm_dp_ctrl_psr_exit(struct msm_dp_ctrl_private *ctrl)
 }
 
 void msm_dp_ctrl_config_psr(struct msm_dp_ctrl *msm_dp_ctrl,
-			    struct msm_dp_panel *panel)
+			    struct msm_dp_panel *panel, bool enable)
 {
 	struct msm_dp_ctrl_private *ctrl = container_of(msm_dp_ctrl,
 			struct msm_dp_ctrl_private, msm_dp_ctrl);
@@ -1923,15 +1923,20 @@ void msm_dp_ctrl_config_psr(struct msm_dp_ctrl *msm_dp_ctrl,
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
index 486348113b8a..234cb2373451 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -822,7 +822,8 @@ static int msm_dp_display_post_enable(struct msm_dp *msm_dp_display)
 	msm_dp_display_handle_plugged_change(msm_dp_display, true);
 
 	if (msm_dp_display->psr_supported)
-		msm_dp_ctrl_config_psr(dp->ctrl, dp->panel);
+		msm_dp_ctrl_config_psr(dp->ctrl, dp->panel,
+				       !dp->panel->msm_dp_mode.out_fmt_is_yuv_420);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 9f1aa87a3687..6b01eeeb1aef 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -204,19 +204,27 @@ static int msm_edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
 				   struct drm_connector_state *conn_state)
 {
 	struct msm_dp *dp = to_dp_bridge(drm_bridge)->msm_dp_display;
+	int ret;
 
 	if (WARN_ON(!conn_state))
 		return -ENODEV;
 
-	conn_state->self_refresh_aware = dp->psr_supported;
-
+	conn_state->self_refresh_aware = false;
 	if (!conn_state->crtc || !crtc_state)
 		return 0;
 
-	if (crtc_state->self_refresh_active && !dp->psr_supported)
+	ret = msm_dp_bridge_atomic_check(drm_bridge, bridge_state, crtc_state, conn_state);
+	if (ret)
+		return ret;
+
+	/* Match the PSR configuration applied when enabling this stream. */
+	conn_state->self_refresh_aware = dp->psr_supported &&
+		!drm_mode_is_420_only(&conn_state->connector->display_info,
+				    &crtc_state->adjusted_mode);
+	if (crtc_state->self_refresh_active && !conn_state->self_refresh_aware)
 		return -EINVAL;
 
-	return msm_dp_bridge_atomic_check(drm_bridge, bridge_state, crtc_state, conn_state);
+	return 0;
 }
 
 static void msm_edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,

-- 
2.56.0

