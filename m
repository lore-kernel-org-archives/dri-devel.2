Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AF3C44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061BE10EF1A;
	Thu, 23 Jul 2026 01:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LCBZaNg1";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB45510E503
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784770505;
 bh=OFVB7kb6sKOuqbakZrPQltL575RF6J7clPMcHjhnDi8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=LCBZaNg1QZJITqISqxRfaLl6TcOzN0OktBfXPaDbJwNiEKGIXLf36/9UzZ+EmnKht
 imr8cIbRLqzK5ZuWUzw24FfxAUaqP/1+CfOk7x1pYXZR+7osnvFEP9W1eJrnqGu8N1
 vuAXPdwTtrHMFgoi/ndaBFmO91hKx9CiFgqvJDXxnpngoqHxsD6dE3tRHbIcwCC2f5
 woAcKMj/BFvYXHvFIoMfRNEfKZ/knckkCmr2+LO+glyfYJwNS6bH1E19lPG9kHMCU/
 XBxm5YKxPUs4pYsZmOybk/mr2hl8hMsaNRyEEfrSHICNXLlip2vcorTX2y3eEzAoF/
 Pfre9qKHcCu3Q==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 83DD117E151D;
 Thu, 23 Jul 2026 03:35:05 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 23 Jul 2026 04:34:54 +0300
Subject: [PATCH v9 05/61] drm/connector: Add HDMI 2.0 scrambler infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-dw-hdmi-qp-scramb-v9-5-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
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
 Maud Spierings <maud_spierings@hotmail.com>
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

Add the connector-level infrastructure to support HDMI 2.0 scrambling:

- A drm_connector_hdmi_scrambler_supported() helper to report whether
  the source supports the scrambling capability, based on the presence
  of the newly introduced .scrambler_{enable|disable}() callbacks in
  drm_connector_hdmi_funcs are mandatory
- A scrambler_needed flag to be managed by the hdmi state helpers based
  on the negotiated TMDS character rate and the source/sink scrambling
  capabilities
- A scrambler_enabled flag to track whether scrambling is currently
  active
- A delayed work item (scdc_work) to monitor sink-side scrambling status
  and retry the setup if the sink resets it
- A scdc_work_initialized flag to support lazy initialization of the
  work item on the first scrambling enable and guard the teardown paths

These are intended to be used by SCDC scrambling helpers to coordinate
scrambling setup and teardown between the source driver and the DRM
core.

Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 31 ++++++++++++---
 include/drm/drm_connector.h     | 83 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 72b630434802..96cca0ca64bd 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -622,12 +622,29 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	 * default with the actual controller capability. A value of zero keeps
 	 * the limit inferred from supported_hdmi_ver.
 	 */
-	if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_2_0)
+	if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_2_0) {
+		if (!hdmi_funcs->scrambler_enable || !hdmi_funcs->scrambler_disable) {
+			drm_err(dev, "Scrambler callbacks missing for HDMI 2.x\n");
+			return -EINVAL;
+		}
+
 		connector->hdmi.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
-	else if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_1_3)
-		connector->hdmi.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
-	else if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_1_0)
-		connector->hdmi.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+	} else {
+		/*
+		 * Scrambler callbacks are only valid for connectors advertising
+		 * HDMI 2.0 capability. drm_connector_hdmi_scrambler_supported()
+		 * relies on their presence to report scrambling support.
+		 */
+		if (hdmi_funcs->scrambler_enable || hdmi_funcs->scrambler_disable) {
+			drm_err(dev, "Scrambler callbacks unexpected for HDMI 1.x\n");
+			return -EINVAL;
+		}
+
+		if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_1_3)
+			connector->hdmi.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
+		else if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_1_0)
+			connector->hdmi.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+	}
 
 	if (hdmi_funcs->supported_tmds_char_rate) {
 		if (hdmi_funcs->supported_tmds_char_rate > connector->hdmi.max_tmds_char_rate) {
@@ -635,6 +652,7 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 				connector->hdmi.max_tmds_char_rate);
 			return -EINVAL;
 		}
+
 		connector->hdmi.max_tmds_char_rate = hdmi_funcs->supported_tmds_char_rate;
 	}
 
@@ -914,6 +932,9 @@ void drm_connector_cleanup(struct drm_connector *connector)
 		    DRM_CONNECTOR_REGISTERED))
 		drm_connector_unregister(connector);
 
