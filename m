Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812660A6F6F
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csiS0LhB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C22E112727;
	Fri, 30 Oct 2026 10:28:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5119711271B
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:28:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 380D743E71;
 Fri, 30 Oct 2026 10:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9587D1F00A20;
 Fri, 30 Oct 2026 10:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793356111;
 bh=LT0xld3i3+JSWMn2TvTzHI0rlyCHD0qoizhwRie3SUc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=csiS0LhBf+Qkahfls0oYo7cbRNHAYw4XRj+IJQL2+hdGXRGdFumssHF5dFDrvKpGj
 sQ63VhsXu5/+PRtrnbrxemwz2wHO3I3vrKgRqGRMXQ9I3WBfPuXMwuJIn1M+q9amZv
 T52YnOcv0Y0R+u6cVzY8z20/icNUf5TduZFr/z4b8d2gGilmUM0sbDIQrELRqTk/6z
 RebE/YY53hRB7xeZN9A2ut7+VtynkYset41C7W5DBYG9fRDHr1UnX5KOHa3ALpm77l
 GPT4LmzEC/a8Mi5867BrflWy3K6Z8b9R66gs/2UcG+ONODIbMnR9UTYxaEkjZ6JFQl
 r3t8IBp0VI+ng==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 11:27:44 +0100
Subject: [PATCH v7 12/16] drm/atomic: Allow filling a commit with pristine
 object states
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-reset-state-flag-v7-12-4e55eaeae683@kernel.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
In-Reply-To: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12282; i=mripard@kernel.org;
 h=from:subject:message-id; bh=4QsIcNRS3tmwhVpQgXvlXRYIeUOoYbaYVopqdOU0vSY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPCmXaog/sqK9YZN0dr1EifuJ9tezmnZM7v3zS0TcrD
 9hwnbm4YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEyk2YWx4YUwr6Ly+0dTTkS/
 5p8wwfNmSfy2ya3FB/dU+bScPSEl8n3v3+Ode9aFePs/nvdJ8UfDY8aGO1m1yefePTdf2553x4s
 v61XvoXW71yi78mzPqunfcuNvTMWLD/3um19ZS9yuexSp87QIAA==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The upcoming DRM_MODE_ATOMIC_RESET flag will need to create an atomic
commit that brings the entire device back to a pristine state, as if
no configuration had ever been applied.

Create drm_atomic_commit_fill_with_defaults() which iterates over all
CRTCs, planes, connectors, and color operations in the device and
inserts a fresh default state for each one into the commit. This uses
the atomic_create_state() hooks rather than atomic_duplicate_state(),
since atomic_create_state() provides exactly this pristine state on a
per-object basis.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 285 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_ioctl.c  |   1 +
 include/drm/drm_atomic.h     |   2 +
 3 files changed, 288 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 7a77051096c9..6bc0d6339f14 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1650,4 +1650,289 @@ bool drm_atomic_implements_create_state(struct drm_device *dev)
 EXPORT_SYMBOL(drm_atomic_implements_create_state);
 
