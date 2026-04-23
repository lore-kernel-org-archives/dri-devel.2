Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27ECCF99362
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F27110F071;
	Thu, 23 Apr 2026 10:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xxu8j77S";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD4E10F071
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:19:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 09F9C44475;
 Thu, 23 Apr 2026 10:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89803C2BCB2;
 Thu, 23 Apr 2026 10:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939548;
 bh=1DSGsi22+NoY/S95xpA53bv2mm4Bkkh6VRAzt5Rmk/A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Xxu8j77S+LODXcTA9eqkkHPk9lhlGqEeYUlk9IxV3NYiuVr65u7HDo1Gc5bg5s2mM
 kW3ZGiy9PlJ9lIOZ5MDbk+OqFZe8EoxlT9SJe+MHpqrRjxMBVbuYOpmpML6Dq8YLBm
 faXxJgV4jpZgDe0u2qaRmAImg+AoYVUp9vW0H6PGtuOMSh2kOjIxLchZWrBlsKODPc
 rf0BQxBkRWQW2r43JCfQKi57t/m5hXSReYMGAWEBjv5RfE30Eiky5J68NSg8Mkg2Gk
 X6wPYxQGVtOvrH1J/lT4BMbd0OWIsnDGqvl2G8ROdtexomeJVN/Bh5U9vPlc12lBfc
 AyhpWSnG9DX4g==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:26 +0200
Subject: [PATCH v2 13/28] drm/atomic_sro: Add function to install state
 into drm objects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-13-8549f87cb978@kernel.org>
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10090; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1DSGsi22+NoY/S95xpA53bv2mm4Bkkh6VRAzt5Rmk/A=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP74VvZ890STd/nTSxi8X+p5Xc9/YalATe/H5O5vH4
 t8afZj5O6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE9vky1oo5FEVt7dedKcHK
 xnnoX3SQWXzAJNZjfdL9//bJaud9ONml3XhFl9XwgeH+I3EXfq5dx1hn/ij+JM+Cj+0Vqd8uCH9
 rOKX3omru9Mne/MGfT6hO2RNss2LzTucOn8e55m+P2+3ivJMCAA==
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

Once the SRO state has been built from hardware, it needs to be
installed as the current state of each KMS object.

Add drm_atomic_sro_install_state() which walks through the SRO state
container and assigns each readout state to its object's state
pointer. Before each assignment, it calls the optional
atomic_sro_install_state hook to give drivers a chance to acquire the
resources they need to keep the hardware state active.

Also introduce the atomic_sro_install_state hook in the plane, CRTC,
connector, and private object funcs vtables.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_sro.c | 97 ++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h         | 18 ++++++++
 include/drm/drm_atomic_sro.h     |  2 +
 include/drm/drm_connector.h      | 18 ++++++++
 include/drm/drm_crtc.h           | 18 ++++++++
 include/drm/drm_plane.h          | 18 ++++++++
 6 files changed, 171 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
index 3eb22c654973..7ff67c140ff2 100644
--- a/drivers/gpu/drm/drm_atomic_sro.c
+++ b/drivers/gpu/drm/drm_atomic_sro.c
@@ -515,5 +515,102 @@ void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *state,
 	drm_dbg_atomic(state->dev,
 		       "Added new private object %p state %p to readout state %p\n", obj,
 		       obj_state, state);
 }
 EXPORT_SYMBOL(drm_atomic_sro_set_private_obj_state);
