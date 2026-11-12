Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803260A2621
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adjo5VCZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58EBB1121DA;
	Thu, 12 Nov 2026 16:32:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E71910EBC5
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:32:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C07D262346;
 Thu, 12 Nov 2026 16:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EC71F000C6;
 Thu, 12 Nov 2026 16:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794501134;
 bh=1WWGUuY5vCeAo5o0O/NzoMgNGGDbB8oWU++N1Z6GQc8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=adjo5VCZrcsuGYpYBij9GQHeKURO5aYpLqxbIjs37JSNCK1MKhQ/3GFuGW7dA+NyR
 K2l8KkaLSjqaYy90xEzEJ4YUxmZbRAdqGhRvH2xmSA3hObjrcKqGFe/Go0CDLfKEkH
 jGersRnIyLq24UtnWF9GRUe1iUzy3qis6f+R5hdlEYDsa6Z/LVTd1OYUMJfYCjK4Gs
 CqGB4DIIjXQG+/yDPAF7/8xZ9IdV7r9MuAyycQOVVtlGShySGersPWqQTqM1qenCVj
 jJQ8qcq+XOJYn/6a0qz4bguwKOqp31+5+50yxmQc58/MDB9SbNdsfjrb5OyI247rem
 Nfh96dSkAPMOA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 12 Nov 2026 17:31:52 +0100
Subject: [PATCH v10 3/9] drm/atomic: Allow filling a commit with pristine
 object states
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-drm-reset-state-flag-v10-3-cefaa1ed056d@kernel.org>
References: <20261112-drm-reset-state-flag-v10-0-cefaa1ed056d@kernel.org>
In-Reply-To: <20261112-drm-reset-state-flag-v10-0-cefaa1ed056d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13973; i=mripard@kernel.org;
 h=from:subject:message-id; bh=EGzywagQQFRuH21vqB7uVISV+3CkXoE0YUykBMTl2ZI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlfX/4XZ9n581Hk7w2Ky1Jm7Cy+vTr4h7teyM6ga5OOB
 sZ4VClu7ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATMbjB2LC6KXfh5NWm07Km
 WbYW1N7mNX0cZMB9pUVYbLKtw5LKzUUpCa5v268H2OqwChtOlGvzZWx4uMPlEEfxngnRarX9sm9
 E+XqWtZ5af43papiDtlPXUTUvHfPSaTpLrNLuG/Z8+J9VogIA
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

The upcoming DRM_MODE_ATOMIC_RESET flag will need to create an atomic
commit that brings the entire device back to a pristine state, as if
no configuration had ever been applied.

Create drm_atomic_commit_fill_with_defaults() which iterates over all
CRTCs, planes, connectors, and color operations in the device and
inserts a fresh default state for each one into the commit. This uses
the atomic_create_state() hooks rather than atomic_duplicate_state(),
since atomic_create_state() provides exactly this pristine state on a
per-object basis.

A lessee only gets the objects of its lease reset, the other ones
keeping their current state. Partial pipelines aren't supported
though: detaching a plane or a connector from its CRTC, and disabling
a CRTC driving them, both need the two sides in the commit, so a lease
that splits a pipeline is rejected with -ENOENT. validate_lease() is
expected to keep that from happening, since it requires a lease to
hold at least a CRTC, a connector and a plane, but it only looks at
the object types, not at what they are bound to.

Part of the state the atomic helpers maintain is only recomputed when
something changed, which a reset re-applying the same configuration
doesn't trigger. The CRTC adjusted_mode and the connector best_encoder
are therefore carried over like a duplicated state would, and the
CRTCs ask for a zpos normalization.

