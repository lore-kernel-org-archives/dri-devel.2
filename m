Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E238A606A339
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tn7v8hRv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F284112923;
	Fri, 27 Nov 2026 09:54:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D9EC10E56B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:53:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5417E45066;
 Fri, 27 Nov 2026 09:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2B61F00927;
 Fri, 27 Nov 2026 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773227;
 bh=R/birCb1wDb4tInBQoy/DUqZqt3X9vcEQ29glIWaUoM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Tn7v8hRv/sXTLB4erDo7VEezKtqIJe5NwnMrJTeRSKGWgrVU2lcK1TnVcE2kQU+xy
 eqYT5oaBr7uTRBQ/4hGkO2rB5RUKDYnjdP6sk0PLkpSkCxweP48ggsKqN4zRB0dx/M
 qznLQzhBHGSHsqp19U1Jrv0b2AbRKGcGELzjndrAxay2N8P61umph+sWCcYwJoXd/u
 8vf9Gg4SflCViHFRMzqF4zdcjl3EBAZCAAmhM8t4p2zPXaswe9GJB5bE3SLXOjl0Am
 RDM5DFJH04knC3tys7xbj8ucOHxdNSoXQsPfaSTLxLPnYYWVo4R5kcy+rxm/9KQ91o
 ZGKdisHrDfsCQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:52:50 +0100
Subject: [PATCH v10 08/36] drm/atomic_sro: Add atomic state readout
 infrastructure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-8-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=22594; i=mripard@kernel.org;
 h=from:subject:message-id; bh=5BzBU0NG/31abIkn3ejZrCfMGLb2JgdXY/hcHCdm2B0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwQym4RfvN8g1+uvO2aNtdz5m3YurtW/+l61JY0nny
 jb7kizaMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACaSpclYK7Pku5JjxNL8uH5e
 5j9bdSYknD/DGJRZ4y4xZ6ugytGgVWxRM5iuHj3aFj9x7dq8yD2WjA0ty4wSTOSluKR2M6qtvd4
 5X4PnmOLrO2Vi28pNFrxZWKZw6SOj0f/7YZfrm5TttSJUBAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In order to enable drivers to read their initial state from the
hardware, each KMS object needs a hook to fill a pre-allocated state
from the hardware registers.

Introduce the atomic_sro_readout_state hook in every KMS object funcs
vtable: drm_crtc_funcs, drm_plane_funcs, drm_connector_funcs,
drm_bridge_funcs, and drm_private_state_funcs.

Also introduce the drm_mode_config_funcs.atomic_sro_readout_state and
drm_mode_config_helper_funcs.atomic_sro_build_state hooks, which are the
top-level entry points for drivers and helpers respectively.

The states read out aren't the current states of the objects yet, so
they also need to be installed. Introduce the
drm_mode_config_helper_funcs.atomic_sro_install_state hook to install a
whole drm_atomic_sro_state, and an optional atomic_sro_install_state
hook in drm_crtc_funcs, drm_plane_funcs, drm_connector_funcs and
drm_private_state_funcs. The latter is called before the state of an
object is replaced, so that drivers can acquire the resources needed to
keep the hardware state active.

Finally, add drm_atomic_sro_can_readout() to verify that all objects on
a device implement the readout hook, and wire it into
drm_atomic_sro_device_can_readout().

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_readout.c | 65 ++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h                   | 49 ++++++++++++++++++++++
 include/drm/drm_bridge.h                   | 47 +++++++++++++++++++++
 include/drm/drm_connector.h                | 50 +++++++++++++++++++++++
 include/drm/drm_crtc.h                     | 55 +++++++++++++++++++++++++
 include/drm/drm_mode_config.h              | 22 ++++++++++
 include/drm/drm_modeset_helper_vtables.h   | 58 ++++++++++++++++++++++++++
 include/drm/drm_plane.h                    | 50 +++++++++++++++++++++++
 8 files changed, 396 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm/drm_atomic_state_readout.c
