Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B224CD6E5C
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 11:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9975112AF0;
	Sun, 31 May 2026 11:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dgUwn73A";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26B0F112AE8;
 Sun, 31 May 2026 11:49:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91E2660123;
 Sun, 31 May 2026 11:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8561F00893;
 Sun, 31 May 2026 11:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780228158;
 bh=tlkPkhOs5YbTIBDNRia+BhFNWjrhaoDIcQZS2a5qaYo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dgUwn73ATSmTXzj4Rxw/qwG3pB9pte6w/yUPmNf63UR8dIuJVT1/lhjLhxNYhkreM
 FST/XOBTsKDx6jrX09PH+xqhQmj2pSU5rQ2RNru0dKw4tqJOPSVdDcG4Bc3MfDDfoc
 wdNgKUXLHkPlfWOf2gpsJRWubVC6tvDLEfNUErMbcCSG/KacS0B2Xew6S/qjpXHzlR
 sSFpAfpKzNEUqFTu8j/FPcmc1nOSTA+GlRguN0aSfD8FQhcAS311bFMe94fgRuy6Vz
 rTRNkoKvz5iZZ+W/NGJ7b6o2iyZ09+HbOyqTJOq9uq3m0BgiQGDThGolPUpH4ovGpG
 fYYNm4AKaO2pQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 04/11] DRM: Add support for client indicating support for
 luminance
Date: Sun, 31 May 2026 06:49:01 -0500
Message-ID: <20260531114908.1693426-5-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531114908.1693426-1-superm1@kernel.org>
References: <20260531114908.1693426-1-superm1@kernel.org>
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
the client and driver has connector support that the luminance can be
set during a modeset. Add capability for the client to register.

When a luminance-aware client sets DRM_CLIENT_CAP_LUMINANCE, each
DRM-connected backlight on the device is marked as taken over. Writes
to the legacy /sys/class/backlight/<dev>/brightness attribute then
return -EBUSY until the last luminance-aware client clears the cap or
closes its DRM file. The takeover follows the active backlight_device
when drm_backlight_link() retargets the link.

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # SM8150-HDK
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * Add tag
 * Added special validation handling for the luminance property
 * Allows value 0 to be set even when the range starts at 1
 * This enables DPMS to set luminance to 0 to turn off the display
 * Add documentation
 * Fix a compile error
 * Drop the driver capability - no longer needed! (yay)
v4:
 * Update unit for luminance
 * Disable backlight of other connectors on same CRTC
 * handle CRTC disconnect
 * Make DRM_CLIENT_CAP_LUMINANCE actually inhibit legacy sysfs writes
   with -EBUSY

f-luminance
---
 drivers/gpu/drm/drm_atomic_helper.c |  7 +++
 drivers/gpu/drm/drm_atomic_uapi.c   | 59 +++++++++++++++++++-
 drivers/gpu/drm/drm_backlight.c     | 86 +++++++++++++++++++++++++++--
 drivers/gpu/drm/drm_connector.c     | 51 +++++++++++++++++
 drivers/gpu/drm/drm_file.c          |  5 ++
 drivers/gpu/drm/drm_ioctl.c         | 15 +++++
 drivers/gpu/drm/drm_property.c      |  6 ++
 drivers/video/backlight/backlight.c |  7 +++
 include/drm/drm_backlight.h         |  2 +-
 include/drm/drm_connector.h         |  5 ++
 include/drm/drm_file.h              |  8 +++
 include/linux/backlight.h           | 15 +++++
 include/uapi/drm/drm.h              | 22 ++++++++
 13 files changed, 280 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 34ed8e5d93d7..bf85e98f1dff 100644
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
@@ -1225,6 +1226,8 @@ drm_atomic_helper_commit_encoder_bridge_disable(struct drm_device *dev,
 		 * it away), so we won't call disable hooks twice.
 		 */
 		bridge = drm_bridge_chain_get_first_bridge(encoder);
+		if (connector->backlight)
+			drm_backlight_set_luminance(connector->backlight, 0);
 		drm_atomic_bridge_chain_disable(bridge, state);
 		drm_bridge_put(bridge);
 