+	if (connector->hdmi.scdc_work_initialized)
+		cancel_delayed_work_sync(&connector->hdmi.scdc_work);
+
 	platform_device_unregister(connector->hdmi_audio.codec_pdev);
 
 	if (connector->privacy_screen) {
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2a49c4d55f77..61ba20296f6a 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -28,6 +28,7 @@
 #include <linux/ctype.h>
 #include <linux/hdmi.h>
 #include <linux/notifier.h>
+#include <linux/workqueue.h>
 #include <drm/drm_mode_object.h>
 #include <drm/drm_util.h>
 #include <drm/drm_property.h>
@@ -1131,6 +1132,17 @@ struct drm_connector_hdmi_state {
 	 * @tmds_char_rate: TMDS Character Rate, in Hz.
 	 */
 	unsigned long long tmds_char_rate;
+
+	/**
+	 * @scrambler_needed: Whether HDMI 2.0 SCDC scrambling is required
+	 * for the negotiated mode/bpc/format.
+	 *
+	 * Computed by drm_atomic_helper_connector_hdmi_check() according to
+	 * the HDMI 2.0 specification: scrambling is mandatory above a 340 MHz
+	 * TMDS character rate. Optional scrambling at lower rates is
+	 * deliberately not requested by the helper.
+	 */
+	bool scrambler_needed;
 };
 
 /**
@@ -1481,6 +1493,36 @@ struct drm_connector_hdmi_funcs {
 	 */
 	const struct drm_edid *(*read_edid)(struct drm_connector *connector);
 
+	/**
+	 * @scrambler_enable:
+	 *
+	 * The callback is invoked via @drm_connector_hdmi_enable_scrambling
+	 * during commit to setup SCDC scrambling and high TMDS clock ratio on
+	 * the source side.
+	 *
+	 * The @scrambler_enable callback is mandatory if HDMI 2.0 is to be
+	 * supported.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise
+	 */
+	int (*scrambler_enable)(struct drm_connector *connector);
+
+	/**
+	 * @scrambler_disable:
+	 *
+	 * The callback is invoked via @drm_connector_hdmi_disable_scrambling
+	 * during commit to tear down SCDC scrambling and high TMDS clock ratio
+	 * on the source side.
+	 *
+	 * The @scrambler_disable callback is mandatory if HDMI 2.0 is to be
+	 * supported.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise
+	 */
+	int (*scrambler_disable)(struct drm_connector *connector);
+
 	/**
 	 * @avi:
 	 *
@@ -2105,6 +2147,25 @@ struct drm_connector_hdmi {
 	 */
 	unsigned long long max_tmds_char_rate;
 
+	/**
+	 * @scrambler_enabled: Tracks whether HDMI 2.0 scrambler is currently enabled.
+	 */
+	bool scrambler_enabled;
+
+	/**
+	 * @scdc_work: Work item currently used to monitor sink-side scrambling
+	 * status and retry setup if the sink resets it.
+	 */
+	struct delayed_work scdc_work;
+
+	/**
+	 * @scdc_work_initialized: Tracks whether @scdc_work has been set up via
+	 * INIT_DELAYED_WORK(). The work item is initialized lazily on the first
+	 * scrambling enable, so this guards the teardown paths against touching
+	 * an uninitialized work item.
+	 */
+	bool scdc_work_initialized;
+
 	/**
 	 * @funcs: HDMI connector Control Functions and controller capabilities
 	 */
@@ -2696,6 +2757,28 @@ drm_connector_is_unregistered(struct drm_connector *connector)
 		DRM_CONNECTOR_UNREGISTERED;
 }
 
+/**
+ * drm_connector_hdmi_scrambler_supported - does connector support HDMI
+ * scrambling?
+ * @connector: DRM connector
+ *
+ * Checks whether or not @connector driver supports HDMI scrambling. When
+ * controller advertises HDMI_VERSION_2_0 support, the
+ * @drm_connector_hdmi_funcs.scrambler_enable and
+ * @drm_connector_hdmi_funcs.scrambler_disable callbacks are mandatory and
+ * enforced during drmm_connector_hdmi_init().
+ *
+ * Returns:
+ * True if the connector supports scrambling, false otherwise.
+ */
+static inline bool
+drm_connector_hdmi_scrambler_supported(struct drm_connector *connector)
+{
+	return connector->hdmi.funcs &&
+		connector->hdmi.funcs->scrambler_enable &&
+		connector->hdmi.funcs->scrambler_disable;
+}
+
 void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
 				     enum drm_connector_status status);
 enum drm_connector_color_format

-- 
2.55.0

