Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCC210A88F0
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D34D10EBA8;
	Thu, 26 Mar 2026 17:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iCiLE2LR";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D2B10EB79
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774546299;
 bh=C/bRBCXqsC7yP3s1o/pXdyTZxhqmJw2YbXnOp1QrdzM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iCiLE2LRuChPGQqjjus/pnbKR3OuAL4GPNhsF+QDgNaVN/jo+4ih0ucxHmJ8QeRO8
 Cirm8DSBrKI+3HxVjuwXerFB/8P8ixzL9thIJrBzim8QNCQMywUJ2COeEaXp7goJLj
 cZFnZu4i/aqBf9WOq4FZgpYSH37/DS1qLL+fENFCy/yyssrpdvUyLQk8ySomGNvxeF
 lb9faDssUA8ku7TV4TCZRwGlsNEgCIPQ51l0nUwHe44OL2G2UnuKl++/Sz5DEyNjWV
 kqLHxJTzUy+6QpjgSXSN/L8d8xXFLFmKnXEeQL2JPP/YgiicU/1GzIi8TvA/KCjaAL
 6K3n+APU3jVHA==
Received: from jupiter.universe (dyndsl-091-248-208-149.ewe-ip-backbone.de
 [91.248.208.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EE56D17E6193;
 Thu, 26 Mar 2026 18:31:38 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 49CC0480035; Thu, 26 Mar 2026 18:31:38 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 26 Mar 2026 18:31:32 +0100
Subject: [PATCH 08/10] drm/rockchip: dw_dp: Add runtime PM support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-synopsys-dw-dp-improvements-v1-8-501849162290@collabora.com>
References: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
In-Reply-To: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Damon Ding <damon.ding@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Alexey Charkov <alchark@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3089;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=C/bRBCXqsC7yP3s1o/pXdyTZxhqmJw2YbXnOp1QrdzM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGnFbXoNi4+i3qTb7MNtT3rYJPw+UYf1HUjY9
 Ft7qXoc4QP3gIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpxW16AAoJENju1/PI
 O/qao9AP/iyrg21s359QjCFlpyhUeTinxCjdMntwvXj3A0XIgb1+KrvSdUIuHell63PAR9CHgj/
 adgEnVPmfp+aH9hro071S3V5DAojo+FEvH49cE2OrZ+bQ/74Vf+TCnC70U+HBEJCoKNeXh+ex4V
 k2rVFGTIitER2CAvAFnO83g9tUS2JYkImbRmhtcrK7myQUlzbELwJOuZ5tJREGjXte6BzY4Zarh
 o47XPYfJNNjIiA75Gz7j/Nv7l/vAsViqZDn1CkhgK9RMx+l1zDiKS+KbRnZl0jR0zRpv9qZ7xkI
 i2W9fkFewjHFL3CJ09WFLxTylpiqYA/qlVwqrEOKAaRorpD2z3zaAhRH8RLZsz7v+HhfSqFW2O1
 gAHqD0sbQTC4CP5hPtwCfkwjCymIRRk1kvmbcrAG0tFzDfrnVWVE8vo3PrCWj7qy9NeX1tTZ//j
 OLrYoIEJMYH+bctaaaEidnG41y1qjcv8DQAshvd568KuLjK9lHpsqgK3ReXOpd513IoE6SVAb5W
 im6mxWSbez690rhAiP/jZZ6grZbbEVtfZOGQgURWRU1Rv6avoTgMY7I9Gn71mTeCPhXbVzDJRO9
 fOJjl33xcldUKqop3JL8WrOkAr/Ploc+2Y9ftqY05Cj1cFQ63a4WVGPoBn+AxSp5Fm/x9wP6N53
 96zlFarDc1hgFnmyHVXo2Qw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

Add support for runtime PM to the Rockchip RK3576/3588 Synopsys
DesignWare DisplayPort driver.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index a9845161ced3..c371306f7073 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/videodev2.h>
 #include <linux/regmap.h>
 
@@ -58,6 +59,8 @@ static void dw_dp_rockchip_hpd_sw_sel(void *data, bool force_hpd_from_sw)
 
 	dp->hpd_sel = force_hpd_from_sw;
 
+	ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
+
 	regmap_write(dp->vo_grf, hpd_reg,
 		     FIELD_PREP_WM16_CONST(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, dp->hpd_sel));
 }
@@ -71,6 +74,8 @@ static void dw_dp_rockchip_hpd_sw_cfg(void *data, bool hpd)
 
 	dp->hpd_cfg = hpd;
 
+	ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
+
 	regmap_write(dp->vo_grf, hpd_reg,
 		     FIELD_PREP_WM16_CONST(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, dp->hpd_cfg));
 }
@@ -213,6 +218,12 @@ static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *
 	if (IS_ERR(dp->base))
 		return PTR_ERR(dp->base);
 
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 500);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable runtime PM\n");
+
 	connector = drm_bridge_connector_init(drm_dev, encoder);
 	if (IS_ERR(connector))
 		return dev_err_probe(dev, PTR_ERR(connector),
@@ -235,6 +246,34 @@ static void dw_dp_remove(struct platform_device *pdev)
 	component_del(&pdev->dev, &dw_dp_rockchip_component_ops);
 }
 
+static int dw_dp_rockchip_runtime_suspend(struct device *dev)
+{
+	struct rockchip_dw_dp *dp = dev_get_drvdata(dev);
+
+	return dw_dp_runtime_suspend(dp->base);
+}
+
+static int dw_dp_rockchip_runtime_resume(struct device *dev)
+{
+	struct rockchip_dw_dp *dp = dev_get_drvdata(dev);
+	u32 hpd_reg = dp->pdata->hpd_reg[dp->id];
+	int ret;
+
+	ret = dw_dp_runtime_resume(dp->base);
+	if (ret)
+		return ret;
+
+	regmap_write(dp->vo_grf, hpd_reg,
+		     FIELD_PREP_WM16_CONST(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, dp->hpd_sel) |
+		     FIELD_PREP_WM16_CONST(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, dp->hpd_cfg));
+
+	return 0;
+}
+
+static const struct dev_pm_ops dw_dp_pm_ops = {
+	RUNTIME_PM_OPS(dw_dp_rockchip_runtime_suspend, dw_dp_rockchip_runtime_resume, NULL)
+};
+
 static const struct rockchip_dw_dp_plat_data rk3588_dp_plat_data = {
 	.num_ctrls = 2,
 	.ctrl_ids = {0xfde50000, 0xfde60000},
@@ -269,5 +308,6 @@ struct platform_driver dw_dp_driver = {
 	.driver = {
 		.name = "dw-dp",
 		.of_match_table = dw_dp_of_match,
+		.pm = pm_ptr(&dw_dp_pm_ops),
 	},
 };

-- 
2.53.0

