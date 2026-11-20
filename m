Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4571D606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuIXJ0m/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E7E9112A0A;
	Fri, 20 Nov 2026 12:58:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35ABF1129E6
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:56:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98BB2629A0;
 Fri, 20 Nov 2026 12:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16081F000CA;
 Fri, 20 Nov 2026 12:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179396;
 bh=KxpZQIPHwrr9AmyIkaTQ1osx5hWilT8CnbMMSZI6ngM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HuIXJ0m/oOeuh68TGVLAsM6mI1PW3vfY3Pk26AC5hhsXpk2DTaX3H0M4rgQVfo1hu
 p84ZwJdYCyDH0KsYpoRWDAhBtVmwSpWlo7zOODD1d3WrZfTObWajCNGzir3ng/EZbi
 AE5ELgoLeTZ8AWUgPCuCiQLf089wI+zjIm1eJaa+74dpDNTyZAaJd1LQPym2E0+M5x
 nW4uOKGvwsdd8oXAFyB1uUsEyRARMTgtlJMoUJOaANenFuT8mOQuP/42pnbxPe21vv
 mJd8Ntu9mx0Lhw73gb0q2VjtEomz4OUz24Cq/96cSTy2VeyyjWmQewLKzWdpYWKZuI
 RB3OBc1qRCOMA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:14 +0100
Subject: [PATCH v9 22/42] drm/atomic_helper: Compare actual and readout
 states once the commit is done
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-22-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=24709; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PTuNLt42TCCz+9IxFiHLUIQJ829i/Y/NosJSnMVKCzM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzjpCR73yCryCKr8FpDqs2vf6leSvO21uHY9iTRu3+
 jrcNU/umMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABNp0GRsOB4e+fn0iXlrPVec
 aL+jP4HXM5b/RLnhKfmDbxeoxTRXyxcw5H+6VBOy5J+Tw/rbChyyjA3/TVgsJxw4dme7xf/W0p9
 h8+ZMXWN15/aLqeEJM1quJ31dEXSI91ZQyJRFx/PkE1SMuJYCAA==
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
 drivers/gpu/drm/drm_atomic_state_readout.c | 309 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/drm_bridge.c               |   3 +-
 include/drm/drm_atomic.h                   |  23 +++
 include/drm/drm_atomic_state_readout.h     |   3 +
 include/drm/drm_bridge.h                   |  22 ++
 include/drm/drm_connector.h                |  22 ++
 include/drm/drm_crtc.h                     |  22 ++
 include/drm/drm_plane.h                    |  22 ++
 9 files changed, 468 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index ccfe3840d505..1ef87b753f8c 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -30,10 +30,11 @@
 #include <linux/ktime.h>
 #include <linux/media-bus-format.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_colorop.h>
 #include <drm/drm_damage_helper.h>
