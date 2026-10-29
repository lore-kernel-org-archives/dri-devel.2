Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2501606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gltG74CG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F2F10FFE3;
	Thu, 29 Oct 2026 07:35:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73C310FFDA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:35:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5328A600DA;
 Thu, 29 Oct 2026 07:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835421F01825;
 Thu, 29 Oct 2026 07:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259311;
 bh=ONCupvt34ypob/K09JySoW7VTT2QQIOclSoI2AujaUE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gltG74CGVv0eVbdShW6WOMHYSypfhCMZBLJcTYva0TgOrgqdFw2PSYtpNw2DTytVr
 HBvmfpu51itJ+KwZ5I+Dwaty/+zuhXtlgT5lHlPu7imWR7g+PBD84YUoNqPuJkqhmT
 lkgEkzmHZhgWVhSmRxzb0i9P/fR1CCrP/d7quY60ZiGtngKen6ITaxVa8h4gW/E13t
 j/U/IPDxuJSQN5l0y1y94Pu6MC49NZv+TMWyd8AUHDHsaiqWfkafzYVvEO37ie4bfA
 rEDmdUqY9JNBmyg5kBeI5KZg1j5DZ8QXq5gp570UDZ0ZefXpCawwlmqyO6ffKroZ53
 J6QnoKJK3RODw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:34:03 +0100
Subject: [PATCH v7 13/34] drm/atomic_sro: Add function to install state
 into drm objects
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-13-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9889; i=mripard@kernel.org;
 h=from:subject:message-id; bh=IC5PmIGpFBkMQWVj71tvD1VS1v20hn3Px3sKZxJMJTM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvn16NPHKvXNrXD0+evB/LZSQMxBITl67z7uR2WSN2
 q7cd292dExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJOFYyNnTH/LhY52LulTA3
 d+WL7/p78ua84GCYpmEQ/O9ZgYDVK337rskRm8KZai9kGMvOsE+RZmx48DLv7/bzW/8yz1vEyDb
 pxR0LqQk1XtU2Kufz088fvfU7oGD9cRnN89Fes0LlezO+3FsMAA==
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

Once the SRO state has been built from hardware, it needs to be
installed as the current state of each KMS object.

Add drm_atomic_sro_install_state() which walks through the SRO state
container and assigns each readout state to its object's state
pointer. Before each assignment, it calls the optional
atomic_sro_install_state hook to give drivers a chance to acquire the
resources they need to keep the hardware state active.

Also introduce the atomic_sro_install_state hook in the plane, CRTC,
connector, and private object funcs vtables.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_readout.c | 145 ++++++++++++++++++++++++++++-
 include/drm/drm_atomic.h                   |  18 ++++
 include/drm/drm_atomic_state_readout.h     |   2 +
 include/drm/drm_connector.h                |  18 ++++
 include/drm/drm_crtc.h                     |  18 ++++
 include/drm/drm_plane.h                    |  18 ++++
 6 files changed, 218 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm/drm_atomic_state_readout.c
index de40e7e2231c..a5bc77b3e492 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout.c
@@ -272,5 +272,6 @@ EXPORT_SYMBOL(drm_atomic_sro_state_alloc);
  *
  * Frees a &struct drm_atomic_sro_state previously allocated with
- * drm_atomic_sro_state_alloc().
+ * drm_atomic_sro_state_alloc(). Any states that have not been
+ * installed via drm_atomic_sro_install_state() are also freed.
  */
 void drm_atomic_sro_state_free(struct drm_atomic_sro_state *state)
@@ -574,2 +575,144 @@ void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *state,
 }
 EXPORT_SYMBOL(drm_atomic_sro_set_private_obj_state);
