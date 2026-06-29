Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C591DC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5EFE10E764;
	Mon, 29 Jun 2026 08:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YIss4Bli";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA54810E738
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:18:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30F3260121;
 Mon, 29 Jun 2026 08:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666D71F00A3A;
 Mon, 29 Jun 2026 08:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721087;
 bh=/073hmHHShNWj+6yY0tEi1WV7CJ04pPUEzZgLyPmrHQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YIss4BlirQ+QJdGaABOOq8miQx2GoXg+xq0FJeQIt+idKVwWMOGyJh6EnYlM8RxmE
 FSFoiWH6SAJonIx77zl6wkGIiZW+nOrPnb/T2Qdj3O8ruhPna1lLfGpCUHEFUAoD2J
 fGuXYGkOaIVlcv7mZxBJTGe5BhNhJVv2Z9m3B2+nDghE+4mXfh4b2QD6V4u+ugr7xK
 awk3+j83IBl4SMv/NNYzk+kH43sLCA5//tBCiYn2An/wFXZJh+9biDIdPP/GBkovcu
 Ehiq/dDnN3SmwMqKic6FRgLRPowKYhPH4ihb/7tixs2Yvf0AHPjlqqdHDTjHDjiQqj
 4j3GZEAynPVcw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:18 +0200
Subject: [PATCH v4 20/30] drm/atomic_helper: Compare actual and readout
 states once the commit is done
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-20-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=21451; i=mripard@kernel.org;
 h=from:subject:message-id; bh=RbQIPlDgIpMQV8XTY+uOrM1JxE242h5oHWyXjq/jA8k=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWpwdD39fX3L0Z9VMB9HJn740v7B0n7a4XnhOG7enV
 fQq/yT/jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRx9sYG/5Ulus5WKwx1OjY
 Vl212CNflv2KuGSkXzHfUZZ5eyt2avW+K7zKuN7moOaaN2abLnyvZWz4V6du/tQ78t2HOPZb2b2
 cpmLRrdM+bn40wym8nbd4Qc78GtGAslsfAsTqpBP+r6xfMwsA
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

The new atomic state readout infrastructure can be hard to test because
getting access to every firmware variation is hard, but also because
most firmware setup will be pretty basic and won't test a wide range of
features. Noticing whether it was successful or not is also not very
convenient.

In order to make it easier, we can however provide some infrastructure
to read out a new state every time a blocking commit is made, and
compare the readout one with the committed one.

To do so, we introduce a new hook for every state, atomic_compare_state,
that takes two state instances and is supposed to return whether they
are identical or not.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c |  40 +++++++
 drivers/gpu/drm/drm_atomic_sro.c    | 206 +++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/drm_bridge.c        |   3 +-
 include/drm/drm_atomic.h            |  23 ++++
 include/drm/drm_atomic_sro.h        |   4 +
 include/drm/drm_bridge.h            |  25 +++++
 include/drm/drm_connector.h         |  25 +++++
 include/drm/drm_crtc.h              |  25 +++++
 include/drm/drm_plane.h             |  25 +++++
 9 files changed, 374 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 6405afc5037d..3de6f42ea54b 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -30,10 +30,11 @@
 #include <linux/ktime.h>
 #include <linux/media-bus-format.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_sro.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_colorop.h>
 #include <drm/drm_damage_helper.h>
@@ -2085,10 +2086,49 @@ static void commit_tail(struct drm_atomic_commit *state, bool nonblock)
 						 (unsigned long)commit_time_ms,
 						 new_self_refresh_mask);
 
 	drm_atomic_helper_commit_cleanup_done(state);
 
