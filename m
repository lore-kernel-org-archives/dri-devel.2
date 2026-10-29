Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741C606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWCyKDIj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A5B10FFE8;
	Thu, 29 Oct 2026 07:35:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538F410FFDA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:35:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDCBA601F8;
 Thu, 29 Oct 2026 07:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54B61F01828;
 Thu, 29 Oct 2026 07:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259325;
 bh=USgEYZxjAcRkM+Bv8HOfoMF0ddveTSImaD4ejbQc8Qk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OWCyKDIjDVNnJ+xEqJqZGTmM3BEgfA3h3zdEMBeDWpQKUsxGSvVHC/43EGvfYga0H
 +j+GNbuN+eLfhAetZXxlhQFuLp4yiagKAlA6MK2Aq+NAGVvoCE3vrbYZxE2uZedHcq
 WECwANjpOB0S9lHM2Y9l5IvfNdyz6c9VmOuzCnYIOWMfh2m1AqSmsYrO5XIyFuO3Ya
 tDiNMBbGY/ZgF361o90mY6XuDB87fbcveU3d2mlFj5hjDmN82FJQL4sC6xXh7IZbzQ
 HaEegxYy+VYW6vBYn/hPQX2eayvABwXF017K+MdyaqlAT630vs2oVosGMxMA3xFt8G
 3yaeUtcrZW4/w==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:34:07 +0100
Subject: [PATCH v7 17/34] drm/atomic_sro: Provide helpers to implement
 hardware state readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-17-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=25175; i=mripard@kernel.org;
 h=from:subject:message-id; bh=v5KgmhyW1S03xk6hRRIFx8ufegG6lgOI66WBGVdCxyk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvn0JucV/f3diSpr7Ypcjrf5mc7ffXDvx+6+OigsCO
 8RevfHa0DGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmsjGCseF821+/NEffgKTN
 pQERhgYP3QIjZk0Lc1nLfp1t1fpSPYu5W+YtamO0XaQU5pAdFuCzj7Fh+oGAKwGmCYeeX5zKu/Z
 T3HPPdcsZDl9r6pKWdFBwjz8fHFmp67ydf84xnhTxCdkvgpoB
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
 drivers/gpu/drm/drm_atomic_state_readout_helper.c | 681 ++++++++++++++++++++++
 include/drm/drm_atomic_state_readout_helper.h     |  35 ++
 include/drm/drm_modeset_helper_vtables.h          |   3 +
 6 files changed, 733 insertions(+), 1 deletion(-)

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
index 413823579ed5..2c17fa09c5f0 100644
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
index 000000000000..a0b0337df2a0
--- /dev/null
+++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
@@ -0,0 +1,681 @@
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
+		drm_warn(dev, "No plane readout implementation.");
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
+	if (drm_WARN_ON(dev, ret)) {
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
+		drm_warn(dev, "No CRTC readout implementation.");
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
+	if (drm_WARN_ON(dev, ret)) {
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
+	struct drm_crtc_state *new_crtc_state;
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
+		drm_warn(dev, "No connector readout implementation.");
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
+	if (drm_WARN_ON(dev, ret)) {
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
+		drm_warn(dev, "No bridge %s readout implementation.",
+			 bridge->name);
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
+	if (drm_WARN_ON(dev, ret)) {
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
+		drm_warn(dev, "No private object %s readout implementation.",
+			 privobj->name);
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
+	if (drm_WARN_ON(dev, ret)) {
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
+	if (IS_ERR(state))
+		return PTR_ERR(state);
+
+	/* TODO: Add colorop state readout support */
+	drm_for_each_colorop(colorop, dev) {
+		struct drm_colorop_state *colorop_state;
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

