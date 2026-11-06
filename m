Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB606606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyYmmNn+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B3E10EA0E;
	Fri,  6 Nov 2026 13:16:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A23610EA0E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 01099418AA;
 Fri,  6 Nov 2026 13:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262231F0089F;
 Fri,  6 Nov 2026 13:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970954;
 bh=x9hVsu2U8j4pPVzE2wP5d/blvVtJ3Em+V09K/+fE5CE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RyYmmNn+g1z3i12NR7GGdkmYV/3vEOQ+dH/tZvlv6SRMqXt8vmCLQ6QL4Lgx6LAwr
 ywJqomWcUE3x9DYhG04e0/XUJJ5by/T6Vlno+bxJhRHA3mTXfMPCFs0OCptVLgTlDH
 ihKakIfc2aqaWW5IQVKcDTNgrcfY7/oGYERB/0wvIauG9qsAAODw2r4QFmKBNoWEfw
 oCn/SdQyh28I1emevYHhxrd7pTlg7EvIGra01CI46sxj40DLqHdRgB1Mh4wbYEWw8b
 u4oaIg3tKTDMSPvyZE0aagmuMCou7b6ZAQr1+ms9KG2jUbWIInuQnyOU6NxiPdwD8/
 Lmdn0cbVsd5aQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:33 +0100
Subject: [PATCH v8 20/39] drm/atomic_sro: Provide helpers to implement
 hardware state readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-20-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=29490; i=mripard@kernel.org;
 h=from:subject:message-id; bh=LE6cMnNyRRGJIhrbVYAtQ8UZtF2zPKzm0Evz0JFqijI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL21de/Sogq743xfsmdFPruZyJ1hbrnQtTwlvzFi9J
 MPu4MbgjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRtaqMDZ2ndii5XQh6x3GY
 ReMm+4R5Kct7b59yCes7xZVzonxue3OqwK//pZIn8uY15EyVqZ8ux9iw8Yb/kaV8KTf6LVKkso3
 3y/FkZPXHu6Y0fl3MzHj++bcC+xkcoZHF4YnZ0udCVE7b+AEA
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

Drivers implementing SRO need to iterate over their KMS objects,
allocate a pristine state for each, call the readout hook, and store
the result in the SRO state container.

Provide helpers for each object type
(drm_atomic_helper_sro_readout_planes_state(),
drm_atomic_helper_sro_readout_crtcs_state(), etc.) and a top-level
drm_atomic_helper_sro_build_state() that calls them in sequence.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/gpu/drm-kms-helpers.rst             |   9 +
 drivers/gpu/drm/Makefile                          |   1 +
 drivers/gpu/drm/drm_atomic_state_readout.c        |   5 +-
 drivers/gpu/drm/drm_atomic_state_readout_helper.c | 789 ++++++++++++++++++++++
 include/drm/drm_atomic_state_readout_helper.h     |  35 +
 include/drm/drm_modeset_helper_vtables.h          |   3 +
 6 files changed, 841 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index b75bde712faf..a6dd8dbb3218 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -100,4 +100,13 @@ Atomic State Read-Out Reference
    :export:
 
+Atomic State Read-Out Helpers Reference
+----------------------------------------
+
+.. kernel-doc:: include/drm/drm_atomic_state_readout_helper.h
+   :internal:
+
+.. kernel-doc:: drivers/gpu/drm/drm_atomic_state_readout_helper.c
+   :export:
+
 GEM Atomic Helper Reference
 ---------------------------
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e94b77497514..7c8b778f4d5e 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -144,4 +144,5 @@ drm_kms_helper-y := \
 	drm_atomic_helper.o \
 	drm_atomic_state_helper.o \
+	drm_atomic_state_readout_helper.o \
 	drm_bridge_helper.o \
 	drm_crtc_helper.o \
diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm/drm_atomic_state_readout.c
index d0f8665860ff..b91a8f71b78b 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout.c
@@ -49,5 +49,8 @@
  * object funcs vtables and setting the
  * &drm_mode_config_funcs.atomic_sro_readout_state and