+
+/**
+ * drm_atomic_sro_install_state - install readout state into DRM objects
+ * @state: SRO state to install
+ *
+ * Takes a &struct drm_atomic_sro_state built by
+ * drm_atomic_helper_sro_build_state() and installs its contents as the
+ * current state of each DRM object (setting &drm_crtc.state,
+ * &drm_plane.state, &drm_connector.state and &drm_private_obj.state).
+ *
+ * For each object, the optional atomic_sro_install_state hook is
+ * called before the state pointer is updated, allowing drivers to
+ * perform any needed action.
+ */
+void drm_atomic_sro_install_state(struct drm_atomic_sro_state *state)
+{
+	unsigned int i;
+
+	for (i = 0; i < state->dev->mode_config.num_connector; i++) {
+		struct drm_connector *conn = state->connectors[i].ptr;
+		const struct drm_connector_funcs *conn_funcs = conn->funcs;
+		struct drm_connector_state *conn_state =
+			state->connectors[i].state;
+
+		if (conn->state) {
+			conn_funcs->atomic_destroy_state(conn, conn->state);
+			conn->state = NULL;
+		}
+
+		if (conn_funcs->atomic_sro_install_state)
+			conn_funcs->atomic_sro_install_state(conn, conn_state);
+
+		conn->state = conn_state;
+		state->connectors[i].state = NULL;
+		state->connectors[i].ptr = NULL;
+		drm_connector_put(conn);
+	}
+
+	for (i = 0; i < state->dev->mode_config.num_crtc; i++) {
+		struct drm_crtc *crtc = state->crtcs[i].ptr;
+		const struct drm_crtc_funcs *crtc_funcs = crtc->funcs;
+		struct drm_crtc_state *crtc_state = state->crtcs[i].state;
+
+		if (crtc->state) {
+			crtc_funcs->atomic_destroy_state(crtc, crtc->state);
+			crtc->state = NULL;
+		}
+
+		if (crtc_funcs->atomic_sro_install_state)
+			crtc_funcs->atomic_sro_install_state(crtc, crtc_state);
+
+		crtc->state = crtc_state;
+		state->crtcs[i].state = NULL;
+		state->crtcs[i].ptr = NULL;
+	}
+
+	for (i = 0; i < state->dev->mode_config.num_total_plane; i++) {
+		struct drm_plane *plane = state->planes[i].ptr;
+		const struct drm_plane_funcs *plane_funcs = plane->funcs;
+		struct drm_plane_state *plane_state = state->planes[i].state;
+
+		if (plane->state) {
+			plane_funcs->atomic_destroy_state(plane, plane->state);
+			plane->state = NULL;
+		}
+
+		if (plane_funcs->atomic_sro_install_state)
+			plane_funcs->atomic_sro_install_state(plane,
+							      plane_state);
+
+		plane->state = plane_state;
+		state->planes[i].state = NULL;
+		state->planes[i].ptr = NULL;
+	}
+
+	for (i = 0; i < count_private_obj(state->dev); i++) {
+		struct drm_private_obj *obj = state->private_objs[i].ptr;
+		const struct drm_private_state_funcs *obj_funcs = obj->funcs;
+		struct drm_private_state *obj_state =
+			state->private_objs[i].state;
+
+		if (obj->state) {
+			obj_funcs->atomic_destroy_state(obj, obj->state);
+			obj->state = NULL;
+		}
+
+		if (obj_funcs->atomic_sro_install_state)
+			obj_funcs->atomic_sro_install_state(obj,
+							      obj_state);
+
+		obj->state = obj_state;
+		state->private_objs[i].state = NULL;
+		state->private_objs[i].ptr = NULL;
+	}
+	state->num_private_objs = 0;
+}
+EXPORT_SYMBOL(drm_atomic_sro_install_state);
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 554dde45b799..81290c4a5ad3 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -318,10 +318,28 @@ struct drm_private_state_funcs {
 	 */
 	int (*atomic_sro_readout_state)(struct drm_private_obj *obj,
 					struct drm_atomic_sro_state *state,
 					struct drm_private_state *obj_state);
 
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
+	 * This hook cannot fail. It is called during
+	 * drm_atomic_sro_install_state(), which is part of the
+	 * hardware state readout initialization sequence.
+	 */
+	void (*atomic_sro_install_state)(struct drm_private_obj *obj,
+					 struct drm_private_state *obj_state);
+
 	/**
 	 * @atomic_print_state:
 	 *
 	 * If driver subclasses &struct drm_private_state, it should implement
 	 * this optional hook for printing additional driver specific state.
diff --git a/include/drm/drm_atomic_sro.h b/include/drm/drm_atomic_sro.h
index 6e5262384c71..195154850ab4 100644
--- a/include/drm/drm_atomic_sro.h
+++ b/include/drm/drm_atomic_sro.h
@@ -48,6 +48,8 @@ drm_atomic_sro_get_private_obj_state(struct drm_atomic_sro_state *state,
 				     struct drm_private_obj *private_obj);
 void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *state,
 					  struct drm_private_obj *obj,
 					  struct drm_private_state *obj_state);
 
+void drm_atomic_sro_install_state(struct drm_atomic_sro_state *state);
+
 #endif /* DRM_ATOMIC_SRO_H_ */
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index db0d2bb80bd5..3cd20198a5e7 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1608,10 +1608,28 @@ struct drm_connector_funcs {
 	 */
 	int (*atomic_sro_readout_state)(struct drm_connector *connector,
 					struct drm_atomic_sro_state *state,
 					struct drm_connector_state *conn_state);
 
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
+	 * This hook cannot fail. It is called during
+	 * drm_atomic_sro_install_state(), which is part of the
+	 * hardware state readout initialization sequence.
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
index b6d4a2341776..146da65448dc 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -675,10 +675,28 @@ struct drm_crtc_funcs {
 	 */
 	int (*atomic_sro_readout_state)(struct drm_crtc *crtc,
 					struct drm_atomic_sro_state *state,
 					struct drm_crtc_state *crtc_state);
 
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
+	 * This hook cannot fail. It is called during
+	 * drm_atomic_sro_install_state(), which is part of the
+	 * hardware state readout initialization sequence.
+	 */
+	void (*atomic_sro_install_state)(struct drm_crtc *crtc,
+					 struct drm_crtc_state *crtc_state);
+
 	/**
 	 * @atomic_duplicate_state:
 	 *
 	 * Duplicate the current atomic state for this CRTC and return it.
 	 * The core and helpers guarantee that any atomic state duplicated with
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 22a16bc63f3e..1e02728838e2 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -425,10 +425,28 @@ struct drm_plane_funcs {
 	 */
 	int (*atomic_sro_readout_state)(struct drm_plane *plane,
 					struct drm_atomic_sro_state *state,
 					struct drm_plane_state *plane_state);
 
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
+	 * This hook cannot fail. It is called during
+	 * drm_atomic_sro_install_state(), which is part of the
+	 * hardware state readout initialization sequence.
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
2.53.0

