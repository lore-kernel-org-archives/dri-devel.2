Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CF5C55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681F410F332;
	Fri, 31 Jul 2026 16:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="R7GNVSHU";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F13910F30D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514781;
 bh=h9JN00DCDPHlyOAmChEQgWAf1Wo4zXLn+vKlFPmSOyU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=R7GNVSHUEdY9uJaVmgvccseLKzBvolOgxfYTySMYYNg9TfB6khNRIvasVF5aNBWvw
 zrGjUxA6mlFM36QRAyaAN31KkwoWyY+Sbc6dOmM3d5sNabcRWJOPo5jI45s8zKX30G
 TLDSzke6BLsqzfztEmAcDI2PMb46Redy/Vk64tyto2HitF7pM+3s79ko+qwHi2oDNG
 UeWeBtGRWONLwTw8FJ2lQPilQ3d+LPnL8jLpcnueSdpLkzJ70m/ZhSj7THWX3qN+QQ
 op1cbugTWK2Jg3LMpVOqh0IlE01sdT9Lui5fcSaQH7u9pQqBc/K0CUgK0Cn3UuBExs
 aFUQl9V6zToew==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 51FDA17E097C;
 Fri, 31 Jul 2026 18:19:41 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:19:44 +0300
Subject: [PATCH v10 37/69] drm/rockchip: dw_hdmi_qp: Control the HPD IRQ
 line via the bridge HPD ops
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-37-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 Diederik de Haas <diederik@cknow-tech.com>
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

The HPD interrupt must not be delivered before the DRM connector is fully
set up, and it should be quiesced while the display pipeline is suspended.
On top of that, the threaded handler re-arms HPD unconditionally after the
hotplug debounce, which must not override an explicit disable requested by
the DRM core.

Request the HPD IRQ in bind() with IRQF_NO_AUTOEN so it stays disabled
until the core arms it, and drive enable_irq()/disable_irq() from the
phy ops invoked by the bridge through its hpd_{enable,disable}()
callbacks.  This ensures the line is only armed after the connector is
ready.  disable_irq() additionally waits for the threaded handler to
finish, so its GRF re-arm can no longer race with and override a
core-requested disable.

Note that IRQF_NO_AUTOEN is incompatible with IRQF_SHARED; the latter is
dropped as this IRQ has no other users.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 46a61112c14f..253da2162ce6 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -99,6 +99,7 @@ struct rockchip_hdmi_qp {
 	struct phy *phy;
 	struct gpio_desc *frl_enable_gpio;
 	struct delayed_work hpd_work;
+	int hpd_irq;
 	int port_id;
 	const struct rockchip_hdmi_qp_ctrl_ops *ctrl_ops;
 	unsigned long long tmds_char_rate;
@@ -308,12 +309,14 @@ static void dw_hdmi_qp_rk3588_enable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 
 	dw_hdmi_qp_rk3588_unmask_hpd(hdmi);
+	enable_irq(hdmi->hpd_irq);
 }
 
 static void dw_hdmi_qp_rk3588_disable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 {
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 
+	disable_irq(hdmi->hpd_irq);
 	dw_hdmi_qp_rk3588_mask_hpd(hdmi);
 }
 
@@ -355,12 +358,14 @@ static void dw_hdmi_qp_rk3576_enable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 
 	dw_hdmi_qp_rk3576_unmask_hpd(hdmi);
+	enable_irq(hdmi->hpd_irq);
 }
 
 static void dw_hdmi_qp_rk3576_disable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 {
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 
+	disable_irq(hdmi->hpd_irq);
 	dw_hdmi_qp_rk3576_mask_hpd(hdmi);
 }
 
@@ -584,7 +589,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	struct resource *res;
 	struct clk_bulk_data *clks;
 	struct clk *ref_clk;
-	int ret, irq, i;
+	int ret, i;
 
 	if (!dev->of_node)
 		return -ENODEV;
@@ -688,14 +693,14 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	if (plat_data.cec_irq < 0)
 		return plat_data.cec_irq;
 
-	irq = platform_get_irq_byname(pdev, "hpd");
-	if (irq < 0)
-		return irq;
+	hdmi->hpd_irq = platform_get_irq_byname(pdev, "hpd");
+	if (hdmi->hpd_irq < 0)
+		return hdmi->hpd_irq;
 
-	ret = devm_request_threaded_irq(dev, irq,
+	ret = devm_request_threaded_irq(dev, hdmi->hpd_irq,
 					cfg->ctrl_ops->hardirq_callback,
 					cfg->ctrl_ops->irq_callback,
-					IRQF_SHARED, "dw-hdmi-qp-hpd",
+					IRQF_NO_AUTOEN, "dw-hdmi-qp-hpd",
 					hdmi);
 	if (ret)
 		return ret;

-- 
2.55.0

