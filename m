Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDFACD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 05:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4E410EC5B;
	Thu, 28 May 2026 05:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Avyd/vHj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB1C10EC56
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 05:50:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9257E43EC4;
 Thu, 28 May 2026 05:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82AB1F000E9;
 Thu, 28 May 2026 05:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779947407;
 bh=FZqniUaR0w0xu7txFOfJck8V127OZelbSmie2a5Wpio=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Avyd/vHjiO8mSah/sUwqUtAnNq1tr1S9r6ci/+766R4Q0JQXCGLvzK0ES6RL6bqEz
 pV/bYvmHY4cmnyJqds/nUi4e27XbvvpFO7HPD08Dcb74kG51trJgePP6oFxp/M+bYY
 T/tlhEjWyA4HZP0MgAYE4oP9ofYeMwZdCUDAhtn4jD5cawOgHVWoerQmi8vKD0FExQ
 NkyVk5iEi3ZTQAfKU69+ljIrN8UNDCJ8pOcUbVEfWpB07SgsbfvupBoaYK9b7aEMCQ
 Sw8HYXMMkXwlpN0Aljx6af2XBuX8yyWbk42JUWDIX/h1ENX25APEyclndqyjBbosA2
 v0EpTzOv1wtaw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v4 4/9] DRM: Add support for client and driver indicating
 support for luminance
Date: Thu, 28 May 2026 00:49:06 -0500
Message-ID: <20260528054911.1513208-5-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528054911.1513208-1-superm1@kernel.org>
References: <20260528054911.1513208-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The legacy backlight control interface can only be disabled when both
the client and driver have agreed that the luminance can be set during
a modeset. Add capability for the client to register and for the driver
to indicate support.

When a luminance-aware client sets DRM_CLIENT_CAP_LUMINANCE, each
DRM-connected backlight on the device is marked as taken over. Writes
to the legacy /sys/class/backlight/<dev>/brightness attribute then
return -EBUSY until the last luminance-aware client clears the cap or
closes its DRM file. The takeover follows the active backlight_device
when drm_backlight_link() retargets the link.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v4:
 * Update unit for luminance
 * Disable backlight of other connectors on same CRTC
 * handle CRTC disconnect
 * Make DRM_CLIENT_CAP_LUMINANCE actually inhibit legacy sysfs writes
   with -EBUSY
---
 drivers/gpu/drm/drm_atomic_helper.c |  1 +
 drivers/gpu/drm/drm_atomic_uapi.c   | 59 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/drm_backlight.c     | 41 +++++++++++++++++++-
 drivers/gpu/drm/drm_file.c          |  5 +++
 drivers/gpu/drm/drm_ioctl.c         | 17 +++++++++
 drivers/video/backlight/backlight.c |  7 ++++
 include/drm/drm_backlight.h         |  5 +++
 include/drm/drm_connector.h         |  5 +++
 include/drm/drm_drv.h               |  7 ++++
 include/drm/drm_file.h              |  8 ++++
 include/linux/backlight.h           |  8 ++++
 include/uapi/drm/drm.h              | 10 +++++
 12 files changed, 170 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index cb76291a9355..857dbc95b13e 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -32,6 +32,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_colorop.h>
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 5bd5bf6661df..64cd0830beb7 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -30,6 +30,8 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_backlight.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
@@ -935,6 +937,14 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->privacy_screen_sw_state = val;
 	} else if (property == connector->broadcast_rgb_property) {
 		state->hdmi.broadcast_rgb = val;
+	} else if (property == config->luminance_property) {
+		state->luminance = val;
+		/* Update hardware backlight only when DPMS is ON.
+		 * Property value is always updated to remember the user's
+		 * desired brightness.
+		 */
+		if (connector->dpms == DRM_MODE_DPMS_ON)
+			drm_backlight_set_luminance(connector->backlight, val);
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -1020,6 +1030,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->privacy_screen_sw_state;
 	} else if (property == connector->broadcast_rgb_property) {
 		*val = state->hdmi.broadcast_rgb;
+	} else if (property == config->luminance_property) {
+		*val = state->luminance;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
@@ -1104,6 +1116,31 @@ static struct drm_pending_vblank_event *create_vblank_event(
 	return e;
 }
 
+static void drm_atomic_connector_set_backlight(struct drm_connector *connector,
+						       unsigned int luminance)
+{
+	if (!connector->backlight)
+		return;
+
+	drm_backlight_set_luminance(connector->backlight, luminance);
+}
+
+static void drm_atomic_crtc_set_backlight(struct drm_crtc *crtc, bool active)
+{
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *connector;
+
+	drm_connector_list_iter_begin(crtc->dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (!connector->state || connector->state->crtc != crtc)
+			continue;
+
+		drm_atomic_connector_set_backlight(connector,
+						  active ? connector->state->luminance : 0);
+	}
+	drm_connector_list_iter_end(&conn_iter);
+}
+
 int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
 				     struct drm_connector *connector,
 				     int mode)
