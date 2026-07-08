Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2838C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 21:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6872110F2F9;
	Wed,  8 Jul 2026 21:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XqfHnrrK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70AA310F2F2
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 21:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783547876;
 bh=Ux9JXRFq9ZIgTcJ9AL9bQIKbKW6ZLn++vU4tGoOlq3g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XqfHnrrKNCn9TqMVDCL1yIbS/V9pJpqv7cikJPbEg7SkLjdOpzTRK7YDUpdIDgRI3
 dAbEVutK94JMecpyxwpjV0LVgVCAJzz+XOQDi8mFJLi7zsW5XEQ1QGE+JqcoMVjymD
 IwGRZC9UDt8HdhZLflmWSi8ddAsnEWiz0ybx+uXw5uH0sn608wq/etYRZ5h482DKPM
 s+tohUzKKLDw8oknse9itQGBSr4r4TVm/yJehnAKSSlLhwNJ869Z6gYKNw7UVN3jJY
 jZg/hCp6gxUvnxMp+Or3Lt4958sW6eww0x7WdygCVA9KxfEfNSEndBWuv9uxnscHvs
 JryMhDcH7O2Yw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 046EA17E0D53;
 Wed, 08 Jul 2026 23:57:56 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 09 Jul 2026 00:57:29 +0300
Subject: [PATCH v3 07/14] drm/rockchip: vop2: Reset AXI and DCLK to improve
 robustness
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-dw-hdmi-qp-yuv-v3-7-a4a982a9f2e7@collabora.com>
References: <20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com>
In-Reply-To: <20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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

Assert the AXI reset in the CRTC disable path, and the VP DCLK reset in
the enable path.

These resets are intended to leave the hardware in a clean state for the
next use, helping recover from exceptions such as IOMMU page faults, as
well as to prevent random display output glitches, such as a blank
image, observed when switching modes that also change the color format,
e.g. from RGB to YUV420 and vice versa.

For now this seems to affect only the RK3588, hence the resets are
optional and will be provided in the device tree for this SoC only.

Co-developed-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 36 ++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 2cd04bedaa2c..8f0f4aa05fac 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/swab.h>
 
 #include <drm/drm.h>
@@ -867,6 +868,26 @@ static void vop2_core_clks_disable_unprepare(struct vop2 *vop2)
 	clk_disable_unprepare(vop2->hclk);
 }
 
+static void vop2_reset_assert_deassert(struct vop2 *vop2, struct reset_control *rstc)
+{
+	int ret;
+
+	if (!rstc)
+		return;
+
+	ret = reset_control_assert(rstc);
+	if (ret < 0) {
+		drm_warn(vop2->drm, "failed to assert reset: %d\n", ret);
+		return;
+	}
+
+	udelay(10);
+
+	ret = reset_control_deassert(rstc);
+	if (ret < 0)
+		drm_err(vop2->drm, "failed to deassert reset: %d\n", ret);
+}
+
 static void rk3588_vop2_power_domain_enable_all(struct vop2 *vop2)
 {
 	u32 pd;
@@ -953,6 +974,8 @@ static int vop2_enable(struct vop2 *vop2)
 
 static void vop2_disable(struct vop2 *vop2)
 {
+	vop2_reset_assert_deassert(vop2, vop2->axi_rst);
+
 	rockchip_drm_dma_detach_device(vop2->drm, vop2->dev);
 
 	pm_runtime_put_sync(vop2->dev);
@@ -1981,6 +2004,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vop2_crtc_atomic_try_set_gamma(vop2, vp, crtc, crtc_state);
 
+	vop2_reset_assert_deassert(vop2, vp->dclk_rst);
+
 	drm_crtc_vblank_on(crtc);
 
 	vp->enabled = true;
@@ -2596,6 +2621,12 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 			return dev_err_probe(drm->dev, PTR_ERR(vp->dclk),
 					     "failed to get %s\n", dclk_name);
 
+		vp->dclk_rst = devm_reset_control_get_optional_exclusive(vop2->dev,
+									 dclk_name);
+		if (IS_ERR(vp->dclk_rst))
+			return dev_err_probe(drm->dev, PTR_ERR(vp->dclk_rst),
+					     "failed to get %s reset\n", dclk_name);
+
 		np = of_graph_get_remote_node(dev->of_node, i, -1);
 		if (!np) {
 			drm_dbg(vop2->drm, "%s: No remote for vp%d\n", __func__, i);
@@ -2955,6 +2986,11 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 		return dev_err_probe(drm->dev, PTR_ERR(vop2->pll_hdmiphy1),
 				     "failed to get pll_hdmiphy1\n");
 
+	vop2->axi_rst = devm_reset_control_get_optional_exclusive(vop2->dev, "axi");
+	if (IS_ERR(vop2->axi_rst))
+		return dev_err_probe(drm->dev, PTR_ERR(vop2->axi_rst),
+				     "failed to get axi reset\n");
+
 	vop2->irq = platform_get_irq(pdev, 0);
 	if (vop2->irq < 0)
 		return dev_err_probe(drm->dev, vop2->irq, "cannot find irq for vop2\n");
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index b209b2d5b96d..1c2d7d97a6c2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -165,6 +165,8 @@ enum vop2_win_regs {
 	VOP2_WIN_MAX_REG,
 };
 
+struct reset_control;
+
 struct vop2_regs_dump {
 	const char *name;
 	u32 base;
@@ -238,6 +240,7 @@ struct vop2_video_port {
 	struct vop2 *vop2;
 	struct clk *dclk;
 	struct clk *dclk_src;
+	struct reset_control *dclk_rst;
 	unsigned int id;
 	const struct vop2_video_port_data *data;
 
@@ -335,6 +338,7 @@ struct vop2 {
 	struct clk *pclk;
 	struct clk *pll_hdmiphy0;
 	struct clk *pll_hdmiphy1;
+	struct reset_control *axi_rst;
 
 	/* optional internal rgb encoder */
 	struct rockchip_rgb *rgb;

-- 
2.54.0

