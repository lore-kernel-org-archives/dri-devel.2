Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DE360A381C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0i1nsAX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3EB10F7E6;
	Tue, 10 Nov 2026 16:03:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B10F10F7D7
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:03:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F3B6C63A5F;
 Tue, 10 Nov 2026 16:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D091F008A4;
 Tue, 10 Nov 2026 16:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794326591;
 bh=uZeevMjphfat9qIaOQsV0pPf9Ls5Ej0bmBBIYogCow4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Q0i1nsAXXq7Em3bKn/YQWuap39VnPBJhNMO3CN9xhKNmcqQDrY0LvOUrgSipk6UHT
 xYcmUJHqR4b0TT99X3/BRolPKY2yzQs+1aeicdGSIrmG95lKrEaQnBgSoo7cPKgfqB
 2YizD2z1Xyha9LD68BshH7gu83D0pvnQSN3tv0dDzadbtIoz5SULV2YdyPYU831zRK
 IccM3qjMwzqvZ4ZJcSRP6pM4YQpO5sHs6WC4bi8dBzP7eTiULaLNZaQeCkQwCoTHBd
 2J3VBRPPzTyeCEnlvLWbILXh+OCJdswz7do7Wqavfk7AYQVfWm8k+G5lgtuDs0aKEr
 2TkqQNbD1N5FA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 10 Nov 2026 17:02:51 +0100
