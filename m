Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CBECD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8480010EC13;
	Tue, 19 May 2026 10:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="wfRUbZv9";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEDC110EC13
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:38:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 903D91A3627;
 Tue, 19 May 2026 10:38:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 62F5B606E9;
 Tue, 19 May 2026 10:38:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DF45B107E8AB2; 
 Tue, 19 May 2026 12:38:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187092; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9aDTr9w2iMM3B9icFD9CXFezhKLvHw/SAcu5pC+lah0=;
 b=wfRUbZv9vuadgyhkI0IbLyIInUMKLCCshiB9JgwNWe71jeAV6dGs4xzdUGajngzCaiaDHL
 vZ9eMzkCfNca5i8A89tHxSqj5zTcQIRhU3gdk9jzvjbP0R1hqPdQ6NYtASJVUDomO0FS80
 OOmWAcf4i77WAVxg+3g3G6vOZzZkR/2rXDG8vQd26tLcACS5aOlDPplDKlWPvpVHSaK0dF
 mpfdEKz43EZmZ9tFw9Pe9iipEj8R9LczJMUZj1Tpq7vFc2kuZskyJBvt0AlmNgvhE12BJt
 Xo1jsdY5eJMOt/YCzw/uVlvTxy9KQd9gsqNk3NZkKdnlqk7jKV6wx1duEviBqg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:19 +0200
Subject: [PATCH 02/37] drm/connector: add drm_connector_hdmi_dynamic_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-2-45e2bdb3dfb4@bootlin.com>
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

In preparation for adding hotpluggable bridges into the
drm_bridge_connector, we need connectors to be created dynamically, both
regular connectors and HDMI ones. drm_connector_init() already has a
dynamic variant, add one for HDMI connectors too.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_connector.c | 50 +++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     |  9 ++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 37ed73300a18..5e7a3a438e5d 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -658,6 +658,56 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drmm_connector_hdmi_init);
 
+/**
+ * drm_connector_hdmi_dynamic_init - Init a preallocated dynamic HDMI connector
+ * @dev: DRM device
+ * @connector: A pointer to the HDMI connector to init
+ * @vendor: HDMI Controller Vendor name
+ * @product: HDMI Controller Product name
+ * @funcs: callbacks for this connector
+ * @hdmi_funcs: HDMI-related callbacks for this connector
+ * @connector_type: user visible type of the connector
+ * @ddc: optional pointer to the associated ddc adapter
+ * @supported_formats: Bitmask of @hdmi_colorspace listing supported output formats
+ * @max_bpc: Maximum bits per char the HDMI connector supports
+ *
+ * Initialises a preallocated dynamic HDMI connector. Connectors can be
+ * subclassed as part of driver connector objects.
+ *
+ * See drm_connector_dynamic_init(), the same constraints apply here. This
+ * is just the HDMI version.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drm_connector_hdmi_dynamic_init(struct drm_device *dev,
+				    struct drm_connector *connector,
+				    const char *vendor, const char *product,
+				    const struct drm_connector_funcs *funcs,
+				    const struct drm_connector_hdmi_funcs *hdmi_funcs,
+				    int connector_type,
+				    struct i2c_adapter *ddc,
+				    unsigned long supported_formats,
+				    unsigned int max_bpc)
+{
+	int ret;
+
+	ret = drm_connector_hdmi_sanity_checks(connector, vendor, product, hdmi_funcs,
+					       connector_type, supported_formats, max_bpc);
+	if (ret)
+		return ret;
+
+	ret = drm_connector_dynamic_init(dev, connector, funcs, connector_type, ddc);
+	if (ret)
+		return ret;
+
+	drm_connector_hdmi_init(connector, vendor, product,
+				hdmi_funcs, supported_formats, max_bpc);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_hdmi_dynamic_init);
+
 /**
  * drm_connector_attach_edid_property - attach edid property.
  * @connector: the connector
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5ad62c207d00..1f5dba947748 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2442,6 +2442,15 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 			     struct i2c_adapter *ddc,
 			     unsigned long supported_formats,
 			     unsigned int max_bpc);
+int drm_connector_hdmi_dynamic_init(struct drm_device *dev,
+				    struct drm_connector *connector,
+				    const char *vendor, const char *product,
+				    const struct drm_connector_funcs *funcs,
+				    const struct drm_connector_hdmi_funcs *hdmi_funcs,
+				    int connector_type,
+				    struct i2c_adapter *ddc,
+				    unsigned long supported_formats,
+				    unsigned int max_bpc);
 void drm_connector_attach_edid_property(struct drm_connector *connector);
 int drm_connector_register(struct drm_connector *connector);
 int drm_connector_dynamic_register(struct drm_connector *connector);

-- 
2.54.0