+	/*
+	 * drm_atomic_sro_readout_and_compare() will compare the @state new
+	 * states with whatever it will read from the hardware.
+	 *
+	 * Since drm_atomic_helper_swap_state() has already been called, this
+	 * means that new states have now been installed in their respective
+	 * object state pointer, and their access must be protected by their
+	 * respective locks.
+	 *
+	 * If we're doing a non-blocking commit however, the locks will be
+	 * dropped as soon as we return from drm_atomic_nonblocking_commit()
+	 * through drm_modeset_drop_locks(), while this function will be
+	 * scheduled to execute later on. This means that by the time we get
+	 * here, we probably have dropped the locks that protect the new states
+	 * and it's not safe to access them anymore.
+	 *
+	 * Thus, we can only safely call drm_atomic_sro_readout_and_compare() if
+	 * the commit is blocking, and we still hold all the locks.
+	 *
+	 * The other thing to consider is that it will take time to readout and
+	 * compare all the states, and we don't want to delay fence signalling
+	 * since some other part of the kernel or hardware might be waiting on
+	 * us. Fortunately, the fence is signalled through
+	 * &drm_crtc_commit.flip_done and drm_crtc_send_vblank_event() ->
+	 * drm_send_event_helper() with drm_pending_event.completion being set
+	 * to drm_crtc_commit.flip_done in drm_atomic_helper_setup_commit().
+	 *
+	 * We later wait for flip_done in
+	 * drm_atomic_helper_wait_for_flip_done(), which is typically part of
+	 * drm_mode_config_helper_funcs.atomic_commit_tail, or the equivalent
+	 * drm_atomic_helper_wait_for_vblank() which is part of
+	 * drm_atomic_helper_commit_tail().
+	 *
+	 * Either way, we're past that point here, so we wouldn't delay the
+	 * fence signalling.
+	 */
+	if (!nonblock)
+		drm_atomic_sro_readout_and_compare(state);
+
 	drm_atomic_commit_put(state);
 }
 
 static void commit_work(struct work_struct *work)
 {
diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
index 1243046dbfb0..479dc345cea2 100644
--- a/drivers/gpu/drm/drm_atomic_sro.c
+++ b/drivers/gpu/drm/drm_atomic_sro.c
@@ -22,11 +22,11 @@
  * firmware at boot, rather than programming a new state. This enables
  * flicker-free boot (also called "fastboot" by i915): if the
  * firmware already configured the display, the first userspace
  * modeset can be skipped when the requested mode matches.
  *
- * The SRO lifecycle has two phases. The first phase is the readout
+ * The SRO lifecycle has three phases. The first phase is the readout
  * itself: at driver registration time, each KMS object (CRTCs, planes,
  * connectors, bridges, private objects) has its
  * atomic_sro_readout_state hook called to populate a
  * &struct drm_atomic_sro_state from hardware registers.
  *
@@ -37,10 +37,19 @@
  * atomic_sro_install_state hook on each object. This gives drivers a
  * chance to acquire the resources needed to keep the hardware state
  * active, such as power domains, clocks, or interrupts. This hook
  * cannot fail.
  *
+ * The third phase is the comparison. Because getting access to every
+ * firmware variation is hard, and most firmware setups will be fairly
+ * basic, the framework also provides a way to verify the readout
+ * implementation during normal operation. After every blocking commit,
+ * the framework reads out a fresh state from hardware and compares it
+ * to the committed state using the atomic_sro_compare_state hooks. Any
+ * mismatch is reported, which allows to catch readout bugs without
+ * needing specific firmware configurations.
+ *
  * Drivers integrate with SRO by implementing the readout and compare
  * hooks in their object funcs vtables and setting the
  * &drm_mode_config_funcs.atomic_sro_readout_state and
  * &drm_mode_config_helper_funcs.atomic_sro_build_state callbacks. The
  * default helpers drm_atomic_helper_sro_readout_state() and
@@ -110,10 +119,60 @@ static bool drm_atomic_sro_can_readout(struct drm_device *dev)
 	drm_connector_list_iter_end(&conn_iter);
 
 	return true;
 }
 
