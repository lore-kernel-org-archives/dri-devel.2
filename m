Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AF8C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD0010EE62;
	Tue,  1 Sep 2026 18:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PGzp1Ssi";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAE610EE51
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288669;
 bh=4/YtiZaZ89Twed4oFSRxyYx32iL1zMvuMBIOY5hJe+k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PGzp1SsilCwKYexcs8Bz9AWbenl0kCA6UHdzrNc6drFAF0zRKDQx0sbazIh4l4zr8
 nyj7K0MoXR0S3HZsdldbnCOHAhuw8wRQ/AOKPg8RK3FTd+Q1PusLGmFxRPQ92qyWeq
 boryLrLsAE0ZO+EgmSa0FtvsE/hRrVisMMLHTjWtfYUMg43Bl6bKMcVdmFotFA6LHV
 9d3RpySLf+hRNTJrIWTlBhAF3J98DN4vt4MOCCz9Ztomz/tBXRIxHA0xlWpAqkLkHr
 Uw5IhMvrMNYdHy+9iW0DKZdJ7HLWYYPUByQHXJMGtsHOGHMQjPWyvfuuD9yTTYEiYx
 jH1CXtdgCP1Pg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 28D7117E3C56;
 Tue, 01 Sep 2026 20:51:09 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:02 +0300
Subject: [PATCH v11 38/74] drm/rockchip: dw_hdmi_qp: Factor out HPD
 interrupt (un)mask helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-38-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org, Diederik de Haas <diederik@cknow-tech.com>
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

Extract the GRF-level HPD interrupt mask/unmask register writes into
dedicated dw_hdmi_qp_rk35{88,76}_{mask,unmask}_hpd() helpers, and use
them from the .enable_hpd()/.disable_hpd() phy ops as well as the
hardirq, threaded re-arm and io_init() paths.

This is a preparatory refactor that separates the SoC-level HPD mask
from the phy op entry points, so a subsequent change can gate the
platform HPD IRQ line without affecting the debounce paths.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 54 ++++++++++++++++++--------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 9e48ec06eb66..ecf12403101d 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -277,9 +277,8 @@ dw_hdmi_qp_rk3588_read_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 	return val ? connector_status_connected : connector_status_disconnected;
 }
 
-static void dw_hdmi_qp_rk3588_enable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
+static void dw_hdmi_qp_rk3588_unmask_hpd(struct rockchip_hdmi_qp *hdmi)
 {
-	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 	u32 val;
 
 	if (hdmi->port_id)
@@ -292,9 +291,8 @@ static void dw_hdmi_qp_rk3588_enable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
 }
 
-static void dw_hdmi_qp_rk3588_disable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
+static void dw_hdmi_qp_rk3588_mask_hpd(struct rockchip_hdmi_qp *hdmi)
 {
-	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 	u32 val;
 
 	if (hdmi->port_id)
@@ -305,6 +303,20 @@ static void dw_hdmi_qp_rk3588_disable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data
 	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
 }
 
+static void dw_hdmi_qp_rk3588_enable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
+{
+	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
+
+	dw_hdmi_qp_rk3588_unmask_hpd(hdmi);
+}
+
+static void dw_hdmi_qp_rk3588_disable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
+{
+	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
+
+	dw_hdmi_qp_rk3588_mask_hpd(hdmi);
+}
+
 static const struct dw_hdmi_qp_phy_ops rk3588_hdmi_phy_ops = {
 	.init		= dw_hdmi_qp_rk3588_phy_init,
 	.disable	= dw_hdmi_qp_rk3588_phy_disable,
@@ -325,23 +337,31 @@ dw_hdmi_qp_rk3576_read_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 		connector_status_connected : connector_status_disconnected;
 }
 
