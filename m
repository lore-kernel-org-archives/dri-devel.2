Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173D60A3803
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=AqkcoMpB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C22AE10FE79;
	Wed, 18 Nov 2026 16:50:57 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D578910FE67
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:50:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 963A84E41635;
 Wed, 18 Nov 2026 16:50:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 64E785FE9B;
 Wed, 18 Nov 2026 16:50:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D06BC11BC27C2; Wed, 18 Nov 2026 17:50:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795020644; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xUapXh3LAgb7b70G8vyUmRNtjSNpiBwfvZc2/AN9HVM=;
 b=AqkcoMpBiz3XS00Cy58lcSFWUufRCXidqGvtyszIqVzlzetrLf0+ci2ep2icS4eHtvQ54N
 urai6hCpRpE/8zQ41/7c3CUWidc9HRteu7u0vRf9de7DtMXZ//3TkmCaFsdGjCvVLQ73Pp
 2FZ1NC0jLvYw+UuAgUQBwHgb4gj5ZfFI6M5neW2s6+KLfQ9nEapxwmEVZav82PTiZvN/P0
 CQ2nx1mmQoPdIIBEYBx8H0RuV3gPf3Ky8LNQFNnFkE3mo8x4WMP6mEhmJ+9LEeSWblWibs
 8RAHw3ogDmsBMqKalZ+CpT2VFbpy/0GKDlePV+Ag+k5cv9/Bcx/VhIBlGnuyCA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 18 Nov 2026 17:49:49 +0100
Subject: [PATCH RFC v3 06/31] drm/connector: add
 drm_connector_hdmi_dynamic_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-drm-bridge-hotplug-v3-6-44bb3b4a828f@bootlin.com>
References: <20261118-drm-bridge-hotplug-v3-0-44bb3b4a828f@bootlin.com>
In-Reply-To: <20261118-drm-bridge-hotplug-v3-0-44bb3b4a828f@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

In preparation for adding hotpluggable bridges into the
drm_bridge_connector, we need connectors to be created dynamically, both
regular connectors and HDMI ones. drm_connector_init() already has a
dynamic variant, add one for HDMI connectors too.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- fix error management dead code
- fix kerneldoc

Changes in v2:
- rebased on current drm-misc-next: now drm_connector_hdmi_init() can fail,
  so call drm_connector_cleanup(connector) if that happens
---
 drivers/gpu/drm/drm_connector.c | 43 +++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     |  6 ++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 877c12b75090..3f548a97bf94 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -704,6 +704,49 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drmm_connector_hdmi_init);
 
+/**
+ * drm_connector_hdmi_dynamic_init - Init a preallocated dynamic HDMI connector
+ * @dev: DRM device
+ * @connector: A pointer to the HDMI connector to init
+ * @funcs: callbacks for this connector
+ * @hdmi_funcs: HDMI-related callbacks and capabilities for this connector
+ * @connector_type: user visible type of the connector
+ * @ddc: optional pointer to the associated ddc adapter
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
+				    const struct drm_connector_funcs *funcs,
+				    const struct drm_connector_hdmi_funcs *hdmi_funcs,
+				    int connector_type,
+				    struct i2c_adapter *ddc)
+{
+	int ret;
+
+	ret = drm_connector_hdmi_sanity_checks(dev, connector, hdmi_funcs, connector_type);
+	if (ret)
+		return ret;
+
+	ret = drm_connector_dynamic_init(dev, connector, funcs, connector_type, ddc);
+	if (ret)
+		return ret;
+
+	ret = drm_connector_hdmi_initialize(dev, connector, hdmi_funcs);
+	if (ret)
+		drm_connector_cleanup(connector);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_connector_hdmi_dynamic_init);
+
 /**
  * drmm_connector_hdmi_ini2 - Init a preallocated HDMI connector
  * @dev: DRM device
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f656ed8324d3..6490dc0a3fe1 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2731,6 +2731,12 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 			     const struct drm_connector_hdmi_funcs *hdmi_funcs,
 			     int connector_type,
 			     struct i2c_adapter *ddc);
+int drm_connector_hdmi_dynamic_init(struct drm_device *dev,
+				    struct drm_connector *connector,
+				    const struct drm_connector_funcs *funcs,
+				    const struct drm_connector_hdmi_funcs *hdmi_funcs,
+				    int connector_type,
+				    struct i2c_adapter *ddc);
 int drmm_connector_hdmi_ini2(struct drm_device *dev,
 			     struct drm_connector *connector,
 			     const char *vendor, const char *product,

-- 
2.56.1

