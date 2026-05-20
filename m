Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD67CD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6D5610E437;
	Wed, 20 May 2026 18:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NbMqhrLH";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D6F410E437
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779302312;
 bh=rf4Hd8Z282ofbw33s/zydaHP4qp8sYgew1OU7iRNARw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=NbMqhrLH+bn3MOqxqb3LuFw0kr3PUO+7LszEG/Sq5FZwRF5ZFcXwJmzHDV5CbXnu9
 nMfQjtHgchXbyp/7PYK4pNpEUg+G7A1E0GpzlN9n+gqdvfU3jliOiSULVy2fTDzWub
 feU1QugeiWYaXYnPuO2t32Spwg58H027hnOucJWAwtoOgJwtqCWVE47K13miSg08Tl
 ccgjxh054rywLQHF3cc7j/G2qsgq2Hr2ZJPLcxQMnz41IseLTNAJ9Hqthx+pqgw9LS
 NG7/S2lONXjz0lYiNGRWgDql46uLl2BnNTxn3Lxm3kSz+NNUWyFiaaGP4q51Xluc/z
 uDxE/PB/6JA2Q==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8D8BD17E141E;
 Wed, 20 May 2026 20:38:32 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 20 May 2026 21:38:13 +0300
Subject: [PATCH v6 02/22] drm/connector: Add HDMI 2.0 scrambler infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dw-hdmi-qp-scramb-v6-2-24b74603b782@collabora.com>
References: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
In-Reply-To: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniels@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
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

Add the connector-level infrastructure to support HDMI 2.0 scrambling:

- .scrambler_src_{enable|disable}() callbacks in
  drm_connector_hdmi_funcs for source-side scrambling control
- A delayed work item (scdc_work) with an associated callback (scdc_cb)
  for periodic monitoring of sink-side scrambling status
- A scrambler_enabled flag to track whether scrambling is currently
  active

These are intended to be used by SCDC scrambling helpers to coordinate
scrambling setup and teardown between the source driver and the DRM
core.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 14 +++++++++++
 include/drm/drm_connector.h     | 52 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 3fa4d2082cd7..91e58362fbc0 100644
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
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5ad62c207d00..49eaa30b1329 100644
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
@@ -1358,6 +1359,36 @@ struct drm_connector_hdmi_funcs {
 	 */
 	const struct drm_edid *(*read_edid)(struct drm_connector *connector);
 
+	/**
+	 * @scrambler_src_enable:
+	 *
+	 * This callback is invoked through @drm_scdc_start_scrambling during
+	 * a commit to setup SCDC scrambling and high TMDS clock ratio on
+	 * source side.
+	 *
+	 * The @scrambler_src_enable callback is mandatory if HDMI 2.0 is
+	 * to be supported.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise
+	 */
+	int (*scrambler_src_enable)(struct drm_connector *connector);
+
+	/**
+	 * @scrambler_src_disable:
+	 *
+	 * This callback is invoked through @drm_scdc_stop_scrambling during
+	 * a commit to disable SCDC scrambling and high TMDS clock ratio on
+	 * source side.
+	 *
+	 * The @scrambler_src_disable callback is mandatory if HDMI 2.0 is
+	 * to be supported.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise
+	 */
+	int (*scrambler_src_disable)(struct drm_connector *connector);
+
 	/**
 	 * @avi:
 	 *
@@ -1944,6 +1975,27 @@ struct drm_connector_hdmi {
 	 */
 	unsigned long supported_formats;
 
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
+	 * drm_scdc_start_scrambling() helper.
+	 */
+	void (*scdc_cb)(struct drm_connector *connector);
+
 	/**
 	 * @funcs: HDMI connector Control Functions
 	 */

-- 
2.53.0

