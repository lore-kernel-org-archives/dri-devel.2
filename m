Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B78C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C03510E803;
	Mon,  7 Sep 2026 13:25:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vo4KJqLR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F2E810E803
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:25:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E159043F48;
 Mon,  7 Sep 2026 13:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423D91F00A3D;
 Mon,  7 Sep 2026 13:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787501;
 bh=qi3mWXDf3NUMWMP9sZe5HvJ/x3+/gecVeUkNgS/ZHrk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Vo4KJqLRF6ByKQk6MAuQV8FLfve6h7YJoAFKnqDSV0/UIhBJ/eU/FJ9dfBOLfqzjV
 sj14vGA8ov/a3LyL4jN3tcblFi1nvjnOn3qNmttu4G4SQZwtgbbrs9YJjT0bXtn+2E
 c554scynT5pYu1t3E0PR4sIee4LjGtrmAD0VBRj59gB3dIyByKDNbG8VksrHGx2GXU
 bWNfewQAy+qXdig+LUq1KAExw6dNBJcn9OLeJ282gnFdISTIVkUHLb6w+2xU1SsI9M
 1IGcR6ohSfwYXCmXtbf7kZTzvIJudjiu/DWmT3WPx6d8l8ealCzEiKpytrbuzokglj
 nJko8TJ9+mU0A==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:23:52 +0200
Subject: [PATCH v5 16/33] drm/atomic_sro: Provide helpers to implement
 hardware state readout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-16-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=17232; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Z2+seukig7b3qVYg7dDc5sKwbQKKqZEGJ4AYSHBRGmQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdj15VOazmTGHX6ZUw3nNSneOqOuOcZ7B+fFXWQ83H
 331KMa0YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkbRdjrcgm2R8+s65dEi1h
 k1pk1n+G++MKXzbZTwdYHO1/J6rbWrr1frjvsKxPKK5i94zGYK6djA3zZm3ydL0vtaXo6ufJ558
 s4Z9fu+Lnq64Qp/tq8VJT97Kbb39+iNt4uZ+mZYztFqPk5UsB
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

Drivers implementing SRO need to iterate over their KMS objects,
allocate a pristine state for each, call the readout hook, and store
the result in the SRO state container.

Provide helpers for each object type
(drm_atomic_helper_sro_readout_planes_state(),
drm_atomic_helper_sro_readout_crtcs_state(), etc.) and a top-level
drm_atomic_helper_sro_build_state() that calls them in sequence.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/gpu/drm-kms-helpers.rst    |   9 +
 drivers/gpu/drm/Makefile                 |   1 +
 drivers/gpu/drm/drm_atomic_sro.c         |   5 +-
 drivers/gpu/drm/drm_atomic_sro_helper.c  | 409 +++++++++++++++++++++++++++++++
 include/drm/drm_atomic_sro_helper.h      |  28 +++
 include/drm/drm_modeset_helper_vtables.h |   3 +
 6 files changed, 454 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index 418637887fc8..46e6dd04768f 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -97,10 +97,19 @@ Atomic State Read-Out Reference
    :internal:
 
 .. kernel-doc:: drivers/gpu/drm/drm_atomic_sro.c
    :export:
 
+Atomic State Read-Out Helpers Reference
+----------------------------------------
+
+.. kernel-doc:: include/drm/drm_atomic_sro_helper.h
+   :internal:
+
+.. kernel-doc:: drivers/gpu/drm/drm_atomic_sro_helper.c
+   :export:
+
 GEM Atomic Helper Reference
 ---------------------------
 
 .. kernel-doc:: drivers/gpu/drm/drm_gem_atomic_helper.c
    :doc: overview
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e59a3d9af3e4..c7f5867a6dbe 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -140,10 +140,11 @@ obj-$(CONFIG_DRM_TTM_HELPER) += drm_ttm_helper.o
 # Modesetting helpers
 #
 
 drm_kms_helper-y := \
 	drm_atomic_helper.o \
+	drm_atomic_sro_helper.o \
 	drm_atomic_state_helper.o \
 	drm_bridge_helper.o \
 	drm_crtc_helper.o \
 	drm_damage_helper.o \
 	drm_flip_work.o \
diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
index 6cd002e857d9..15ecf88714fa 100644
--- a/drivers/gpu/drm/drm_atomic_sro.c
+++ b/drivers/gpu/drm/drm_atomic_sro.c
@@ -40,11 +40,14 @@
  * cannot fail.
  *
  * Drivers integrate with SRO by implementing the readout hooks in their
  * object funcs vtables and setting the
  * &drm_mode_config_funcs.atomic_sro_readout_state and
- * &drm_mode_config_helper_funcs.atomic_sro_build_state callbacks.
+ * &drm_mode_config_helper_funcs.atomic_sro_build_state callbacks. The
+ * default helpers drm_atomic_helper_sro_readout_state() and
+ * drm_atomic_helper_sro_build_state() handle the standard readout
+ * sequence.
  */
 
 enum drm_atomic_readout_status {
 	DRM_ATOMIC_READOUT_DISABLED = 0,
 	DRM_ATOMIC_READOUT_ENABLED,
diff --git a/drivers/gpu/drm/drm_atomic_sro_helper.c b/drivers/gpu/drm/drm_atomic_sro_helper.c
new file mode 100644
index 000000000000..50d1af53bfc2
--- /dev/null
+++ b/drivers/gpu/drm/drm_atomic_sro_helper.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_sro.h>
+#include <drm/drm_atomic_sro_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_print.h>
+
+#include <linux/gfp.h>
+#include <linux/sched/mm.h>
+
+/**
+ * drm_atomic_helper_sro_readout_planes_state - read out all plane states from hardware
+ * @dev: DRM device
+ * @state: SRO state container to fill
+ *
+ * Iterates over all planes, allocates a state for each via
+ * atomic_create_state, and calls the plane's
+ * atomic_sro_readout_state hook to fill it from hardware.
+ *
+ * RETURNS:
+ *
+ * 0 on success, a negative error code otherwise.
+ */
+int
+drm_atomic_helper_sro_readout_planes_state(struct drm_device *dev,
+					   struct drm_atomic_sro_state *state)
+{
+	struct drm_plane *plane;
+
+	might_alloc(GFP_KERNEL);
+
+	drm_for_each_plane(plane, dev) {
+		const struct drm_plane_funcs *plane_funcs = plane->funcs;
+		struct drm_plane_state *plane_state;
+		int ret;
+
+		if (!plane_funcs->atomic_sro_readout_state) {
+			drm_warn(dev, "No plane readout implementation.");
+			continue;
+		}
+
+		drm_dbg_kms(dev, "Initializing Plane %s state.\n", plane->name);
+
+		plane_state = plane_funcs->atomic_create_state(plane);
+		if (drm_WARN_ON(dev, IS_ERR(plane_state)))
+			return PTR_ERR(plane_state);
+
+		ret = plane_funcs->atomic_sro_readout_state(plane, state,
+							    plane_state);
+		if (drm_WARN_ON(dev, ret)) {
+			plane_funcs->atomic_destroy_state(plane, plane_state);
+			return ret;
+		}
+
+		drm_atomic_sro_set_plane_state(state, plane, plane_state);
+	}
+
+	return 0;
+}
+
+/**
+ * drm_atomic_helper_sro_readout_crtcs_state - read out all CRTC states from hardware
+ * @dev: DRM device
+ * @state: SRO state container to fill
+ *
+ * Iterates over all CRTCs, allocates a state for each via
+ * atomic_create_state, and calls the CRTC's
+ * atomic_sro_readout_state hook to fill it from hardware.
+ *
+ * RETURNS:
+ *
+ * 0 on success, a negative error code otherwise.
+ */
+int
+drm_atomic_helper_sro_readout_crtcs_state(struct drm_device *dev,
+					  struct drm_atomic_sro_state *state)
+{
+	struct drm_crtc *crtc;
+
+	might_alloc(GFP_KERNEL);
+
+	drm_for_each_crtc(crtc, dev) {
+		const struct drm_crtc_funcs *crtc_funcs = crtc->funcs;
+		struct drm_crtc_state *crtc_state;
+		int ret;
+
+		if (!crtc_funcs->atomic_sro_readout_state) {
+			drm_warn(dev, "No CRTC readout implementation.");
+			continue;
+		}
+
+		drm_dbg_kms(dev, "Initializing CRTC %s state.\n", crtc->name);
+
+		crtc_state = crtc_funcs->atomic_create_state(crtc);
+		if (drm_WARN_ON(dev, IS_ERR(crtc_state)))
+			return PTR_ERR(crtc_state);
+
+		ret = crtc_funcs->atomic_sro_readout_state(crtc, state,
+							   crtc_state);
+		if (drm_WARN_ON(dev, ret)) {
+			crtc_funcs->atomic_destroy_state(crtc, crtc_state);
+			return ret;
+		}
+
+		drm_atomic_sro_set_crtc_state(state, crtc, crtc_state);
+	}
+
+	return 0;
+}
+
+/**
+ * drm_atomic_helper_sro_readout_connectors_state - read out all connector states from hardware
+ * @dev: DRM device
+ * @state: SRO state container to fill
+ *
+ * Iterates over all connectors, allocates a state for each via
+ * atomic_create_state, and calls the connector's
+ * atomic_sro_readout_state hook to fill it from hardware.
+ *
+ * RETURNS:
+ *
+ * 0 on success, a negative error code otherwise.
+ */
+int
+drm_atomic_helper_sro_readout_connectors_state(struct drm_device *dev,
+					       struct drm_atomic_sro_state *state)
+{
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *connector;
+
+	might_alloc(GFP_KERNEL);
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		const struct drm_connector_funcs *conn_funcs = connector->funcs;
+		struct drm_connector_state *conn_state;
+		int ret;
+
+		if (!conn_funcs->atomic_sro_readout_state) {
+			drm_warn(dev, "No Connector readout implementation.");
+			continue;
+		}
+
+		drm_dbg_kms(dev, "Initializing Connector %s state.\n", connector->name);
+
+		conn_state = conn_funcs->atomic_create_state(connector);
+		if (drm_WARN_ON(dev, IS_ERR(conn_state))) {
+			drm_connector_list_iter_end(&conn_iter);
+			return PTR_ERR(conn_state);
+		}
+
+		ret = conn_funcs->atomic_sro_readout_state(connector, state,
+							   conn_state);
+		if (drm_WARN_ON(dev, ret)) {
+			conn_funcs->atomic_destroy_state(connector, conn_state);
+			drm_connector_list_iter_end(&conn_iter);
+			return ret;
+		}
+
+		drm_atomic_sro_set_connector_state(state, connector, conn_state);
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+
+	return 0;
+}
+
+/**
+ * drm_atomic_helper_sro_readout_bridges_state - read out all bridge states from hardware
+ * @dev: DRM device
+ * @state: SRO state container to fill
+ *
+ * Iterates over all encoders and their bridge chains, allocates a state
+ * for each bridge via atomic_create_state, and calls the bridge's
+ * atomic_sro_readout_state hook to fill it from hardware.
+ *
+ * Bridges are handled separately from other private objects because
+ * bridge registration does not guarantee ordering. Traversing the
+ * encoder bridge chains ensures each bridge can query the state of
+ * preceding bridges in its chain.
+ *
+ * RETURNS:
+ *
+ * 0 on success, a negative error code otherwise.
+ */
+int
+drm_atomic_helper_sro_readout_bridges_state(struct drm_device *dev,
+					    struct drm_atomic_sro_state *state)
+{
+	struct drm_encoder *encoder;
+
+	might_alloc(GFP_KERNEL);
+
+	/*
+	 * It works a bit differently for bridges. Indeed they rely on a
+	 * drm_private_obj and drm_private_state, but bridge
+	 * registration doesn't guarantee ordering.
+	 *
+	 * In order for each bridge callback to be able to query the
+	 * previous bridge state, we thus need to read out the bridge
+	 * state by looking at each encoder and then traversing its
+	 * bridge list.
+	 *
+	 * And we'll then readout all the non-bridge drm_private_obj
+	 * later.
+	 */
+	drm_for_each_encoder(encoder, dev) {
+		struct drm_bridge *bridge;
+		int ret;
+
+		list_for_each_entry(bridge, &encoder->bridge_chain, chain_node) {
+			struct drm_private_obj *bridge_obj = &bridge->base;
+			const struct drm_private_state_funcs *bridge_obj_funcs =
+				bridge_obj->funcs;
+			struct drm_private_state *bridge_obj_state;
+
+			if (!bridge_obj_funcs->atomic_sro_readout_state) {
+				drm_warn(dev,
+					 "No bridge %s readout implementation.",
+					 bridge->name);
+				continue;
+			}
+
+			drm_dbg_kms(dev, "Initializing Bridge %s", bridge->name);
+
+			bridge_obj_state =
+				bridge_obj_funcs->atomic_create_state(
+					bridge_obj);
+			if (drm_WARN_ON(dev, IS_ERR(bridge_obj_state)))
+				return PTR_ERR(bridge_obj_state);
+
+			ret = bridge_obj_funcs->atomic_sro_readout_state(
+				bridge_obj, state, bridge_obj_state);
+			if (drm_WARN_ON(dev, ret)) {
+				bridge_obj_funcs->atomic_destroy_state(
+					bridge_obj, bridge_obj_state);
+				return ret;
+			}
+
+			drm_atomic_sro_set_private_obj_state(state, bridge_obj,
+							     bridge_obj_state);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * drm_atomic_helper_sro_readout_private_objs_state - read out non-bridge private object states
+ * @dev: DRM device
+ * @state: SRO state container to fill
+ *
+ * Iterates over all private objects that are not bridges (bridges are
+ * handled by drm_atomic_helper_sro_readout_bridges_state()), allocates
+ * a state for each via atomic_create_state, and calls the object's
+ * atomic_sro_readout_state hook to fill it from hardware.
+ *
+ * RETURNS:
+ *
+ * 0 on success, a negative error code otherwise.
+ */
+int
+drm_atomic_helper_sro_readout_private_objs_state(struct drm_device *dev,
+						 struct drm_atomic_sro_state *state)
+{
+	struct drm_private_obj *privobj;
+
+	might_alloc(GFP_KERNEL);
+
+	drm_for_each_privobj(privobj, dev) {
+		const struct drm_private_state_funcs *priv_funcs =
+			privobj->funcs;
+		struct drm_private_state *priv_state;
+		int ret;
+
+		/*
+		 * We already accounted readout the bridge state earlier, we only
+		 * have to deal with !bridges drm_private_obj now.
+		 */
+		if (drm_private_obj_is_bridge(privobj))
+			continue;
+
+		if (!priv_funcs->atomic_sro_readout_state) {
+			drm_warn(dev,
+				 "No private object %s readout implementation.",
+				 privobj->name);
+			continue;
+		}
+
+		drm_dbg_kms(dev, "Initializing Private Object %s",
+			    privobj->name);
+
+		priv_state = priv_funcs->atomic_create_state(privobj);
+		if (drm_WARN_ON(dev, IS_ERR(priv_state)))
+			return PTR_ERR(priv_state);
+
+		ret = priv_funcs->atomic_sro_readout_state(privobj, state,
+							   priv_state);
+		if (drm_WARN_ON(dev, ret)) {
+			priv_funcs->atomic_destroy_state(privobj, priv_state);
+			return ret;
+		}
+
+		drm_atomic_sro_set_private_obj_state(state, privobj,
+						     priv_state);
+	}
+
+	return 0;
+}
+
+/**
+ * drm_atomic_helper_sro_build_state - build an SRO state from hardware
+ * @dev: DRM device to build the state for
+ *
+ * Allocates a &struct drm_atomic_sro_state and calls the readout hooks
+ * for CRTCs, planes, connectors, bridges, and private objects in
+ * sequence to fill it from the current hardware state.
+ *
+ * This is the default implementation for
+ * &drm_mode_config_helper_funcs.atomic_sro_build_state.
+ *
+ * RETURNS:
+ *
+ * A &struct drm_atomic_sro_state on success, an error pointer otherwise.
+ */
+struct drm_atomic_sro_state *
+drm_atomic_helper_sro_build_state(struct drm_device *dev)
+{
+	struct drm_atomic_sro_state *state;
+	struct drm_printer p = drm_dbg_printer(dev, DRM_UT_ATOMIC, NULL);
+	int ret;
+
+	drm_dbg_kms(dev, "Starting to build atomic state from hardware state.\n");
+
+	state = drm_atomic_sro_state_alloc(dev);
+	if (drm_WARN_ON(dev, IS_ERR(state)))
+		return ERR_PTR(-ENOMEM);
+
+	ret = drm_atomic_helper_sro_readout_crtcs_state(dev, state);
+	if (ret)
+		goto err_state_free;
+
+	ret = drm_atomic_helper_sro_readout_planes_state(dev, state);
+	if (ret)
+		goto err_state_free;
+
+	ret = drm_atomic_helper_sro_readout_connectors_state(dev, state);
+	if (ret)
+		goto err_state_free;
+
+	ret = drm_atomic_helper_sro_readout_bridges_state(dev, state);
+	if (ret)
+		goto err_state_free;
+
+	ret = drm_atomic_helper_sro_readout_private_objs_state(dev, state);
+	if (ret)
+		goto err_state_free;
+
+	drm_atomic_sro_state_print(state, &p);
+
+	return state;
+
+err_state_free:
+	drm_atomic_sro_state_free(state);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(drm_atomic_helper_sro_build_state);
+
+/**
+ * drm_atomic_helper_sro_readout_state - default &drm_mode_config_funcs.atomic_sro_readout_state implementation
+ * @dev: DRM device to read out state for
+ *
+ * Checks if the device supports hardware state readout, builds the SRO
+ * state via &drm_mode_config_helper_funcs.atomic_sro_build_state,
+ * installs it as the current state of all DRM objects, and frees the
+ * SRO container.
+ *
+ * RETURNS:
+ *
+ * 0 on success, -ENOTSUPP if the device does not support readout, a
+ * negative error code otherwise.
+ */
+int drm_atomic_helper_sro_readout_state(struct drm_device *dev)
+{
+	const struct drm_mode_config_helper_funcs *funcs =
+		dev->mode_config.helper_private;
+	struct drm_atomic_sro_state *state;
+
+	if (!drm_atomic_sro_device_can_readout(dev)) {
+		drm_info(dev, "Device doesn't support hardware state readout.");
+		return -ENOTSUPP;
+	}
+
+	state = funcs->atomic_sro_build_state(dev);
+	if (IS_ERR(state))
+		return PTR_ERR(state);
+
+	drm_atomic_sro_install_state(state);
+	drm_atomic_sro_state_free(state);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_helper_sro_readout_state);
diff --git a/include/drm/drm_atomic_sro_helper.h b/include/drm/drm_atomic_sro_helper.h
new file mode 100644
index 000000000000..a42ed8136a49
--- /dev/null
+++ b/include/drm/drm_atomic_sro_helper.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef DRM_ATOMIC_SRO_HELPER_H_
+#define DRM_ATOMIC_SRO_HELPER_H_
+
+struct drm_atomic_sro_state;
+struct drm_device;
+
+int
+drm_atomic_helper_sro_readout_planes_state(struct drm_device *dev,
+					   struct drm_atomic_sro_state *state);
+int
+drm_atomic_helper_sro_readout_crtcs_state(struct drm_device *dev,
+					  struct drm_atomic_sro_state *state);
+int
+drm_atomic_helper_sro_readout_connectors_state(struct drm_device *dev,
+					       struct drm_atomic_sro_state *state);
+int
+drm_atomic_helper_sro_readout_bridges_state(struct drm_device *dev,
+					    struct drm_atomic_sro_state *state);
+int
+drm_atomic_helper_sro_readout_private_objs_state(struct drm_device *dev,
+						 struct drm_atomic_sro_state *state);
+struct drm_atomic_sro_state *
+drm_atomic_helper_sro_build_state(struct drm_device *dev);
+int drm_atomic_helper_sro_readout_state(struct drm_device *dev);
+
+#endif /* DRM_ATOMIC_SRO_HELPER_H_ */
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 807e9ac8539f..38d8f15594c2 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1577,10 +1577,13 @@ struct drm_mode_config_helper_funcs {
 	 * This hook is called both at initialization time, to create
 	 * the initial state from what the firmware programmed, and
 	 * after blocking commits, to read back the hardware state and
 	 * compare it to what was committed.
 	 *
+	 * The default implementation is
+	 * drm_atomic_helper_sro_build_state().
+	 *
 	 * RETURNS:
 	 *
 	 * A &struct drm_atomic_sro_state on success, an error pointer
 	 * otherwise.
 	 */

-- 
2.55.0

