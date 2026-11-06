Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D0606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXI/IL7B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B015810EA20;
	Fri,  6 Nov 2026 13:16:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E4610EA20
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99BB04033F;
 Fri,  6 Nov 2026 13:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037101F0089F;
 Fri,  6 Nov 2026 13:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970965;
 bh=1f2hAzJD7TWw0v4/ewteNTXWMd2gKRPZA6VzJA3sa0o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OXI/IL7B71demt7Ltza4ez11qjwqenjZlQahl1f8l+HgQfOf3k3DefKRtVJ5nzfC1
 sukPW8O7F809STLX7zQtwvc2388gMDb0ZIwUBjfoI3QFr5WM4LSlk5auk5Pv0Vn85c
 5kej3Ub7CSgb8I7mTv5V0QuWkFQE6IjNcCvZL8qxHpWWGlEF4oAchPyHeJ/Iey49uS
 v5AO7gUBZ1bbMyGPWRWxwMcQ/OUtUGwKW0orWNOWybSQPRvkkA4vVpPtiQhVnC3wte
 xPu6IC/iBUIdQ1XTGuTl+KccF4zJHUQhk0tqrMuoxUh4O6tis7xalBDCRUN+6Bwpyb
 7DBaHmV0nWRKA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:36 +0100
Subject: [PATCH v8 23/39] drm/atomic_helper: Compare actual and readout
 states once the commit is done
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-23-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20741; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vg9JO9T2FQ3kljwwgXyaAcSfO/LICybjPvCsWyAoFK8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL22PDGI3ypkz9WzXxW9T+DauNZQ7vj/+tLb/A9kWk
 zJbk/oZHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiubsZ69PDTtmrmMixftCb
 32hiZ7q25MCR1j1+26b+NbxrfET+/Z0EyX/dYnfun0zrffm+vmCGCWN98NYkezW9FN7Jb32yj0c
 EZx1uf5Yd0iO4UyavwNeG4y7L7vI3G5bfTp+SLbbAc6LSN1UA
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
 drivers/gpu/drm/drm_atomic_helper.c        |  45 +++++
 drivers/gpu/drm/drm_atomic_state_readout.c | 291 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/drm_bridge.c               |   3 +-
 include/drm/drm_atomic.h                   |  23 +++
 include/drm/drm_atomic_state_readout.h     |   4 +
 include/drm/drm_bridge.h                   |  22 +++
 include/drm/drm_connector.h                |  22 +++
 include/drm/drm_crtc.h                     |  22 +++
 include/drm/drm_plane.h                    |  22 +++
 9 files changed, 450 insertions(+), 4 deletions(-)

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
index b91a8f71b78b..d34fc9bb138b 100644
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
@@ -117,4 +126,55 @@ static bool drm_atomic_sro_can_readout(struct drm_device *dev)
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
@@ -143,4 +203,8 @@ bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
 		return false;
 
+	ret = drm_atomic_sro_can_compare(dev);
+	if (!ret)
+		return false;
+
 	return true;
 }
@@ -764,2 +828,223 @@ void drm_atomic_sro_install_state(struct drm_atomic_sro_state *state)
 }
 EXPORT_SYMBOL(drm_atomic_sro_install_state);
+
+/*
+ * Whether @crtc drives a picture once @commit has been applied.
+ *
+ * A commit can leave an object attached to a CRTC it just turned off:
+ * a DPMS off commit only clears &drm_crtc_state.active and leaves the
+ * connectors bound to their CRTC. The hardware has nothing to read out
+ * for such a pipeline, so there is nothing to compare either.
+ */
+static bool
+drm_atomic_sro_crtc_is_active(struct drm_atomic_commit *commit,
+			      struct drm_crtc *crtc)
+{
+	struct drm_crtc_state *crtc_state;
+
+	if (!crtc)
+		return false;
+
+	crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+	if (!crtc_state)
+		crtc_state = crtc->state;
+
+	return crtc_state && crtc_state->active;
+}
+
+static bool
+drm_atomic_sro_bridge_pipeline_active(struct drm_private_obj *obj,
+				       struct drm_atomic_commit *commit)
+{
+	struct drm_connector_state *new_conn_state;
+	struct drm_connector *conn;
+	struct drm_bridge *bridge;
+	unsigned int i;
+
+	bridge = drm_priv_to_bridge(obj);
+
+	for_each_new_connector_in_state(commit, conn, new_conn_state, i) {
+		if (new_conn_state->best_encoder == bridge->encoder &&
+		    drm_atomic_sro_crtc_is_active(commit, new_conn_state->crtc))
+			return true;
+	}
+
+	return false;
+}
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
+	if (IS_ERR(readout_state)) {
+		drm_dbg_kms(dev, "Couldn't read out the state to compare: %pe\n",
+			    readout_state);
+		return false;
+	}
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
+		/*
+		 * The connector routing and its negotiated properties
+		 * can't be read out of a pipeline that isn't driving a
+		 * picture anymore. A connector left on in hardware
+		 * after the commit turned its CRTC off is caught by the
+		 * CRTC comparison above.
+		 */
+		if (!drm_atomic_sro_crtc_is_active(commit, new_conn_state->crtc))
+			continue;
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
+		/*
+		 * A commit disabling a pipeline keeps duplicated, stale
+		 * states for the bridges of the old pipeline, while
+		 * their readout is a pristine state since there is
+		 * nothing to read out from powered down hardware.
+		 * Skip the comparison for those.
+		 */
+		if (drm_private_obj_is_bridge(obj) &&
+		    !drm_atomic_sro_bridge_pipeline_active(obj, commit))
+			continue;
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
index c0224dcc8aa5..b183002b7b3d 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -762,5 +762,6 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 
 	if (bridge->funcs &&
-	    bridge->funcs->atomic_sro_readout_state)
+	    bridge->funcs->atomic_sro_readout_state &&
+	    bridge->funcs->atomic_sro_compare_state)
 		ret = drm_atomic_private_obj_init(bridge->dev, &bridge->base,
 						  bridge->name,
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 481a5742a78c..4c7a65723228 100644
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
index e1e705f94f66..5d71d2918def 100644
--- a/include/drm/drm_atomic_state_readout.h
+++ b/include/drm/drm_atomic_state_readout.h
@@ -4,4 +4,7 @@
 #define DRM_ATOMIC_SRO_H_
 
+#include <linux/types.h>
+
+struct drm_atomic_commit;
 struct drm_atomic_sro_state;
 struct drm_connector;
@@ -59,4 +62,5 @@ void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *state,
 
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

