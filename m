Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244F7CD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 787AC10EC35;
	Tue, 19 May 2026 10:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nn+E8RLx";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70FF910EC23
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:38:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5B504C2B9DB;
 Tue, 19 May 2026 10:39:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3112B606E9;
 Tue, 19 May 2026 10:38:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EDA09107E8ACB; 
 Tue, 19 May 2026 12:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187123; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=S5WFJQqOqjQzKJf/CECXTNKa8ItDPlAdG2fp5Z2XuTU=;
 b=nn+E8RLxi9zZ81a2PX2w9Xp+wfPFMkRzIzARFzLbHfV+tGVjr2IVm71PoNCMng87IJ3U5W
 4T8ZdRkZBGAX5VWZQ1jY3en+WJBUHlMWFJ/rZb3hzPVfjlUKO2E9VTUpzTw2vhy3vAEyUL
 GUCafz3iT06OkddxAdovlrwU/BkCvqML3jCY0tS5LsIw5hE8fUQb6IA0sbJP3pEvAZZoTl
 Q33B0RIxxBcDn5gaIeK3U8k20TZ4dzJDWkVjDfnz7zyYv3KZDBeLB7EpYW85tq54BFCaw0
 GQbzuVOurCgPYl7lRZePfSWtVpolymGhGAcfrYdGJ08ZVnorSEgW+V4IcejeuQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:26 +0200
Subject: [PATCH 09/37] drm/display: bridge-connector: extract
 drm_bridge_connector_init_hdmi_audio_cec()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-9-45e2bdb3dfb4@bootlin.com>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
In-Reply-To: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
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

To support bridge hotplug we will need better control over the steps
involved in the crm_connector creation, especially in terms of error
management. This will be complicated by the length and amount of return
points in this function. In preparation, split the code to initialize HDMI
audio and CEC fields out to a separate function.

No functional changes. Just moving code around.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 102 ++++++++++++++-----------
 1 file changed, 57 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index d8a033ed8f41..e6306e98a167 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -930,6 +930,60 @@ static int drm_bridge_connector_get_bridges(struct drm_bridge_connector *bridge_
 	return 0;
 }
 
+static struct drm_bridge_connector *
+drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector *bridge_connector)
+{
+	int ret;
+
+	if (bridge_connector->bridge_hdmi_audio ||
+	    bridge_connector->bridge_dp_audio) {
+		struct device *dev;
+		struct drm_bridge *bridge;
+
+		if (bridge_connector->bridge_hdmi_audio)
+			bridge = bridge_connector->bridge_hdmi_audio;
+		else
+			bridge = bridge_connector->bridge_dp_audio;
+
+		dev = bridge->hdmi_audio_dev;
+
+		ret = drm_connector_hdmi_audio_init(&bridge_connector->base, dev,
+						    &drm_bridge_connector_hdmi_audio_funcs,
+						    bridge->hdmi_audio_max_i2s_playback_channels,
+						    bridge->hdmi_audio_i2s_formats,
+						    bridge->hdmi_audio_spdif_playback,
+						    bridge->hdmi_audio_dai_port);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	if (bridge_connector->bridge_hdmi_cec &&
+	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
+		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
+
+		ret = drmm_connector_hdmi_cec_notifier_register(&bridge_connector->base,
+								NULL,
+								bridge->hdmi_cec_dev);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	if (bridge_connector->bridge_hdmi_cec &&
+	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
+		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
+
+		ret = drmm_connector_hdmi_cec_register(&bridge_connector->base,
+						       &drm_bridge_connector_hdmi_cec_funcs,
+						       bridge->hdmi_cec_adapter_name,
+						       bridge->hdmi_cec_available_las,
+						       bridge->hdmi_cec_dev);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	return bridge_connector;
+}
+
 /**
  * drm_bridge_connector_add_connector - add the drm_connector
  * @bridge_connector: drm_bridge_connector to add the drm_connector to
@@ -997,51 +1051,9 @@ drm_bridge_connector_add_connector(struct drm_bridge_connector *bridge_connector
 			return ERR_PTR(ret);
 	}
 
-	if (bridge_connector->bridge_hdmi_audio ||
-	    bridge_connector->bridge_dp_audio) {
-		struct device *dev;
-		struct drm_bridge *bridge;
-
-		if (bridge_connector->bridge_hdmi_audio)
-			bridge = bridge_connector->bridge_hdmi_audio;
-		else
-			bridge = bridge_connector->bridge_dp_audio;
-
-		dev = bridge->hdmi_audio_dev;
-
-		ret = drm_connector_hdmi_audio_init(connector, dev,
-						    &drm_bridge_connector_hdmi_audio_funcs,
-						    bridge->hdmi_audio_max_i2s_playback_channels,
-						    bridge->hdmi_audio_i2s_formats,
-						    bridge->hdmi_audio_spdif_playback,
-						    bridge->hdmi_audio_dai_port);
-		if (ret)
-			return ERR_PTR(ret);
-	}
-
-	if (bridge_connector->bridge_hdmi_cec &&
-	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
-		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
-
-		ret = drmm_connector_hdmi_cec_notifier_register(connector,
-								NULL,
-								bridge->hdmi_cec_dev);
-		if (ret)
-			return ERR_PTR(ret);
-	}
-
-	if (bridge_connector->bridge_hdmi_cec &&
-	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
-		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
-
-		ret = drmm_connector_hdmi_cec_register(connector,
-						       &drm_bridge_connector_hdmi_cec_funcs,
-						       bridge->hdmi_cec_adapter_name,
-						       bridge->hdmi_cec_available_las,
-						       bridge->hdmi_cec_dev);
-		if (ret)
-			return ERR_PTR(ret);
-	}
+	bridge_connector = drm_bridge_connector_init_hdmi_audio_cec(bridge_connector);
+	if (IS_ERR(bridge_connector))
+		return bridge_connector;
 
 	drm_connector_helper_add(connector, &drm_bridge_connector_helper_funcs);
 

-- 
2.54.0

