Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7B7F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505C410F073;
	Thu, 23 Apr 2026 10:19:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KWAp1IwW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1773D10F071
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:19:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 821FE60120;
 Thu, 23 Apr 2026 10:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93B0C2BCB5;
 Thu, 23 Apr 2026 10:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939546;
 bh=K41ebIXSM+v0dcoLlEPBDt+LhVglF/pzBTqy3fRbm5M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=KWAp1IwWObS8mGwgn0n48amgWVxdYeYRjqMxGs8QkQbiQ3JKVnXN6PIDeHM3ToI1I
 MO4roFOU0Zu5WUC3zi95JOTJrpeFbdUdOUwmdPECQvpMLon35wjFp/fCif+1jNqhw3
 +YHzIWV4k7hq5mxEp4IiM103VUjs87kxbTzdxBTYLBYusMhth0+8SkOpC4AQ5zSB85
 tSCHHm+d4blvfPrf3Nr1T2lCvuhwgPV1rDwShZnviJk0vCywpEZ2zuubNzxzAdS7ON
 U1zsHEcCKok23Zm7gewwmDaSCS6Uf9UusjN9ng1qttUScXBQjKk6LTTgmcWZN+d0gw
 HkEg7yQEJSOig==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:25 +0200
Subject: [PATCH v2 12/28] drm/atomic_sro: Add atomic state readout
 infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-12-8549f87cb978@kernel.org>
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=15036; i=mripard@kernel.org;
 h=from:subject:message-id; bh=K41ebIXSM+v0dcoLlEPBDt+LhVglF/pzBTqy3fRbm5M=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP77N4Pr2SPrQqypjr8mmSyTtjl59uCliiYnM40zxB
 XurHWMXd0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJWMUzNlx9l3S+prvi2yMu
 ldKb3m9b0k6v3PPfvG3RTlll/q3dk9e+nXj26gIdP+arSwP+KlU7aDPWiihoztzHHrWl/e+kad7
 ORipRXtytv1Rzq/eav9ip9r39wNa/OSbyP5WabczWCXUvLX8NAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

In order to enable drivers to read their initial state from the
hardware, each KMS object needs a hook to fill a pre-allocated state
from the hardware registers.

Introduce the atomic_sro_readout_state hook in every KMS object funcs
vtable: drm_crtc_funcs, drm_plane_funcs, drm_connector_funcs,
drm_bridge_funcs, and drm_private_state_funcs.

Also introduce the drm_mode_config_funcs.atomic_sro_readout_state and
drm_mode_config_helper_funcs.atomic_sro_build_state hooks, which are the
top-level entry points for drivers and helpers respectively.

Finally, add drm_atomic_sro_can_readout() to verify that all objects on
a device implement the readout hook, and wire it into
drm_atomic_sro_device_can_readout().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_sro.c         | 59 ++++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h                 | 25 ++++++++++++++
 include/drm/drm_bridge.h                 | 31 +++++++++++++++++
 include/drm/drm_connector.h              | 26 ++++++++++++++
 include/drm/drm_crtc.h                   | 26 ++++++++++++++
 include/drm/drm_mode_config.h            | 18 ++++++++++
 include/drm/drm_modeset_helper_vtables.h | 23 +++++++++++++
 include/drm/drm_plane.h                  | 26 ++++++++++++++
 8 files changed, 234 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
index a46f06e75c4e..3eb22c654973 100644
--- a/drivers/gpu/drm/drm_atomic_sro.c
+++ b/drivers/gpu/drm/drm_atomic_sro.c
@@ -4,10 +4,11 @@
 #include <drm/drm_atomic_sro.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 #include <linux/module.h>
 
 #include "drm_internal.h"
