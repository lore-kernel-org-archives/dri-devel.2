Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401F2FF885C
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 00:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9079710E4DF;
	Sun, 26 Apr 2026 00:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Mfb60Ypr";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E59610E4E7
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 00:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777162835;
 bh=jgysKGQ2uKrEiDbiSpIyt4MLZj/8UeOF2e7BOMrKLbA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Mfb60Yprpj/NPTxhsvkSQjfqWSBHgqZO7R2HTsn1Xaa8vaiH7xnfTnvlAKcLaNg65
 WkTZ/WQByzwl4aK8TY92PNosZvYthig1rzPiOJxRJ82vW00CVHuww/JLVDGF4cMqZ4
 0vGKGb2/EVKVfGWdDwhQegWV4wH70xQLZ6vqZvCS+jd3Kj2+WnBXV7Sgpi0IiyDpTz
 sAkYeNYrjPLmfhs2HIcKhtIeoDla8h0d1JeMuNBthV2wbrg8cz+OMRg34Dy4dhFpfS
 hU1f6gI2Y1P7mRNbR6+IixNZFdF1/Vr2pp7XZR5oAQyWhVfRVPGub/qUar8Pxsnlo8
 MYaGC6pXR6V4Q==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D29FB17E15A3;
 Sun, 26 Apr 2026 02:20:34 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 26 Apr 2026 03:20:22 +0300
Subject: [PATCH v5 10/10] drm/rockchip: dw_hdmi_qp: Restrict HPD event to
 the affected connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-dw-hdmi-qp-scramb-v5-10-d778e70c317b@collabora.com>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
In-Reply-To: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 Maud Spierings <maud_spierings@hotmail.com>
X-Mailer: b4 0.15.1
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

Switch from drm_helper_hpd_irq_event(), which polls all connectors, to
drm_connector_helper_hpd_irq_event(), which runs the detect cycle only
on the affected connector.

This avoids unnecessary work and redundant detect calls on unrelated
connectors.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>
Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index fbbe26f8730c..d6338195a5b7 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -93,6 +93,7 @@ struct rockchip_hdmi_qp {
 	struct regmap *regmap;
 	struct regmap *vo_regmap;
 	struct rockchip_encoder encoder;
+	struct drm_connector *connector;
 	struct dw_hdmi_qp *hdmi;
 	struct phy *phy;
 	struct gpio_desc *frl_enable_gpio;
@@ -252,11 +253,10 @@ static void dw_hdmi_qp_rk3588_hpd_work(struct work_struct *work)
 	struct rockchip_hdmi_qp *hdmi = container_of(work,
 						     struct rockchip_hdmi_qp,
 						     hpd_work.work);
-	struct drm_device *drm = hdmi->encoder.encoder.dev;
 	bool changed;
 
-	if (drm) {
-		changed = drm_helper_hpd_irq_event(drm);
+	if (hdmi->connector) {
+		changed = drm_connector_helper_hpd_irq_event(hdmi->connector);
 		if (changed)
 			dev_dbg(hdmi->dev, "connector status changed\n");
 	}
@@ -467,7 +467,6 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	struct dw_hdmi_qp_plat_data plat_data = {};
 	const struct rockchip_hdmi_qp_cfg *cfg;
 	struct drm_device *drm = data;
-	struct drm_connector *connector;
 	struct drm_encoder *encoder;
 	struct rockchip_hdmi_qp *hdmi;
 	struct resource *res;
@@ -589,12 +588,12 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(dev, PTR_ERR(hdmi->hdmi),
 				     "Failed to bind dw-hdmi-qp\n");
 
-	connector = drm_bridge_connector_init(drm, encoder);
-	if (IS_ERR(connector))
-		return dev_err_probe(dev, PTR_ERR(connector),
+	hdmi->connector = drm_bridge_connector_init(drm, encoder);
+	if (IS_ERR(hdmi->connector))
+		return dev_err_probe(dev, PTR_ERR(hdmi->connector),
 				     "Failed to init bridge connector\n");
 
-	ret = drm_connector_attach_encoder(connector, encoder);
+	ret = drm_connector_attach_encoder(hdmi->connector, encoder);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to attach connector\n");
 
@@ -612,6 +611,8 @@ static void dw_hdmi_qp_rockchip_unbind(struct device *dev,
 	struct rockchip_hdmi_qp *hdmi = dev_get_drvdata(dev);
 
 	cancel_delayed_work_sync(&hdmi->hpd_work);
+
+	hdmi->connector = NULL;
 }
 
 static const struct component_ops dw_hdmi_qp_rockchip_ops = {
@@ -646,8 +647,8 @@ static int __maybe_unused dw_hdmi_qp_rockchip_resume(struct device *dev)
 
 	dw_hdmi_qp_resume(dev, hdmi->hdmi);
 
-	if (hdmi->encoder.encoder.dev)
-		drm_helper_hpd_irq_event(hdmi->encoder.encoder.dev);
+	if (hdmi->connector)
+		drm_connector_helper_hpd_irq_event(hdmi->connector);
 
 	return 0;
 }

-- 
2.53.0

