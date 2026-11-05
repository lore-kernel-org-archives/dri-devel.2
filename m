Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C260A260F
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=gO49w1ev
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3526510E488;
	Thu,  5 Nov 2026 01:01:21 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD01710E5D5
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 01:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793840471;
 bh=iaNpfOnhFYyNwBNNGCDSCauJoe4k1Gg6kWuk/4H67pM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=gO49w1evwkPKn9yyB5XrxnlI/Yt6WtOYLMhrSrZd2xKFt6QROMiH2ExQZWkVGI1Mo
 vY1oEK0FN84QaV0y1J7iiZM5+Zt2R2V4b04fnUWbDegD7V1bu0ckBFA8cmkAPAjSm9
 ySVSUWNEiFvT9/YsAyqaGXLs9oVWfPWJa3lWw3w4T0FZlefgj6E078VDGo2jpH5n6z
 4p5DYi93TJc5Z9bXPn3My9wHtFC9jCNhD41Mo94Q9cwyK1Is7lF3VyXYW05x7jjmin
 g1+Tj6R+q5DM7A8FF84RfwkDno/jVPyfSu1d8WEoqkyxvN+tx2GHsxdlBISJ+r9+Nb
 Xd5FucnY8XrsQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3170F17E0D58;
 Thu, 05 Nov 2026 02:01:11 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 05 Nov 2026 03:00:41 +0200
Subject: [PATCH v6 07/15] drm/rockchip: vop2: Reset AXI and DCLK to improve
 robustness
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-dw-hdmi-qp-yuv-v6-7-1bb63ef5766e@collabora.com>
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Igor Paunovic <royalnet026@gmail.com>, Andy Yan <andyshrk@163.com>
X-Mailer: b4 0.15.2
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Assert the AXI reset in the bind and CRTC disable paths, and the VP DCLK
reset in the enable path.

These resets are intended to leave the hardware in a clean state for the
next use, helping recover from exceptions such as IOMMU page faults, as
well as to prevent random display output glitches, such as a blank
image, observed when switching modes that also change the color format,
e.g. from RGB to YUV420 and vice versa.  Moreover, this is also expected
to fix the DSI panel support on RK3588 EVB1.

For now this seems to affect only the RK3588, hence the resets are
optional and will be provided in the device tree for this SoC only.

Co-developed-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 38 ++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  4 +++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index b85cd94d1e9d..98430587a7ab 100644
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
 
 	regcache_drop_region(vop2->map, 0, vop2_regmap_config.max_register);
@@ -1981,6 +2004,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vop2_crtc_atomic_try_set_gamma(vop2, vp, crtc, crtc_state);
 
+	vop2_reset_assert_deassert(vop2, vp->dclk_rst);
+
 	drm_crtc_vblank_on(crtc);
 
 	vp->enabled = true;
@@ -2585,6 +2610,12 @@ static int vop2_create_crtcs(struct vop2 *vop2)
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
@@ -2944,6 +2975,13 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 		return dev_err_probe(drm->dev, PTR_ERR(vop2->pll_hdmiphy1),
 				     "failed to get pll_hdmiphy1\n");
 
+	vop2->axi_rst = devm_reset_control_get_optional_exclusive(vop2->dev, "axi");
+	if (IS_ERR(vop2->axi_rst))
+		return dev_err_probe(drm->dev, PTR_ERR(vop2->axi_rst),
+				     "failed to get axi reset\n");
+
+	vop2_reset_assert_deassert(vop2, vop2->axi_rst);
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
2.55.0