- * &drm_mode_config_helper_funcs.atomic_sro_build_state callbacks.
+ * &drm_mode_config_helper_funcs.atomic_sro_build_state callbacks. The
+ * default helpers drm_atomic_helper_sro_readout_state() and
+ * drm_atomic_helper_sro_build_state() handle the standard readout
+ * sequence.
  */
 
diff --git a/drivers/gpu/drm/drm_atomic_state_readout_helper.c b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
new file mode 100644
index 000000000000..1b6cf304702c
--- /dev/null
+++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
@@ -0,0 +1,789 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_colorop.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_print.h>
+
+#include <linux/gfp.h>
+#include <linux/sched/mm.h>
+
+static int
+drm_atomic_helper_sro_readout_plane_state(struct drm_device *dev,
+					  struct drm_atomic_sro_state *state,
+					  struct drm_plane *plane)
+{
+	const struct drm_plane_funcs *plane_funcs = plane->funcs;
+	struct drm_plane_state *plane_state;
+	int ret;
+
+	if (!plane_funcs->atomic_sro_readout_state) {
+		/*
+		 * Missing readout implementations are only allowed
+		 * when drm.atomic_readout skips them, but the object
+		 * still needs a valid state: fall back to a pristine
+		 * state, like drm_mode_config_create_state() would.
+		 */
+		drm_warn(dev, "No plane readout implementation.");
+
+		plane_state = plane_funcs->atomic_create_state(plane);
+		if (drm_WARN_ON(dev, IS_ERR(plane_state)))
+			return PTR_ERR(plane_state);
+
+		drm_atomic_sro_set_plane_state(state, plane, plane_state);
+		return 0;
+	}
+
+	drm_dbg_kms(dev, "Initializing Plane %s state.\n", plane->name);
+
+	plane_state = plane_funcs->atomic_create_state(plane);
+	if (drm_WARN_ON(dev, IS_ERR(plane_state)))
+		return PTR_ERR(plane_state);
+
+	ret = plane_funcs->atomic_sro_readout_state(plane, state,
+						    plane_state);
+	if (ret) {
+		drm_dbg_kms(dev, "Plane %s readout failed: %pe\n",
+			    plane->name, ERR_PTR(ret));
+		plane_funcs->atomic_destroy_state(plane, plane_state);
+		return ret;
+	}
+
+	drm_atomic_sro_set_plane_state(state, plane, plane_state);
+
+	return 0;
+}
+
+static int
+drm_atomic_helper_sro_readout_commit_planes_state(struct drm_device *dev,
+						  struct drm_atomic_sro_state *state,
+						  struct drm_atomic_commit *commit)
+{
+	struct drm_plane_state *new_plane_state;
+	struct drm_plane *plane;
+	unsigned int i;
+	int ret;
+
+	if (!commit)
+		return -EINVAL;
+
+	for_each_new_plane_in_state(commit, plane, new_plane_state, i) {
+		ret = drm_atomic_helper_sro_readout_plane_state(dev, state, plane);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * drm_atomic_helper_sro_readout_planes_state - read out all plane states from hardware
+ * @dev: DRM device
+ * @state: SRO state container to fill
+ * @commit: optional atomic commit limiting the objects to read out
+ *
+ * Iterates over the planes that have a state in @commit when it isn't
+ * NULL, or over all the planes of @dev otherwise. For each, allocates
+ * a state via atomic_create_state, and calls the plane's
+ * atomic_sro_readout_state hook to fill it from hardware.
+ *
+ * RETURNS:
+ *
+ * 0 on success, a negative error code otherwise.
+ */
+int
+drm_atomic_helper_sro_readout_planes_state(struct drm_device *dev,
+					   struct drm_atomic_sro_state *state,
+					   struct drm_atomic_commit *commit)
+{
+	struct drm_plane *plane;
+	int ret;
+
+	might_alloc(GFP_KERNEL);
+
+	if (commit)
+		return drm_atomic_helper_sro_readout_commit_planes_state(dev, state, commit);
+
+	drm_for_each_plane(plane, dev) {
+		ret = drm_atomic_helper_sro_readout_plane_state(dev, state, plane);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_helper_sro_readout_planes_state);
+
+static int
+drm_atomic_helper_sro_readout_crtc_state(struct drm_device *dev,
+					 struct drm_atomic_sro_state *state,
+					 struct drm_crtc *crtc)
+{
+	const struct drm_crtc_funcs *crtc_funcs = crtc->funcs;
+	struct drm_crtc_state *crtc_state;
+	int ret;
+
+	if (!crtc_funcs->atomic_sro_readout_state) {
+		/*
+		 * Missing readout implementations are only allowed
+		 * when drm.atomic_readout skips them, but the object
+		 * still needs a valid state: fall back to a pristine
+		 * state, like drm_mode_config_create_state() would.
+		 */
+		drm_warn(dev, "No CRTC readout implementation.");
+
+		crtc_state = crtc_funcs->atomic_create_state(crtc);
+		if (drm_WARN_ON(dev, IS_ERR(crtc_state)))
+			return PTR_ERR(crtc_state);
+
+		drm_atomic_sro_set_crtc_state(state, crtc, crtc_state);
+		return 0;
+	}
+
+	drm_dbg_kms(dev, "Initializing CRTC %s state.\n", crtc->name);
+
+	crtc_state = crtc_funcs->atomic_create_state(crtc);
+	if (drm_WARN_ON(dev, IS_ERR(crtc_state)))
+		return PTR_ERR(crtc_state);
+
+	ret = crtc_funcs->atomic_sro_readout_state(crtc, state, crtc_state);
+	if (ret) {
+		drm_dbg_kms(dev, "CRTC %s readout failed: %pe\n",
+			    crtc->name, ERR_PTR(ret));
+		crtc_funcs->atomic_destroy_state(crtc, crtc_state);
+		return ret;
+	}
+
+	drm_atomic_sro_set_crtc_state(state, crtc, crtc_state);
+
+	return 0;
+}
+
+static int
+drm_atomic_helper_sro_readout_commit_crtcs_state(struct drm_device *dev,
+						 struct drm_atomic_sro_state *state,
+						 struct drm_atomic_commit *commit)
+{
+	struct drm_crtc_state *new_crtc_state, *readout_crtc_state;
+	struct drm_crtc *crtc;
+	unsigned int i;
+	int ret;
+
+	if (!commit)
+		return -EINVAL;
+
+	for_each_new_crtc_in_state(commit, crtc, new_crtc_state, i) {
+		ret = drm_atomic_helper_sro_readout_crtc_state(dev, state, crtc);
+		if (ret)
+			return ret;
+
+		/*
+		 * A commit can include a CRTC without including all the
+		 * planes and connectors enabled on it, a plane property
+		 * update for instance, but the readout CRTC state needs a
+		 * complete plane_mask, connector_mask and encoder_mask to
+		 * compare against the committed one.
+		 *
+		 * Only the objects of the commit are read out, as their
+		 * locks are the only ones held, so report the objects the
+		 * commit doesn't touch as enabled: the commit doesn't
+		 * affect them, and the objects it does affect are
+		 * verified by their own comparison hooks.
+		 */
+		readout_crtc_state = drm_atomic_sro_get_crtc_state(state, crtc);
+		if (readout_crtc_state) {
+			readout_crtc_state->plane_mask |= new_crtc_state->plane_mask;
+			readout_crtc_state->connector_mask |= new_crtc_state->connector_mask;
+			readout_crtc_state->encoder_mask |= new_crtc_state->encoder_mask;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * drm_atomic_helper_sro_readout_crtcs_state - read out all CRTC states from hardware
+ * @dev: DRM device
+ * @state: SRO state container to fill
+ * @commit: optional atomic commit limiting the objects to read out
+ *
+ * Iterates over the CRTCs that have a state in @commit when it isn't
+ * NULL, or over all the CRTCs of @dev otherwise. For each, allocates a
+ * state via atomic_create_state, and calls the CRTC's
+ * atomic_sro_readout_state hook to fill it from hardware.
+ *
+ * RETURNS:
+ *
+ * 0 on success, a negative error code otherwise.
+ */
+int
+drm_atomic_helper_sro_readout_crtcs_state(struct drm_device *dev,
+					  struct drm_atomic_sro_state *state,
+					  struct drm_atomic_commit *commit)
+{
+	struct drm_crtc *crtc;
+	int ret;
+
+	might_alloc(GFP_KERNEL);
+
+	if (commit)
+		return drm_atomic_helper_sro_readout_commit_crtcs_state(dev, state, commit);
+
+	drm_for_each_crtc(crtc, dev) {
+		ret = drm_atomic_helper_sro_readout_crtc_state(dev, state, crtc);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_helper_sro_readout_crtcs_state);
+
+static int
+drm_atomic_helper_sro_readout_connector_state(struct drm_device *dev,
+					      struct drm_atomic_sro_state *state,
+					      struct drm_connector *connector)
+{
+	const struct drm_connector_funcs *conn_funcs = connector->funcs;
+	struct drm_connector_state *conn_state;
+	int ret;
+
+	if (!conn_funcs->atomic_sro_readout_state) {
+		/*
+		 * Missing readout implementations are only allowed
+		 * when drm.atomic_readout skips them, but the object
+		 * still needs a valid state: fall back to a pristine
+		 * state, like drm_mode_config_create_state() would.
+		 */
+		drm_warn(dev, "No connector readout implementation.");
+
+		conn_state = conn_funcs->atomic_create_state(connector);
+		if (drm_WARN_ON(dev, IS_ERR(conn_state)))
+			return PTR_ERR(conn_state);
+
+		drm_atomic_sro_set_connector_state(state, connector, conn_state);
+		return 0;
+	}
+
+	drm_dbg_kms(dev, "Initializing connector %s state.\n",
+		    connector->name);
+
+	conn_state = conn_funcs->atomic_create_state(connector);
+	if (drm_WARN_ON(dev, IS_ERR(conn_state)))
+		return PTR_ERR(conn_state);
+
+	ret = conn_funcs->atomic_sro_readout_state(connector, state,
+						   conn_state);
+	if (ret) {
+		drm_dbg_kms(dev, "Connector %s readout failed: %pe\n",
+			    connector->name, ERR_PTR(ret));
+		conn_funcs->atomic_destroy_state(connector, conn_state);
+		return ret;
+	}
+
+	drm_atomic_sro_set_connector_state(state, connector, conn_state);
+
+	return 0;
+}
+
+static int
+drm_atomic_helper_sro_readout_commit_connectors_state(struct drm_device *dev,
+						      struct drm_atomic_sro_state *state,
+						      struct drm_atomic_commit *commit)
+{
+	struct drm_connector_state *new_connector_state;
+	struct drm_connector *connector;
+	unsigned int i;
+	int ret;
+
+	if (!commit)
+		return -EINVAL;
+
+	for_each_new_connector_in_state(commit, connector, new_connector_state, i) {
+		ret = drm_atomic_helper_sro_readout_connector_state(dev, state, connector);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * drm_atomic_helper_sro_readout_connectors_state - read out all connector states from hardware
+ * @dev: DRM device
+ * @state: SRO state container to fill
+ * @commit: optional atomic commit limiting the objects to read out
+ *
+ * Iterates over the connectors that have a state in @commit when it
+ * isn't NULL, or over all the connectors of @dev otherwise. For each,
+ * allocates a state via atomic_create_state, and calls the connector's
+ * atomic_sro_readout_state hook to fill it from hardware.
+ *
+ * RETURNS:
+ *
+ * 0 on success, a negative error code otherwise.
+ */
+int
+drm_atomic_helper_sro_readout_connectors_state(struct drm_device *dev,
+					       struct drm_atomic_sro_state *state,
+					       struct drm_atomic_commit *commit)
+{
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *connector;
+	int ret;
+
+	might_alloc(GFP_KERNEL);
+
+	if (commit)
+		return drm_atomic_helper_sro_readout_commit_connectors_state(dev, state, commit);
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		ret = drm_atomic_helper_sro_readout_connector_state(dev, state, connector);
+		if (ret) {
+			drm_connector_list_iter_end(&conn_iter);
+			return ret;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_helper_sro_readout_connectors_state);
+
+static int
+drm_atomic_helper_sro_readout_bridge_state(struct drm_device *dev,
+					   struct drm_atomic_sro_state *state,
+					   struct drm_bridge *bridge)
+{
+	struct drm_private_obj *bridge_obj = &bridge->base;
+	const struct drm_private_state_funcs *bridge_obj_funcs =
+		bridge_obj->funcs;
+	struct drm_private_state *bridge_obj_state;
+	int ret;
+
+	/*
+	 * The same bridge chain can be reached through several
+	 * connectors of the commit. This happens for instance when a
+	 * commit disables a connector and routes another one to its
+	 * encoder: the chain is then reached through the old state of
+	 * the connector being disabled and through the new state of
+	 * the connector taking over. Don't read a bridge out twice.
+	 */
+	if (drm_atomic_sro_get_private_obj_state(state, bridge_obj))
+		return 0;
+
+	if (!bridge_obj_funcs->atomic_sro_readout_state) {
+		/*
+		 * Missing readout implementations are only allowed
+		 * when drm.atomic_readout skips them, but the object
+		 * still needs a valid state: fall back to a pristine
+		 * state, like drm_mode_config_create_state() would.
+		 */
+		drm_warn(dev, "No bridge %s readout implementation.",
+			 bridge->name);
+
+		bridge_obj_state = bridge_obj_funcs->atomic_create_state(bridge_obj);
+		if (drm_WARN_ON(dev, IS_ERR(bridge_obj_state)))
+			return PTR_ERR(bridge_obj_state);
+
+		drm_atomic_sro_set_private_obj_state(state, bridge_obj,
+						     bridge_obj_state);
+		return 0;
+	}
+
+	drm_dbg_kms(dev, "Initializing Bridge %s state", bridge->name);
+
+	bridge_obj_state = bridge_obj_funcs->atomic_create_state(bridge_obj);
+	if (drm_WARN_ON(dev, IS_ERR(bridge_obj_state)))
+		return PTR_ERR(bridge_obj_state);
+
+	ret = bridge_obj_funcs->atomic_sro_readout_state(bridge_obj, state,
+						       bridge_obj_state);
+	if (ret) {
+		drm_dbg_kms(dev, "Bridge %s readout failed: %pe\n",
+			    bridge->name, ERR_PTR(ret));
+		bridge_obj_funcs->atomic_destroy_state(bridge_obj,
+						       bridge_obj_state);
+		return ret;
+	}
+
+	drm_atomic_sro_set_private_obj_state(state, bridge_obj,
+					     bridge_obj_state);
+
+	return 0;
+}
+
+static int
+drm_atomic_helper_sro_readout_bridge_chain_state(struct drm_device *dev,
+						 struct drm_atomic_sro_state *state,
+						 struct drm_encoder *encoder)
+{
+	int ret;
+
+	drm_for_each_bridge_in_chain(encoder, bridge) {
+		ret = drm_atomic_helper_sro_readout_bridge_state(dev, state, bridge);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int
+drm_atomic_helper_sro_readout_commit_bridges_state(struct drm_device *dev,
+						   struct drm_atomic_sro_state *state,
+						   struct drm_atomic_commit *commit)
+{
+	struct drm_connector_state *old_conn_state, *new_conn_state;
+	struct drm_connector *connector;
+	unsigned int i;
+
+	if (!commit)
+		return -EINVAL;
+
+	/*
+	 * Bridges can only be part of a commit through the connector
+	 * they are routed to, either the one they were routed to before
+	 * the commit or the one they are routed to after. Walking the
+	 * chains of the encoders of the committed connectors thus
+	 * covers all the bridges the commit can contain.
+	 */
+	for_each_oldnew_connector_in_state(commit, connector, old_conn_state, new_conn_state, i) {
+		struct drm_encoder *old_encoder = old_conn_state->best_encoder;
+		struct drm_encoder *new_encoder = new_conn_state->best_encoder;
+		int ret;
+
+		if (old_encoder) {
+			ret = drm_atomic_helper_sro_readout_bridge_chain_state(dev,
+									       state,
+									       old_encoder);
+			if (ret)
+				return ret;
+		}
+
+		if (new_encoder && new_encoder != old_encoder) {
+			ret = drm_atomic_helper_sro_readout_bridge_chain_state(dev,
+									       state,
+									       new_encoder);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * drm_atomic_helper_sro_readout_bridges_state - read out all bridge states from hardware
+ * @dev: DRM device
+ * @state: SRO state container to fill
+ * @commit: optional atomic commit limiting the objects to read out
+ *
+ * Iterates over the bridge chains of the encoders of the connectors
+ * that have a state in @commit when it isn't NULL, or over all the
+ * encoders of @dev otherwise. For each bridge, allocates a state via
+ * atomic_create_state, and calls the bridge's atomic_sro_readout_state
+ * hook to fill it from hardware.
+ *
+ * Bridges are handled separately from other private objects because
+ * bridge registration does not guarantee ordering. Traversing the
+ * encoder bridge chains ensures each bridge can query the state of
+ * preceding bridges in its chain.
+ *
+ * RETURNS:
+ *
+ * 0 on success, a negative error code otherwise.
+ */
+int
+drm_atomic_helper_sro_readout_bridges_state(struct drm_device *dev,
+					    struct drm_atomic_sro_state *state,
+					    struct drm_atomic_commit *commit)
+{
+	struct drm_encoder *encoder;
+	int ret;
+
+	might_alloc(GFP_KERNEL);
+
+	/*
+	 * It works a bit differently for bridges. Indeed they rely on a
+	 * drm_private_obj and drm_private_state, but bridge
+	 * registration doesn't guarantee ordering.
+	 *
+	 * In order for each bridge callback to be able to query the
+	 * previous bridge state, we thus need to read out the bridge
+	 * state by looking at each encoder and then traversing its
+	 * bridge list.
+	 *
+	 * And we'll then readout all the non-bridge drm_private_obj
+	 * later.
+	 */
+
+	if (commit)
+		return drm_atomic_helper_sro_readout_commit_bridges_state(dev, state, commit);
+
+	drm_for_each_encoder(encoder, dev) {
+		ret = drm_atomic_helper_sro_readout_bridge_chain_state(dev, state, encoder);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_helper_sro_readout_bridges_state);
+
+static int
+drm_atomic_helper_sro_readout_private_obj_state(struct drm_device *dev,
+						struct drm_atomic_sro_state *state,
+						struct drm_private_obj *privobj)
+{
+	const struct drm_private_state_funcs *priv_funcs = privobj->funcs;
+	struct drm_private_state *priv_state;
+	int ret;
+
+	/*
+	 * The bridges are read out by
+	 * drm_atomic_helper_sro_readout_bridges_state() instead, in
+	 * bridge chain order.
+	 */
+	if (drm_private_obj_is_bridge(privobj))
+		return 0;
+
+	if (!priv_funcs->atomic_sro_readout_state) {
+		/*
+		 * Missing readout implementations are only allowed
+		 * when drm.atomic_readout skips them, but the object
+		 * still needs a valid state: fall back to a pristine
+		 * state, like drm_mode_config_create_state() would.
+		 */
+		drm_warn(dev, "No private object %s readout implementation.",
+			 privobj->name);
+
+		priv_state = priv_funcs->atomic_create_state(privobj);
+		if (drm_WARN_ON(dev, IS_ERR(priv_state)))
+			return PTR_ERR(priv_state);
+
+		drm_atomic_sro_set_private_obj_state(state, privobj, priv_state);
+		return 0;
+	}
+
+	drm_dbg_kms(dev, "Initializing Private Object %s state", privobj->name);
+
+	priv_state = priv_funcs->atomic_create_state(privobj);
+	if (drm_WARN_ON(dev, IS_ERR(priv_state)))
+		return PTR_ERR(priv_state);
+
+	ret = priv_funcs->atomic_sro_readout_state(privobj, state,
+						   priv_state);
+	if (ret) {
+		drm_dbg_kms(dev, "Private object %s readout failed: %pe\n",
+			    privobj->name, ERR_PTR(ret));
+		priv_funcs->atomic_destroy_state(privobj, priv_state);
+		return ret;
+	}
+
+	drm_atomic_sro_set_private_obj_state(state, privobj, priv_state);
+
+	return 0;
+}
+
+static int
+drm_atomic_helper_sro_readout_commit_private_objs_state(struct drm_device *dev,
+							struct drm_atomic_sro_state *state,
+							struct drm_atomic_commit *commit)
+{
+	struct drm_private_state *new_obj_state;
+	struct drm_private_obj *obj;
+	unsigned int i;
+	int ret;
+
+	if (!commit)
+		return -EINVAL;
+
+	for_each_new_private_obj_in_state(commit, obj, new_obj_state, i) {
+		ret = drm_atomic_helper_sro_readout_private_obj_state(dev, state, obj);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * drm_atomic_helper_sro_readout_private_objs_state - read out non-bridge private object states
+ * @dev: DRM device
+ * @state: SRO state container to fill
+ * @commit: optional atomic commit limiting the objects to read out
+ *
+ * Iterates over the private objects that have a state in @commit when
+ * it isn't NULL, or over all the private objects of @dev otherwise. For
+ * each, allocates a state via atomic_create_state, and calls the
+ * object's atomic_sro_readout_state hook to fill it from hardware.
+ *
+ * RETURNS:
+ *
+ * 0 on success, a negative error code otherwise.
+ */
+int
+drm_atomic_helper_sro_readout_private_objs_state(struct drm_device *dev,
+						 struct drm_atomic_sro_state *state,
+						 struct drm_atomic_commit *commit)
+{
+	struct drm_private_obj *obj;
+	int ret;
+
+	might_alloc(GFP_KERNEL);
+
+	if (commit)
+		return drm_atomic_helper_sro_readout_commit_private_objs_state(dev, state, commit);
+
+	drm_for_each_privobj(obj, dev) {
+		ret = drm_atomic_helper_sro_readout_private_obj_state(dev, state, obj);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_helper_sro_readout_private_objs_state);
+
+/**
+ * drm_atomic_helper_sro_build_state - build an SRO state from hardware
+ * @dev: DRM device to build the state for
+ * @commit: optional atomic commit limiting the objects to read out
+ *
+ * Allocates a &struct drm_atomic_sro_state and calls the readout hooks
+ * for CRTCs, planes, connectors, bridges, and private objects in
+ * sequence to fill it from the current hardware state.
+ *
+ * When @commit is NULL, the state of every object in the device is
+ * read out, and the caller must hold all the modeset locks. When it
+ * isn't NULL, only the objects that have a state in @commit are read
+ * out, and the caller must hold the locks of the objects in @commit.
+ *
+ * This is the default implementation for
+ * &drm_mode_config_helper_funcs.atomic_sro_build_state.
+ *
+ * RETURNS:
+ *
+ * A &struct drm_atomic_sro_state on success, an error pointer otherwise.
+ */
+struct drm_atomic_sro_state *
+drm_atomic_helper_sro_build_state(struct drm_device *dev,
+				  struct drm_atomic_commit *commit)
+{
+	struct drm_atomic_sro_state *state;
+	struct drm_printer p = drm_dbg_printer(dev, DRM_UT_ATOMIC, NULL);
+	int ret;
+
+	might_alloc(GFP_KERNEL);
+
+	drm_dbg_kms(dev, "Starting to build atomic state from hardware state.\n");
+
+	state = drm_atomic_sro_state_alloc(dev);
+	if (drm_WARN_ON(dev, IS_ERR(state)))
+		return state;
+
+	ret = drm_atomic_helper_sro_readout_crtcs_state(dev, state, commit);
+	if (ret)
+		goto err_state_free;
+
+	ret = drm_atomic_helper_sro_readout_planes_state(dev, state, commit);
+	if (ret)
+		goto err_state_free;
+
+	ret = drm_atomic_helper_sro_readout_connectors_state(dev, state,
+							     commit);
+	if (ret)
+		goto err_state_free;
+
+	ret = drm_atomic_helper_sro_readout_bridges_state(dev, state, commit);
+	if (ret)
+		goto err_state_free;
+
+	ret = drm_atomic_helper_sro_readout_private_objs_state(dev, state,
+							       commit);
+	if (ret)
+		goto err_state_free;
+
+	drm_atomic_sro_state_print(state, &p);
+
+	return state;
+
+err_state_free:
+	drm_atomic_sro_state_free(state);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(drm_atomic_helper_sro_build_state);
+
+/**
+ * drm_atomic_helper_sro_readout_state - default &drm_mode_config_funcs.atomic_sro_readout_state implementation
+ * @dev: DRM device to read out state for
+ *
+ * Checks if the device supports hardware state readout, builds the SRO
+ * state via &drm_mode_config_helper_funcs.atomic_sro_build_state,
+ * installs it as the current state of all DRM objects, and frees the
+ * SRO container.
+ *
+ * The caller must hold all the modeset locks of @dev, as
+ * drm_mode_config_create_initial_state(), the usual caller, does.
+ *
+ * RETURNS:
+ *
+ * 0 on success, -ENOTSUPP if the device does not support readout, a
+ * negative error code otherwise.
+ */
+int drm_atomic_helper_sro_readout_state(struct drm_device *dev)
+{
+	const struct drm_mode_config_helper_funcs *funcs =
+		dev->mode_config.helper_private;
+	struct drm_atomic_sro_state *state;
+	struct drm_colorop *colorop;
+
+	if (!drm_atomic_sro_device_can_readout(dev)) {
+		drm_info(dev, "Device doesn't support hardware state readout.");
+		return -ENOTSUPP;
+	}
+
+	state = funcs->atomic_sro_build_state(dev, NULL);
+	if (IS_ERR(state)) {
+		drm_warn(dev, "Couldn't read out the hardware state: %pe\n",
+			 state);
+		return PTR_ERR(state);
+	}
+
+	/* TODO: Add colorop state readout support */
+	drm_for_each_colorop(colorop, dev) {
+		struct drm_colorop_state *colorop_state;
+
+		/*
+		 * The colorop states are already initialized when the
+		 * colorops are created. Only create a pristine state for
+		 * the ones that don't have one, like
+		 * drm_mode_config_create_state() does.
+		 */
+		if (colorop->state)
+			continue;
+
+		colorop_state = drm_atomic_helper_colorop_create_state(colorop);
+		if (IS_ERR(colorop_state)) {
+			drm_atomic_sro_state_free(state);
+			return PTR_ERR(colorop_state);
+		}
+
+		colorop->state = colorop_state;
+	}
+
+	drm_atomic_sro_install_state(state);
+	drm_atomic_sro_state_free(state);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_helper_sro_readout_state);
diff --git a/include/drm/drm_atomic_state_readout_helper.h b/include/drm/drm_atomic_state_readout_helper.h
new file mode 100644
index 000000000000..d685644ec25a
--- /dev/null
+++ b/include/drm/drm_atomic_state_readout_helper.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef DRM_ATOMIC_SRO_HELPER_H_
+#define DRM_ATOMIC_SRO_HELPER_H_
+
+struct drm_atomic_commit;
+struct drm_atomic_sro_state;
+struct drm_device;
+
+int
+drm_atomic_helper_sro_readout_planes_state(struct drm_device *dev,
+					   struct drm_atomic_sro_state *state,
+					   struct drm_atomic_commit *commit);
+int
+drm_atomic_helper_sro_readout_crtcs_state(struct drm_device *dev,
+					  struct drm_atomic_sro_state *state,
+					  struct drm_atomic_commit *commit);
+int
+drm_atomic_helper_sro_readout_connectors_state(struct drm_device *dev,
+					       struct drm_atomic_sro_state *state,
+					       struct drm_atomic_commit *commit);
+int
+drm_atomic_helper_sro_readout_bridges_state(struct drm_device *dev,
+					    struct drm_atomic_sro_state *state,
+					    struct drm_atomic_commit *commit);
+int
+drm_atomic_helper_sro_readout_private_objs_state(struct drm_device *dev,
+						 struct drm_atomic_sro_state *state,
+						 struct drm_atomic_commit *commit);
+struct drm_atomic_sro_state *
+drm_atomic_helper_sro_build_state(struct drm_device *dev,
+				  struct drm_atomic_commit *commit);
+int drm_atomic_helper_sro_readout_state(struct drm_device *dev);
+
+#endif /* DRM_ATOMIC_SRO_HELPER_H_ */
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 6858f0052637..e72f4f781df8 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1621,4 +1621,7 @@ struct drm_mode_config_helper_funcs {
 	 * commit, since its locks aren't held.
 	 *
+	 * The default implementation is
+	 * drm_atomic_helper_sro_build_state().
+	 *
 	 * RETURNS:
 	 *

-- 
2.55.0

