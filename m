Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B3DE98FC2
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB45410E73A;
	Thu,  9 Apr 2026 06:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KVaavLxi";
	dkim-atps=neutral
Received: from mail-m32101.qiye.163.com (mail-m32101.qiye.163.com
 [220.197.32.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E679110E73A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 06:53:40 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3a11ab33b;
 Thu, 9 Apr 2026 14:53:34 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, victor.liu@nxp.com, Frank.Li@nxp.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, inki.dae@samsung.com,
 sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
 jingoohan1@gmail.com, p.zabel@pengutronix.de, hjc@rock-chips.com,
 heiko@sntech.de, andy.yan@rock-chips.com
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, kernel@pengutronix.de, festevam@gmail.com,
 alim.akhtar@samsung.com, dmitry.baryshkov@oss.qualcomm.com,
 luca.ceresoli@bootlin.com, nicolas.frattaroli@collabora.com,
 dianders@chromium.org, m.szyprowski@samsung.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v13 10/17] drm/bridge: analogix_dp: Pass struct
 drm_atomic_state* for analogix_dp_bridge_mode_set()
Date: Thu,  9 Apr 2026 14:52:54 +0800
Message-Id: <20260409065301.446670-11-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409065301.446670-1-damon.ding@rock-chips.com>
References: <20260409065301.446670-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d7104840a03a3kunmc1f4d654403a3f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh4eHlZJQx5PSB1DTh1PGUtWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=KVaavLxiNsTRboPRgtoNS1Ve3Ojj0CT4IflTsi7aGQhgzayIH0Df36csj5MFdsiGnHmVJ95EEcMnowe1Z9iemObA3EUvWzHwwkZPOZCoRwXpBRlSMgR5Of+VSGin+I2pAXxz/1NaN858YFNC8b9zKd6tx8g3/PKrUwL9Ze9+V3E=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=A/8Fvy7J5BVB+FxoirPdlPQvgwvtL4v5yvK+fpD9HUY=;
 h=date:mime-version:subject:message-id:from;
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

To avoid using &analogix_dp_device.connector for compatibility
with the bridge connector framework, get &drm_connector from
&drm_atomic_state instead.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 840c1963e60e..84b994cce900 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1095,14 +1095,21 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 }
 
 static void analogix_dp_bridge_mode_set(struct drm_bridge *bridge,
+					struct drm_atomic_state *state,
 					const struct drm_display_mode *mode)
 {
 	struct analogix_dp_device *dp = to_dp(bridge);
-	struct drm_display_info *display_info = &dp->connector.display_info;
 	struct video_info *video = &dp->video_info;
 	struct device_node *dp_node = dp->dev->of_node;
+	struct drm_connector *connector;
+	struct drm_display_info *display_info;
 	int vic;
 
+	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	if (!connector)
+		return;
+	display_info = &connector->display_info;
+
 	/* Input video interlaces & hsync pol & vsync pol */
 	video->interlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
 	video->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NVSYNC);
@@ -1186,7 +1193,7 @@ static void analogix_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 	new_crtc_state = drm_atomic_get_new_crtc_state(old_state, crtc);
 	if (!new_crtc_state)
 		return;
-	analogix_dp_bridge_mode_set(bridge, &new_crtc_state->adjusted_mode);
+	analogix_dp_bridge_mode_set(bridge, old_state, &new_crtc_state->adjusted_mode);
 
 	old_crtc_state = drm_atomic_get_old_crtc_state(old_state, crtc);
 	/* Not a full enable, just disable PSR and continue */
-- 
2.34.1