@@ -1126,9 +1163,29 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
 	if (connector->dpms == mode)
 		goto out;
 
+	crtc = connector->state ? connector->state->crtc : NULL;
+
+	/* Handle backlight brightness coordination with DPMS state changes */
+	if (old_mode != DRM_MODE_DPMS_OFF && mode == DRM_MODE_DPMS_OFF) {
+		/* DPMS ON -> OFF: dim all connectors driven by this CRTC. */
+		if (crtc)
+			drm_atomic_crtc_set_backlight(crtc, false);
+		else
+			drm_atomic_connector_set_backlight(connector, 0);
+	}
+
 	connector->dpms = mode;
 
-	crtc = connector->state->crtc;
+	/* DPMS OFF -> ON: restore brightness to property value */
+	if (old_mode == DRM_MODE_DPMS_OFF && mode == DRM_MODE_DPMS_ON &&
+	    connector->state) {
+		if (crtc)
+			drm_atomic_crtc_set_backlight(crtc, true);
+		else
+			drm_atomic_connector_set_backlight(connector,
+						  connector->state->luminance);
+	}
+
 	if (!crtc)
 		goto out;
 	ret = drm_atomic_add_affected_connectors(state, crtc);
diff --git a/drivers/gpu/drm/drm_backlight.c b/drivers/gpu/drm/drm_backlight.c
index a54629749ce4..2aa9a6263535 100644
--- a/drivers/gpu/drm/drm_backlight.c
+++ b/drivers/gpu/drm/drm_backlight.c
@@ -50,6 +50,13 @@ struct drm_backlight {
 	struct backlight_device *link;
 	struct work_struct work;
 	unsigned int set_value;
+	/*
+	 * Number of luminance-aware DRM clients that have taken over this
+	 * connector's backlight. While > 0, legacy sysfs writes to the
+	 * linked backlight_device return -EBUSY. Protected by
+	 * drm_backlight_lock.
+	 */
+	unsigned int luminance_clients;
 	bool changed : 1;
 };
 
@@ -123,11 +130,30 @@ static void __drm_backlight_prop_changed(struct drm_backlight *b, unsigned int v
 /* caller must hold @drm_backlight_lock */
 static void __drm_backlight_real_changed(struct drm_backlight *b, uint64_t v)
 {
+	struct drm_connector *connector = b->connector;
+	unsigned int max, set;
+
 	lockdep_assert_held(&drm_backlight_lock);
 
-	/* Atomic state update of the luminance property is wired up by a
-	 * follow-up patch that introduces the connector_state field.
+	if (!b->link)
+		return;
+
+	max = b->link->props.max_brightness;
+	if (max < 1)
+		return;
+
+	set = v;
+	if (set >= max)
+		set = max;
+
+	/* Update the atomic state directly.
+	 * For atomic drivers, the luminance value is stored in
+	 * connector->state->luminance, not in the legacy property array.
+	 * We update it unconditionally to reflect the hardware state,
+	 * regardless of DPMS.
 	 */
+	if (connector->state)
+		connector->state->luminance = set;
 }
 
 /**
@@ -167,6 +193,16 @@ static void __drm_backlight_link(struct drm_backlight *b,
 	if (bd == b->link)
 		return;
 
+	/* Transfer any DRM legacy-sysfs takeover from the old link to the
+	 * new one so the inhibit follows the active backlight_device.
+	 */
+	if (b->luminance_clients) {
+		if (b->link)
+			atomic_sub(b->luminance_clients, &b->link->drm_takeover);
+		if (bd)
+			atomic_add(b->luminance_clients, &bd->drm_takeover);
+	}
+
 	backlight_device_unref(b->link);
 	b->link = bd;
 	backlight_device_ref(b->link);
@@ -222,6 +258,7 @@ void drm_backlight_free(struct drm_connector *connector)
 
 	WARN_ON(__drm_backlight_is_registered(b));
 	WARN_ON(b->link);
+	WARN_ON(b->luminance_clients);
 
 	kfree(b);
 	connector->backlight = NULL;
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index ec820686b302..4d2520de7614 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -41,6 +41,7 @@
 #include <linux/slab.h>
 #include <linux/vga_switcheroo.h>
 
+#include <drm/drm_backlight.h>
 #include <drm/drm_client_event.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
@@ -252,6 +253,10 @@ void drm_file_free(struct drm_file *file)
 	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
 		drm_fb_release(file);
 		drm_property_destroy_user_blobs(dev, file);
+		if (file->supports_luminance_control) {
+			drm_backlight_uninhibit_legacy_all(dev);
+			file->supports_luminance_control = false;
+		}
 	}
 
 	if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index ff193155129e..721bf4ddeb5c 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -28,12 +28,14 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include "drm/drm.h"
 #include <linux/export.h>
 #include <linux/nospec.h>
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 
 #include <drm/drm_auth.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
