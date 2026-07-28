Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE7DC54F57
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BDC610E98F;
	Tue, 28 Jul 2026 17:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qyEVdcfG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDCD510E99D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785260447;
 bh=1HZ6TnZb1RJLoxq7Qwcu8RatOuTC6uAWV6dcjk4cHmY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=qyEVdcfGPZSarEK+lG4JW44hLv2J2zvXPBHUlfUbJ7JPjvykTtY5Ed8nX5iSVsIzZ
 4w2UtzxDz3OyDYpyzpNvqS4WhYymUai1uL0imvWmg6lxikImfOU3FplygK1Zry9xED
 KZ6AxBy+FHD4y81gwHWDM8k5cAbm/gigQ+I+iuRuzR/0faxnLYCfjmDaLMKq3XebQc
 Jz0IqhZFX2qGsDLXLsa6lGVpo/rO90C+auW8US5/HnGaeGW7q9wVEeo4jxhN+bqpKJ
 UEevLOVOASJlpDuMdI+Tv+jfgsD7IEMoTTbXYDsLvnoKPV4qRr9ee722KLHMEdsaTH
 NN/S3wiIHDGaw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CF98617E07B2;
 Tue, 28 Jul 2026 19:40:46 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 1CF2648004E; Tue, 28 Jul 2026 19:40:46 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 28 Jul 2026 19:40:49 +0200
Subject: [PATCH v7 13/18] drm/rockchip: dw_dp: Add runtime PM support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-synopsys-dw-dp-improvements-v7-13-b7640fa8cf48@collabora.com>
References: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
In-Reply-To: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
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
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3624;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=1HZ6TnZb1RJLoxq7Qwcu8RatOuTC6uAWV6dcjk4cHmY=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpo6Z0nrympKTR7Jkux+/TPtCNPN8ysyQQK2
 Lgv1zrdbvwttYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqaOmdAAoJENju1/PI
 O/qavWAQAKjX9OxV4H1GU4BdKgGsxDvahaYZtNSLNW/07VSFpcZ+Z1m0dKcZp7Ku/X5M7/3Zkx4
 knIoVWRengwv+/WDQuYgOfpQAyY+YUwDPkVg8kFf5NP8TkciixwK67o168HGenBMDJGfkRjY2OS
 rkon0NBte8HhZcwJmTyJucYgWyIiHKukP0yRaN1LY4KhAzATNWa2L1wHd9rkpkwo7L36QM5a3uM
 WfZX6479XOFINVCvwYUVSAvLQLsFHmk0iKhnE2s+OBehv3nEQ7E7+uQzLQWfD/VrHiv/NK79F2+
 SXuNHbpq05g84qxlHDXFjxfebt+sSGP1Rpa1pYbhYhHj1du5WNSJ1wcoQSZSEqRvhk3EQHaRuNv
 ZkhyegHOcLx6OZrWZ7sUoWsfASitlaIamxaoEts7pLuDA6697UtRpS2fRlTzYyFDvTNd653yJAp
 gCylUxnC4niZc1RXH49mAEnNfuI1uFF460yl/styQP9cgJ+OjM/5VJFfbnvGTMy0IJHqiaM1eRB
 llrDK5ape2CzOo9yzf0OG2w9HIXvIsnpbxV4Ylk8weLOMgb7g0cCls/vF047enCynvHJK1jpr9g
 HUl3Z5d4LDQ3Rqbh5hoGE6LFKAw+iaGV7PxmZwZ6l7wekjCT3xrQbxsd/v1IqtilvbWXQdk3wYI
 xRz140kFMEFot9BXotpM0tA==
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
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 50 ++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index b2e817044c94..01915f7b24d5 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/videodev2.h>
 
@@ -54,9 +55,15 @@ static void dw_dp_rockchip_hpd_sw_sel(void *data, bool force_hpd_from_sw)
 {
 	struct rockchip_dw_dp *dp = data;
 	u32 hpd_reg = dp->pdata->hpd_reg[dp->id];
+	int ret;
 
 	dp->hpd_sel = force_hpd_from_sw;
 
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return;
+
 	regmap_write(dp->vo_grf, hpd_reg,
 		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, dp->hpd_sel));
 }
@@ -65,11 +72,17 @@ static void dw_dp_rockchip_hpd_sw_cfg(void *data, bool hpd)
 {
 	struct rockchip_dw_dp *dp = data;
 	u32 hpd_reg = dp->pdata->hpd_reg[dp->id];
+	int ret;
 
 	dev_dbg(dp->dev, "Force HPD connected=%s\n", str_yes_no(hpd));
 
 	dp->hpd_cfg = hpd;
 
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return;
+
 	regmap_write(dp->vo_grf, hpd_reg,
 		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, dp->hpd_cfg));
 }
@@ -200,7 +213,7 @@ static int dw_dp_rockchip_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rockchip_dw_dp *dp;
 	struct resource *res;
-	int id;
+	int id, ret;
 
 	plat_data_const = device_get_match_data(dev);
 	if (!plat_data_const)
@@ -247,6 +260,12 @@ static int dw_dp_rockchip_probe(struct platform_device *pdev)
 	if (IS_ERR(dp->base))
 		return PTR_ERR(dp->base);
 
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 500);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
 	return component_add(&pdev->dev, &dw_dp_rockchip_component_ops);
 }
 
@@ -255,6 +274,34 @@ static void dw_dp_rockchip_remove(struct platform_device *pdev)
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
+		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, dp->hpd_sel) |
+		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, dp->hpd_cfg));
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
@@ -289,5 +336,6 @@ struct platform_driver dw_dp_driver = {
 	.driver = {
 		.name = "dw-dp",
 		.of_match_table = dw_dp_of_match,
+		.pm = pm_ptr(&dw_dp_pm_ops),
 	},
 };

-- 
2.53.0

