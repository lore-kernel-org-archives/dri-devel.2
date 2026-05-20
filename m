Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F9FCD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF7310F115;
	Wed, 20 May 2026 18:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MWk9NuHF";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 251F410E437
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779302314;
 bh=PMazGqrcLk62NiMiM9e91vC9gW9B5kWfiknu5e2hMqQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=MWk9NuHFft+ssCnRSNfAq9lIBXdSiTZj8eyoUn1w2i16+mCvg+qB1GdU5jg34Gak9
 4Xn1HUmKXzeLkyRygE2iGwYXPCCSYG4wkLCuSD40w+aZtM+6StO/GDAhOKpKoR8NtK
 whN0sfmD7mMyDqIlfUQWaQKoh4xajv6w7d7AW2dmEBysqMUycGxVnHzFwEdmhVYPwp
 VSok+yeSBU54gG9r6Glv/wjqgkY4srQu9WS5PpvsgDm2+4KTk9le+bkSmfPhrS/EWY
 nqSthg2/bTB8kH+H9Ue6DGfU5b5MEc+Bi98+7BCnyfOFoWMjeZsnD3w58zOY0qep3Z
 rrSitDbXy4QYQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C0CE517E1454;
 Wed, 20 May 2026 20:38:34 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 20 May 2026 21:38:16 +0300
Subject: [PATCH v6 05/22] drm/display: hdmi_state_helper: Add ctx-aware
 hotplug helper for SCDC sync
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dw-hdmi-qp-scramb-v6-5-24b74603b782@collabora.com>
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

Introduce drm_atomic_helper_connector_hdmi_hotplug_ctx(), a variant of
drm_atomic_helper_connector_hdmi_hotplug() that accepts a
drm_modeset_acquire_ctx.

This enables SCDC status synchronization on hotplug events, which
requires lock acquisition context for performing the CRTC reset
triggered by drm_scdc_sync_status().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 36 ++++++++++++++++++++-----
 include/drm/display/drm_hdmi_state_helper.h     |  4 +++
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 4867edbf2622..26c491047a6a 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -12,6 +12,7 @@
 #include <drm/display/drm_hdmi_cec_helper.h>
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
+#include <drm/display/drm_scdc_helper.h>
 
 /**
  * DOC: hdmi helpers
@@ -1149,18 +1150,20 @@ drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *con
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_clear_audio_infoframe);
 
-static void
+static int
 drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
-					enum drm_connector_status status)
+					enum drm_connector_status status,
+					struct drm_modeset_acquire_ctx *ctx)
 {
 	const struct drm_edid *drm_edid;
+	int ret = 0;
 
 	if (status == connector_status_disconnected) {
-		// TODO: also handle scramber, HDMI sink disconnected.
+		drm_scdc_sync_status(connector, false, ctx);
 		drm_connector_hdmi_audio_plugged_notify(connector, false);
 		drm_edid_connector_update(connector, NULL);
 		drm_connector_cec_phys_addr_invalidate(connector);
-		return;
+		return 0;
 	}
 
 	if (connector->hdmi.funcs->read_edid)
@@ -1173,10 +1176,12 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
 	drm_edid_free(drm_edid);
 
 	if (status == connector_status_connected) {
-		// TODO: also handle scramber, HDMI sink is now connected.
+		ret = drm_scdc_sync_status(connector, true, ctx);
 		drm_connector_hdmi_audio_plugged_notify(connector, true);
 		drm_connector_cec_phys_addr_set(connector);
 	}
+
+	return ret;
 }
 
 /**
@@ -1190,10 +1195,27 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
 void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 					      enum drm_connector_status status)
 {
-	drm_atomic_helper_connector_hdmi_update(connector, status);
+	drm_atomic_helper_connector_hdmi_update(connector, status, NULL);
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
 
+/**
+ * drm_atomic_helper_connector_hdmi_hotplug_ctx - Handle the hotplug event for the HDMI connector
+ * @connector: A pointer to the HDMI connector
+ * @status: Connection status
+ * @ctx: Lock acquisition context to be used for resetting CRTC
+ *
+ * This function should be called as a part of the .detect() / .detect_ctx()
+ * callbacks for all status changes.
+ */
+int drm_atomic_helper_connector_hdmi_hotplug_ctx(struct drm_connector *connector,
+						 enum drm_connector_status status,
+						 struct drm_modeset_acquire_ctx *ctx)
+{
+	return drm_atomic_helper_connector_hdmi_update(connector, status, ctx);
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug_ctx);
+
 /**
  * drm_atomic_helper_connector_hdmi_force - HDMI Connector implementation of the force callback
  * @connector: A pointer to the HDMI connector
@@ -1205,6 +1227,6 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
  */
 void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_hdmi_update(connector, connector->status);
+	drm_atomic_helper_connector_hdmi_update(connector, connector->status, NULL);
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_force);
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 0adc30c55ec9..a572fe2bf9aa 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -7,6 +7,7 @@ struct drm_atomic_commit;
 struct drm_connector;
 struct drm_connector_state;
 struct drm_display_mode;
+struct drm_modeset_acquire_ctx;
 struct hdmi_audio_infoframe;
 
 enum drm_connector_status;
@@ -24,6 +25,9 @@ int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *con
 						       struct drm_atomic_commit *state);
 void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 					      enum drm_connector_status status);
+int drm_atomic_helper_connector_hdmi_hotplug_ctx(struct drm_connector *connector,
+						 enum drm_connector_status status,
+						 struct drm_modeset_acquire_ctx *ctx);
 void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector);
 
 enum drm_mode_status

-- 
2.53.0

