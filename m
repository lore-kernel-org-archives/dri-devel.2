Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BAFCC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED2010E861;
	Thu, 15 Oct 2026 15:09:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2017510E95A
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:09:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0216F4334B;
 Thu, 15 Oct 2026 15:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED501F000C4;
 Thu, 15 Oct 2026 15:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792076976;
 bh=cso408BL4WC+c6fjJ4E1pt6yUMwoxS0+BwZUuabb+4E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=j9LMBBmGmPTg69L9KX0PKgquIQetJ9EJLNmfNELuwv4kIVwulDh81/44GVGtCivWV
 Fi0m3QznfxNNjoNn+DWZLWxlO7JJ2gULPYdjyShY9ybTuygmhDGQybdSpdIQSrjXJ9
 wHqAqUkrIu/SRHjTtXVgBPSHhMN9xzS6Mq1x2Sr1ugxqi0FHQegG5ercysPXiFrWWC
 gGexM1ZzdstM8CoHupnRc7BsFX+KaCuOFtY2qJzEBncqAOvY9mL5MY0/rn1PHymsl4
 X98by4fuWpM0SkEHW2gnh5dEZNM5ZQCBA2dT1dHugh6UodaDCXPB6/3WZRmnJfdNss
 vHbNuLsfy3ENg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:08:58 +0200
Subject: [PATCH v6 06/28] drm/atomic_sro: Create drm_atomic_sro_state container
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-6-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16126; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zmXdWEyTP498u8cFl+t4JxPM/I5GM9RLbaDJhLIulCk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3vRqbNh4ge3994Bll9RzEziO5ykUij5yTdZnLOB8a
 5Y2mfF/x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiI7wzGhsnr7Rb5//vdEunk
 vCqt6nFuRs8XmUp1poMRHElcJxwMGfT7/i1w7MpZZrSrt7Iut62UsWFaieue9plX47nDI07MNL6
 hcKn0IMO8Dfczp0VMu52wcNdazrstPjE57T2uTLMuS2cv1wcA
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

The SRO infrastructure needs a state container to collect the readout
states for all KMS objects. Unlike drm_atomic_commit which tracks old
and new states for atomic commits, this container only holds a single
state per object: the one read out from the hardware.

Create struct drm_atomic_sro_state with arrays for planes, CRTCs,
connectors, and private objects, along with accessors to get and set
individual object states within it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/Makefile         |   1 +
 drivers/gpu/drm/drm_atomic_sro.c | 454 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic_sro.h     |  51 +++++
 3 files changed, 506 insertions(+)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c6bc093a923..80d590aea521 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -32,10 +32,11 @@ endif
 # Enable -Werror in CI and development
 subdir-ccflags-$(CONFIG_DRM_WERROR) += -Werror
 
 drm-y := \
 	drm_atomic.o \
+	drm_atomic_sro.o \
 	drm_atomic_uapi.o \
 	drm_auth.o \
 	drm_blend.o \
 	drm_bridge.o \
 	drm_cache.o \
diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
new file mode 100644
index 000000000000..096fdb708819
--- /dev/null
+++ b/drivers/gpu/drm/drm_atomic_sro.c
@@ -0,0 +1,454 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_sro.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_print.h>
+#include <linux/module.h>
+
+#include "drm_internal.h"
+#include "drm_crtc_internal.h"
+
+struct __drm_atomic_sro_plane {
+	struct drm_plane *ptr;
+	struct drm_plane_state *state;
+};
+
+struct __drm_atomic_sro_crtc {
+	struct drm_crtc *ptr;
+	struct drm_crtc_state *state;
+};
+
+struct __drm_atomic_sro_connector {
+	struct drm_connector *ptr;
+	struct drm_connector_state *state;
+};
+
+struct __drm_atomic_sro_private_obj {
+	struct drm_private_obj *ptr;
+	struct drm_private_state *state;
+};
+
+struct drm_atomic_sro_state {
+	struct drm_device *dev;
+	struct __drm_atomic_sro_plane *planes;
+	struct __drm_atomic_sro_crtc *crtcs;
+	struct __drm_atomic_sro_connector *connectors;
+	struct __drm_atomic_sro_private_obj *private_objs;
+	unsigned int num_private_objs;
+};
+
+static unsigned int count_private_obj(struct drm_device *dev)
+{
+	struct drm_mode_config *config = &dev->mode_config;
+	struct drm_private_obj *obj;
+	unsigned int count = 0;
+
+	list_for_each_entry(obj, &config->privobj_list, head)
+		count++;
+
+	return count;
+}
+
+/**
+ * drm_atomic_sro_state_get_device - get the DRM device from an SRO state
+ * @state: SRO state
+ *
+ * RETURNS:
+ *
+ * The &struct drm_device associated with the SRO state.
+ */
+struct drm_device *
+drm_atomic_sro_state_get_device(struct drm_atomic_sro_state *state)
+{
+	return state->dev;
+}
+
+static int drm_atomic_sro_state_init(struct drm_device *dev,
+				     struct drm_atomic_sro_state *state)
+{
+	int err;
+
+	state->planes =
+		kzalloc_objs(*state->planes, dev->mode_config.num_total_plane);
+	if (!state->planes)
+		return -ENOMEM;
+
+	state->crtcs = kzalloc_objs(*state->crtcs, dev->mode_config.num_crtc);
+	if (!state->crtcs) {
+		err = -ENOMEM;
+		goto err_free_planes;
+	}
+
+	state->connectors = kzalloc_objs(*state->connectors,
+					 dev->mode_config.num_connector);
+	if (!state->connectors) {
+		err = -ENOMEM;
+		goto err_free_crtcs;
+	}
+
+	state->private_objs =
+		kzalloc_objs(*state->private_objs, count_private_obj(dev));
+	if (!state->private_objs)  {
+		err = -ENOMEM;
+		goto err_free_connectors;
+	}
+
+	state->num_private_objs = 0;
+
+	drm_dev_get(dev);
+	state->dev = dev;
+
+	return 0;
+
+err_free_connectors:
+	kfree(state->connectors);
+err_free_crtcs:
+	kfree(state->crtcs);
+err_free_planes:
+	kfree(state->planes);
+	return err;
+}
+
+/**
+ * drm_atomic_sro_state_alloc - allocate an SRO state container
+ * @dev: DRM device to allocate the state for
+ *
+ * Allocates and initializes a &struct drm_atomic_sro_state that can hold
+ * readout states for all KMS objects on @dev.
+ *
+ * The returned state must be freed with drm_atomic_sro_state_free().
+ *
+ * RETURNS:
+ *
+ * A new &struct drm_atomic_sro_state on success, an error pointer on
+ * failure.
+ */
+struct drm_atomic_sro_state *drm_atomic_sro_state_alloc(struct drm_device *dev)
+{
+	struct drm_atomic_sro_state *state;
+	int ret;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return ERR_PTR(-EINVAL);
+
+	ret = drm_atomic_sro_state_init(dev, state);
+	if (ret) {
+		kfree(state);
+		return ERR_PTR(ret);
+	}
+
+	return state;
+}
+EXPORT_SYMBOL(drm_atomic_sro_state_alloc);
+
+/**
+ * drm_atomic_sro_state_free - free an SRO state container
+ * @state: SRO state to free
+ *
+ * Frees a &struct drm_atomic_sro_state previously allocated with
+ * drm_atomic_sro_state_alloc().
+ */
+void drm_atomic_sro_state_free(struct drm_atomic_sro_state *state)
+{
+	struct drm_device *dev = state->dev;
+	unsigned int i;
+
+	for (i = 0; i < state->num_private_objs; i++) {
+		struct drm_private_obj *obj = state->private_objs[i].ptr;
+		struct drm_private_state *obj_state = state->private_objs[i].state;
+
+		if (!obj || !obj_state)
+			continue;
+
+		obj->funcs->atomic_destroy_state(obj, obj_state);
+		state->private_objs[i].state = NULL;
+		state->private_objs[i].ptr = NULL;
+	}
+
+	kfree(state->private_objs);
+
+	for (i = 0; i < state->dev->mode_config.num_connector; i++) {
+		struct drm_connector *conn = state->connectors[i].ptr;
+		struct drm_connector_state *conn_state =
+			state->connectors[i].state;
+
+		if (!conn || !conn_state)
+			continue;
+
+		conn->funcs->atomic_destroy_state(conn, conn_state);
+		state->connectors[i].state = NULL;
+		state->connectors[i].ptr = NULL;
+		drm_connector_put(conn);
+	}
+
+	kfree(state->connectors);
+
+	for (i = 0; i < state->dev->mode_config.num_crtc; i++) {
+		struct drm_crtc *crtc = state->crtcs[i].ptr;
+		struct drm_crtc_state *crtc_state =
+			state->crtcs[i].state;
+
+		if (!crtc || !crtc_state)
+			continue;
+
+		crtc->funcs->atomic_destroy_state(crtc, crtc_state);
+		state->crtcs[i].state = NULL;
+		state->crtcs[i].ptr = NULL;
+	}
+
+	kfree(state->crtcs);
+
+	for (i = 0; i < state->dev->mode_config.num_total_plane; i++) {
+		struct drm_plane *plane = state->planes[i].ptr;
+		struct drm_plane_state *plane_state =
+			state->planes[i].state;
+
+		if (!plane || !plane_state)
+			continue;
+
+		plane->funcs->atomic_destroy_state(plane, plane_state);
+		state->planes[i].state = NULL;
+		state->planes[i].ptr = NULL;
+	}
+
+	kfree(state->planes);
+	kfree(state);
+
+	drm_dev_put(dev);
+}
+EXPORT_SYMBOL(drm_atomic_sro_state_free);
+
+/**
+ * drm_atomic_sro_state_print - prints drm atomic SRO state
+ * @state: SRO state to print
+ * @p: drm printer
+ *
+ * This function prints the SRO state snapshot using the drm printer which is
+ * passed to it. This snapshot can be used for debugging purposes.
+ */
+void drm_atomic_sro_state_print(const struct drm_atomic_sro_state *state,
+				struct drm_printer *p)
+{
+	struct drm_mode_config *config = &state->dev->mode_config;
+	int i;
+
+	if (!p) {
+		drm_err(state->dev, "invalid drm printer\n");
+		return;
+	}
+
+	drm_dbg_atomic(state->dev, "Printing readout state %p\n", state);
+
+	for (i = 0; i < config->num_total_plane; i++) {
+		struct drm_plane_state *plane_state = state->planes[i].state;
+
+		if (!plane_state)
+			continue;
+
+		drm_atomic_plane_print_state(p, plane_state);
+	}
+
+	for (i = 0; i < config->num_crtc; i++) {
+		struct drm_crtc_state *crtc_state = state->crtcs[i].state;
+
+		if (!crtc_state)
+			continue;
+
+		drm_atomic_crtc_print_state(p, crtc_state);
+	}
+
+	for (i = 0; i < config->num_connector; i++) {
+		struct drm_connector_state *conn_state = state->connectors[i].state;
+
+		if (!conn_state)
+			continue;
+
+		drm_atomic_connector_print_state(p, conn_state);
+	}
+
+	for (i = 0; i < state->num_private_objs; i++) {
+		struct drm_private_state *obj_state = state->private_objs[i].state;
+
+		if (!obj_state)
+			continue;
+
+		drm_atomic_private_obj_print_state(p, obj_state);
+	}
+}
+EXPORT_SYMBOL(drm_atomic_sro_state_print);
+
+/**
+ * drm_atomic_sro_get_plane_state - get the plane state from an SRO state
+ * @state: SRO state container
+ * @plane: plane to get the state for
+ *
+ * RETURNS:
+ *
+ * The &struct drm_plane_state for @plane, or NULL if not yet read out.
+ */
+struct drm_plane_state *
+drm_atomic_sro_get_plane_state(struct drm_atomic_sro_state *state,
+			       struct drm_plane *plane)
+{
+	unsigned int index = drm_plane_index(plane);
+
+	return state->planes[index].state;
+};
+EXPORT_SYMBOL(drm_atomic_sro_get_plane_state);
+
+/**
+ * drm_atomic_sro_set_plane_state - store a plane state into an SRO state
+ * @state: SRO state container
+ * @plane: plane the state belongs to
+ * @plane_state: plane state to store
+ */
+void drm_atomic_sro_set_plane_state(struct drm_atomic_sro_state *state,
+				    struct drm_plane *plane,
+				    struct drm_plane_state *plane_state)
+{
+	unsigned int index = drm_plane_index(plane);
+
+	state->planes[index].ptr = plane;
+	state->planes[index].state = plane_state;
+
+	drm_dbg_atomic(plane->dev,
+		       "Added [PLANE:%d:%s] %p state to readout state %p\n",
+		       plane->base.id, plane->name, plane_state, state);
+}
+EXPORT_SYMBOL(drm_atomic_sro_set_plane_state);
+
+/**
+ * drm_atomic_sro_get_crtc_state - get the CRTC state from an SRO state
+ * @state: SRO state container
+ * @crtc: CRTC to get the state for
+ *
+ * RETURNS:
+ *
+ * The &struct drm_crtc_state for @crtc, or NULL if not yet read out.
+ */
+struct drm_crtc_state *
+drm_atomic_sro_get_crtc_state(struct drm_atomic_sro_state *state,
+			      struct drm_crtc *crtc)
+{
+	unsigned int index = drm_crtc_index(crtc);
+
+	return state->crtcs[index].state;
+};
+EXPORT_SYMBOL(drm_atomic_sro_get_crtc_state);
+
+/**
+ * drm_atomic_sro_set_crtc_state - store a CRTC state into an SRO state
+ * @state: SRO state container
+ * @crtc: CRTC the state belongs to
+ * @crtc_state: CRTC state to store
+ */
+void drm_atomic_sro_set_crtc_state(struct drm_atomic_sro_state *state,
+				   struct drm_crtc *crtc,
+				   struct drm_crtc_state *crtc_state)
+{
+	unsigned int index = drm_crtc_index(crtc);
+
+	state->crtcs[index].ptr = crtc;
+	state->crtcs[index].state = crtc_state;
+
+	drm_dbg_atomic(state->dev,
+		       "Added [CRTC:%d:%s] %p state to readout state %p\n",
+		       crtc->base.id, crtc->name, crtc_state, state);
+}
+EXPORT_SYMBOL(drm_atomic_sro_set_crtc_state);
+
+/**
+ * drm_atomic_sro_get_connector_state - get the connector state from an SRO state
+ * @state: SRO state container
+ * @connector: connector to get the state for
+ *
+ * RETURNS:
+ *
+ * The &struct drm_connector_state for @connector, or NULL if not yet
+ * read out.
+ */
+struct drm_connector_state *
+drm_atomic_sro_get_connector_state(struct drm_atomic_sro_state *state,
+				   struct drm_connector *connector)
+{
+	unsigned int index = drm_connector_index(connector);
+
+	return state->connectors[index].state;
+};
+EXPORT_SYMBOL(drm_atomic_sro_get_connector_state);
+
+/**
+ * drm_atomic_sro_set_connector_state - store a connector state into an SRO state
+ * @state: SRO state container
+ * @conn: connector the state belongs to
+ * @conn_state: connector state to store
+ *
+ * Takes a reference on @conn which is released when the state is
+ * installed or freed.
+ */
+void drm_atomic_sro_set_connector_state(struct drm_atomic_sro_state *state,
+					struct drm_connector *conn,
+					struct drm_connector_state *conn_state)
+{
+	unsigned int index = drm_connector_index(conn);
+
+	drm_connector_get(conn);
+	state->connectors[index].ptr = conn;
+	state->connectors[index].state = conn_state;
+
+	drm_dbg_atomic(conn->dev,
+		       "Added [CONNECTOR:%d:%s] %p state to readout state %p\n",
+		       conn->base.id, conn->name, conn_state, state);
+}
+EXPORT_SYMBOL(drm_atomic_sro_set_connector_state);
+
+/**
+ * drm_atomic_sro_get_private_obj_state - get a private object state from an SRO state
+ * @state: SRO state container
+ * @obj: private object to get the state for
+ *
+ * RETURNS:
+ *
+ * The &struct drm_private_state for @obj, or NULL if not yet read out.
+ */
+struct drm_private_state *
+drm_atomic_sro_get_private_obj_state(struct drm_atomic_sro_state *state,
+				     struct drm_private_obj *obj)
+{
+	unsigned int i;
+
+	for (i = 0; i < state->num_private_objs; i++)
+		if (obj == state->private_objs[i].ptr)
+			return state->private_objs[i].state;
+
+	return NULL;
+}
+EXPORT_SYMBOL(drm_atomic_sro_get_private_obj_state);
+
+/**
+ * drm_atomic_sro_set_private_obj_state - store a private object state into an SRO state
+ * @state: SRO state container
+ * @obj: private object the state belongs to
+ * @obj_state: private object state to store
+ */
+void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *state,
+					  struct drm_private_obj *obj,
+					  struct drm_private_state *obj_state)
+{
+	unsigned int index = state->num_private_objs;
+
+	state->private_objs[index].ptr = obj;
+	state->private_objs[index].state = obj_state;
+	state->num_private_objs += 1;
+
+	drm_dbg_atomic(state->dev,
+		       "Added new private object %p state %p to readout state %p\n", obj,
+		       obj_state, state);
+}
+EXPORT_SYMBOL(drm_atomic_sro_set_private_obj_state);
diff --git a/include/drm/drm_atomic_sro.h b/include/drm/drm_atomic_sro.h
new file mode 100644
index 000000000000..5a9333a05796
--- /dev/null
+++ b/include/drm/drm_atomic_sro.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef DRM_ATOMIC_SRO_H_
+#define DRM_ATOMIC_SRO_H_
+
+struct drm_atomic_sro_state;
+struct drm_connector;
+struct drm_connector_state;
+struct drm_crtc;
+struct drm_crtc_state;
+struct drm_device;
+struct drm_plane;
+struct drm_plane_state;
+struct drm_printer;
+struct drm_private_obj;
+struct drm_private_state;
+
+struct drm_atomic_sro_state *drm_atomic_sro_state_alloc(struct drm_device *dev);
+void drm_atomic_sro_state_free(struct drm_atomic_sro_state *state);
+void drm_atomic_sro_state_print(const struct drm_atomic_sro_state *state,
+				struct drm_printer *p);
+
+struct drm_device *
+drm_atomic_sro_state_get_device(struct drm_atomic_sro_state *state);
+
+struct drm_plane_state *
+drm_atomic_sro_get_plane_state(struct drm_atomic_sro_state *state,
+			       struct drm_plane *plane);
+void drm_atomic_sro_set_plane_state(struct drm_atomic_sro_state *state,
+				    struct drm_plane *plane,
+				    struct drm_plane_state *plane_state);
+struct drm_crtc_state *
+drm_atomic_sro_get_crtc_state(struct drm_atomic_sro_state *state,
+			      struct drm_crtc *crtc);
+void drm_atomic_sro_set_crtc_state(struct drm_atomic_sro_state *state,
+				   struct drm_crtc *crtc,
+				   struct drm_crtc_state *crtc_state);
+struct drm_connector_state *
+drm_atomic_sro_get_connector_state(struct drm_atomic_sro_state *state,
+				   struct drm_connector *connector);
+void drm_atomic_sro_set_connector_state(struct drm_atomic_sro_state *state,
+					struct drm_connector *conn,
+					struct drm_connector_state *conn_state);
+struct drm_private_state *
+drm_atomic_sro_get_private_obj_state(struct drm_atomic_sro_state *state,
+				     struct drm_private_obj *private_obj);
+void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *state,
+					  struct drm_private_obj *obj,
+					  struct drm_private_state *obj_state);
+
+#endif /* DRM_ATOMIC_SRO_H_ */

-- 
2.55.0

