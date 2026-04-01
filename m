Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6A5D3515E
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A0C10F01D;
	Wed,  1 Apr 2026 09:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VUuR0z6e";
	dkim-atps=neutral
Received: from mail-m3273.qiye.163.com (mail-m3273.qiye.163.com
 [220.197.32.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4B010F01D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 09:15:45 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3923a2fca;
 Wed, 1 Apr 2026 17:15:40 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, victor.liu@nxp.com,
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
Subject: [PATCH v12 07/17] drm/bridge: analogix_dp: Move the color format
 check to .atomic_check() for Rockchip platforms
Date: Wed,  1 Apr 2026 17:14:44 +0800
Message-Id: <20260401091454.25730-8-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401091454.25730-1-damon.ding@rock-chips.com>
References: <20260401091454.25730-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d4853bbad03a3kunm479af8c3b32dd5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUsfTVZDT0kZTUsfQx5DSElWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=VUuR0z6eDDx+3vwi5BkwuzVB0BL055b56nj6t+wbet1Mr9Q2OWlZSd4KOzmgRMgNFTP6BGLbM+y5MgRtpsw37vQMLu4LaNc6N8PB5Ecl90pltx6U17QJGhI3rRN0kkjhRa/i0LinXEtqBTH/Hg0Wzy5hNmB+HkSXvaMmUHNpNKY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=3rkQ8jPKQUXQ5Fcb5jzjcMRfHXjYelN4FuQCG5UEL4g=;
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

For Rockchip platforms, the YUV color formats are currently unsupported.
This compatibility check was previously implemented in
&analogix_dp_plat_data.get_modes().

Moving color format check to &drm_connector_helper_funcs.atomic_check()
would get rid of &analogix_dp_plat_data.get_modes() and be more
reasonable than before.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de> (on rk3588)

---

Changes in v9:
- Add Tested-by tag.
---
 .../gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++++++++
 .../gpu/drm/rockchip/analogix_dp-rockchip.c    | 18 ------------------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 4606ecc3f480..5bf41b364aba 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -894,8 +894,19 @@ static int analogix_dp_atomic_check(struct drm_connector *connector,
 				    struct drm_atomic_state *state)
 {
 	struct analogix_dp_device *dp = to_dp(connector);
+	struct drm_display_info *di = &connector->display_info;
 	struct drm_connector_state *conn_state;
 	struct drm_crtc_state *crtc_state;
+	u32 mask = DRM_COLOR_FORMAT_YCBCR444 | DRM_COLOR_FORMAT_YCBCR422;
+
+	if (is_rockchip(dp->plat_data->dev_type)) {
+		if ((di->color_formats & mask)) {
+			DRM_DEBUG_KMS("Swapping display color format from YUV to RGB\n");
+			di->color_formats &= ~mask;
+			di->color_formats |= DRM_COLOR_FORMAT_RGB444;
+			di->bpc = 8;
+		}
+	}
 
 	conn_state = drm_atomic_get_new_connector_state(state, connector);
 	if (WARN_ON(!conn_state))
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index fdab71d51e2a..70fe5ae69e2e 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -166,23 +166,6 @@ static int rockchip_dp_powerdown(struct analogix_dp_plat_data *plat_data)
 	return 0;
 }
 
-static int rockchip_dp_get_modes(struct analogix_dp_plat_data *plat_data,
-				 struct drm_connector *connector)
-{
-	struct drm_display_info *di = &connector->display_info;
-	/* VOP couldn't output YUV video format for eDP rightly */
-	u32 mask = DRM_COLOR_FORMAT_YCBCR444 | DRM_COLOR_FORMAT_YCBCR422;
-
-	if ((di->color_formats & mask)) {
-		DRM_DEBUG_KMS("Swapping display color format from YUV to RGB\n");
-		di->color_formats &= ~mask;
-		di->color_formats |= DRM_COLOR_FORMAT_RGB444;
-		di->bpc = 8;
-	}
-
-	return 0;
-}
-
 static bool
 rockchip_dp_drm_encoder_mode_fixup(struct drm_encoder *encoder,
 				   const struct drm_display_mode *mode,
@@ -481,7 +464,6 @@ static int rockchip_dp_probe(struct platform_device *pdev)
 	dp->plat_data.dev_type = dp->data->chip_type;
 	dp->plat_data.power_on = rockchip_dp_poweron;
 	dp->plat_data.power_off = rockchip_dp_powerdown;
-	dp->plat_data.get_modes = rockchip_dp_get_modes;
 
 	ret = rockchip_dp_of_probe(dp);
 	if (ret < 0)
-- 
2.34.1