+/*
+ * Returns true if the colorop state @new differs from the colorop state
+ * @old.
+ */
+static bool drm_atomic_colorop_state_changed(const struct drm_colorop_state *old,
+					     const struct drm_colorop_state *new)
+{
+	return old->bypass != new->bypass ||
+	       old->curve_1d_type != new->curve_1d_type ||
+	       old->multiplier != new->multiplier ||
+	       old->data != new->data ||
+	       old->lut1d_interpolation != new->lut1d_interpolation ||
+	       old->lut3d_interpolation != new->lut3d_interpolation ||
+	       old->fixed_matrix_type != new->fixed_matrix_type;
+}
+
+/**
+ * drm_atomic_commit_fill_with_defaults - populate a commit with pristine states
+ * @file_priv: DRM file the reset was requested from, or NULL
+ * @commit: atomic commit to fill
+ *
+ * Iterate over all CRTCs, planes, connectors, and color operations in
+ * the device and insert a freshly created default state for each one
+ * into @commit. The states are created through the atomic_create_state()
+ * hooks, producing the same initial state the driver starts with rather
+ * than a copy of the current hardware state.
+ *
+ * If @file_priv is a lessee, only the CRTCs, planes and connectors part
+ * of its lease are reset, and the other ones are left untouched.
+ * @file_priv is optional: if NULL, it is considered to not hold any
+ * lease, and all objects are reset.
+ *
+ * The objects that are bound to the objects being reset are still added
+ * to the commit, with their current state: the CRTC a reset plane or
+ * connector is bound to, and the connectors bound to a reset CRTC. The
+ * atomic helpers require them to be part of the commit to update the
+ * CRTC state and the routing, and they would dereference a NULL state
+ * otherwise.
+ *
+ * In the default state, all objects are disabled: CRTCs are inactive,
+ * planes are disabled, and connectors are unbound. Driver-specific
+ * properties such as color pipeline settings or max_bpc may carry
+ * non-zero defaults appropriate for basic display output.
+ *
+ * The CRTC and plane states in the commit carry color_mgmt_changed set
+ * when the reset changes the color management properties compared to the
+ * current state, so that drivers reprogram the color management
+ * hardware.
+ *
+ * The connector states keep the encoder currently in use in their
+ * best_encoder field, like a duplicated state would, so that the atomic
+ * helpers can detect the commits that don't change the connector
+ * routing.
+ *
+ * This is meant to be used with the %DRM_MODE_ATOMIC_RESET flag, which
+ * needs to bring the device back to a known baseline before applying
+ * userspace property changes on top.
+ *
+ * Returns:
+ * 0 on success, or a negative error code on failure.
+ */
+int drm_atomic_commit_fill_with_defaults(struct drm_file *file_priv,
+					 struct drm_atomic_commit *commit)
+{
+	struct drm_device *dev = commit->dev;
+	struct drm_mode_config *config = &dev->mode_config;
+	struct drm_crtc *crtc;
+	struct drm_plane *plane;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+	struct drm_colorop *colorop;
+	int ret;
+
+	drm_WARN_ON(dev, !commit->acquire_ctx);
+
+	/*
+	 * Private objects are ignored because none have userspace
+	 * properties we might want to reset. atomic_check
+	 * implementations will derive or infer their private obj state
+	 * from the state that will end up being committed anyway.
+	 *
+	 * The CRTCs are handled before the planes and connectors so that,
+	 * when those pull the CRTC they are currently bound to into the
+	 * commit, a leased CRTC is already there with its pristine state
+	 * while an unleased one gets duplicated and keeps its current
+	 * state.
+	 */
+	drm_for_each_crtc(crtc, dev) {
+		struct drm_crtc_state *crtc_state;
+
+		if (!drm_lease_held(file_priv, crtc->base.id))
+			continue;
+
+		ret = drm_modeset_lock(&crtc->mutex, commit->acquire_ctx);
+		if (ret)
+			return ret;
+
+		crtc_state = crtc->funcs->atomic_create_state(crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+
+		/*
+		 * The userspace property handlers only set
+		 * color_mgmt_changed when a property write changes the
+		 * value stored in the new state. Since the pristine states
+		 * we create here are already set to their default values,
+		 * restoring those defaults wouldn't set the flag, and
+		 * neither would leaving the properties untouched, even
+		 * though the commit clears whatever LUT or CTM is
+		 * currently programmed. Compare with the current state
+		 * so that the drivers reprogram the color management
+		 * hardware.
+		 */
+		crtc_state->color_mgmt_changed =
+			crtc->state->degamma_lut != crtc_state->degamma_lut ||
+			crtc->state->ctm != crtc_state->ctm ||
+			crtc->state->gamma_lut != crtc_state->gamma_lut;
+
+		drm_atomic_commit_set_crtc_state(commit, crtc, crtc_state);
+	}
+
+	drm_for_each_plane(plane, dev) {
+		struct drm_plane_state *plane_state;
+
+		if (!drm_lease_held(file_priv, plane->base.id))
+			continue;
+
+		ret = drm_modeset_lock(&plane->mutex, commit->acquire_ctx);
+		if (ret)
+			return ret;
+
+		/*
+		 * Make sure the CRTC the plane is currently enabled on is
+		 * part of the commit, like drm_atomic_set_crtc_for_plane()
+		 * does when userspace disables a plane. The atomic helpers
+		 * need the CRTC state to update planes_changed and track
+		 * the commit, and would dereference a NULL CRTC state
+		 * otherwise.
+		 */
+		if (plane->state->crtc) {
+			struct drm_crtc_state *crtc_state;
+
+			crtc_state = drm_atomic_get_crtc_state(commit,
+							       plane->state->crtc);
+			if (IS_ERR(crtc_state))
+				return PTR_ERR(crtc_state);
+		}
+
+		plane_state = plane->funcs->atomic_create_state(plane);
+		if (IS_ERR(plane_state))
+			return PTR_ERR(plane_state);
+
+		/*
+		 * Same thing for the planes: report a color pipeline change
+		 * compared to the current state.
+		 */
+		plane_state->color_mgmt_changed =
+			plane->state->color_pipeline != plane_state->color_pipeline;
+
+		drm_atomic_commit_set_plane_state(commit, plane, plane_state);
+	}
+
+	drm_for_each_colorop(colorop, dev) {
+		struct drm_plane_state *plane_state;
+		struct drm_colorop_state *colorop_state;
+
+		if (!drm_lease_held(file_priv, colorop->plane->base.id))
+			continue;
+
+		ret = drm_modeset_lock(&colorop->plane->mutex, commit->acquire_ctx);
+		if (ret)
+			return ret;
+
+		colorop_state = drm_atomic_helper_colorop_create_state(colorop);
+		if (IS_ERR(colorop_state))
+			return PTR_ERR(colorop_state);
+
+		drm_atomic_commit_set_colorop_state(commit, colorop, colorop_state);
+
+		/*
+		 * Report the colorop state changes on their plane state,
+		 * like drm_atomic_set_property() does when userspace
+		 * changes a colorop property.
+		 */
+		if (drm_atomic_colorop_state_changed(colorop->state, colorop_state)) {
+			plane_state = drm_atomic_get_new_plane_state(commit,
+								     colorop->plane);
+			if (plane_state)
+				plane_state->color_mgmt_changed = true;
+		}
+	}
+
+	ret = drm_modeset_lock(&config->connection_mutex, commit->acquire_ctx);
+	if (ret)
+		return ret;
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		struct drm_connector_state *connector_state;
+		struct drm_crtc_state *crtc_state;
+
+		if (!drm_lease_held(file_priv, connector->base.id)) {
+			/*
+			 * The connector isn't part of the lease so it keeps
+			 * its current state, but if it is bound to a CRTC
+			 * that is part of the commit, pull it in like
+			 * drm_atomic_add_affected_connectors() would do on a
+			 * regular commit, so that its routing and encoder
+			 * are properly handled.
+			 */
+			if (!connector->state->crtc)
+				continue;
+
+			if (!drm_atomic_get_new_crtc_state(commit,
+							   connector->state->crtc))
+				continue;
+
+			connector_state = drm_atomic_get_connector_state(commit,
+									 connector);
+			if (IS_ERR(connector_state)) {
+				drm_connector_list_iter_end(&conn_iter);
+				return PTR_ERR(connector_state);
+			}
+
+			continue;
+		}
+
+		/*
+		 * drm_atomic_implements_create_state() already checked
+		 * this, but connectors can be hotplugged between that
+		 * lockless check and the iteration here.
+		 */
+		if (!connector->funcs->atomic_create_state) {
+			drm_connector_list_iter_end(&conn_iter);
+			return -EOPNOTSUPP;
+		}
+
+		connector_state = connector->funcs->atomic_create_state(connector);
+		if (IS_ERR(connector_state)) {
+			drm_connector_list_iter_end(&conn_iter);
+			ret = PTR_ERR(connector_state);
+			return ret;
+		}
+
+		/*
+		 * best_encoder is a routing information maintained by the
+		 * atomic helpers rather than a userspace property, and it
+		 * is only carried over to a new state when that state is a
+		 * duplicate of the current one. Since
+		 * update_connector_routing() uses it to detect the commits
+		 * that keep the connector routing unchanged, let's carry
+		 * the encoder currently in use over so that a reset on
+		 * which userspace re-applies the exact same configuration
+		 * doesn't require a modeset.
+		 */
+		connector_state->best_encoder = connector->state->best_encoder;
+
+		ret = drm_atomic_commit_set_connector_state(commit, connector, connector_state);
+		if (ret) {
+			connector->funcs->atomic_destroy_state(connector, connector_state);
+			drm_connector_list_iter_end(&conn_iter);
+			return ret;
+		}
+
+		/*
+		 * Make sure the CRTC the connector is currently bound to
+		 * is part of the commit, like drm_atomic_get_connector_state()
+		 * does, so that the atomic helpers can update the CRTC
+		 * state and the connector routing.
+		 */
+		if (connector->state->crtc) {
+			crtc_state = drm_atomic_get_crtc_state(commit,
+							       connector->state->crtc);
+			if (IS_ERR(crtc_state)) {
+				drm_connector_list_iter_end(&conn_iter);
+				return PTR_ERR(crtc_state);
+			}
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_commit_fill_with_defaults);
+
 /**
  * drm_atomic_add_encoder_bridges - add bridges attached to an encoder
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 9039a39c4324..0dbf04d4aa9e 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -34,4 +34,5 @@
 #include <linux/uaccess.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_auth.h>
 #include <drm/drm_crtc.h>
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 72c3d420f40c..cac74d43a34d 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -704,4 +704,6 @@ void drm_atomic_commit_clear(struct drm_atomic_commit *state);
 
 bool drm_atomic_implements_create_state(struct drm_device *dev);
+int drm_atomic_commit_fill_with_defaults(struct drm_file *file_priv,
+					 struct drm_atomic_commit *commit);
 
 /**

-- 
2.55.0

