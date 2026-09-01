Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E650C624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60FD510EE61;
	Tue,  1 Sep 2026 18:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="US2DkFNZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C219510EE50
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288668;
 bh=PsQOYxICkFHONAMa1SotvPoVv5QJ9j94I5evVuz6mdQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=US2DkFNZ9udIhak13OPHmaVgauR1X9EG/LaEdQ6uU6NbLYqJDS4hWOfoEFafb/peX
 luPYk33yCY6SDA3q1c4msA0r1mS053SCokPfgJDuvwzTuKDAaKI5A3or20qu++0E4q
 cqg2BNMFhNcYKRiCLlJ7N99wLRhBW+7iJDeg48Gdz32cGYIaW5y347nysmTXV+Dxr2
 UCQRIysmR3Aa1O+xRPo27DOtpBv3ruqL4U16P6ojv2MtmtbtJfDo9Y8NrW/Deyvg8O
 vE9uoS2tRLIPUkdh0ls+V6E+hYeB1NPgECJizl4OOaF3K+dIL/aNZWL+sQLJru9saV
 cUwSwRL8XdCuA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 624B917E3C4B;
 Tue, 01 Sep 2026 20:51:08 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:01 +0300
Subject: [PATCH v11 37/74] drm/rockchip: dw_hdmi_qp: Implement
 .{enable,disable}_hpd() PHY ops
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-37-bc12954a0688@collabora.com>
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
 linux-fbdev@vger.kernel.org, Maud Spierings <maud_spierings@hotmail.com>, 
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

Implement .enable_hpd() and .disable_hpd() phy ops for RK3576 and RK3588
SoCs, used by the corresponding bridge callbacks for HPD activation
control.

Consolidate the interrupt clear-and-unmask sequence into enable_hpd()
and the mask-only operation into disable_hpd(), replacing the open-coded
register writes in the interrupt handlers and io_init().

The .setup_hpd() phy op, which was previously called from
dw_hdmi_qp_init_hw(), is no longer needed and its users are removed.

Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 78 +++++++++++++-------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index bcfa6646546e..9e48ec06eb66 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -277,7 +277,7 @@ dw_hdmi_qp_rk3588_read_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 	return val ? connector_status_connected : connector_status_disconnected;
 }
 
-static void dw_hdmi_qp_rk3588_setup_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
+static void dw_hdmi_qp_rk3588_enable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 {
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 	u32 val;
@@ -292,11 +292,25 @@ static void dw_hdmi_qp_rk3588_setup_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
 }
 
+static void dw_hdmi_qp_rk3588_disable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
+{
+	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
+	u32 val;
+
+	if (hdmi->port_id)
+		val = FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_MSK, 1);
+	else
+		val = FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_MSK, 1);
+
+	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
+}
+
 static const struct dw_hdmi_qp_phy_ops rk3588_hdmi_phy_ops = {
 	.init		= dw_hdmi_qp_rk3588_phy_init,
 	.disable	= dw_hdmi_qp_rk3588_phy_disable,
 	.read_hpd	= dw_hdmi_qp_rk3588_read_hpd,
-	.setup_hpd	= dw_hdmi_qp_rk3588_setup_hpd,
+	.enable_hpd	= dw_hdmi_qp_rk3588_enable_hpd,
+	.disable_hpd	= dw_hdmi_qp_rk3588_disable_hpd,
 };
 
 static enum drm_connector_status
@@ -311,7 +325,7 @@ dw_hdmi_qp_rk3576_read_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 		connector_status_connected : connector_status_disconnected;
 }
 
-static void dw_hdmi_qp_rk3576_setup_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
+static void dw_hdmi_qp_rk3576_enable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 {
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 	u32 val;
@@ -320,14 +334,22 @@ static void dw_hdmi_qp_rk3576_setup_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 	       FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 0));
 
 	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
-	regmap_write(hdmi->regmap, 0xa404, 0xffff0102);
+}
+
+static void dw_hdmi_qp_rk3576_disable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
+{
+	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
+
+	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0,
+		     FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 1));
 }
 
 static const struct dw_hdmi_qp_phy_ops rk3576_hdmi_phy_ops = {
 	.init		= dw_hdmi_qp_rk3588_phy_init,
 	.disable	= dw_hdmi_qp_rk3588_phy_disable,
 	.read_hpd	= dw_hdmi_qp_rk3576_read_hpd,
-	.setup_hpd	= dw_hdmi_qp_rk3576_setup_hpd,
+	.enable_hpd	= dw_hdmi_qp_rk3576_enable_hpd,
+	.disable_hpd	= dw_hdmi_qp_rk3576_disable_hpd,
 };
 
 static void dw_hdmi_qp_rk3588_hpd_work(struct work_struct *work)
