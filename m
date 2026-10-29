Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89617606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyNZEvZe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8727410FFDC;
	Thu, 29 Oct 2026 07:35:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5469010FFDE
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:35:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B60E6600D1;
 Thu, 29 Oct 2026 07:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E870B1F01825;
 Thu, 29 Oct 2026 07:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259307;
 bh=qOoBXFiKGCRFTRS0eYb/EGUO5sdPuEsASGyrT9qNxQY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RyNZEvZe5h4NFi+34k333x4F323HSOrutqIwRMdkle+Hab+TU0oIynJNWUhEhZ28b
 lzihAJwI7phYJ8PTSSALU0YW7WldwdUEpI5IIr4MJ1j/VgQY9J8bVK14PujsclTgKD
 Lt41qxDIl6xZOMaJhD5gcOzjCDQ/paA0Yc6iQVT8Ea+LZ6TWFqJRUDQu3uWmNdhAxm
 /nND6eb/b6fwNKSlVuIVqFVz0vyd72E07B5/5WMaV/IsZr/0MfWXxOQxqUqKjJ89qD
 YnG9P/K/8VGRYF4k+jB1kt/qKiOO8+P3/K4qxzevWD1ej0V/e6oXUMw+le+aYUXVkS
 hprMTVWiNqO7A==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:34:02 +0100
Subject: [PATCH v7 12/34] drm/atomic_sro: Add atomic state readout
 infrastructure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-12-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
In-Reply-To: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14648; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QEoXCIGtXYgaN5he9+i3WjJ61Y6ZKQRz2OsdQdsPUf4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvn1ae35F66vc+O/vL9/6fPykaKqmmpCc5tK0OO5pI
 UfXB6R7dkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJsB9krHfSYmf9IDR1A28C
 e3T7DkU7qX9iz/wPNGQ+NWZSrfq13rPhUN69lU+n8rtKvdPyeVgUw9hw1/Pc9POnaucnbuF6UZu
 wUCWpNWNC6hvzPbczsiUrn/2qmTdrvrFd2S8XnxnNljltfm4A
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

Finally, add drm_atomic_sro_can_readout() to verify that all objects on
a device implement the readout hook, and wire it into
drm_atomic_sro_device_can_readout().

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_readout.c | 64 ++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h                   | 30 ++++++++++++++
 include/drm/drm_bridge.h                   | 36 +++++++++++++++++
 include/drm/drm_connector.h                | 31 +++++++++++++++
 include/drm/drm_crtc.h                     | 31 +++++++++++++++
 include/drm/drm_mode_config.h              | 22 ++++++++++
 include/drm/drm_modeset_helper_vtables.h   | 31 +++++++++++++++
 include/drm/drm_plane.h                    | 31 +++++++++++++++
 8 files changed, 276 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm/drm_atomic_state_readout.c
index e93b0e4f0839..de40e7e2231c 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout.c
@@ -7,4 +7,5 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
@@ -27,4 +28,61 @@ MODULE_PARM_DESC(atomic_readout,
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
@@ -41,4 +99,6 @@ MODULE_PARM_DESC(atomic_readout,
 bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
 {
+	bool ret;
+
 	if (!drm_drv_uses_atomic_modeset(dev))
 		return false;
@@ -47,4 +107,8 @@ bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
 		return false;
 
+	ret = drm_atomic_sro_can_readout(dev);
+	if (!ret)
+		return false;
+
 	return true;
 }
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 87f85a77e5f3..42923f960b30 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -315,4 +315,34 @@ struct drm_private_state_funcs {
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
 	/**
 	 * @atomic_print_state:
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index a22a0bdf3251..ef044ad27d2c 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -281,4 +281,40 @@ struct drm_bridge_funcs {
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
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f656ed8324d3..f70b3aff259d 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -36,4 +36,5 @@
 #include <uapi/drm/drm_mode.h>
 
+struct drm_atomic_sro_state;
 struct drm_connector_helper_funcs;
 struct drm_modeset_acquire_ctx;
@@ -1814,4 +1815,34 @@ struct drm_connector_funcs {
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
 	/**
 	 * @atomic_duplicate_state:
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index be5dca538d87..52365638b06f 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -36,4 +36,5 @@
 #include <drm/drm_mode_config.h>
 
+struct drm_atomic_sro_state;
 struct drm_connector;
 struct drm_device;
@@ -643,4 +644,34 @@ struct drm_crtc_funcs {
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
 	/**
 	 * @atomic_duplicate_state:
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 084517beb924..dd555f8727ad 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -322,4 +322,26 @@ struct drm_mode_config_funcs {
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
 
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 60b30cc26940..6858f0052637 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1598,4 +1598,35 @@ struct drm_mode_config_helper_funcs {
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
 };
 
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 410d7b02b77a..d16dc057adf6 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -35,4 +35,5 @@
 enum drm_panic_type;
 
+struct drm_atomic_sro_state;
 struct drm_crtc;
 struct drm_plane_size_hint;
@@ -395,4 +396,34 @@ struct drm_plane_funcs {
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
 	/**
 	 * @atomic_duplicate_state:

-- 
2.55.0

