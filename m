Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76CCC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74ABF10F40F;
	Thu,  2 Jul 2026 14:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XkRbuTSS";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA2110F40B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783003594;
 bh=XsiOHnKG4SPo7X0UGed/J+0uvQr1+vBQt+lfVk7aPnw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XkRbuTSSQIE1klIwXr0sU7Jzjbxq665fL9vrNQfYrbcbDC4TG48pLnzSWWyYV90pH
 HWUGhBWdMVSir1+ICbLIAe2JpHtwE4g4Gsrl85I7vfLVv5UzS6pTaqcFjAvKORYijA
 V/0tPENRX4n88A8ZTRS9BIfBQfrvMdvAd8zmJMu7Go1sXuQJ2GlWHFYUQSpyhimrbf
 f9CgTlcZU6LBjv7mIY9QSFRjHLsDI9pKfDkEnLS/hUHacPoOlv/e/OgP+cfC0JDzLH
 bVgla8F+mxZPovVsVqmBPpJibv8MOJRuXY9VZFjb6eCyJDj1i+GyGCcUY2urRGNh5L
 bL8Js57gfRzjw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 733DE17E0FDF;
 Thu,  2 Jul 2026 16:46:34 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 02 Jul 2026 17:46:17 +0300
Subject: [PATCH v8 04/39] drm/connector: Add HDMI 2.0 scrambler infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dw-hdmi-qp-scramb-v8-4-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
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

- A scrambler_supported flag to indicate whether the source supports the
  scrambling capability, in which case the newly introduced
  .scrambler_{enable|disable}() callbacks in drm_connector_hdmi_funcs
  are mandatory
- A scrambler_needed flag to be managed by the hdmi state helpers based
  on the negotiated TMDS character rate and the source/sink scrambling
  capabilities
- A scrambler_enabled flag to track whether scrambling is currently
  active
- A delayed work item (scdc_work) with an associated callback (scdc_cb)
  to monitor sink-side scrambling status and retry the setup if the sink
  resets it

These are intended to be used by SCDC scrambling helpers to coordinate
scrambling setup and teardown between the source driver and the DRM
core.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 26 ++++++++++++--
 include/drm/drm_connector.h     | 77 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index c7ce6b7bd8b0..deecfc582f09 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -220,6 +220,19 @@ void drm_connector_free_work_fn(struct work_struct *work)
 	}
 }
 
+static void drm_connector_hdmi_scdc_work(struct work_struct *work)
+{
+	struct drm_connector *connector;
+	struct drm_connector_hdmi *hdmi;
+
+	hdmi = container_of(to_delayed_work(work), struct drm_connector_hdmi,
+			    scdc_work);
+	connector = container_of(hdmi, struct drm_connector, hdmi);
+
+	if (hdmi->scdc_cb)
+		hdmi->scdc_cb(connector);
+}
+
 static int drm_connector_init_only(struct drm_device *dev,
 				   struct drm_connector *connector,
 				   const struct drm_connector_funcs *funcs,
@@ -285,6 +298,7 @@ static int drm_connector_init_only(struct drm_device *dev,
 	mutex_init(&connector->edid_override_mutex);
 	mutex_init(&connector->hdmi.infoframes.lock);
 	mutex_init(&connector->hdmi_audio.lock);
+	INIT_DELAYED_WORK(&connector->hdmi.scdc_work, drm_connector_hdmi_scdc_work);
 	connector->edid_blob_ptr = NULL;
 	connector->epoch_counter = 0;
 	connector->tile_blob_ptr = NULL;
@@ -624,12 +638,18 @@ int drmm_connector_hdmi_init_with_caps(struct drm_device *dev,
 	 * inferred limit with the actual controller capability. A value of
 	 * zero keeps the default limit inferred from supported_hdmi_ver.
 	 */
-	if (caps->supported_hdmi_ver >= HDMI_VERSION_2_0)
+	if (caps->supported_hdmi_ver >= HDMI_VERSION_2_0) {
+		if (!hdmi_funcs->scrambler_enable ||
+		    !hdmi_funcs->scrambler_disable)
+			return -EINVAL;
+
+		connector->hdmi.scrambler_supported = true;
 		connector->hdmi.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
-	else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_3)
+	} else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_3) {
 		connector->hdmi.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
-	else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_0)
+	} else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_0) {
 		connector->hdmi.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+	}
 
 	if (caps->max_tmds_char_rate) {
 		if (caps->max_tmds_char_rate > connector->hdmi.max_tmds_char_rate)
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 961a729d0869..c70b57963f28 100644
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
@@ -1131,6 +1132,19 @@ struct drm_connector_hdmi_state {
 	 * @tmds_char_rate: TMDS Character Rate, in Hz.
 	 */
 	unsigned long long tmds_char_rate;
+
+	/**
+	 * @scrambler_needed: Whether HDMI 2.0 SCDC scrambling is required
+	 * for the negotiated mode/bpc/format.
+	 *
+	 * Computed by drm_atomic_helper_connector_hdmi_check() from
+	 * @tmds_char_rate and the source/sink scrambling capabilities.
+	 *
+	 * Per HDMI 2.0, scrambling is mandatory above 340 MHz TMDS
+	 * character rate. Optional scrambling at lower rates is
+	 * deliberately not requested by the helper.
+	 */
+	bool scrambler_needed;
 };
 
 /**
@@ -1439,6 +1453,36 @@ struct drm_connector_hdmi_funcs {
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
@@ -2098,6 +2142,39 @@ struct drm_connector_hdmi {
 	 */
 	unsigned long long max_tmds_char_rate;
 
+	/**
+	 * @scrambler_supported: Indicates whether the HDMI controller
+	 * (source) supports HDMI 2.0 SCDC scrambling.
+	 *
+	 * This is set by the HDMI connector init helpers if the provided
+	 * capabilities advertise HDMI_VERSION_2_0 support.
+	 *
+	 * When true, @drm_connector_hdmi_funcs.scrambler_enable and
+	 * @drm_connector_hdmi_funcs.scrambler_disable are mandatory.
+	 */
+	bool scrambler_supported;
+
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
+	/** @scdc_cb: Callback to be invoked as part of @scdc_work.
+	 *
+	 * Currently used to monitor sink-side scrambling status and retry
+	 * setup if the sink resets it.
+	 *
+	 * This is assigned by the framework when making use of
+	 * drm_connector_hdmi_enable_scrambling() helper.
+	 */
+	void (*scdc_cb)(struct drm_connector *connector);
+
 	/**
 	 * @funcs: HDMI connector Control Functions
 	 */

-- 
2.54.0

