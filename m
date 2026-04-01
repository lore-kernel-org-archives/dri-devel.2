Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDADD35163
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50FB410EF9D;
	Wed,  1 Apr 2026 09:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DOiw7uJB";
	dkim-atps=neutral
Received: from mail-m1973189.qiye.163.com (mail-m1973189.qiye.163.com
 [220.197.31.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45FB10EF9D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 09:35:54 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 392496b4d;
 Wed, 1 Apr 2026 17:35:50 +0800 (GMT+08:00)
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
Subject: [PATCH v12 14/17] drm/exynos: exynos_dp: Apply
 analogix_dp_finish_probe()
Date: Wed,  1 Apr 2026 17:35:44 +0800
Message-Id: <20260401093547.25840-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401091454.25730-1-damon.ding@rock-chips.com>
References: <20260401091454.25730-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d486631fb03a3kunm1fbc9b38b36ec3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwaT1ZPSR0fGh5DT0IZSx9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=DOiw7uJB0OOmKKpobAKrs41VGo1F+FJbWyIm8YHOGbfMzgWFLxi0gZH7RjZ4maOiYEEhHg+lLXGY4OTyGu+Dp3ci4CYxibLjKTC+7+aDHiDg3k52XiipiGoXWQ3DWfayJ/Tsvlq4KMjoVRlIl0BECF6lTqnwE1OMb7neCBOk/Bc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=l0rCYWGbbWqoD8V97nbLeMFxlHthOJgEIOH48elhF+M=;
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

Apply analogix_dp_finish_probe() in order to move the panel/bridge
parsing from Exynos side to the Analogix side.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de> (on rk3588)

---

Changes in v4:
- Rename analogix_dp_find_panel_or_bridge() to
  analogix_dp_finish_probe().

Changes in v7:
- Remove exynos_dp_legacy_bridge_init() and inline API
  devm_drm_of_display_mode_bridge().
- If the panel or the next_bridge is parsed from DT, use ptr validity
  to check whether to call component_add() directly at the end of
  probing.

-Changes in v9:
- Add Tested-by tag.
---
 drivers/gpu/drm/exynos/exynos_dp.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index b2597fafd73d..9f3d4d4c7352 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -158,9 +158,6 @@ static int exynos_dp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np;
 	struct exynos_dp_device *dp;
-	struct drm_panel *panel;
-	struct drm_bridge *bridge;
-	int ret;
 
 	dp = devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device),
 			  GFP_KERNEL);
@@ -187,30 +184,30 @@ static int exynos_dp_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &panel, &bridge);
-	if (ret == -ENODEV) {
+	if (of_get_display_timings(dev->of_node)) {
 		dp->plat_data.next_bridge = devm_drm_of_display_mode_bridge(dp->dev,
 									dp->dev->of_node,
 									DRM_MODE_CONNECTOR_eDP);
-		ret = IS_ERR(dp->plat_data.next_bridge) ? PTR_ERR(dp->plat_data.next_bridge) : 0;
+		if (IS_ERR(dp->plat_data.next_bridge))
+			return PTR_ERR(dp->plat_data.next_bridge);
 	}
-	if (ret)
-		return ret;
 
 	/* The remote port can be either a panel or a bridge */
-	dp->plat_data.panel = panel;
-	dp->plat_data.next_bridge = bridge;
 	dp->plat_data.dev_type = EXYNOS_DP;
 	dp->plat_data.power_on = exynos_dp_poweron;
 	dp->plat_data.power_off = exynos_dp_poweroff;
 	dp->plat_data.attach = exynos_dp_bridge_attach;
+	dp->plat_data.ops = &exynos_dp_ops;
 
 out:
 	dp->adp = analogix_dp_probe(dev, &dp->plat_data);
 	if (IS_ERR(dp->adp))
 		return PTR_ERR(dp->adp);
 
-	return component_add(&pdev->dev, &exynos_dp_ops);
+	if (dp->plat_data.panel || dp->plat_data.next_bridge)
+		return component_add(&pdev->dev, &exynos_dp_ops);
+	else
+		return analogix_dp_finish_probe(dp->adp);
 }
 
 static void exynos_dp_remove(struct platform_device *pdev)
-- 
2.34.1