+static void dw_hdmi_qp_rk3576_unmask_hpd(struct rockchip_hdmi_qp *hdmi)
+{
+	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0,
+		     FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_CLR, 1) |
+		     FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 0));
+}
+
+static void dw_hdmi_qp_rk3576_mask_hpd(struct rockchip_hdmi_qp *hdmi)
+{
+	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0,
+		     FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 1));
+}
+
 static void dw_hdmi_qp_rk3576_enable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 {
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
-	u32 val;
 
-	val = (FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_CLR, 1) |
-	       FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 0));
-
-	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
+	dw_hdmi_qp_rk3576_unmask_hpd(hdmi);
 }
 
 static void dw_hdmi_qp_rk3576_disable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 {
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 
-	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0,
-		     FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 1));
+	dw_hdmi_qp_rk3576_mask_hpd(hdmi);
 }
 
 static const struct dw_hdmi_qp_phy_ops rk3576_hdmi_phy_ops = {
@@ -375,7 +395,7 @@ static irqreturn_t dw_hdmi_qp_rk3576_hardirq(int irq, void *dev_id)
 	regmap_read(hdmi->regmap, RK3576_IOC_HDMI_HPD_STATUS, &intr_stat);
 
 	if (intr_stat & RK3576_HDMI_OHPD_INT) {
-		dw_hdmi_qp_rk3576_disable_hpd(NULL, hdmi);
+		dw_hdmi_qp_rk3576_mask_hpd(hdmi);
 		return IRQ_WAKE_THREAD;
 	}
 
@@ -389,7 +409,7 @@ static irqreturn_t dw_hdmi_qp_rk3576_irq(int irq, void *dev_id)
 	mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
 			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 
-	dw_hdmi_qp_rk3576_enable_hpd(NULL, hdmi);
+	dw_hdmi_qp_rk3576_unmask_hpd(hdmi);
 
 	return IRQ_HANDLED;
 }
@@ -404,7 +424,7 @@ static irqreturn_t dw_hdmi_qp_rk3588_hardirq(int irq, void *dev_id)
 	intr_stat &= hdmi->port_id ? RK3588_HDMI1_OHPD_INT : RK3588_HDMI0_OHPD_INT;
 
 	if (intr_stat) {
-		dw_hdmi_qp_rk3588_disable_hpd(NULL, hdmi);
+		dw_hdmi_qp_rk3588_mask_hpd(hdmi);
 		return IRQ_WAKE_THREAD;
 	}
 
@@ -418,7 +438,7 @@ static irqreturn_t dw_hdmi_qp_rk3588_irq(int irq, void *dev_id)
 	mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
 			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 
-	dw_hdmi_qp_rk3588_enable_hpd(NULL, hdmi);
+	dw_hdmi_qp_rk3588_unmask_hpd(hdmi);
 
 	return IRQ_HANDLED;
 }
@@ -435,7 +455,7 @@ static void dw_hdmi_qp_rk3576_io_init(struct rockchip_hdmi_qp *hdmi)
 
 	regmap_write(hdmi->regmap, 0xa404, 0xffff0102);
 
-	dw_hdmi_qp_rk3576_disable_hpd(NULL, hdmi);
+	dw_hdmi_qp_rk3576_mask_hpd(hdmi);
 }
 
 static void dw_hdmi_qp_rk3588_io_init(struct rockchip_hdmi_qp *hdmi)
@@ -460,7 +480,7 @@ static void dw_hdmi_qp_rk3588_io_init(struct rockchip_hdmi_qp *hdmi)
 		val = FIELD_PREP_WM16(RK3588_HDMI0_GRANT_SEL, 1);
 	regmap_write(hdmi->vo_regmap, RK3588_GRF_VO1_CON9, val);
 
-	dw_hdmi_qp_rk3588_disable_hpd(NULL, hdmi);
+	dw_hdmi_qp_rk3588_mask_hpd(hdmi);
 }
 
 static void dw_hdmi_qp_rk3576_enc_init(struct rockchip_hdmi_qp *hdmi,

-- 
2.55.0