@@ -1737,6 +1740,10 @@ drm_atomic_helper_commit_encoder_bridge_enable(struct drm_device *dev, struct dr
 
 		drm_atomic_bridge_chain_enable(bridge, state);
 		drm_bridge_put(bridge);
+
+		if (connector->backlight && connector->state)
+			drm_backlight_set_luminance(connector->backlight,
+						    connector->state->luminance);
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_encoder_bridge_enable);
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
index b1ec470be86c..2cddf209d508 100644
--- a/drivers/gpu/drm/drm_backlight.c
+++ b/drivers/gpu/drm/drm_backlight.c
@@ -71,6 +71,7 @@ static bool __drm_backlight_is_registered(struct drm_backlight *b)
 /* caller must hold @drm_backlight_lock */
 static void __drm_backlight_real_changed(struct drm_backlight *b, uint64_t v)
 {
+	struct drm_connector *connector = b->connector;
 	unsigned int max, set;
 
 	lockdep_assert_held(&drm_backlight_lock);
@@ -85,6 +86,15 @@ static void __drm_backlight_real_changed(struct drm_backlight *b, uint64_t v)
 	set = v;
 	if (set >= max)
 		set = max;
+
+	/* Update the atomic state directly.
+	 * For atomic drivers, the luminance value is stored in
+	 * connector->state->luminance, not in the legacy property array.
+	 * We update it unconditionally to reflect the hardware state,
+	 * regardless of DPMS.
+	 */
+	if (connector->state)
+		connector->state->luminance = set;
 }
 
 /**
@@ -100,18 +110,22 @@ static void __drm_backlight_update_prop_range(struct drm_backlight *b)
 	struct drm_device *dev = b->connector->dev;
 	struct drm_property *prop = dev->mode_config.luminance_property;
 	unsigned int max = 0;
+	bool can_disable = false;
 
 	lockdep_assert_held(&drm_backlight_lock);
 
-	if (b->link && b->link->props.max_brightness > 0)
+	if (b->link && b->link->props.max_brightness > 0) {
 		max = b->link->props.max_brightness;
+		can_disable = b->link->props.can_disable;
+	}
 
 	/* Update property range to match hardware capabilities.
 	 * Range of 0-0 indicates no backing device.
-	 * Range of 1-max for normal operation (0 reserved for display off).
+	 * Range of 1-max for normal operation.
+	 * Range of 0-max means that the display would turn off at 0
 	 */
 	if (prop->values[1] != max) {
-		prop->values[0] = max ? 1 : 0;
+		prop->values[0] = max ? (can_disable ? 0 : 1) : 0;
 		prop->values[1] = max;
 	}
 }