@@ -23,10 +24,62 @@ enum drm_atomic_readout_status {
 static unsigned int atomic_readout = DRM_ATOMIC_READOUT_ENABLED;
 module_param_unsafe(atomic_readout, uint, 0);
 MODULE_PARM_DESC(atomic_readout,
 		 "Enable Hardware State Readout (0 = disabled, 1 = enabled, 2 = ignore missing compares, 3 = ignore missing readouts and compares, default = 1)");
 
+static bool drm_atomic_sro_can_readout(struct drm_device *dev)
+{
+	struct drm_crtc *crtc;
+	struct drm_plane *plane;
+	struct drm_connector *connector;
+	struct drm_private_obj *privobj;
+	struct drm_connector_list_iter conn_iter;
+
+	if (atomic_readout == DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT)
+		return true;
+
+	if (!dev->mode_config.funcs->atomic_sro_readout_state)
+		return false;
+
+	drm_for_each_privobj(privobj, dev) {
+		if (!privobj->funcs->atomic_sro_readout_state) {
+			drm_dbg_atomic(dev,
+				       "Private object %s missing readout callback",
+				       privobj->name);
+			return false;
+		}
+	}
+
+	drm_for_each_plane(plane, dev) {
+		if (!plane->funcs->atomic_sro_readout_state) {
+			drm_dbg_atomic(dev, "Plane %s missing readout callback",
+				       plane->name);
+			return false;
+		}
+	}
+
+	drm_for_each_crtc(crtc, dev) {
+		if (!crtc->funcs->atomic_sro_readout_state) {
+			drm_dbg_atomic(dev, "CRTC %s missing readout callback",
+				       crtc->name);
+			return false;
+		}
+	}
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (!connector->funcs->atomic_sro_readout_state) {
+			drm_dbg_atomic(dev, "Connector %s missing readout callback",
+				       connector->name);
+			return false;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return true;
+}
+
 /**
  * drm_atomic_sro_device_can_readout - check if a device supports hardware state readout
  * @dev: DRM device to check
  *
  * Verifies that the device is an atomic driver, that readout is
@@ -37,16 +90,22 @@ MODULE_PARM_DESC(atomic_readout,
  * True if the device supports full hardware state readout, false
  * otherwise.
  */
 bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
 {
+	bool ret;
+
 	if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
 		return false;
 
 	if (atomic_readout == DRM_ATOMIC_READOUT_DISABLED)
 		return false;
 
+	ret = drm_atomic_sro_can_readout(dev);
+	if (!ret)
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL(drm_atomic_sro_device_can_readout);
 
 struct __drm_atomic_sro_plane {
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 4f58289d3a34..554dde45b799 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -293,10 +293,35 @@ struct drm_private_state_funcs {
 	 * Frees the private object state created with @atomic_duplicate_state.
 	 */
 	void (*atomic_destroy_state)(struct drm_private_obj *obj,
 				     struct drm_private_state *state);
 
+	/**
+	 * @atomic_sro_readout_state:
+	 *
+	 * Initializes @obj_state to reflect the current hardware state
+	 * of the private object.
+	 *
+	 * It is meant to be used by drivers that want to implement
+	 * flicker-free boot (also called fastboot by i915) and allows
+	 * to initialize the atomic state from the hardware state left
+	 * by the firmware.
+	 *
+	 * It is used at initialization time, so drivers must make sure
+	 * that the power state is sensible when accessing the hardware.
+	 *
+	 * This hook is mandatory for drivers implementing SRO, but can
+	 * be left unassigned otherwise.
+	 *
+	 * RETURNS:
+	 *
+	 * 0 on success, a negative error code otherwise.
+	 */
+	int (*atomic_sro_readout_state)(struct drm_private_obj *obj,
+					struct drm_atomic_sro_state *state,
+					struct drm_private_state *obj_state);
+
 	/**
 	 * @atomic_print_state:
 	 *
 	 * If driver subclasses &struct drm_private_state, it should implement
 	 * this optional hook for printing additional driver specific state.
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 425f3ca03d95..e0f9b7e6353a 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -373,10 +373,41 @@ struct drm_bridge_funcs {
 	 * The @atomic_post_disable callback is optional.
 	 */
 	void (*atomic_post_disable)(struct drm_bridge *bridge,
 				    struct drm_atomic_state *state);
 
+	/**
+	 * @atomic_sro_readout_state:
+	 *
+	 * Initializes @bridge_state to reflect the current hardware
+	 * state of the bridge.
+	 *
+	 * It is meant to be used by drivers that want to implement
+	 * flicker-free boot (also called fastboot by i915) and allows
+	 * to initialize the atomic state from the hardware state left
+	 * by the firmware.
+	 *
+	 * It is used at initialization time, so drivers must make sure
+	 * that the power state is sensible when accessing the hardware.
+	 *
+	 * The @crtc_state and @conn_state parameters point to the CRTC
+	 * and connector states for the pipeline this bridge is part
+	 * of.
+	 *
+	 * This hook is mandatory for drivers implementing SRO, but can
+	 * be left unassigned otherwise.
+	 *
+	 * RETURNS:
+	 *
+	 * 0 on success, a negative error code otherwise.
+	 */
+	int (*atomic_sro_readout_state)(struct drm_bridge *bridge,
+					struct drm_atomic_sro_state *state,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state);
+
 	/**
 	 * @atomic_duplicate_state:
 	 *
 	 * Duplicate the current bridge state object (which is guaranteed to be
 	 * non-NULL).
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index a2c6c87065b6..db0d2bb80bd5 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -32,10 +32,11 @@
 #include <drm/drm_util.h>
 #include <drm/drm_property.h>
 
 #include <uapi/drm/drm_mode.h>
 
+struct drm_atomic_sro_state;
 struct drm_connector_helper_funcs;
 struct drm_modeset_acquire_ctx;
 struct drm_device;
 struct drm_crtc;
 struct drm_display_mode;
@@ -1582,10 +1583,35 @@ struct drm_connector_funcs {
 	 * A new, pristine, connector state instance or an error pointer
 	 * on failure.
 	 */
 	struct drm_connector_state *(*atomic_create_state)(struct drm_connector *connector);
 
+	/**
+	 * @atomic_sro_readout_state:
+	 *
+	 * Initializes @conn_state to reflect the current hardware
+	 * state of the connector.
+	 *
+	 * It is meant to be used by drivers that want to implement
+	 * flicker-free boot (also called fastboot by i915) and allows
+	 * to initialize the atomic state from the hardware state left
+	 * by the firmware.
+	 *
+	 * It is used at initialization time, so drivers must make sure
+	 * that the power state is sensible when accessing the hardware.
+	 *
+	 * This hook is mandatory for drivers implementing SRO, but can
+	 * be left unassigned otherwise.
+	 *
+	 * RETURNS:
+	 *
+	 * 0 on success, a negative error code otherwise.
+	 */
+	int (*atomic_sro_readout_state)(struct drm_connector *connector,
+					struct drm_atomic_sro_state *state,
+					struct drm_connector_state *conn_state);
+
 	/**
 	 * @atomic_duplicate_state:
 	 *
 	 * Duplicate the current atomic state for this connector and return it.
 	 * The core and helpers guarantee that any atomic state duplicated with
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 9e410191683c..b6d4a2341776 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -33,10 +33,11 @@
 #include <drm/drm_device.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_debugfs_crc.h>
 #include <drm/drm_mode_config.h>
 
+struct drm_atomic_sro_state;
 struct drm_connector;
 struct drm_device;
 struct drm_framebuffer;
 struct drm_mode_set;
 struct drm_file;
@@ -649,10 +650,35 @@ struct drm_crtc_funcs {
 	 * A new, pristine, crtc state instance or an error pointer
 	 * on failure.
 	 */
 	struct drm_crtc_state *(*atomic_create_state)(struct drm_crtc *crtc);
 
+	/**
+	 * @atomic_sro_readout_state:
+	 *
+	 * Initializes @crtc_state to reflect the current hardware
+	 * state of the CRTC.
+	 *
+	 * It is meant to be used by drivers that want to implement
+	 * flicker-free boot (also called fastboot by i915) and allows
+	 * to initialize the atomic state from the hardware state left
+	 * by the firmware.
+	 *
+	 * It is used at initialization time, so drivers must make sure
+	 * that the power state is sensible when accessing the hardware.
+	 *
+	 * This hook is mandatory for drivers implementing SRO, but can
+	 * be left unassigned otherwise.
+	 *
+	 * RETURNS:
+	 *
+	 * 0 on success, a negative error code otherwise.
+	 */
+	int (*atomic_sro_readout_state)(struct drm_crtc *crtc,
+					struct drm_atomic_sro_state *state,
+					struct drm_crtc_state *crtc_state);
+
 	/**
 	 * @atomic_duplicate_state:
 	 *
 	 * Duplicate the current atomic state for this CRTC and return it.
 	 * The core and helpers guarantee that any atomic state duplicated with
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 22c7e767a2e9..ce2b4115b417 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -319,10 +319,28 @@ struct drm_mode_config_funcs {
 	 *
 	 * Subclassing of &drm_atomic_state is deprecated in favour of using
 	 * &drm_private_state and &drm_private_obj.
 	 */
 	void (*atomic_state_free)(struct drm_atomic_state *state);
+
+	/**
+	 * @atomic_sro_readout_state:
+	 *
+	 * This optional hook is called at initialization time to read
+	 * out the hardware state and initialize the DRM objects' atomic
+	 * states from it.
+	 *
+	 * When implemented, the framework will prefer hardware state
+	 * readout over creating pristine default states, enabling the
+	 * first modeset to be skipped if the firmware already set up
+	 * the display (flicker-free boot).
+	 *
+	 * RETURNS:
+	 *
+	 * 0 on success, a negative error code otherwise.
+	 */
+	 int (*atomic_sro_readout_state)(struct drm_device *dev);
 };
 
 /**
  * struct drm_mode_config - Mode configuration control structure
  * @min_width: minimum fb pixel width on this device
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 3e68213958dd..8c886c5ea9d3 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1550,8 +1550,31 @@ struct drm_mode_config_helper_funcs {
 	 * how one should implement this.
 	 *
 	 * This hook is optional.
 	 */
 	int (*atomic_commit_setup)(struct drm_atomic_state *state);
+
+	/**
+	 * @atomic_sro_build_state:
+	 *
+	 * Builds a &struct drm_atomic_sro_state from the current
+	 * hardware state by calling the atomic_sro_readout_state hooks
+	 * on every KMS object.
+	 *
+	 * This hook is called both at initialization time, to create
+	 * the initial state from what the firmware programmed, and
+	 * after blocking commits, to read back the hardware state and
+	 * compare it to what was committed.
+	 *
+	 * The default implementation is
+	 * drm_atomic_helper_sro_build_state().
+	 *
+	 * RETURNS:
+	 *
+	 * A &struct drm_atomic_sro_state on success, an error pointer
+	 * otherwise.
+	 */
+	struct drm_atomic_sro_state *
+	(*atomic_sro_build_state)(struct drm_device *dev);
 };
 
 #endif
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 4d4d511b681d..22a16bc63f3e 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -30,10 +30,11 @@
 #include <drm/drm_color_mgmt.h>
 #include <drm/drm_rect.h>
 #include <drm/drm_modeset_lock.h>
 #include <drm/drm_util.h>
 
+struct drm_atomic_sro_state;
 struct drm_crtc;
 struct drm_plane_size_hint;
 struct drm_printer;
 struct drm_modeset_acquire_ctx;
 
@@ -399,10 +400,35 @@ struct drm_plane_funcs {
 	 * A new, pristine, plane state instance or an error pointer
 	 * on failure.
 	 */
 	struct drm_plane_state *(*atomic_create_state)(struct drm_plane *plane);
 
+	/**
+	 * @atomic_sro_readout_state:
+	 *
+	 * Initializes @plane_state to reflect the current hardware
+	 * state of the plane.
+	 *
+	 * It is meant to be used by drivers that want to implement
+	 * flicker-free boot (also called fastboot by i915) and allows
+	 * to initialize the atomic state from the hardware state left
+	 * by the firmware.
+	 *
+	 * It is used at initialization time, so drivers must make sure
+	 * that the power state is sensible when accessing the hardware.
+	 *
+	 * This hook is mandatory for drivers implementing SRO, but can
+	 * be left unassigned otherwise.
+	 *
+	 * RETURNS:
+	 *
+	 * 0 on success, a negative error code otherwise.
+	 */
+	int (*atomic_sro_readout_state)(struct drm_plane *plane,
+					struct drm_atomic_sro_state *state,
+					struct drm_plane_state *plane_state);
+
 	/**
 	 * @atomic_duplicate_state:
 	 *
 	 * Duplicate the current atomic state for this plane and return it.
 	 * The core and helpers guarantee that any atomic state duplicated with

-- 
2.53.0

