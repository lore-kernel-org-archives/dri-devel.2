Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12EBCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC6D10F152;
	Thu,  7 May 2026 13:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bCsQ1luk";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097BD10F14B;
 Thu,  7 May 2026 13:46:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9B4E0C5DC5B;
 Thu,  7 May 2026 13:46:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DB10D60495;
 Thu,  7 May 2026 13:46:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C45B3108194AF; 
 Thu,  7 May 2026 15:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1778161564; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=CNAywJbD55/79Kay7v4Z9jjJDlDuDprtAGni4uyb1B4=;
 b=bCsQ1luk4lHyXfPp0bGzJ1bv+aVBuI7dExc5t9NINDS6CyFmbXhLkIu3/K4d4s0j8TnZlO
 iocQGsG/FUWbkVttREnikuOXLPFP/kZmChD1gib8wh04wVIAXdZ/0t3EXrJOg40UqJfS28
 NqtuYBRyPJz+867bP6MdR2Bh30GlFdeEy+ReXqsdfW923OhDPW4hFl512+PRktoocmgKWm
 3cfXym2rIYOLi05P/tf4wX6d+65+VAmTwuHyJaHe9XK+mPlIH9odcM4mE6dBBC4tCt9G6o
 5qtN+d7t/JxoOpD6MKwNkqTpa2e845peGlfK/f/GcJ6LUfHxJUEHKW+T6LVyPg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 07 May 2026 15:45:23 +0200
Subject: [PATCH v5 05/11] drm/bridge: chrontel-ch7033: switch to
 of_drm_get_bridge_by_endpoint()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-5-472b913b5cb7@bootlin.com>
References: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-0-472b913b5cb7@bootlin.com>
In-Reply-To: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-0-472b913b5cb7@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
@panel parameter, thus using a reduced feature set of that function.
Replace this call with the simpler of_drm_get_bridge_by_endpoint().

Since of_drm_get_bridge_by_endpoint() increases the refcount of the
returned bridge, ensure it is put on removal. To achieve this, instead of
adding an explicit drm_bridge_put(), migrate to the bridge::next_bridge
pointer which is automatically put when the bridge is eventually freed.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/chrontel-ch7033.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index 54d49d4882c8..a237c65ebd69 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -199,7 +199,6 @@ enum {
 
 struct ch7033_priv {
 	struct regmap *regmap;
-	struct drm_bridge *next_bridge;
 	struct drm_bridge bridge;
 	struct drm_connector connector;
 };
@@ -215,7 +214,7 @@ static enum drm_connector_status ch7033_connector_detect(
 {
 	struct ch7033_priv *priv = conn_to_ch7033_priv(connector);
 
-	return drm_bridge_detect(priv->next_bridge, connector);
+	return drm_bridge_detect(priv->bridge.next_bridge, connector);
 }
 
 static const struct drm_connector_funcs ch7033_connector_funcs = {
@@ -233,7 +232,7 @@ static int ch7033_connector_get_modes(struct drm_connector *connector)
 	const struct drm_edid *drm_edid;
 	int ret;
 
-	drm_edid = drm_bridge_edid_read(priv->next_bridge, connector);
+	drm_edid = drm_bridge_edid_read(priv->bridge.next_bridge, connector);
 	drm_edid_connector_update(connector, drm_edid);
 	if (drm_edid) {
 		ret = drm_edid_connector_add_modes(connector);
@@ -275,7 +274,7 @@ static int ch7033_bridge_attach(struct drm_bridge *bridge,
 	struct drm_connector *connector = &priv->connector;
 	int ret;
 
-	ret = drm_bridge_attach(encoder, priv->next_bridge, bridge,
+	ret = drm_bridge_attach(encoder, priv->bridge.next_bridge, bridge,
 				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret)
 		return ret;
@@ -283,15 +282,15 @@ static int ch7033_bridge_attach(struct drm_bridge *bridge,
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
 		return 0;
 
-	if (priv->next_bridge->ops & DRM_BRIDGE_OP_DETECT) {
+	if (priv->bridge.next_bridge->ops & DRM_BRIDGE_OP_DETECT) {
 		connector->polled = DRM_CONNECTOR_POLL_HPD;
 	} else {
 		connector->polled = DRM_CONNECTOR_POLL_CONNECT |
 				    DRM_CONNECTOR_POLL_DISCONNECT;
 	}
 
-	if (priv->next_bridge->ops & DRM_BRIDGE_OP_HPD) {
-		drm_bridge_hpd_enable(priv->next_bridge, ch7033_hpd_event,
+	if (priv->bridge.next_bridge->ops & DRM_BRIDGE_OP_HPD) {
+		drm_bridge_hpd_enable(priv->bridge.next_bridge, ch7033_hpd_event,
 				      priv);
 	}
 
@@ -299,8 +298,8 @@ static int ch7033_bridge_attach(struct drm_bridge *bridge,
 				 &ch7033_connector_helper_funcs);
 	ret = drm_connector_init_with_ddc(bridge->dev, &priv->connector,
 					  &ch7033_connector_funcs,
-					  priv->next_bridge->type,
-					  priv->next_bridge->ddc);
+					  priv->bridge.next_bridge->type,
+					  priv->bridge.next_bridge->ddc);
 	if (ret) {
 		DRM_ERROR("Failed to initialize connector\n");
 		return ret;
@@ -313,8 +312,8 @@ static void ch7033_bridge_detach(struct drm_bridge *bridge)
 {
 	struct ch7033_priv *priv = bridge_to_ch7033_priv(bridge);
 
-	if (priv->next_bridge->ops & DRM_BRIDGE_OP_HPD)
-		drm_bridge_hpd_disable(priv->next_bridge);
+	if (priv->bridge.next_bridge->ops & DRM_BRIDGE_OP_HPD)
+		drm_bridge_hpd_disable(priv->bridge.next_bridge);
 	drm_connector_cleanup(&priv->connector);
 }
 
@@ -543,10 +542,9 @@ static int ch7033_probe(struct i2c_client *client)
 
 	dev_set_drvdata(dev, priv);
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, -1, NULL,
-					  &priv->next_bridge);
-	if (ret)
-		return ret;
+	priv->bridge.next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 1, -1);
+	if (IS_ERR(priv->bridge.next_bridge))
+		return PTR_ERR(priv->bridge.next_bridge);
 
 	priv->regmap = devm_regmap_init_i2c(client, &ch7033_regmap_config);
 	if (IS_ERR(priv->regmap)) {

-- 
2.53.0