index dab47fef6672..a9c4e383397a 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout.c
@@ -4,12 +4,14 @@
 #include <drm/drm_atomic_state_readout.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
+#include <drm/drm_vblank.h>
 #include <linux/module.h>
 #include <linux/sched/mm.h>
 
 #include "drm_internal.h"
 #include "drm_crtc_internal.h"
@@ -19,10 +21,67 @@ EXPORT_SYMBOL(drm_atomic_sro_status);
 
 module_param_named_unsafe(atomic_readout, drm_atomic_sro_status, uint, 0400);
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
+	if (!dev->mode_config.helper_private ||
+	    !dev->mode_config.helper_private->atomic_sro_build_state)
+		return false;
+
+	if (drm_atomic_sro_status == DRM_ATOMIC_SRO_SKIP_MISSING_READOUT)
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
+			drm_connector_list_iter_end(&conn_iter);
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
@@ -33,16 +92,22 @@ MODULE_PARM_DESC(atomic_readout,
  * True if the device supports full hardware state readout, false
  * otherwise.
  */
 bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
 {
+	bool ret;
+
 	if (!drm_drv_uses_atomic_modeset(dev))
 		return false;
 
 	if (drm_atomic_sro_status == DRM_ATOMIC_SRO_DISABLED)
 		return false;
 
+	ret = drm_atomic_sro_can_readout(dev);
+	if (!ret)
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL(drm_atomic_sro_device_can_readout);
 
 static unsigned int max_connector_index(struct drm_device *dev)
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 6babffaa7733..f82e24fce7dc 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -312,10 +312,59 @@ struct drm_private_state_funcs {
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
+	 * Drivers are expected to return a negative error code if the
+	 * hardware was programmed with a configuration they don't
+	 * support. The framework will then abort the readout and fall
+	 * back to the regular initialization path.
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
+	/**
+	 * @atomic_sro_install_state:
+	 *
+	 * This optional hook is called when a state read out from
+	 * hardware is about to be installed as the private object's
+	 * current state.
+	 *
+	 * It allows drivers to acquire the resources needed to keep
+	 * the current hardware state active, such as power domains,
+	 * clocks, or interrupts.
+	 *
+	 * This hook cannot fail. It is called by the
+	 * &drm_mode_config_helper_funcs.atomic_sro_install_state
+	 * implementation, which is part of the hardware state readout
+	 * initialization sequence.
+	 */
+	void (*atomic_sro_install_state)(struct drm_private_obj *obj,
+					 struct drm_private_state *obj_state);
+
 	/**
 	 * @atomic_print_state:
 	 *
 	 * If driver subclasses &struct drm_private_state, it should implement
 	 * this optional hook for printing additional driver specific state.
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index a22a0bdf3251..ab0a6c03c8dd 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -278,10 +278,57 @@ struct drm_bridge_funcs {
 	 * The @atomic_post_disable callback is optional.
 	 */
 	void (*atomic_post_disable)(struct drm_bridge *bridge,
 				    struct drm_atomic_commit *state);
 
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
+	 * The bridges of a chain are read out from the first one to the
+	 * last one, so the state of the previous bridge, including its
+	 * &drm_bridge_state.output_bus_cfg, is available, but the state
+	 * of the next one isn't. This is the opposite of the order used
+	 * by the bus format negotiation and the bus flags propagation
+	 * during an atomic check. Implementations are expected to
+	 * reconstruct @bridge_state.input_bus_cfg and
+	 * @bridge_state.output_bus_cfg so that they match what the atomic
+	 * check would have computed. See
+	 * drm_atomic_helper_bridge_compare_state() for the details.
+	 *
+	 * Drivers are expected to return a negative error code if the
+	 * hardware was programmed with a configuration they don't
+	 * support. The framework will then abort the readout and fall
+	 * back to the regular initialization path.
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
index 2f9dd780809f..159767ecf202 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -33,10 +33,11 @@
 #include <drm/drm_util.h>
 #include <drm/drm_property.h>
 
 #include <uapi/drm/drm_mode.h>
 
+struct drm_atomic_sro_state;
 struct drm_connector_helper_funcs;
 struct drm_modeset_acquire_ctx;
 struct drm_device;
 struct drm_crtc;
 struct drm_display_mode;
@@ -1811,10 +1812,59 @@ struct drm_connector_funcs {
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
+	 * Drivers are expected to return a negative error code if the
+	 * hardware was programmed with a configuration they don't
+	 * support. The framework will then abort the readout and fall
+	 * back to the regular initialization path.
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
+	/**
+	 * @atomic_sro_install_state:
+	 *
+	 * This optional hook is called when a state read out from
+	 * hardware is about to be installed as the connector's current
+	 * state.
+	 *
+	 * It allows drivers to acquire the resources needed to keep
+	 * the current hardware state active, such as power domains,
+	 * clocks, or interrupts.
+	 *
+	 * This hook cannot fail. It is called by the
+	 * &drm_mode_config_helper_funcs.atomic_sro_install_state
+	 * implementation, which is part of the hardware state readout
+	 * initialization sequence.
+	 */
+	void (*atomic_sro_install_state)(struct drm_connector *conn,
+					 struct drm_connector_state *conn_state);
+
 	/**
 	 * @atomic_duplicate_state:
 	 *
 	 * Duplicate the current atomic state for this connector and return it.
 	 * The core and helpers guarantee that any atomic state duplicated with
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index be5dca538d87..2def0b58a10d 100644
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
@@ -640,10 +641,64 @@ struct drm_crtc_funcs {
 	 * A new, pristine, CRTC state instance or an error pointer
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
+	 * Drivers are expected to return a negative error code if the
+	 * hardware was programmed with a configuration they don't
+	 * support. The framework will then abort the readout and fall
+	 * back to the regular initialization path.
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
+	/**
+	 * @atomic_sro_install_state:
+	 *
+	 * This optional hook is called when a state read out from
+	 * hardware is about to be installed as the CRTC's current
+	 * state.
+	 *
+	 * It allows drivers to acquire the resources needed to keep
+	 * the current hardware state active, such as power domains,
+	 * clocks, or interrupts.
+	 *
+	 * The vblank state of the CRTC has been reset with
+	 * drm_crtc_vblank_reset() when this hook is called. Drivers
+	 * supporting vblank should call drm_crtc_vblank_on() from it
+	 * for the active CRTCs they take over.
+	 *
+	 * This hook cannot fail. It is called by the
+	 * &drm_mode_config_helper_funcs.atomic_sro_install_state
+	 * implementation, which is part of the hardware state readout
+	 * initialization sequence.
+	 */
+	void (*atomic_sro_install_state)(struct drm_crtc *crtc,
+					 struct drm_crtc_state *crtc_state);
+
 	/**
 	 * @atomic_duplicate_state:
 	 *
 	 * Duplicate the current atomic state for this CRTC and return it.
 	 * The core and helpers guarantee that any atomic state duplicated with
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 084517beb924..dd555f8727ad 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -319,10 +319,32 @@ struct drm_mode_config_funcs {
 	 *
 	 * Subclassing of &drm_atomic_commit is deprecated in favour of using
 	 * &drm_private_state and &drm_private_obj.
 	 */
 	void (*atomic_state_free)(struct drm_atomic_commit *state);
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
+	 * If the readout fails, for example because the hardware was
+	 * programmed with a configuration the driver doesn't support,
+	 * the state initialization will fall back to the regular path.
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
index 0fdba3eded28..69f52f75b5e8 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1595,8 +1595,66 @@ struct drm_mode_config_helper_funcs {
 	 * how one should implement this.
 	 *
 	 * This hook is optional.
 	 */
 	int (*atomic_commit_setup)(struct drm_atomic_commit *state);
+
+	/**
+	 * @atomic_sro_build_state:
+	 *
+	 * Builds a &struct drm_atomic_sro_state from the current hardware
+	 * state by calling the atomic_sro_readout_state hooks on the KMS
+	 * objects to read out.
+	 *
+	 * This hook is called both at initialization time, to create the
+	 * initial state from what the firmware programmed, and after
+	 * blocking commits, to read back the hardware state and compare it
+	 * to what was committed.
+	 *
+	 * When @commit is NULL, the state of every object in the device is
+	 * read out, and the caller must hold all the modeset locks, as
+	 * drm_mode_config_create_initial_state() does.
+	 *
+	 * When @commit is not NULL, only the objects that have a state in
+	 * @commit are read out. The caller must hold the locks of the
+	 * objects in @commit through its acquire context, and the readout
+	 * hooks must not access the state of any object outside of the
+	 * commit, since its locks aren't held.
+	 *
+	 * RETURNS:
+	 *
+	 * A &struct drm_atomic_sro_state on success, an error pointer
+	 * otherwise.
+	 */
+	struct drm_atomic_sro_state *
+	(*atomic_sro_build_state)(struct drm_device *dev,
+				  struct drm_atomic_commit *commit);
+
+	/**
+	 * @atomic_sro_install_state:
+	 *
+	 * Installs the states of a &struct drm_atomic_sro_state, built
+	 * by @atomic_sro_build_state, as the current state of the KMS
+	 * objects (&drm_crtc.state, &drm_plane.state,
+	 * &drm_connector.state and &drm_private_obj.state).
+	 *
+	 * The implementation takes ownership of the object states it
+	 * installs, and must clear them from @state so that they aren't
+	 * destroyed when @state is freed. It must destroy the state
+	 * previously held by the object, if any, using the
+	 * corresponding atomic_destroy_state hook. Objects without a
+	 * state in @state must be left untouched.
+	 *
+	 * Before replacing the state of an object, the implementation
+	 * is expected to call its atomic_sro_install_state hook, so
+	 * that drivers can acquire the resources needed to keep the
+	 * hardware state active.
+	 *
+	 * This hook cannot fail.
+	 *
+	 * This hook is mandatory for drivers implementing SRO, since
+	 * the read out states are dropped without it.
+	 */
+	void (*atomic_sro_install_state)(struct drm_atomic_sro_state *state);
 };
 
 #endif
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 410d7b02b77a..fe5f778cb636 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -32,10 +32,11 @@
 #include <drm/drm_modeset_lock.h>
 #include <drm/drm_util.h>
 
 enum drm_panic_type;
 
+struct drm_atomic_sro_state;
 struct drm_crtc;
 struct drm_plane_size_hint;
 struct drm_printer;
 struct drm_modeset_acquire_ctx;
 
@@ -392,10 +393,59 @@ struct drm_plane_funcs {
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
+	 * Drivers are expected to return a negative error code if the
+	 * hardware was programmed with a configuration they don't
+	 * support. The framework will then abort the readout and fall
+	 * back to the regular initialization path.
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
+	/**
+	 * @atomic_sro_install_state:
+	 *
+	 * This optional hook is called when a state read out from
+	 * hardware is about to be installed as the plane's current
+	 * state.
+	 *
+	 * It allows drivers to acquire the resources needed to keep
+	 * the current hardware state active, such as power domains,
+	 * clocks, or interrupts.
+	 *
+	 * This hook cannot fail. It is called by the
+	 * &drm_mode_config_helper_funcs.atomic_sro_install_state
+	 * implementation, which is part of the hardware state readout
+	 * initialization sequence.
+	 */
+	void (*atomic_sro_install_state)(struct drm_plane *plane,
+					 struct drm_plane_state *plane_state);
+
 	/**
 	 * @atomic_duplicate_state:
 	 *
 	 * Duplicate the current atomic state for this plane and return it.
 	 * The core and helpers guarantee that any atomic state duplicated with

-- 
2.56.1