+static bool drm_atomic_sro_can_compare(struct drm_device *dev)
+{
+	struct drm_crtc *crtc;
+	struct drm_plane *plane;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+	struct drm_private_obj *privobj;
+
+	if (atomic_readout == DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE ||
+	    atomic_readout == DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT)
+		return true;
+
+	drm_for_each_privobj(privobj, dev) {
+		if (!privobj->funcs->atomic_sro_compare_state) {
+			drm_dbg_atomic(dev,
+				       "Private object %s missing compare callback",
+				       privobj->name);
+			return false;
+		}
+	}
+
+	drm_for_each_plane(plane, dev) {
+		if (!plane->funcs->atomic_sro_compare_state) {
+			drm_dbg_atomic(dev, "Plane %s missing compare callback",
+				       plane->name);
+			return false;
+		}
+	}
+
+	drm_for_each_crtc(crtc, dev) {
+		if (!crtc->funcs->atomic_sro_compare_state) {
+			drm_dbg_atomic(dev, "CRTC %s missing compare callback",
+				       crtc->name);
+			return false;
+		}
+	}
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (!connector->funcs->atomic_sro_compare_state) {
+			drm_dbg_atomic(dev, "Connector %s missing compare callback",
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
@@ -136,10 +195,14 @@ bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
 
 	ret = drm_atomic_sro_can_readout(dev);
 	if (!ret)
 		return false;
 
+	ret = drm_atomic_sro_can_compare(dev);
+	if (!ret)
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL(drm_atomic_sro_device_can_readout);
 
 struct __drm_atomic_sro_plane {
@@ -646,5 +709,146 @@ void drm_atomic_sro_install_state(struct drm_atomic_sro_state *state)
 		state->private_objs[i].ptr = NULL;
 	}
 	state->num_private_objs = 0;
 }
 EXPORT_SYMBOL(drm_atomic_sro_install_state);
+
+/**
+ * drm_atomic_sro_readout_and_compare - verify committed state against hardware
+ * @commit: the atomic commit we just performed
+ *
+ * Reads out a fresh &struct drm_atomic_sro_state from the hardware and
+ * compares it to @commit using the atomic_sro_compare_state hooks. Any
+ * mismatches are reported through the DRM error printer.
+ *
+ * This is called after blocking commits to verify that the readout
+ * implementation is correct.
+ *
+ * RETURNS:
+ *
+ * True if the committed state and the hardware state are identical,
+ * false otherwise.
+ */
+bool drm_atomic_sro_readout_and_compare(struct drm_atomic_commit *commit)
+{
+	struct drm_device *dev = commit->dev;
+	const struct drm_mode_config_helper_funcs *funcs =
+		dev->mode_config.helper_private;
+	struct drm_printer p = drm_err_printer(dev, NULL);
+	struct drm_private_state *new_obj_state;
+	struct drm_private_obj *obj;
+	struct drm_plane_state *new_plane_state;
+	struct drm_plane *plane;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_crtc *crtc;
+	struct drm_connector_state *new_conn_state;
+	struct drm_connector *conn;
+	struct drm_atomic_sro_state *readout_state;
+	unsigned int i;
+	bool identical = true;
+
+	readout_state = funcs->atomic_sro_build_state(dev);
+	if (WARN_ON(IS_ERR(readout_state)))
+		return false;
+
+	for_each_new_plane_in_state(commit, plane, new_plane_state, i) {
+		const struct drm_plane_funcs *plane_funcs =
+			plane->funcs;
+		struct drm_plane_state *readout_plane_state;
+
+		readout_plane_state = drm_atomic_sro_get_plane_state(readout_state, plane);
+		if (!readout_plane_state) {
+			identical = false;
+			continue;
+		}
+
+		if (!plane_funcs->atomic_sro_compare_state)
+			continue;
+
+		if (!plane_funcs->atomic_sro_compare_state(plane,
+							   &p,
+							   new_plane_state,
+							   readout_plane_state)) {
+			drm_warn(dev, "[PLANE:%d:%s] Committed and Readout PLANE state don't match\n",
+				 plane->base.id, plane->name);
+			identical = false;
+			continue;
+		}
+	}
+
+	for_each_new_crtc_in_state(commit, crtc, new_crtc_state, i) {
+		const struct drm_crtc_funcs *crtc_funcs = crtc->funcs;
+		struct drm_crtc_state *readout_crtc_state;
+
+		readout_crtc_state = drm_atomic_sro_get_crtc_state(readout_state, crtc);
+		if (!readout_crtc_state) {
+			identical = false;
+			continue;
+		}
+
+		if (!crtc_funcs->atomic_sro_compare_state)
+			continue;
+
+		if (!crtc_funcs->atomic_sro_compare_state(crtc,
+							  &p,
+							  new_crtc_state,
+							  readout_crtc_state)) {
+			drm_warn(dev, "[CRTC:%d:%s] Committed and Readout CRTC state don't match\n",
+				 crtc->base.id, crtc->name);
+			identical = false;
+			continue;
+		}
+	}
+
+	for_each_new_connector_in_state(commit, conn, new_conn_state, i) {
+		const struct drm_connector_funcs *conn_funcs =
+			conn->funcs;
+		struct drm_connector_state *readout_conn_state;
+
+		readout_conn_state = drm_atomic_sro_get_connector_state(readout_state, conn);
+		if (!readout_conn_state) {
+			identical = false;
+			continue;
+		}
+
+		if (!conn_funcs->atomic_sro_compare_state)
+			continue;
+
+		if (!conn_funcs->atomic_sro_compare_state(conn,
+							  &p,
+							  new_conn_state,
+							  readout_conn_state)) {
+			drm_warn(dev, "[CONNECTOR:%d:%s] Committed and Readout connector state don't match\n",
+				 conn->base.id, conn->name);
+			identical = false;
+			continue;
+		}
+	}
+
+	for_each_new_private_obj_in_state(commit, obj, new_obj_state, i) {
+		const struct drm_private_state_funcs *obj_funcs = obj->funcs;
+		struct drm_private_state *readout_obj_state;
+
+		readout_obj_state = drm_atomic_sro_get_private_obj_state(readout_state, obj);
+		if (!readout_obj_state) {
+			identical = false;
+			continue;
+		}
+
+		if (!obj_funcs->atomic_sro_compare_state)
+			continue;
+
+		if (!obj_funcs->atomic_sro_compare_state(obj,
+							 &p,
+							 new_obj_state,
+							 readout_obj_state)) {
+			drm_warn(dev, "Committed and Readout private object state don't match\n");
+			identical = false;
+			continue;
+		}
+	}
+
+	drm_atomic_sro_state_free(readout_state);
+
+	return identical;
+}
+EXPORT_SYMBOL(drm_atomic_sro_readout_and_compare);
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 6349f202db0b..dbf21508fd37 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -733,11 +733,12 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 			goto err_reset_bridge;
 	}
 
 	if (drm_bridge_is_atomic(bridge)) {
 		if (bridge->funcs &&
-		    bridge->funcs->atomic_sro_readout_state)
+		    bridge->funcs->atomic_sro_readout_state &&
+		    bridge->funcs->atomic_sro_compare_state)
 			drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
 						    &drm_bridge_priv_state_funcs_with_sro);
 		else
 			drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
 						    &drm_bridge_priv_state_funcs);
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 0e5c87f258ef..6e06d0615f62 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -339,10 +339,33 @@ struct drm_private_state_funcs {
 	 * hardware state readout initialization sequence.
 	 */
 	void (*atomic_sro_install_state)(struct drm_private_obj *obj,
 					 struct drm_private_state *obj_state);
 
+	/**
+	 * @atomic_sro_compare_state:
+	 *
+	 * Compares two &struct drm_private_state instances and reports
+	 * any mismatches through @p.
+	 *
+	 * It is called after blocking commits to verify that the
+	 * committed state matches what can be read back from the
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields.
+	 *
+	 * This hook is mandatory for drivers implementing SRO, but can
+	 * be left unassigned otherwise.
+	 *
+	 * RETURNS:
+	 *
+	 * True if the states are identical, false otherwise.
+	 */
+	bool (*atomic_sro_compare_state)(struct drm_private_obj *obj,
+					 struct drm_printer *p,
+					 struct drm_private_state *a,
+					 struct drm_private_state *b);
+
 	/**
 	 * @atomic_print_state:
 	 *
 	 * If driver subclasses &struct drm_private_state, it should implement
 	 * this optional hook for printing additional driver specific state.
diff --git a/include/drm/drm_atomic_sro.h b/include/drm/drm_atomic_sro.h
index 195154850ab4..6529774d9ca8 100644
--- a/include/drm/drm_atomic_sro.h
+++ b/include/drm/drm_atomic_sro.h
@@ -1,10 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #ifndef DRM_ATOMIC_SRO_H_
 #define DRM_ATOMIC_SRO_H_
 
+#include <linux/types.h>
+
+struct drm_atomic_commit;
 struct drm_atomic_sro_state;
 struct drm_connector;
 struct drm_connector_state;
 struct drm_crtc;
 struct drm_crtc_state;
@@ -49,7 +52,8 @@ drm_atomic_sro_get_private_obj_state(struct drm_atomic_sro_state *state,
 void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *state,
 					  struct drm_private_obj *obj,
 					  struct drm_private_state *obj_state);
 
 void drm_atomic_sro_install_state(struct drm_atomic_sro_state *state);
+bool drm_atomic_sro_readout_and_compare(struct drm_atomic_commit *commit);
 
 #endif /* DRM_ATOMIC_SRO_H_ */
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 9f15c9087e58..397218a5ebcf 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -404,10 +404,35 @@ struct drm_bridge_funcs {
 					struct drm_atomic_sro_state *state,
 					struct drm_bridge_state *bridge_state,
 					struct drm_crtc_state *crtc_state,
 					struct drm_connector_state *conn_state);
 
+	/**
+	 * @atomic_sro_compare_state:
+	 *
+	 * Compares two &struct drm_bridge_state instances and reports
+	 * any mismatches through @p.
+	 *
+	 * It is called after blocking commits to verify that the
+	 * committed state matches what can be read back from the
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields, calling
+	 * drm_atomic_helper_bridge_compare_state() first for the base
+	 * state fields.
+	 *
+	 * This hook is mandatory for drivers implementing SRO, but can
+	 * be left unassigned otherwise.
+	 *
+	 * RETURNS:
+	 *
+	 * True if the states are identical, false otherwise.
+	 */
+	bool (*atomic_sro_compare_state)(struct drm_bridge *bridge,
+					 struct drm_printer *p,
+					 struct drm_bridge_state *a,
+					 struct drm_bridge_state *b);
+
 	/**
 	 * @atomic_duplicate_state:
 	 *
 	 * Duplicate the current bridge state object (which is guaranteed to be
 	 * non-NULL).
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 96ac5d472198..9aeead49407e 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1748,10 +1748,35 @@ struct drm_connector_funcs {
 	 * This callback is mandatory for atomic drivers.
 	 */
 	void (*atomic_destroy_state)(struct drm_connector *connector,
 				     struct drm_connector_state *state);
 
+	/**
+	 * @atomic_sro_compare_state:
+	 *
+	 * Compares two &struct drm_connector_state instances and
+	 * reports any mismatches through @p.
+	 *
+	 * It is called after blocking commits to verify that the
+	 * committed state matches what can be read back from the
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields, calling
+	 * drm_atomic_helper_connector_compare_state() first for the
+	 * base state fields.
+	 *
+	 * This hook is mandatory for drivers implementing SRO, but can
+	 * be left unassigned otherwise.
+	 *
+	 * RETURNS:
+	 *
+	 * True if the states are identical, false otherwise.
+	 */
+	bool (*atomic_sro_compare_state)(struct drm_connector *connector,
+					 struct drm_printer *p,
+					 struct drm_connector_state *a,
+					 struct drm_connector_state *b);
+
 	/**
 	 * @atomic_set_property:
 	 *
 	 * Decode a driver-private property value and store the decoded value
 	 * into the passed-in state structure. Since the atomic core decodes all
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 4689a4a68c28..0a2ad007c274 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -740,10 +740,35 @@ struct drm_crtc_funcs {
 	 * This callback is mandatory for atomic drivers.
 	 */
 	void (*atomic_destroy_state)(struct drm_crtc *crtc,
 				     struct drm_crtc_state *state);
 
+	/**
+	 * @atomic_sro_compare_state:
+	 *
+	 * Compares two &struct drm_crtc_state instances and reports
+	 * any mismatches through @p.
+	 *
+	 * It is called after blocking commits to verify that the
+	 * committed state matches what can be read back from the
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields, calling
+	 * drm_atomic_helper_crtc_compare_state() first for the base
+	 * state fields.
+	 *
+	 * This hook is mandatory for drivers implementing SRO, but can
+	 * be left unassigned otherwise.
+	 *
+	 * RETURNS:
+	 *
+	 * True if the states are identical, false otherwise.
+	 */
+	bool (*atomic_sro_compare_state)(struct drm_crtc *crtc,
+					 struct drm_printer *p,
+					 struct drm_crtc_state *a,
+					 struct drm_crtc_state *b);
+
 	/**
 	 * @atomic_set_property:
 	 *
 	 * Decode a driver-private property value and store the decoded value
 	 * into the passed-in state structure. Since the atomic core decodes all
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 358c4f4062b4..15cde65188a4 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -490,10 +490,35 @@ struct drm_plane_funcs {
 	 * This callback is mandatory for atomic drivers.
 	 */
 	void (*atomic_destroy_state)(struct drm_plane *plane,
 				     struct drm_plane_state *state);
 
+	/**
+	 * @atomic_sro_compare_state:
+	 *
+	 * Compares two &struct drm_plane_state instances and reports
+	 * any mismatches through @p.
+	 *
+	 * It is called after blocking commits to verify that the
+	 * committed state matches what can be read back from the
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields, calling
+	 * drm_atomic_helper_plane_compare_state() first for the base
+	 * state fields.
+	 *
+	 * This hook is mandatory for drivers implementing SRO, but can
+	 * be left unassigned otherwise.
+	 *
+	 * RETURNS:
+	 *
+	 * True if the states are identical, false otherwise.
+	 */
+	bool (*atomic_sro_compare_state)(struct drm_plane *plane,
+					 struct drm_printer *p,
+					 struct drm_plane_state *a,
+					 struct drm_plane_state *b);
+
 	/**
 	 * @atomic_set_property:
 	 *
 	 * Decode a driver-private property value and store the decoded value
 	 * into the passed-in state structure. Since the atomic core decodes all

-- 
2.54.0

