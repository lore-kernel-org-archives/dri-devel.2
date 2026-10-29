Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F8606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ut3AcyrX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91BA310E794;
	Thu, 29 Oct 2026 07:36:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5F2810FFDE
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:35:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D5253601F8;
 Thu, 29 Oct 2026 07:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC2C1F01825;
 Thu, 29 Oct 2026 07:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259336;
 bh=xDX3wYmOY8oF0mVlO8BKdfDUarhDTHxmEyRfkymLL34=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ut3AcyrXkL+N5x+4vYMFR4CZmUPgL//aP7j0pdNigUWWC493TeqMpS8Kv+F2uA2v5
 jH82jzcCE9iqZj8IP+eklAYCrQ93sE3WKYZfGTUiWSnf7Ua7CHMPV8PbiP+Fx3QlhD
 Q1cX30Z3o5GXu+KTuNgTNuUEt/C4SEQEfUjDCBEWUN6lDog0T5u/eJk9RGwzImyMRb
 +u308cWxyKJP6eVZdlxnrOD7n4qKLWUhho68vsymLxJV70r02SmL4s4hvsbjooDSTL
 jbSfxqSfBaVtbm3esjd+vdbJBZ+hn672yhDOe2b9kD3XiQp/DJPGjx+sOX+pHpGUQo
 EM/WM3jyJYvZw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:34:10 +0100
Subject: [PATCH v7 20/34] drm/atomic_helper: Compare actual and readout
 states once the commit is done
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-20-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18633; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NALao4DSI1KVixU50I6JrgMo8sZq5sIlVTKsC0fB7qg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvn3dYtj+9fOJO8vtfVdb/j8VXu9cE5VawHHx3UtjQ
 Yf7Z9SOdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJnFrHWGf0a/mvtccFW1dM
 3n43SXz+hkqdDRIcbiqPvh+V4Fz5Xm9Ref3vkmaGgl9Zr/edNrj/bRpjw3YLdZErtsHv9kRPyr0
 wO7vslW5yMEvrQn3zM49012qKZ5wsyf6l65vvO+/oAQfvsD/CAA==
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

The new atomic state readout infrastructure can be hard to test because
getting access to every firmware variation is hard, but also because
most firmware setup will be pretty basic and won't test a wide range of
features. Noticing whether it was successful or not is also not very
convenient.

In order to make it easier, we can however provide some infrastructure
to read out a new state every time a blocking commit is made, and
compare the readout one with the committed one.

To do so, we introduce a new hook for every state,
atomic_sro_compare_state, that takes two state instances and is supposed
to return whether they are identical or not.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c        |  45 ++++++
 drivers/gpu/drm/drm_atomic_state_readout.c | 223 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/drm_bridge.c               |   3 +-
 include/drm/drm_atomic.h                   |  23 +++
 include/drm/drm_atomic_state_readout.h     |   4 +
 include/drm/drm_bridge.h                   |  22 +++
 include/drm/drm_connector.h                |  22 +++
 include/drm/drm_crtc.h                     |  22 +++
 include/drm/drm_plane.h                    |  22 +++
 9 files changed, 382 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 9d006f98413a..412864b22db6 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -33,4 +33,5 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_blend.h>
@@ -2088,4 +2089,48 @@ static void commit_tail(struct drm_atomic_commit *state, bool nonblock)
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
+	 * The readout is limited to the objects that have a state in
+	 * the commit, which are exactly the objects whose locks we
+	 * hold, so it can't race with a concurrent commit touching
+	 * the other objects.
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
diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm/drm_atomic_state_readout.c
index 2c17fa09c5f0..f29d127f99f8 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout.c
@@ -26,5 +26,5 @@
  * modeset can be skipped when the requested mode matches.
  *
- * The SRO lifecycle has two phases. The first phase is the readout
+ * The SRO lifecycle has three phases. The first phase is the readout
  * itself: at driver registration time, each KMS object (CRTCs, planes,
  * connectors, bridges, private objects) has its
@@ -46,6 +46,15 @@
  * cannot fail.
  *
- * Drivers integrate with SRO by implementing the readout hooks in their
- * object funcs vtables and setting the
+ * The third phase is the comparison. Because getting access to every
+ * firmware variation is hard, and most firmware setups will be fairly
+ * basic, the framework also provides a way to verify the readout
+ * implementation during normal operation. After every blocking commit,
+ * the framework reads out a fresh state from hardware and compares it
+ * to the committed state using the atomic_sro_compare_state hooks. Any
+ * mismatch is reported, which allows to catch readout bugs without
+ * needing specific firmware configurations.
+ *
+ * Drivers integrate with SRO by implementing the readout and compare
+ * hooks in their object funcs vtables and setting the
  * &drm_mode_config_funcs.atomic_sro_readout_state and
  * &drm_mode_config_helper_funcs.atomic_sro_build_state callbacks. The