+
+/**
+ * drm_atomic_sro_install_state - install readout state into DRM objects
+ * @state: SRO state to install
+ *
+ * Takes a &struct drm_atomic_sro_state built by
+ * &drm_mode_config_helper_funcs.atomic_sro_build_state and installs its
+ * contents as the current state of each DRM object (setting
+ * &drm_crtc.state, &drm_plane.state, &drm_connector.state and
+ * &drm_private_obj.state).
+ *
+ * For each object, the optional atomic_sro_install_state hook is
+ * called before the state pointer is updated, allowing drivers to
+ * perform any needed action.
+ */
+void drm_atomic_sro_install_state(struct drm_atomic_sro_state *state)
+{
+	unsigned int i;
+
+	for (i = 0; i <= state->max_connector_index; i++) {
+		const struct drm_connector_funcs *conn_funcs;
+		struct drm_connector_state *conn_state;
+		struct drm_connector *conn;
+
+		conn = state->connectors[i].ptr;
+		if (!conn)
+			continue;
+
+		conn_funcs = conn->funcs;
+		if (!conn_funcs)
+			continue;
+
+		if (conn->state) {
+			conn_funcs->atomic_destroy_state(conn, conn->state);
+			conn->state = NULL;
+		}
+
+		conn_state = state->connectors[i].state;
+		if (!conn_state)
+			continue;
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
+		const struct drm_crtc_funcs *crtc_funcs;
+		struct drm_crtc_state *crtc_state;
+		struct drm_crtc *crtc;
+
+		crtc = state->crtcs[i].ptr;
+		if (!crtc)
+			continue;
+
+		crtc_funcs = crtc->funcs;
+		if (!crtc_funcs)
+			continue;
+
+		if (crtc->state) {
+			crtc_funcs->atomic_destroy_state(crtc, crtc->state);
+			crtc->state = NULL;
+		}
+
+		crtc_state = state->crtcs[i].state;
+		if (!crtc_state)
+			continue;
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
+		const struct drm_plane_funcs *plane_funcs;
+		struct drm_plane_state *plane_state;
+		struct drm_plane *plane;
+
+		plane = state->planes[i].ptr;
+		if (!plane)
+			continue;
+
+		plane_funcs = plane->funcs;
+		if (!plane_funcs)
+			continue;
+
+		if (plane->state) {
+			plane_funcs->atomic_destroy_state(plane, plane->state);
+			plane->state = NULL;
+		}
+
+		plane_state = state->planes[i].state;
+		if (!plane_state)
+			continue;
+
+		if (plane_funcs->atomic_sro_install_state)
+			plane_funcs->atomic_sro_install_state(plane, plane_state);
+
+		plane->state = plane_state;
+		state->planes[i].state = NULL;
+		state->planes[i].ptr = NULL;
+	}
+
+	for (i = 0; i < count_private_obj(state->dev); i++) {
+		const struct drm_private_state_funcs *obj_funcs;
+		struct drm_private_state *obj_state;
+		struct drm_private_obj *obj;
+
+		obj = state->private_objs[i].ptr;
+		if (!obj)
+			continue;
+
+		obj_funcs = obj->funcs;
+		if (!obj_funcs)
+			continue;
+
+		if (obj->state) {
+			obj_funcs->atomic_destroy_state(obj, obj->state);
+			obj->state = NULL;
+		}
+
+		obj_state = state->private_objs[i].state;
+		if (!obj_state)
+			continue;
+
+		if (obj_funcs->atomic_sro_install_state)
+			obj_funcs->atomic_sro_install_state(obj, obj_state);
+
+		obj->state = obj_state;
+		state->private_objs[i].state = NULL;
+		state->private_objs[i].ptr = NULL;
+	}
+	state->num_private_objs = 0;
+}
+EXPORT_SYMBOL(drm_atomic_sro_install_state);
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 42923f960b30..7a66e35257d8 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -345,4 +345,22 @@ struct drm_private_state_funcs {
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
diff --git a/include/drm/drm_atomic_state_readout.h b/include/drm/drm_atomic_state_readout.h
index 6e5262384c71..195154850ab4 100644
--- a/include/drm/drm_atomic_state_readout.h
+++ b/include/drm/drm_atomic_state_readout.h
@@ -51,3 +51,5 @@ void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *state,
 					  struct drm_private_state *obj_state);
 
+void drm_atomic_sro_install_state(struct drm_atomic_sro_state *state);
+
 #endif /* DRM_ATOMIC_SRO_H_ */
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f70b3aff259d..2d8639a870b3 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1845,4 +1845,22 @@ struct drm_connector_funcs {
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
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 52365638b06f..ed69a2733a34 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -674,4 +674,22 @@ struct drm_crtc_funcs {
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
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index d16dc057adf6..381d31d5c3e2 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -426,4 +426,22 @@ struct drm_plane_funcs {
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

-- 
2.55.0