Subject: [PATCH v9 04/10] drm/atomic: Allow filling a commit with pristine
 object states
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-drm-reset-state-flag-v9-4-ddb0e26324a0@kernel.org>
References: <20261110-drm-reset-state-flag-v9-0-ddb0e26324a0@kernel.org>
In-Reply-To: <20261110-drm-reset-state-flag-v9-0-ddb0e26324a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18213; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/RHSBEeIWOiephoHsTLGT8k5yGX933rWx91P1rHrdkc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmfHXSFP2xcU/z0uKzPNIHsGyL5dVOLvq3LKD2qsTOnf
 brUs6rKjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR7ibGhgf1Ly/OSPs4wUNB
 bKnc0i925zlm/Zj73C7gibMgv/r1KBm2CXaP/jpbnDTJse8u8Jz2lrFW7ojsgbqKX422lqs/qph
 5uk9WuSY2U2Vr8SYHQTMJg2m3DuYfvRDwjF1zWuvuKPMUmxsA
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
 drivers/gpu/drm/drm_atomic.c | 430 +++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h     |   2 +
 2 files changed, 432 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 7a77051096c9..b469a8169ca6 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1647,10 +1647,440 @@ bool drm_atomic_implements_create_state(struct drm_device *dev)
 
 	return true;
 }
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
+static int drm_atomic_commit_fill_connector_with_defaults(struct drm_file *file_priv,
+							  struct drm_atomic_commit *commit,
+							  struct drm_connector *connector)
+{
+	struct drm_connector_state *connector_state;
+	struct drm_crtc_state *crtc_state;
+	int ret;
+
+	if (drm_lease_held(file_priv, connector->base.id)) {
+		/*
+		 * The connector is part of the lease, so it gets a
+		 * pristine state: every property userspace can set goes
+		 * back to its default value, which leaves the connector
+		 * unbound from whatever CRTC it is currently on.
+		 *
+		 * That CRTC still needs to be part of the commit for the
+		 * helpers to update the routing, whether it is leased or
+		 * not, which is what the end of this branch takes care of.
+		 */
+
+		/*
+		 * drm_atomic_implements_create_state() already checked
+		 * this, but connectors can be hotplugged between that
+		 * lockless check and the iteration here.
+		 */
+		if (!connector->funcs->atomic_create_state)
+			return -EOPNOTSUPP;
+
+		connector_state = connector->funcs->atomic_create_state(connector);
+		if (IS_ERR(connector_state))
+			return PTR_ERR(connector_state);
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
+			return ret;
+		}
+
+		if (!connector->state->crtc)
+			return 0;
+
+		/*
+		 * Make sure the CRTC the connector is currently bound to
+		 * is part of the commit. The atomic helpers need that
+		 * state: set_best_encoder() clears the encoder mask of
+		 * that CRTC when the connector gets detached from it.
+		 */
+		crtc_state = drm_atomic_get_crtc_state(commit,
+						       connector->state->crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+
+		/*
+		 * The pristine state unbinds the connector from that
+		 * CRTC, so drop it from the connector mask like
+		 * drm_atomic_set_crtc_for_connector() would.
+		 */
+		crtc_state->connector_mask &= ~drm_connector_mask(connector);
+
+		/*
+		 * An unleased CRTC is pulled into the commit with a
+		 * duplicate of its current state, so it stays enabled. If
+		 * the connector was its last one, the CRTC can't remain
+		 * enabled with no connector: the atomic helpers would
+		 * reject the commit. Disable it like
+		 * handle_conflicting_encoders() does when it steals the
+		 * last encoder of a CRTC.
+		 */
+		if (!drm_lease_held(file_priv, crtc_state->crtc->base.id) &&
+		    !crtc_state->connector_mask) {
+			ret = drm_atomic_set_mode_prop_for_crtc(crtc_state,
+							       NULL);
+			if (ret)
+				return ret;
+
+			crtc_state->active = false;
+		}
+	} else {
+		/*
+		 * The connector isn't part of the lease so it keeps its
+		 * current state. If it is bound to a leased CRTC though,
+		 * that CRTC is being reset under it and comes with an
+		 * empty connector mask, so
+		 * drm_atomic_add_affected_connectors() won't find the
+		 * connector during the check. Pull it in here so that its
+		 * routing and encoder are properly handled.
+		 *
+		 * The leased CRTCs are all part of the commit by now. An
+		 * unleased one might not be yet, but it keeps its
+		 * connector mask, so the helpers will pull the connector
+		 * in on their own if that CRTC ends up being changed.
+		 */
+		if (!connector->state->crtc)
+			return 0;
+
+		crtc_state = drm_atomic_get_new_crtc_state(commit,
+							   connector->state->crtc);
+		if (!crtc_state)
+			return 0;
+
+		connector_state = drm_atomic_get_connector_state(commit,
+								 connector);
+		if (IS_ERR(connector_state))
+			return PTR_ERR(connector_state);
+
+		/*
+		 * The connector can't stay bound to a CRTC that the reset
+		 * disables, whether it is a leased one being reset or an
+		 * unleased one that just lost its last leased connector:
+		 * update_connector_routing() would keep it attached to a
+		 * disabled CRTC. Detach it like userspace setting CRTC_ID
+		 * to 0 would.
+		 */
+		if (!crtc_state->enable) {
+			ret = drm_atomic_set_crtc_for_connector(connector_state,
+								NULL);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
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
+ * of its lease are reset. The other ones keep their current state,
+ * except for the ones that are bound to a reset object and cannot stay
+ * that way: the connectors of a reset CRTC are detached from it, the
+ * planes enabled on a CRTC disabled by the reset are disabled, and an
+ * unleased CRTC losing its last leased connector is disabled. @file_priv
+ * is optional: if NULL, it is considered to not hold any lease, and all
+ * objects are reset.
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
+	 * The CRTCs are handled first so that, when the connectors and
+	 * planes pull the CRTC they are currently bound to into the
+	 * commit, a leased CRTC is already there with its pristine state
+	 * while an unleased one gets duplicated and keeps its current
+	 * state.
+	 *
+	 * The connectors are then handled before the planes: detaching a
+	 * leased connector from an unleased CRTC can disable that CRTC,
+	 * and the planes enabled on it have to be disabled too, which
+	 * they can only tell from the CRTC state filled in here.
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
+		drm_atomic_commit_set_crtc_state(commit, crtc, crtc_state);
+	}
+
+	/*
+	 * The connectors are handled after the CRTCs so that the CRTC
+	 * they are bound to is already part of the commit, with its
+	 * pristine state if it is leased and a duplicate of its current
+	 * state otherwise.
+	 */
+	ret = drm_modeset_lock(&config->connection_mutex, commit->acquire_ctx);
+	if (ret)
+		return ret;
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		ret = drm_atomic_commit_fill_connector_with_defaults(file_priv, commit, connector);
+		if (ret) {
+			drm_connector_list_iter_end(&conn_iter);
+			return ret;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	drm_for_each_plane(plane, dev) {
+		struct drm_plane_state *plane_state;
+		struct drm_crtc_state *crtc_state;
+
+		if (drm_lease_held(file_priv, plane->base.id)) {
+			ret = drm_modeset_lock(&plane->mutex, commit->acquire_ctx);
+			if (ret)
+				return ret;
+
+			/*
+			 * Make sure the CRTC the plane is currently enabled on is
+			 * part of the commit, like drm_atomic_set_crtc_for_plane()
+			 * does when userspace disables a plane. The atomic helpers
+			 * need the CRTC state to update planes_changed and track
+			 * the commit, and would dereference a NULL CRTC state
+			 * otherwise.
+			 */
+			if (plane->state->crtc) {
+				crtc_state = drm_atomic_get_crtc_state(commit,
+								       plane->state->crtc);
+				if (IS_ERR(crtc_state))
+					return PTR_ERR(crtc_state);
+
+				/*
+				 * The pristine state detaches the plane from that
+				 * CRTC, so drop it from the plane mask like
+				 * drm_atomic_set_crtc_for_plane() would. The mask
+				 * of a leased CRTC is already empty, but an
+				 * unleased one got duplicated and still has the
+				 * plane in it.
+				 */
+				crtc_state->plane_mask &= ~drm_plane_mask(plane);
+			}
+
+			plane_state = plane->funcs->atomic_create_state(plane);
+			if (IS_ERR(plane_state))
+				return PTR_ERR(plane_state);
+
+			/*
+			 * Same thing for the planes: report a color pipeline change
+			 * compared to the current state.
+			 */
+			plane_state->color_mgmt_changed =
+				plane->state->color_pipeline != plane_state->color_pipeline;
+
+			drm_atomic_commit_set_plane_state(commit, plane, plane_state);
+		} else if (plane->state->crtc) {
+			/*
+			 * An unleased plane keeps its current state, unless
+			 * the CRTC it is enabled on is disabled by the reset:
+			 * that CRTC is either leased and comes with a
+			 * pristine state, or unleased and just lost its last
+			 * leased connector. The plane can't remain enabled on
+			 * a disabled CRTC: the atomic helpers would pull it in
+			 * with its current state during the check and reject
+			 * the commit. Disable it like userspace setting
+			 * CRTC_ID and FB_ID to 0 would.
+			 */
+			crtc_state = drm_atomic_get_new_crtc_state(commit,
+								   plane->state->crtc);
+			if (!crtc_state || crtc_state->enable)
+				continue;
+
+			plane_state = drm_atomic_get_plane_state(commit, plane);
+			if (IS_ERR(plane_state))
+				return PTR_ERR(plane_state);
+
+			ret = drm_atomic_set_crtc_for_plane(plane_state, NULL);
+			if (ret)
+				return ret;
+
+			drm_atomic_set_fb_for_plane(plane_state, NULL);
+		}
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
+	/*
+	 * drm_lease_held() is evaluated once per object and takes
+	 * idr_mutex each time, so a revocation can land between two of
+	 * those checks and leave the commit with pristine states for some
+	 * objects and the current state for the others. Holding idr_mutex
+	 * across the whole function isn't an option, since
+	 * __drm_mode_object_find() takes it while the modeset locks are
+	 * already held and the ordering is therefore the other way
+	 * around.
+	 *
+	 * A lease is always revoked as a whole though, and the revocation
+	 * is tracked explicitly in drm_master, so checking it once at
+	 * the end is enough to tell that it survived the whole fill.
+	 */
+	if (drm_lease_revoked(file_priv)) {
+		drm_dbg_atomic(dev, "Lease revoked while filling the commit\n");
+		return -ENOENT;
+	}
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