@@ -123,6 +137,16 @@ static bool __drm_backlight_link(struct drm_backlight *b,
 	if (bd == b->link)
 		return false;
 
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
@@ -177,6 +201,7 @@ void drm_backlight_free(struct drm_connector *connector)
 
 	WARN_ON(__drm_backlight_is_registered(b));
 	WARN_ON(b->link);
+	WARN_ON(b->luminance_clients);
 
 	kfree(b);
 	connector->backlight = NULL;
@@ -228,11 +253,18 @@ EXPORT_SYMBOL(drm_backlight_unregister);
  */
 void drm_backlight_link(struct drm_backlight *b, struct backlight_device *bd)
 {
+	static const char * const ep[] = { "BACKLIGHT=1", NULL };
+	bool send_uevent = false;
+
 	if (!b)
 		return;
 
 	guard(spinlock)(&drm_backlight_lock);
-	__drm_backlight_link(b, bd);
+	send_uevent = __drm_backlight_link(b, bd);
+
+	if (send_uevent)
+		kobject_uevent_env(&b->connector->kdev->kobj, KOBJ_CHANGE,
+				   (char **)ep);
 }
 EXPORT_SYMBOL(drm_backlight_link);
 
@@ -269,6 +301,11 @@ void drm_backlight_inhibit_legacy(struct drm_backlight *b)
 {
 	if (!b)
 		return;
+
+	guard(spinlock)(&drm_backlight_lock);
+	b->luminance_clients++;
+	if (b->link)
+		atomic_inc(&b->link->drm_takeover);
 }
 EXPORT_SYMBOL(drm_backlight_inhibit_legacy);
 
@@ -283,6 +320,13 @@ void drm_backlight_uninhibit_legacy(struct drm_backlight *b)
 {
 	if (!b)
 		return;
+
+	guard(spinlock)(&drm_backlight_lock);
+	if (WARN_ON(b->luminance_clients == 0))
+		return;
+	b->luminance_clients--;
+	if (b->link)
+		atomic_dec(&b->link->drm_takeover);
 }
 EXPORT_SYMBOL(drm_backlight_uninhibit_legacy);
 
@@ -324,8 +368,38 @@ EXPORT_SYMBOL(drm_backlight_uninhibit_legacy_all);
 
 void drm_backlight_set_luminance(struct drm_backlight *b, unsigned int value)
 {
-	guard(spinlock)(&drm_backlight_lock);
-	__drm_backlight_real_changed(b, value);
+	struct backlight_device *bd = NULL;
+	unsigned int set = 0;
+	unsigned long flags;
+	unsigned int max = 0;
+
+	spin_lock_irqsave(&drm_backlight_lock, flags);
+	if (b && b->link) {
+		struct backlight_device *link = b->link;
+
+		max = b->link->props.max_brightness;
+
+		if (max == 0)
+			goto out;
+
+		set = min(value, max);
+		if (set == link->props.brightness)
+			goto out;
+
+		bd = link;
+		backlight_device_ref(bd);
+	}
+out:
+	spin_unlock_irqrestore(&drm_backlight_lock, flags);
+
+	if (bd) {
+		int rc = backlight_set_brightness(bd, set, BACKLIGHT_UPDATE_DRM);
+
+		WARN_ON(rc);
+		if (rc)
+			backlight_set_brightness(bd, max, BACKLIGHT_UPDATE_DRM);
+		backlight_device_unref(bd);
+	}
 }
 EXPORT_SYMBOL(drm_backlight_set_luminance);
 
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 09bb790782f1..224661587241 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1512,6 +1512,57 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
  * 	Summarizing: Only set "DPMS" when the connector is known to be enabled,
  * 	assume that a successful SETCONFIG call also sets "DPMS" to on, and
  * 	never read back the value of "DPMS" because it can be incorrect.
+ * LUMINANCE:
+ * 	Atomic property for controlling the backlight brightness level of the
+ * 	connector's display. This property provides unified access to the display
+ * 	backlight, replacing the legacy sysfs interface for brightness control.
+ *
+ * 	The property value is an unsigned integer representing the brightness level.
+ * 	The valid range is dynamically determined by the capabilities of the
+ * 	connected backlight hardware and is exposed through the property's minimum
+ * 	and maximum values:
+ *
+ * 	- Range 0-0: No backlight device is available for this connector.
+ * 	- Range 1-N: Normal operation. Values from 1 to N (max_brightness) are
+ * 	  valid brightness levels, where 1 is the minimum visible brightness and
+ * 	  N is the maximum brightness the hardware supports.
+ * 	- Value 0: Special value to turn off the display backlight completely.
+ * 	  This value is accepted even when the normal range starts at 1.
+ *
+ * 	The range may change during runtime if a new backlight device is linked
+ * 	or unlinked. The kernel will send a change uevent when this occurs.
+ *
+ * 	Setting LUMINANCE to 0 turns off the backlight, which may turn off the
+ * 	display completely depending on the hardware. Setting it to any value
+ * 	from 1 to N adjusts the brightness accordingly. Reading this property
+ * 	returns the current brightness level that was last set (or the hardware's
+ * 	current state for drivers that support reading actual brightness).
+ *
+ * 	For atomic drivers, the luminance value is stored in
+ * 	&drm_connector_state.luminance. The actual hardware update only occurs
+ * 	when the connector is active (DPMS is ON). When DPMS transitions to OFF,
+ * 	the kernel automatically sets luminance to 0 to turn off the backlight.
+ * 	When DPMS transitions back to ON, the kernel restores the previously
+ * 	set luminance value.
+ *
+ * 	This property is only available on connectors that have an associated
+ * 	backlight device.  The property is created by calling drm_backlight_alloc()
+ * 	during connector initialization.
+ *
+ * 	Client Capability:
+ * 		User-space must set the DRM_CLIENT_CAP_LUMINANCE client capability
+ * 		to 1 before using this property. When this capability is enabled,
+ * 		the legacy sysfs backlight interface is inhibited to prevent
+ * 		conflicts between multiple clients trying to control the same
+ * 		backlight. This ensures that only luminance-aware clients control
+ * 		the backlight through the DRM atomic interface.
+ *
+ * 		Legacy clients that do not set this capability will not see the
+ * 		LUMINANCE property and should continue using the sysfs interface
+ * 		(if available).
+ *
+ * 	Note: This property can be set through MODE_ATOMIC ioctl as part of the
+ * 	atomic state.
  * panel_type:
  * 	Immutable enum property to indicate the type of connected panel.
  * 	Possible values are "unknown" (default) and "OLED".
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
index ff193155129e..fdae36b13300 100644
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
@@ -380,6 +382,19 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 			return -EINVAL;
 		file_priv->plane_color_pipeline = req->value;
 		break;
+	case DRM_CLIENT_CAP_LUMINANCE:
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
diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index f38f2c5437e6..4475896c963b 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -952,6 +952,12 @@ bool drm_property_change_valid_get(struct drm_property *property,
 	*ref = NULL;
 
 	if (drm_property_type_is(property, DRM_MODE_PROP_RANGE)) {
+		/* Special case for luminance property: allow 0 to turn off display
+		 * even when the normal range starts at 1.
+		 */
+		if (property == property->dev->mode_config.luminance_property &&
+		    value == 0 && property->values[1] > 0)
+			return true;
 		if (value < property->values[0] || value > property->values[1])
 			return false;
 		return true;
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 13954c2220b7..40cfc2296445 100644
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
index e0e09e38f7c0..2af48be3aa37 100644
--- a/include/drm/drm_backlight.h
+++ b/include/drm/drm_backlight.h
@@ -43,9 +43,9 @@ void drm_backlight_unregister(struct drm_backlight *b);
 
 void drm_backlight_link(struct drm_backlight *b, struct backlight_device *bd);
 struct backlight_device *drm_backlight_get_device(struct drm_backlight *b);
-void drm_backlight_set_luminance(struct drm_backlight *b, unsigned int value);
 void drm_backlight_inhibit_legacy(struct drm_backlight *b);
 void drm_backlight_uninhibit_legacy(struct drm_backlight *b);
 void drm_backlight_inhibit_legacy_all(struct drm_device *dev);
 void drm_backlight_uninhibit_legacy_all(struct drm_device *dev);
+void drm_backlight_set_luminance(struct drm_backlight *b, unsigned int value);
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
index 26a7281d179c..b03737ee8dac 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -197,6 +197,13 @@ struct backlight_properties {
 	 */
 	int brightness;
 
+	/**
+	 * @can_disable: Minimum brightness would turn off the panel.
+	 *
+	 * Setting minimum brightness turns off the panel.
+	 */
+	bool can_disable;
+
 	/**
 	 * @max_brightness: The maximum brightness value.
 	 *
@@ -314,6 +321,14 @@ struct backlight_device {
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
index 27cc159c1d27..1b17fd2d3b2c 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -921,6 +921,28 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
 
+/**
+ * DRM_CLIENT_CAP_LUMINANCE
+ *
+ * If set to 1, the client declares support for the LUMINANCE connector property
+ * and will control backlight brightness through the DRM atomic interface. This
+ * enables the kernel to expose the LUMINANCE property on connectors that have
+ * an associated backlight device.
+ *
+ * When this capability is enabled:
+ *  - The LUMINANCE property becomes visible on supported connectors
+ *  - Legacy sysfs writes to /sys/class/backlight/{*}/brightness will return
+ *    -EBUSY to prevent conflicts with DRM-based brightness control
+ *  - The client should include luminance values as part of atomic commits
+ *  - Brightness changes are synchronized with display power state (DPMS)
+ *
+ * The LUMINANCE property accepts values from 0 to max_brightness, where 0 turns
+ * off the backlight, and 1 to max_brightness control the brightness level.
+ *
+ * This capability is supported starting in kernel 7.2.
+ */
+#define DRM_CLIENT_CAP_LUMINANCE		8
+
 /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
-- 
2.54.0