@@ -2085,10 +2086,54 @@ static void commit_tail(struct drm_atomic_commit *state, bool nonblock)
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
 
 static void commit_work(struct work_struct *work)
 {
diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm/drm_atomic_state_readout.c
index 3e50b0796cbe..4b6512ef1aae 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout.c
@@ -24,11 +24,11 @@
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
@@ -44,11 +44,21 @@
  * optional atomic_sro_install_state hook on each object. This gives
  * drivers a chance to acquire the resources needed to keep the hardware
  * state active, such as power domains, clocks, or interrupts. This hook
  * cannot fail.
  *
- * Drivers integrate with SRO by implementing the readout hooks in their
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
  * object funcs vtables and setting the
  * &drm_mode_config_funcs.atomic_sro_readout_state,
  * &drm_mode_config_helper_funcs.atomic_sro_install_state, and
  * &drm_mode_config_helper_funcs.atomic_sro_build_state callbacks. The
  * default helpers drm_atomic_helper_sro_readout_state(),
@@ -117,10 +127,61 @@ static bool drm_atomic_sro_can_readout(struct drm_device *dev)
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
@@ -143,10 +204,14 @@ bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
 
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
 
 static unsigned int max_connector_index(struct drm_device *dev)
@@ -592,5 +657,245 @@ void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *state,
 	drm_dbg_atomic(state->dev,
 		       "Added new private object %p state %p to readout state %p\n", obj,
 		       obj_state, state);
 }
 EXPORT_SYMBOL(drm_atomic_sro_set_private_obj_state);
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
+	/*
+	 * Adding a connector or a plane to a commit, or routing it to
+	 * a CRTC, adds the state of that CRTC to the commit as well.
+	 */
+	crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+	if (drm_WARN_ON(commit->dev, !crtc_state))
+		return false;
+
+	return crtc_state->active;
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
+		/*
+		 * A plane can be left attached to a framebuffer and a
+		 * CRTC without being scanned out, either because its
+		 * CRTC was turned off by a DPMS off commit, or because
+		 * it was clipped off-screen. The hardware plane is then
+		 * disabled and its readout is pristine, so there is
+		 * nothing to compare. A plane left on in hardware after
+		 * its CRTC was turned off is caught by the CRTC
+		 * comparison below.
+		 */
+		if (new_plane_state->crtc &&
+		    (!new_plane_state->visible ||
+		     !drm_atomic_sro_crtc_is_active(commit, new_plane_state->crtc)))
+			continue;
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
index 868558a09f95..fe9b535d02bd 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -796,11 +796,12 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		if (ret < 0)
 			goto err_reset_bridge;
 	}
 
 	if (bridge->funcs &&
-	    bridge->funcs->atomic_sro_readout_state)
+	    bridge->funcs->atomic_sro_readout_state &&
+	    bridge->funcs->atomic_sro_compare_state)
 		ret = drm_atomic_private_obj_init(bridge->dev, &bridge->base,
 						  bridge->name,
 						  &drm_bridge_priv_state_funcs_with_sro);
 	else
 		ret = drm_atomic_private_obj_init(bridge->dev, &bridge->base,
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index f82e24fce7dc..a9ce086c97ac 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -361,10 +361,33 @@ struct drm_private_state_funcs {
 	 * initialization sequence.
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
diff --git a/include/drm/drm_atomic_state_readout.h b/include/drm/drm_atomic_state_readout.h
index b62d66783f84..68f04583f8ad 100644
--- a/include/drm/drm_atomic_state_readout.h
+++ b/include/drm/drm_atomic_state_readout.h
@@ -3,10 +3,11 @@
 #ifndef DRM_ATOMIC_SRO_H_
 #define DRM_ATOMIC_SRO_H_
 
 #include <linux/types.h>
 
+struct drm_atomic_commit;
 struct drm_connector;
 struct drm_connector_state;
 struct drm_crtc;
 struct drm_crtc_state;
 struct drm_device;
@@ -233,6 +234,8 @@ drm_atomic_sro_get_private_obj_state(struct drm_atomic_sro_state *state,
 				     struct drm_private_obj *private_obj);
 void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *state,
 					  struct drm_private_obj *obj,
 					  struct drm_private_state *obj_state);
 
+bool drm_atomic_sro_readout_and_compare(struct drm_atomic_commit *commit);
+
 #endif /* DRM_ATOMIC_SRO_H_ */
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 7e30877a81cc..d812e809ae81 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -352,10 +352,32 @@ struct drm_bridge_funcs {
 	void (*atomic_sro_install_state)(struct drm_bridge *bridge,
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
 	 *
 	 * Duplicate the current bridge state object (which is guaranteed to be
 	 * non-NULL).
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 3625cd1b66ed..495c9a806d6c 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1905,10 +1905,32 @@ struct drm_connector_funcs {
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
 	 *
 	 * Decode a driver-private property value and store the decoded value
 	 * into the passed-in state structure. Since the atomic core decodes all
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 2def0b58a10d..5a94fdb0f7c0 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -739,10 +739,32 @@ struct drm_crtc_funcs {
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
 	 *
 	 * Decode a driver-private property value and store the decoded value
 	 * into the passed-in state structure. Since the atomic core decodes all
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index fe5f778cb636..d7af4b58ab31 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -486,10 +486,32 @@ struct drm_plane_funcs {
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
 	 *
 	 * Decode a driver-private property value and store the decoded value
 	 * into the passed-in state structure. Since the atomic core decodes all

-- 
2.56.1

