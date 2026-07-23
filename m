Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E07C531C8
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E4010EF34;
	Thu, 23 Jul 2026 01:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HuozuEYQ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C49E10EF05
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784770513;
 bh=N85WYXIyp7svItL0OlXT1YwLpcigKtFADFHc3tqyBI8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HuozuEYQjDGrD+aO2hWV29yWSyjX86YxKJ8aWpwKBgt05Iz1o7cSAc7pi4t97DERl
 X5POZHdPocTfa2/pmhWlSVulADddNiomEWXuh0cESQktffvJ4OK8i5cAdyNpAc6xNt
 kPpyxAvnfz1zN1j6NV9uTYrkcJM8FzaMCWxkAxXnFTmNVu2PbZBePTNigpsUG/8+UV
 tTFLVgIUcr1A0JsWXhXI/2opENJD2BkEIf8xsHvX+7aqb3a5SsCGXpXoAsnxHF3feb
 dK976oti0QS8TjdIGVoHtiCgXLD7dIqEJ7nsf+1akY+nRIb9kXVooFV8qExxI0gZXd
 +xAVRkRlBlQdA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3EF1717E1313;
 Thu, 23 Jul 2026 03:35:13 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 23 Jul 2026 04:35:05 +0300
Subject: [PATCH v9 16/61] drm/display: hdmi-state-helper: Pass acquire ctx
 to hotplug helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-dw-hdmi-qp-scramb-v9-16-4fb12ea22ac9@collabora.com>
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
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org
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

In preparation for supporting SCDC status synchronization on hotplug
events, extend drm_atomic_helper_connector_hdmi_hotplug() and
drm_atomic_helper_connector_hdmi_update() to take a struct
drm_modeset_acquire_ctx argument.  This will be used when a CRTC reset
is required.

Additionally, change their return type from void to int to allow
propagation of errors such as -EDEADLK caused by lock contention.

Update existing callers accordingly.  Note that in the VC4 case, the
return code is ignored, as it cannot fail: being in the .detect_ctx()
call path, the connection mutex is already held through ctx, and it
bails out early because the driver relies on a local SCDC
state-management implementation, and therefore does not yet expose the
scrambler capability through the common helpers.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c  |  8 ++++--
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 34 ++++++++++++++++++++-----
 drivers/gpu/drm/vc4/vc4_hdmi.c                  |  2 +-
 include/drm/display/drm_hdmi_state_helper.h     |  6 +++--
 4 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index ed3b5b73a88a..1dcce4ab8035 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -297,12 +297,16 @@ static int drm_bridge_connector_detect_ctx(struct drm_connector *connector,
 	struct drm_bridge *detect = bridge_connector->bridge_detect;
 	struct drm_bridge *hdmi = bridge_connector->bridge_hdmi;
 	enum drm_connector_status status;
+	int ret;
 
 	if (detect) {
 		status = detect->funcs->detect(detect, connector);
 
-		if (hdmi)
-			drm_atomic_helper_connector_hdmi_hotplug(connector, status);
+		if (hdmi) {
+			ret = drm_atomic_helper_connector_hdmi_hotplug(connector, ctx, status);
+			if (ret == -EDEADLK)
+				return ret;
+		}
 
 		drm_bridge_connector_hpd_notify(connector, status);
 	} else {
diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 92be6278ea44..04d5196a2010 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1199,8 +1199,9 @@ drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *con
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_clear_audio_infoframe);
 
-static void
+static int
 drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
+					struct drm_modeset_acquire_ctx *ctx,
 					enum drm_connector_status status)
 {
 	const struct drm_edid *drm_edid;
@@ -1210,7 +1211,7 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
 		drm_connector_hdmi_audio_plugged_notify(connector, false);
 		drm_edid_connector_update(connector, NULL);
 		drm_connector_cec_phys_addr_invalidate(connector);
-		return;
+		return 0;
 	}
 
 	if (connector->hdmi.funcs->read_edid)
@@ -1227,20 +1228,28 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
 		drm_connector_hdmi_audio_plugged_notify(connector, true);
 		drm_connector_cec_phys_addr_set(connector);
 	}
+
+	return 0;
 }
 
 /**
  * drm_atomic_helper_connector_hdmi_hotplug - Handle the hotplug event for the HDMI connector
  * @connector: A pointer to the HDMI connector
+ * @ctx: Lock acquisition context to be used for resetting CRTC
  * @status: Connection status
  *
  * This function should be called as a part of the .detect() / .detect_ctx()
  * callbacks for all status changes.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ * If @ctx is set, it might also return -EDEADLK.
  */
-void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
-					      enum drm_connector_status status)
+int drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
+					     struct drm_modeset_acquire_ctx *ctx,
+					     enum drm_connector_status status)
 {
-	drm_atomic_helper_connector_hdmi_update(connector, status);
+	return drm_atomic_helper_connector_hdmi_update(connector, ctx, status);
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
 
@@ -1255,6 +1264,19 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
  */
 void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_hdmi_update(connector, connector->status);
+	struct drm_modeset_acquire_ctx ctx;
+	int ret;
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry:
+	ret = drm_atomic_helper_connector_hdmi_update(connector, &ctx, connector->status);
+	if (ret == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry;
+	}
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_force);
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 72ff95ca97de..7f613f912368 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -375,7 +375,7 @@ static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
 	 * the lock for now.
 	 */
 
-	drm_atomic_helper_connector_hdmi_hotplug(connector, status);
+	drm_atomic_helper_connector_hdmi_hotplug(connector, ctx, status);
 
 	if (status != connector_status_connected)
 		return;
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 13375bd0f4ae..c26c6a87795e 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -7,6 +7,7 @@ struct drm_atomic_commit;
 struct drm_connector;
 struct drm_connector_state;
 struct drm_display_mode;
+struct drm_modeset_acquire_ctx;
 struct hdmi_audio_infoframe;
 
 enum drm_connector_status;
@@ -22,8 +23,9 @@ int drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector
 int drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *connector);
 int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *connector,
 						       struct drm_atomic_commit *state);
-void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
-					      enum drm_connector_status status);
+int drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
+					     struct drm_modeset_acquire_ctx *ctx,
+					     enum drm_connector_status status);
 void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector);
 
 enum drm_mode_status

-- 
2.55.0