@@ -348,13 +370,12 @@ static void dw_hdmi_qp_rk3588_hpd_work(struct work_struct *work)
 static irqreturn_t dw_hdmi_qp_rk3576_hardirq(int irq, void *dev_id)
 {
 	struct rockchip_hdmi_qp *hdmi = dev_id;
-	u32 intr_stat, val;
+	u32 intr_stat;
 
 	regmap_read(hdmi->regmap, RK3576_IOC_HDMI_HPD_STATUS, &intr_stat);
-	if (intr_stat & RK3576_HDMI_OHPD_INT) {
-		val = FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 1);
 
-		regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
+	if (intr_stat & RK3576_HDMI_OHPD_INT) {
+		dw_hdmi_qp_rk3576_disable_hpd(NULL, hdmi);
 		return IRQ_WAKE_THREAD;
 	}
 
@@ -364,15 +385,11 @@ static irqreturn_t dw_hdmi_qp_rk3576_hardirq(int irq, void *dev_id)
 static irqreturn_t dw_hdmi_qp_rk3576_irq(int irq, void *dev_id)
 {
 	struct rockchip_hdmi_qp *hdmi = dev_id;
-	u32 val;
 
-	val = FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_CLR, 1);
-	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
 	mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
 			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 
-	val = FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 0);
-	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
+	dw_hdmi_qp_rk3576_enable_hpd(NULL, hdmi);
 
 	return IRQ_HANDLED;
 }
@@ -380,18 +397,14 @@ static irqreturn_t dw_hdmi_qp_rk3576_irq(int irq, void *dev_id)
 static irqreturn_t dw_hdmi_qp_rk3588_hardirq(int irq, void *dev_id)
 {
 	struct rockchip_hdmi_qp *hdmi = dev_id;
-	u32 intr_stat, val;
+	u32 intr_stat;
 
 	regmap_read(hdmi->regmap, RK3588_GRF_SOC_STATUS1, &intr_stat);
 
 	intr_stat &= hdmi->port_id ? RK3588_HDMI1_OHPD_INT : RK3588_HDMI0_OHPD_INT;
 
 	if (intr_stat) {
-		if (hdmi->port_id)
-			val = FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_MSK, 1);
-		else
-			val = FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_MSK, 1);
-		regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
+		dw_hdmi_qp_rk3588_disable_hpd(NULL, hdmi);
 		return IRQ_WAKE_THREAD;
 	}
 
@@ -401,22 +414,11 @@ static irqreturn_t dw_hdmi_qp_rk3588_hardirq(int irq, void *dev_id)
 static irqreturn_t dw_hdmi_qp_rk3588_irq(int irq, void *dev_id)
 {
 	struct rockchip_hdmi_qp *hdmi = dev_id;
-	u32 val;
-
-	if (hdmi->port_id)
-		val = FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_CLR, 1);
-	else
-		val = FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_CLR, 1);
-	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
 
 	mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
 			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 
-	if (hdmi->port_id)
-		val |= FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_MSK, 0);
-	else
-		val |= FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_MSK, 0);
-	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
+	dw_hdmi_qp_rk3588_enable_hpd(NULL, hdmi);
 
 	return IRQ_HANDLED;
 }
@@ -429,11 +431,11 @@ static void dw_hdmi_qp_rk3576_io_init(struct rockchip_hdmi_qp *hdmi)
 	      FIELD_PREP_WM16(RK3576_SDAIN_MASK, 1) |
 	      FIELD_PREP_WM16(RK3576_HDMI_GRANT_SEL, 1) |
 	      FIELD_PREP_WM16(RK3576_I2S_SEL_MASK, 1);
-
 	regmap_write(hdmi->vo_regmap, RK3576_VO0_GRF_SOC_CON14, val);
 
-	val = FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 1);
-	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
+	regmap_write(hdmi->regmap, 0xa404, 0xffff0102);
+
+	dw_hdmi_qp_rk3576_disable_hpd(NULL, hdmi);
 }
 
 static void dw_hdmi_qp_rk3588_io_init(struct rockchip_hdmi_qp *hdmi)
@@ -458,11 +460,7 @@ static void dw_hdmi_qp_rk3588_io_init(struct rockchip_hdmi_qp *hdmi)
 		val = FIELD_PREP_WM16(RK3588_HDMI0_GRANT_SEL, 1);
 	regmap_write(hdmi->vo_regmap, RK3588_GRF_VO1_CON9, val);
 
-	if (hdmi->port_id)
-		val = FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_MSK, 1);
-	else
-		val = FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_MSK, 1);
-	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
+	dw_hdmi_qp_rk3588_disable_hpd(NULL, hdmi);
 }
 
 static void dw_hdmi_qp_rk3576_enc_init(struct rockchip_hdmi_qp *hdmi,

-- 
2.55.0

