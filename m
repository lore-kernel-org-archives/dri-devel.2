Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD39EC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEEAD10EE29;
	Tue,  1 Sep 2026 18:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Kw8xDDin";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0126A10EE1A
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288646;
 bh=LnXnylUSdv6jm5z3ZYqcTeXlK8ki377u+5hmVFhOZfY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Kw8xDDiniiCcfeQDzprzO/zAtcq8A0YU7U3uMU4kL4B9pvKySadEUmdtk/mzRAiHQ
 B24IZK2cqFKptQEXeCnMtMyE0MSXoIx2Any5j9rWKc0OxxsdomiDAu4fT+lSV1vEiS
 XLapGkyB6ccrdYB1wKR4la6aUzSsiaFmkfH3cWdzJZzqCg3iil61pB396R9n8sYIQu
 0KU8Pb0qypwk0snK1HjOelVvNvViLA6Ywnuh+922xUWCMjy0ic6UkRKP+D7mJsgCIm
 B0QiO1hYmiRONvHhLnZhlrr/4IdIYpcJxeaIU6tgVDMsek+/vFBpMpkNge2YnOiptk
 KwYjDDLU7JK1w==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 44F4217E1298;
 Tue, 01 Sep 2026 20:50:46 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:31 +0300
Subject: [PATCH v11 07/74] drm/connector: Add HDMI 2.0 scrambler infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-7-bc12954a0688@collabora.com>
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

Add the connector-level infrastructure to support HDMI 2.0 scrambling:

- A drm_connector_hdmi_scrambler_supported() helper to report whether
  the source supports the scrambling capability
- A .scrambler_{enable,disable}() pair of callbacks in
  drm_connector_hdmi_funcs to allow scrambling setup on the source side
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
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 10 ++++++
 include/drm/drm_connector.h     | 79 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 38cf853e867e..d94c86bfed86 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -602,6 +602,13 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	    !hdmi_funcs->hdmi.write_infoframe)
 		return -EINVAL;
 
+	if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_2_0 &&
+	    (!hdmi_funcs->scrambler_enable ||
+	     !hdmi_funcs->scrambler_disable)) {
+		drm_err(dev, "Scrambler callbacks missing for HDMI 2.x\n");
+		return -EINVAL;
+	}
+
 	if (!(connector_type == DRM_MODE_CONNECTOR_HDMIA ||
 	      connector_type == DRM_MODE_CONNECTOR_HDMIB))
 		return -EINVAL;
@@ -919,6 +926,9 @@ void drm_connector_cleanup(struct drm_connector *connector)
 		    DRM_CONNECTOR_REGISTERED))
 		drm_connector_unregister(connector);
 
+	if (connector->hdmi.scdc_work_initialized)
+		cancel_delayed_work_sync(&connector->hdmi.scdc_work);
+
 	platform_device_unregister(connector->hdmi_audio.codec_pdev);
 
 	if (connector->privacy_screen) {
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f2be06f12b1a..2ee7c59329aa 100644
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
@@ -1198,6 +1199,17 @@ struct drm_connector_hdmi_state {
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
@@ -1548,6 +1560,36 @@ struct drm_connector_hdmi_funcs {
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
@@ -2178,6 +2220,25 @@ struct drm_connector_hdmi {
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
@@ -2769,6 +2830,24 @@ drm_connector_is_unregistered(struct drm_connector *connector)
 		DRM_CONNECTOR_UNREGISTERED;
 }
 
+/**
+ * drm_connector_hdmi_scrambler_supported - does connector support HDMI
+ * scrambling?
+ * @connector: DRM connector
+ *
+ * Checks whether or not @connector driver supports HDMI scrambling, based on
+ * the HDMI version advertised by the controller.
+ *
+ * Returns:
+ * True if the connector supports scrambling, false otherwise.
+ */
+static inline bool
+drm_connector_hdmi_scrambler_supported(const struct drm_connector *connector)
+{
+	return connector->hdmi.funcs &&
+		connector->hdmi.funcs->supported_hdmi_ver >= HDMI_VERSION_2_0;
+}
+
 void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
 				     enum drm_connector_status status);
 enum drm_connector_color_format

-- 
2.55.0