The color management changes are reported through color_mgmt_changed
for the same reason: the userspace property handlers only set it when
a property write changes the value stored in the new state, so neither
restoring a default nor leaving a property untouched would, even
though the reset clears whatever is currently programmed.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 285 +++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h     |   2 +
 2 files changed, 287 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 7a77051096c9..4fcce3bb0aa1 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1647,10 +1647,295 @@ bool drm_atomic_implements_create_state(struct drm_device *dev)
 
 	return true;
 }
 EXPORT_SYMBOL(drm_atomic_implements_create_state);
 
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
+ * In the default state, all objects are disabled: CRTCs are inactive,
+ * planes are disabled, and connectors are unbound. Driver-specific
+ * properties such as color pipeline settings or max_bpc may carry
+ * non-zero defaults appropriate for basic display output.
+ *
+ * If @file_priv is a lessee, only the CRTCs, planes and connectors part
+ * of its lease are reset, and the other objects keep their current
+ * state. @file_priv is optional: if NULL, it is considered to not hold
+ * any lease, and all objects are reset.
+ *
+ * Partial pipelines aren't supported. Resetting a plane or a connector
+ * detaches it from the CRTC it is bound to, and resetting a CRTC
+ * disables the planes and connectors bound to it, neither of which the
+ * atomic helpers can sort out with only one side of the pair in the
+ * commit. A lease covering a plane or a connector without the CRTC it
+ * is bound to, or a CRTC without all the planes and connectors bound
+ * to it, would thus require reaching outside of it, so the reset is
+ * rejected instead.
+ *
+ * Such a lease shouldn't exist in the first place: validate_lease()
+ * requires a lease to hold at least a CRTC, a connector and a plane,
+ * so leases are meant to describe whole pipelines. It only looks at
+ * the object types though, not at what they are bound to, so the
+ * reset still has to guard against it.
+ *
+ * This is meant to be used with the %DRM_MODE_ATOMIC_RESET flag, which
+ * needs to bring the device back to a known baseline before applying
+ * userspace property changes on top.
+ *
+ * Returns:
+ * 0 on success, -ENOENT if a leased plane or connector is bound to a
+ * CRTC that isn't leased, or a negative error code on failure.
+ */
+int drm_atomic_commit_fill_with_defaults(struct drm_file *file_priv,
+					 struct drm_atomic_commit *commit)
+{
+	struct drm_device *dev = commit->dev;
+	struct drm_mode_config *config = &dev->mode_config;
+	struct drm_crtc *crtc;
+	struct drm_plane *plane, *crtc_plane;
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
+	 */
+	drm_for_each_colorop(colorop, dev) {
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
+		 * The pristine state detaches the plane from the CRTC it
+		 * is enabled on, which the atomic helpers can only sort
+		 * out with that CRTC in the commit. Resetting a plane
+		 * enabled on a CRTC that isn't leased would thus require
+		 * touching an object the lease doesn't cover, so report it
+		 * like any other access outside of the lease.
+		 */
+		if (plane->state->crtc &&
+		    !drm_lease_held(file_priv, plane->state->crtc->base.id)) {
+			drm_dbg_atomic(dev,
+				       "[PLANE:%d:%s] is enabled on [CRTC:%d:%s], which isn't leased\n",
+				       plane->base.id, plane->name,
+				       plane->state->crtc->base.id,
+				       plane->state->crtc->name);
+			return -ENOENT;
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
+		/*
+		 * The reset disables the CRTC, which the planes enabled on
+		 * it can't stay bound to. Disabling them is only an option
+		 * for the ones the lease covers, so a CRTC driving a plane
+		 * it doesn't is rejected like the other way around.
+		 */
+		drm_for_each_plane_mask(crtc_plane, dev, crtc->state->plane_mask) {
+			if (drm_lease_held(file_priv, crtc_plane->base.id))
+				continue;
+
+			drm_dbg_atomic(dev,
+				       "[CRTC:%d:%s] drives [PLANE:%d:%s], which isn't leased\n",
+				       crtc->base.id, crtc->name,
+				       crtc_plane->base.id, crtc_plane->name);
+			return -ENOENT;
+		}
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
+		/*
+		 * adjusted_mode is derived from the mode by the atomic
+		 * helpers rather than set by userspace, and mode_fixup()
+		 * only recomputes it when the mode or the connectors
+		 * changed. A duplicated state carries it over, so nothing
+		 * needs to be recomputed when nothing changes, but the
+		 * pristine states we create here would be left with a
+		 * zeroed adjusted_mode on a CRTC that stays enabled across
+		 * the commit. Carry it over too, so that the drivers and
+		 * the vblank timestamping constants keep seeing the
+		 * timings currently programmed.
+		 */
+		drm_mode_copy(&crtc_state->adjusted_mode,
+			      &crtc->state->adjusted_mode);
+
+		/*
+		 * The planes come back with the default zpos, which the
+		 * atomic helpers only normalize when the planes bound to a
+		 * CRTC or one of their zpos changed. Re-applying the same
+		 * configuration on top of the reset wouldn't trigger
+		 * either, so ask for a normalization explicitly.
+		 */
+		crtc_state->zpos_changed = true;
+
+		drm_atomic_commit_set_crtc_state(commit, crtc, crtc_state);
+	}
+
+	ret = drm_modeset_lock(&config->connection_mutex, commit->acquire_ctx);
+	if (ret)
+		return ret;
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		struct drm_connector_state *connector_state;
+
+		if (!drm_lease_held(file_priv, connector->base.id)) {
+			/*
+			 * Same as the planes of a leased CRTC: the reset
+			 * disables that CRTC, and a connector the lease
+			 * doesn't cover can't be unbound from it.
+			 */
+			if (connector->state->crtc &&
+			    drm_lease_held(file_priv,
+					   connector->state->crtc->base.id)) {
+				drm_dbg_atomic(dev,
+					       "[CONNECTOR:%d:%s] isn't leased, but [CRTC:%d:%s] it is bound to is\n",
+					       connector->base.id, connector->name,
+					       connector->state->crtc->base.id,
+					       connector->state->crtc->name);
+				drm_connector_list_iter_end(&conn_iter);
+				return -ENOENT;
+			}
+
+			continue;
+		}
+
+		/*
+		 * Same as the planes above: unbinding the connector from
+		 * an unleased CRTC would need that CRTC in the commit.
+		 */
+		if (connector->state->crtc &&
+		    !drm_lease_held(file_priv, connector->state->crtc->base.id)) {
+			drm_dbg_atomic(dev,
+				       "[CONNECTOR:%d:%s] is bound to [CRTC:%d:%s], which isn't leased\n",
+				       connector->base.id, connector->name,
+				       connector->state->crtc->base.id,
+				       connector->state->crtc->name);
+			drm_connector_list_iter_end(&conn_iter);
+			return -ENOENT;
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
+		 * that keep the connector routing unchanged, carry the
+		 * encoder currently in use over so that a reset on which
+		 * userspace re-applies the exact same configuration doesn't
+		 * require a modeset.
+		 */
+		connector_state->best_encoder = connector->state->best_encoder;
+
+		ret = drm_atomic_commit_set_connector_state(commit, connector, connector_state);
+		if (ret) {
+			connector->funcs->atomic_destroy_state(connector, connector_state);
+			drm_connector_list_iter_end(&conn_iter);
+			return ret;
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
  * @state: atomic state
  * @encoder: DRM encoder
  *
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 72c3d420f40c..cac74d43a34d 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -701,10 +701,12 @@ int drm_crtc_commit_wait(struct drm_crtc_commit *commit);
 struct drm_atomic_commit * __must_check
 drm_atomic_commit_alloc(struct drm_device *dev);
 void drm_atomic_commit_clear(struct drm_atomic_commit *state);
 
 bool drm_atomic_implements_create_state(struct drm_device *dev);
+int drm_atomic_commit_fill_with_defaults(struct drm_file *file_priv,
+					 struct drm_atomic_commit *commit);
 
 /**
  * drm_atomic_commit_get - acquire a reference to the atomic state
  * @state: The atomic state
  *

-- 
2.56.0