@@ -124,4 +133,55 @@ static bool drm_atomic_sro_can_readout(struct drm_device *dev)
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
@@ -150,4 +210,8 @@ bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
 		return false;
 
+	ret = drm_atomic_sro_can_compare(dev);
+	if (!ret)
+		return false;
+
 	return true;
 }
@@ -756,2 +820,155 @@ void drm_atomic_sro_install_state(struct drm_atomic_sro_state *state)
 }
 EXPORT_SYMBOL(drm_atomic_sro_install_state);
+
+/**
+ * drm_atomic_sro_readout_and_compare - verify committed state against hardware
+ * @commit: the atomic commit we just performed
+ *
+ * Reads out a fresh &struct drm_atomic_sro_state from the hardware,
+ * limited to the objects that have a state in @commit, and compares it
+ * to @commit using the atomic_sro_compare_state hooks. Any mismatches
+ * are reported through the DRM error printer.
+ *
+ * This is called after blocking commits to verify that the readout
+ * implementation is correct. It must be called while the locks of the
+ * objects in @commit are still held, so before the caller drops them
+ * through the acquire context of @commit.
+ *
+ * Since only the objects of @commit are read out, and those are the
+ * objects whose locks are held, the readout can't race with a
+ * concurrent commit touching other objects.
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
+	might_alloc(GFP_KERNEL);
+
+	if (!drm_atomic_sro_device_can_readout(dev))
+		return true;
+
+	readout_state = funcs->atomic_sro_build_state(dev, commit);
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
index 5977157d8e67..1c16e637b97e 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -752,5 +752,6 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 
 	if (bridge->funcs &&
-	    bridge->funcs->atomic_sro_readout_state)
+	    bridge->funcs->atomic_sro_readout_state &&
+	    bridge->funcs->atomic_sro_compare_state)
 		drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
 					    &drm_bridge_priv_state_funcs_with_sro);
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 7a66e35257d8..6d3aef9bf9d3 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -363,4 +363,27 @@ struct drm_private_state_funcs {
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
diff --git a/include/drm/drm_atomic_state_readout.h b/include/drm/drm_atomic_state_readout.h
index 195154850ab4..6529774d9ca8 100644
--- a/include/drm/drm_atomic_state_readout.h
+++ b/include/drm/drm_atomic_state_readout.h
@@ -4,4 +4,7 @@
 #define DRM_ATOMIC_SRO_H_
 
+#include <linux/types.h>
+
+struct drm_atomic_commit;
 struct drm_atomic_sro_state;
 struct drm_connector;
@@ -52,4 +55,5 @@ void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *state,
 
 void drm_atomic_sro_install_state(struct drm_atomic_sro_state *state);
+bool drm_atomic_sro_readout_and_compare(struct drm_atomic_commit *commit);
 
 #endif /* DRM_ATOMIC_SRO_H_ */
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index ef044ad27d2c..030467e2cb1e 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -317,4 +317,26 @@ struct drm_bridge_funcs {
 					struct drm_connector_state *conn_state);
 
+	/**
+	 * @atomic_sro_compare_state:
+	 *
+	 * Compares two &struct drm_bridge_state instances and reports
+	 * any mismatches through @p.
+	 *
+	 * It is called after blocking commits to verify that the
+	 * committed state matches what can be read back from the
+	 * hardware.
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
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2d8639a870b3..3892a20a6cca 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1907,4 +1907,26 @@ struct drm_connector_funcs {
 				     struct drm_connector_state *state);
 
+	/**
+	 * @atomic_sro_compare_state:
+	 *
+	 * Compares two &struct drm_connector_state instances and
+	 * reports any mismatches through @p.
+	 *
+	 * It is called after blocking commits to verify that the
+	 * committed state matches what can be read back from the
+	 * hardware.
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
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index ed69a2733a34..e5662ddb61fb 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -736,4 +736,26 @@ struct drm_crtc_funcs {
 				     struct drm_crtc_state *state);
 
+	/**
+	 * @atomic_sro_compare_state:
+	 *
+	 * Compares two &struct drm_crtc_state instances and reports
+	 * any mismatches through @p.
+	 *
+	 * It is called after blocking commits to verify that the
+	 * committed state matches what can be read back from the
+	 * hardware.
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
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 381d31d5c3e2..0a18d26eb397 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -488,4 +488,26 @@ struct drm_plane_funcs {
 				     struct drm_plane_state *state);
 
+	/**
+	 * @atomic_sro_compare_state:
+	 *
+	 * Compares two &struct drm_plane_state instances and reports
+	 * any mismatches through @p.
+	 *
+	 * It is called after blocking commits to verify that the
+	 * committed state matches what can be read back from the
+	 * hardware.
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

-- 
2.55.0