@@ -380,6 +382,21 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 			return -EINVAL;
 		file_priv->plane_color_pipeline = req->value;
 		break;
+	case DRM_CLIENT_CAP_LUMINANCE:
+		if (!drm_core_check_feature(dev, DRIVER_CONNECTOR_LUMINANCE))
+			return -EOPNOTSUPP;
+		if (!file_priv->atomic)
+			return -EINVAL;
+		if (req->value > 1)
+			return -EINVAL;
+		if (req->value == file_priv->supports_luminance_control)
+			break;
+		if (req->value)
+			drm_backlight_inhibit_legacy_all(dev);
+		else
+			drm_backlight_uninhibit_legacy_all(dev);
+		file_priv->supports_luminance_control = req->value;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 68e472d8f3fd..ecc98970f8c5 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -217,6 +217,13 @@ static ssize_t brightness_store(struct device *dev,
 	struct backlight_device *bd = to_backlight_device(dev);
 	unsigned long brightness;
 
+	/* A luminance-aware DRM client has taken over this backlight; the
+	 * legacy sysfs interface is disabled until the last such client
+	 * goes away.
+	 */
+	if (atomic_read(&bd->drm_takeover) > 0)
+		return -EBUSY;
+
 	rc = kstrtoul(buf, 0, &brightness);
 	if (rc)
 		return rc;
diff --git a/include/drm/drm_backlight.h b/include/drm/drm_backlight.h
index c35345664a5d..2af48be3aa37 100644
--- a/include/drm/drm_backlight.h
+++ b/include/drm/drm_backlight.h
@@ -30,6 +30,7 @@
 struct backlight_device;
 struct drm_backlight;
 struct drm_connector;
+struct drm_device;
 struct drm_mode_object;
 
 int drm_backlight_init(void);
@@ -42,5 +43,9 @@ void drm_backlight_unregister(struct drm_backlight *b);
 
 void drm_backlight_link(struct drm_backlight *b, struct backlight_device *bd);
 struct backlight_device *drm_backlight_get_device(struct drm_backlight *b);
+void drm_backlight_inhibit_legacy(struct drm_backlight *b);
+void drm_backlight_uninhibit_legacy(struct drm_backlight *b);
+void drm_backlight_inhibit_legacy_all(struct drm_device *dev);
+void drm_backlight_uninhibit_legacy_all(struct drm_device *dev);
 void drm_backlight_set_luminance(struct drm_backlight *b, unsigned int value);
 #endif /* __DRM_BACKLIGHT_H__ */
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 10daf088b8f1..dcb7dd0bdf44 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1209,6 +1209,11 @@ struct drm_connector_state {
 	 * @drm_atomic_helper_connector_hdmi_check().
 	 */
 	struct drm_connector_hdmi_state hdmi;
+
+	/**
+	 * @luminance: Luminance for the connector
+	 */
+	unsigned int luminance;
 };
 
 struct drm_connector_hdmi_audio_funcs {
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 42fc085f986d..a6b668cb68c5 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -123,6 +123,13 @@ enum drm_driver_feature {
 	 */
 	DRIVER_CURSOR_HOTSPOT           = BIT(9),
 
+	/**
+	 * @DRIVER_CONNECTOR_LUMINANCE:
+	 *
+	 * Driver supports luminance control on a per connector basis.
+	 */
+	DRIVER_CONNECTOR_LUMINANCE           = BIT(10),
+
 	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
 
 	/**
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 6ee70ad65e1f..0bb1e53f36be 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -248,6 +248,14 @@ struct drm_file {
 	 */
 	bool supports_virtualized_cursor_plane;
 
+	/**
+	 * @supports_luminance_control:
+	 *
+	 * This client is capable of setting the luminance for connectors.
+	 *
+	 */
+	bool supports_luminance_control;
+
 	/**
 	 * @master:
 	 *
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 26a7281d179c..667f5dd33c9d 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -314,6 +314,14 @@ struct backlight_device {
 	 * @use_count: The number of unblanked displays.
 	 */
 	int use_count;
+
+	/**
+	 * @drm_takeover: Number of luminance-aware DRM clients that have
+	 * taken over brightness control of this device. When non-zero,
+	 * writes to the legacy sysfs ``brightness`` attribute return
+	 * ``-EBUSY``. Managed by the DRM backlight helpers.
+	 */
+	atomic_t drm_takeover;
 };
 
 /* Forward declaration for backlight_update_status */
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 27cc159c1d27..b5e6d940f281 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -921,6 +921,16 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
 
+/**
+ * DRM_CLIENT_CAP_LUMINANCE
+ *
+ * If set to 1, legacy sysfs interface for controlling backlight brightness will
+ * be disabled.  The client will include luminance values as part of the modeset.
+
+ * This capability is supported starting in kernel 7.2
+ */
+#define DRM_CLIENT_CAP_LUMINANCE		8
+
 /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
-- 
2.54.0

