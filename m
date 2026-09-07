Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83212C79FA1
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E0710E78D;
	Mon,  7 Sep 2026 13:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iZyZjkRd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C037310E69A
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:24:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A6BC043F48;
 Mon,  7 Sep 2026 13:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30101F00A3D;
 Mon,  7 Sep 2026 13:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787486;
 bh=zh+eEa/GKt+SeeXb8/d9X2kXgEJfj/0AX9fsCQFIf9Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iZyZjkRdAkfudXj/WJMQYBcSrT44to5dDrX+WysuTOT2pRv8cEMmGEk6AU/H9zwyy
 TeCLExtkdgMFsCy9VVpgBhlEiIlA2pPr2bayjpytI1hVYSrYBJ+9sSLf0WPPFbdtL4
 7666EhHbrKOMHrmQKfqva5oWrdp6Vp0svm2hmdU05330r1LiKMOQFAaJChpDBsFYYW
 kXHfQMw/IYb/Tm1P5KHcjFFnL0iUk5ULrVZaKsBEBakaEp231ht9NjyOUElVQK01J9
 B8I+QtbWAMrX+Eqw8xesfWoeb3Kbg8l5+WCK7Gm0jETDTl4S28myE33IKwcYI58Oa2
 +RNbdsFLreHPg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:23:48 +0200
Subject: [PATCH v5 12/33] drm/atomic_sro: Add function to install state
 into drm objects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-12-5fa1ac7a5148@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11233; i=mripard@kernel.org;
 h=from:subject:message-id; bh=T3gAisCuyQhLHCEJgnfqrMAH4BtdSww7tRMdwfhJi1w=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdj2uF527u8hC4MoS/drPAfKLHOYtDmoqC8m5s2DfI
 5FZHsc+dUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ7OhkbDj/nPPm6g3/zsZn
 82hfz0h75Puv+G111nlvFh7R60s5c0p3BCim75GerdJexP9k1+Nnlxkb9jE/LM+cNmlyupSVRtO
 fn2y3bCyaFjFr3+E96+mm9oxVafYK3upy4VnM6xXfpHwN8O4EAA==
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
 drivers/gpu/drm/drm_atomic_sro.c | 145 ++++++++++++++++++++++++++++++++++++++-
 include/drm/drm_atomic.h         |  18 +++++
 include/drm/drm_atomic_sro.h     |   2 +
 include/drm/drm_connector.h      |  18 +++++
 include/drm/drm_crtc.h           |  18 +++++
 include/drm/drm_plane.h          |  18 +++++
 6 files changed, 218 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
index 6921af73eb69..14fddd760165 100644
--- a/drivers/gpu/drm/drm_atomic_sro.c
+++ b/drivers/gpu/drm/drm_atomic_sro.c
@@ -246,11 +246,12 @@ EXPORT_SYMBOL(drm_atomic_sro_state_alloc);
 /**
  * drm_atomic_sro_state_free - free an SRO state container
  * @state: SRO state to free
  *
  * Frees a &struct drm_atomic_sro_state previously allocated with
- * drm_atomic_sro_state_alloc().
+ * drm_atomic_sro_state_alloc(). Any states that have not been
+ * installed via drm_atomic_sro_install_state() are also freed.
  */
 void drm_atomic_sro_state_free(struct drm_atomic_sro_state *state)
 {
 	struct drm_device *dev = state->dev;
 	unsigned int i;
@@ -546,5 +547,147 @@ void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *state,
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
+	for (i = 0; i < state->dev->mode_config.num_connector; i++) {
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
index 657f5f4c223f..0e5c87f258ef 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -321,10 +321,28 @@ struct drm_private_state_funcs {
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
index 730a2e41f2c5..50e9e94c2532 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1759,10 +1759,28 @@ struct drm_connector_funcs {
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
index 62366caf2a84..a23364fa7e3e 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -666,10 +666,28 @@ struct drm_crtc_funcs {
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
index d841fee3a9cd..358c4f4062b4 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -428,10 +428,28 @@ struct drm_plane_funcs {
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
2.55.0

