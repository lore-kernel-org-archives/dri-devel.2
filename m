Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C714A606A681
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FaRM5UxZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B32112931;
	Fri, 27 Nov 2026 09:55:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5BDD10E56B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:54:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB712611ED;
 Fri, 27 Nov 2026 09:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095C41F00897;
 Fri, 27 Nov 2026 09:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773268;
 bh=9NzSkc3wa/Y4pJD2qzD+A7ZFxU+1sHRPiWrYtsv1Pw8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FaRM5UxZdath2Wna1qMZCPMB4/bg0kTcCafbtXFrzwuvIF/WTccW5qgB6rGIe4H75
 IC3okk9D4IfUvrEzwf2PvQkSoa2t5zqWljbYH03MlfI9jzQ6lwiavaWEzb+6J+Kn33
 j9gdCZTh9Bi5w/2yO+Ns5AE1e/pzWENnLA0dbyXiEOVk9Jm/jTJyZknpSD7BQ29ikT
 fRQKpAXAs9wK2ZwxOS73LUYjEIYQlLnQXqwjGIIGlHAWrRTK3Q8T1OsUhFia2dhMHk
 zVMFXXGdLvGI7WD55lKOq0Xtfis/nGtyIS66ku0V2seIT0VXgEkuwsmF5eqoKgNndS
 87S1LU/dDlMVw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:02 +0100
Subject: [PATCH v10 20/36] drm/tests: Add tests for the atomic state
 readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-20-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=72948; i=mripard@kernel.org;
 h=from:subject:message-id; bh=5St0kMF1qgUuoDzxzJQZhFcKyrEskAg9WJ/YqyOCpEU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwaypu0JqOT04DV9xGJ7KnlFkxzEvV/rXlM1ifKmc5
 kedFzF0TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIm8amRsaFHKVp3s3/vbWSdm
 6Zf/vOy/BbNS89ZIRCTyGc5eXv1dLDd8G88mm9msr//27Wuben42Y8PTSQGSL7neKzrpzggs/11
 n3cV/bGET90q52UX2Arp9fn+OxkzS28927+bhvbbr42cnLwQA
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

The atomic state readout framework allows a driver to read the state of
its hardware into atomic states, either to create the initial state of
a device whose outputs have already been enabled, or to compare a
commit against the current hardware state.

Add a KUnit test suite covering:

- the drm_atomic_sro_state container API: allocation, per-object get
  and set, and installation of the read-out states into a drm_device;
- drm_atomic_helper_sro_create_gem_dma_object(), checking the object
  it creates, its error cases, and that it can't be mapped, exported
  or given a handle to;
- drm_atomic_helper_sro_readout_state(), including the cases where
  the readout isn't possible (-ENOTSUPP) because the mode
  configuration or helper hooks are missing, and error propagation
  from the readout hooks;
- drm_atomic_sro_readout_and_compare() and the per-object state
  comparison helpers for planes, CRTCs, connectors and bridges,
  including the mismatch reporting through a drm_printer;
- drm_mode_config_create_initial_state(), including its error paths
  and the fallback to the regular initialization path when the
  readout isn't available.

The tests are built on a mock DRM device whose per-object function
tables either implement or omit the readout hooks, with dedicated
variants to inject errors from them.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/Makefile                     |    1 +
 .../gpu/drm/tests/drm_atomic_state_readout_test.c  | 2121 ++++++++++++++++++++
 2 files changed, 2122 insertions(+)

diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index 42207df1d1c8..b11a07094b32 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -4,10 +4,11 @@ obj-$(CONFIG_DRM_KUNIT_TEST_HELPERS) += \
 	drm_kunit_helpers.o
 
 obj-$(CONFIG_DRM_KUNIT_TEST) += \
 	drm_atomic_test.o \
 	drm_atomic_commit_test.o \
+	drm_atomic_state_readout_test.o \
 	drm_bridge_test.o \
 	drm_cmdline_parser_test.o \
 	drm_connector_test.o \
 	drm_damage_helper_test.o \
 	drm_dp_mst_helper_test.o \
diff --git a/drivers/gpu/drm/tests/drm_atomic_state_readout_test.c b/drivers/gpu/drm/tests/drm_atomic_state_readout_test.c
new file mode 100644
index 000000000000..0eaee73e7d8f
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_atomic_state_readout_test.c
@@ -0,0 +1,2121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kunit test for the DRM atomic state readout infrastructure
+ */
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
+#include <drm/drm_atomic_uapi.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_kunit_helpers.h>
+#include <drm/drm_mode_config.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_print.h>
+#include <drm/drm_vblank.h>
+
+#include <kunit/test.h>
+
+#include <linux/media-bus-format.h>
+
+/*
+ * Those tests assume that the atomic_readout module parameter of
+ * drm_atomic_state_readout is left to its default value (enabled).
+ *
+ * The drm_atomic_sro_readout_mode suite tests the other values the
+ * parameter can take, and its init/exit hooks save and restore it
+ * around every test case.
+ */
+
+struct sro_test_priv {
+	struct drm_device drm;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+	struct drm_private_obj private_obj;
+	struct drm_bridge bridge;
+
+	unsigned int connector_destroy_count;
+	unsigned int private_obj_destroy_count;
+	bool connector_readout_called;
+	bool hw_reset_called;
+
+	/*
+	 * Whether the mock hardware drives a picture. The readout
+	 * hooks report a disabled pipeline when it isn't set, like a
+	 * driver reading a powered down encoder would.
+	 */
+	bool hw_active;
+
+	/* KUnit context, for the hooks that can't get it as an argument */
+	struct kunit *test;
+};
+
+/*
+ * The tests run with the mock hardware state described by those
+ * constants.
+ */
+#define SRO_TEST_CRTC_X		42
+#define SRO_TEST_CRTC_Y		24
+#define SRO_TEST_MODE_VIC	16	/* 1920x1080@60Hz */
+#define SRO_TEST_OTHER_MODE_VIC	4	/* 640x480@60Hz */
+
+static int mock_plane_sro_readout_state(struct drm_plane *plane,
+					struct drm_atomic_sro_state *state,
+					struct drm_plane_state *plane_state)
+{
+	plane_state->visible = true;
+	plane_state->crtc_x = SRO_TEST_CRTC_X;
+	plane_state->crtc_y = SRO_TEST_CRTC_Y;
+
+	return 0;
+}
+
+static const struct drm_plane_funcs mock_plane_with_sro_funcs = {
+	.atomic_create_state		= drm_atomic_helper_plane_create_state,
+	.atomic_destroy_state		= drm_atomic_helper_plane_destroy_state,
+	.atomic_duplicate_state		= drm_atomic_helper_plane_duplicate_state,
+	.atomic_sro_readout_state	= mock_plane_sro_readout_state,
+	.atomic_sro_compare_state	= drm_atomic_helper_plane_compare_state,
+};
+
+static int mock_crtc_sro_readout_state(struct drm_crtc *crtc,
+				       struct drm_atomic_sro_state *state,
+				       struct drm_crtc_state *crtc_state)
+{
+	struct sro_test_priv *priv =
+		container_of(crtc->dev, struct sro_test_priv, drm);
+	struct drm_display_mode *mode;
+	int ret;
+
+	/* The pipeline is off, there's nothing to read out. */
+	if (!priv->hw_active)
+		return 0;
+
+	mode = drm_kunit_display_mode_from_cea_vic(priv->test, crtc->dev,
+						   SRO_TEST_MODE_VIC);
+	if (!mode)
+		return -EINVAL;
+
+	/*
+	 * drm_atomic_set_mode_for_crtc() also sets the mode blob an
+	 * enabled CRTC needs to pass the atomic checks.
+	 */
+	ret = drm_atomic_set_mode_for_crtc(crtc_state, mode);
+	if (ret)
+		return ret;
+
+	crtc_state->active = true;
+
+	/* The connector read out is routed to that CRTC */
+	crtc_state->connector_mask = drm_connector_mask(&priv->connector);
+
+	return 0;
+}
+
+/*
+ * Install hook of a driver taking over the active CRTCs, which turns
+ * the vblank reporting on for them.
+ */
+static void mock_crtc_sro_install_state(struct drm_crtc *crtc,
+					struct drm_crtc_state *crtc_state)
+{
+	if (crtc_state->active)
+		drm_crtc_vblank_on(crtc);
+}
+
+static const struct drm_crtc_funcs mock_crtc_with_sro_funcs = {
+	.atomic_create_state		= drm_atomic_helper_crtc_create_state,
+	.atomic_destroy_state		= drm_atomic_helper_crtc_destroy_state,
+	.atomic_duplicate_state		= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_sro_readout_state	= mock_crtc_sro_readout_state,
+	.atomic_sro_install_state	= mock_crtc_sro_install_state,
+	.atomic_sro_compare_state	= drm_atomic_helper_crtc_compare_state,
+};
+
+/*
+ * Install hook of a driver that couldn't take over the hardware state
+ * of an active CRTC, and installs it as inactive instead.
+ */
+static void mock_crtc_sro_install_state_inactive(struct drm_crtc *crtc,
+						 struct drm_crtc_state *crtc_state)
+{
+	crtc_state->active = false;
+}
+
+static const struct drm_crtc_funcs mock_crtc_with_sro_install_inactive_funcs = {
+	.atomic_create_state		= drm_atomic_helper_crtc_create_state,
+	.atomic_destroy_state		= drm_atomic_helper_crtc_destroy_state,
+	.atomic_duplicate_state		= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_sro_readout_state	= mock_crtc_sro_readout_state,
+	.atomic_sro_install_state	= mock_crtc_sro_install_state_inactive,
+	.atomic_sro_compare_state	= drm_atomic_helper_crtc_compare_state,
+};
+
+/*
+ * Same as mock_crtc_with_sro_funcs, but without the comparison hook:
+ * used to exercise the modes that tolerate missing comparison
+ * implementations.
+ */
+static const struct drm_crtc_funcs mock_crtc_with_sro_no_compare_funcs = {
+	.atomic_create_state		= drm_atomic_helper_crtc_create_state,
+	.atomic_destroy_state		= drm_atomic_helper_crtc_destroy_state,
+	.atomic_duplicate_state		= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_sro_readout_state	= mock_crtc_sro_readout_state,
+};
+
+static int mock_connector_sro_readout_state(struct drm_connector *conn,
+					    struct drm_atomic_sro_state *state,
+					    struct drm_connector_state *conn_state)
+{
+	struct sro_test_priv *priv =
+		container_of(conn, struct sro_test_priv, connector);
+	struct drm_crtc *crtc;
+
+	priv->connector_readout_called = true;
+
+	/* The pipeline is off, there's nothing to read out. */
+	if (!priv->hw_active)
+		return 0;
+
+	/*
+	 * The CRTC states must be read out before the connectors so
+	 * that the connector readout hooks can find them.
+	 */
+	drm_for_each_crtc(crtc, conn->dev) {
+		if (!drm_atomic_sro_get_crtc_state(state, crtc))
+			continue;
+
+		/*
+		 * drm_atomic_set_crtc_for_connector() takes a connector
+		 * reference when setting the crtc pointer, which is
+		 * later released by
+		 * __drm_atomic_helper_connector_destroy_state(). The
+		 * readout bypasses that path, so take the reference
+		 * explicitly.
+		 */
+		drm_connector_get(conn);
+		conn_state->crtc = crtc;
+		conn_state->best_encoder = &priv->encoder;
+	}
+
+	if (!conn_state->crtc)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void mock_connector_destroy_state(struct drm_connector *conn,
+					 struct drm_connector_state *conn_state)
+{
+	struct sro_test_priv *priv =
+		container_of(conn, struct sro_test_priv, connector);
+
+	priv->connector_destroy_count++;
+
+	drm_atomic_helper_connector_destroy_state(conn, conn_state);
+}
+
+static const struct drm_connector_funcs mock_connector_with_sro_funcs = {
+	.atomic_create_state		= drm_atomic_helper_connector_create_state,
+	.atomic_destroy_state		= mock_connector_destroy_state,
+	.atomic_duplicate_state		= drm_atomic_helper_connector_duplicate_state,
+	.atomic_sro_readout_state	= mock_connector_sro_readout_state,
+	.atomic_sro_compare_state	= drm_atomic_helper_connector_compare_state,
+};
+
+static int mock_connector_sro_readout_err(struct drm_connector *conn,
+					  struct drm_atomic_sro_state *state,
+					  struct drm_connector_state *conn_state)
+{
+	return -EINVAL;
+}
+
+static const struct drm_connector_funcs mock_connector_with_sro_err_funcs = {
+	.atomic_create_state		= drm_atomic_helper_connector_create_state,
+	.atomic_destroy_state		= mock_connector_destroy_state,
+	.atomic_duplicate_state		= drm_atomic_helper_connector_duplicate_state,
+	.atomic_sro_readout_state	= mock_connector_sro_readout_err,
+	.atomic_sro_compare_state	= drm_atomic_helper_connector_compare_state,
+};
+
+static const struct drm_connector_helper_funcs mock_connector_helper_funcs = {
+};
+
+/*
+ * The private object state is subclassed so that the tests can check
+ * that it went through the readout hook.
+ */
+struct mock_privobj_state {
+	struct drm_private_state base;
+	bool readout;
+};
+
+static inline struct mock_privobj_state *
+to_mock_privobj_state(struct drm_private_state *state)
+{
+	return container_of(state, struct mock_privobj_state, base);
+}
+
+static struct drm_private_state *
+mock_private_obj_create_state(struct drm_private_obj *obj)
+{
+	struct mock_privobj_state *privobj_state;
+
+	privobj_state = kzalloc_obj(*privobj_state);
+	if (!privobj_state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_private_obj_create_state(obj,
+						     &privobj_state->base);
+
+	return &privobj_state->base;
+}
+
+static void mock_private_obj_destroy_state(struct drm_private_obj *obj,
+					   struct drm_private_state *obj_state)
+{
+	struct sro_test_priv *priv =
+		container_of(obj, struct sro_test_priv, private_obj);
+
+	priv->private_obj_destroy_count++;
+
+	kfree(obj_state);
+}
+
+static int mock_private_obj_sro_readout_state(struct drm_private_obj *obj,
+					      struct drm_atomic_sro_state *state,
+					      struct drm_private_state *obj_state)
+{
+	to_mock_privobj_state(obj_state)->readout = true;
+
+	return 0;
+}
+
+static bool mock_private_obj_compare_state(struct drm_private_obj *obj,
+					   struct drm_printer *p,
+					   struct drm_private_state *expected,
+					   struct drm_private_state *actual)
+{
+	return to_mock_privobj_state(expected)->readout ==
+		to_mock_privobj_state(actual)->readout;
+}
+
+static const struct drm_private_state_funcs mock_private_obj_with_sro_funcs = {
+	.atomic_create_state		= mock_private_obj_create_state,
+	.atomic_destroy_state		= mock_private_obj_destroy_state,
+	.atomic_sro_readout_state	= mock_private_obj_sro_readout_state,
+	.atomic_sro_compare_state	= mock_private_obj_compare_state,
+};
+
+static const struct drm_bridge_funcs mock_bridge_funcs = {
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
+	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
+};
+
+static void mock_private_obj_fini(void *ptr)
+{
+	drm_atomic_private_obj_fini(ptr);
+}
+
+static void mock_hw_reset(struct drm_device *drm)
+{
+	struct sro_test_priv *priv =
+		container_of(drm, struct sro_test_priv, drm);
+
+	priv->hw_reset_called = true;
+}
+
+static int mock_modeset_commit(struct drm_device *drm,
+			       struct drm_atomic_commit *commit,
+			       bool nonblock)
+{
+	struct sro_test_priv *priv =
+		container_of(drm, struct sro_test_priv, drm);
+
+	KUNIT_FAIL(priv->test, "unexpected modeset");
+
+	return 0;
+}
+
+/*
+ * The atomic_commit hook is a tripwire: reading out the hardware
+ * state and installing it is a state read, not a modeset, so nothing
+ * must ever go through the atomic commit machinery. atomic_check is
+ * only there so that a commit doesn't crash before reaching the
+ * tripwire.
+ */
+static const struct drm_mode_config_funcs mock_mode_config_with_sro_funcs = {
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = mock_modeset_commit,
+	.atomic_sro_readout_state = drm_atomic_helper_sro_readout_state,
+	.hw_reset = mock_hw_reset,
+};
+
+static int mock_sro_readout_err(struct drm_device *dev)
+{
+	return -EINVAL;
+}
+
+static const struct drm_mode_config_funcs mock_mode_config_with_sro_err_funcs = {
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = mock_modeset_commit,
+	.atomic_sro_readout_state = mock_sro_readout_err,
+	.hw_reset = mock_hw_reset,
+};
+
+static const struct drm_mode_config_funcs mock_mode_config_without_sro_with_hw_reset_funcs = {
+	.hw_reset = mock_hw_reset,
+};
+
+static const struct drm_mode_config_helper_funcs mock_mode_config_helper_without_sro_funcs = {
+};
+
+static const struct drm_mode_config_helper_funcs mock_mode_config_helper_with_sro_funcs = {
+	.atomic_sro_build_state = drm_atomic_helper_sro_build_state,
+	.atomic_sro_install_state = drm_atomic_helper_sro_install_state,
+};
+
+static struct drm_atomic_sro_state *
+mock_build_state_error(struct drm_device *dev,
+		       struct drm_atomic_commit *commit)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static const struct drm_mode_config_helper_funcs mock_mode_config_helper_with_err_funcs = {
+	.atomic_sro_build_state = mock_build_state_error,
+};
+
+/*
+ * Passing NULL for any of the object funcs will make the KUnit
+ * helpers use their defaults, which don't implement the state
+ * readout hooks.
+ */
+static struct sro_test_priv *
+mock_device_create(struct kunit *test,
+		   const struct drm_mode_config_funcs *mode_config_funcs,
+		   const struct drm_mode_config_helper_funcs *helper_funcs,
+		   const struct drm_plane_funcs *plane_funcs,
+		   const struct drm_crtc_funcs *crtc_funcs,
+		   const struct drm_connector_funcs *connector_funcs)
+{
+	struct sro_test_priv *priv;
+	struct drm_device *drm;
+	struct device *dev;
+	int ret;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	priv = drm_kunit_helper_alloc_drm_device(test, dev,
+						 struct sro_test_priv, drm,
+						 DRIVER_MODESET |
+						 DRIVER_ATOMIC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	drm = &priv->drm;
+
+	priv->test = test;
+	priv->hw_active = true;
+
+	drm->mode_config.funcs = mode_config_funcs;
+	drm->mode_config.helper_private = helper_funcs;
+
+	priv->plane = drm_kunit_helper_create_primary_plane(test, drm,
+							    plane_funcs,
+							    NULL,
+							    NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->plane);
+
+	priv->crtc = drm_kunit_helper_create_crtc(test, drm,
+						  priv->plane, NULL,
+						  crtc_funcs,
+						  NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->crtc);
+
+	ret = drmm_encoder_init(drm, &priv->encoder, NULL,
+				DRM_MODE_ENCODER_NONE, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	priv->encoder.possible_crtcs = drm_crtc_mask(priv->crtc);
+
+	ret = drmm_connector_init(drm, &priv->connector,
+				  connector_funcs,
+				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_connector_helper_add(&priv->connector,
+				 &mock_connector_helper_funcs);
+
+	drm_connector_attach_encoder(&priv->connector, &priv->encoder);
+
+	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = drm_atomic_private_obj_init(drm, &priv->private_obj,
+					  "test private obj",
+					  &mock_private_obj_with_sro_funcs);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kunit_add_action_or_reset(test, mock_private_obj_fini,
+					&priv->private_obj);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return priv;
+}
+
+static struct sro_test_priv *
+mock_device_with_sro_create(struct kunit *test)
+{
+	return mock_device_create(test,
+				  &mock_mode_config_with_sro_funcs,
+				  &mock_mode_config_helper_with_sro_funcs,
+				  &mock_plane_with_sro_funcs,
+				  &mock_crtc_with_sro_funcs,
+				  &mock_connector_with_sro_funcs);
+}
+
+/*
+ * State readout container tests
+ */
+
+/*
+ * Test that a state container can be allocated and freed for a device,
+ * and that it reports the device it was created for.
+ */
+static void drm_test_sro_state_alloc_free(struct kunit *test)
+{
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	struct drm_atomic_sro_state *sro_state;
+
+	sro_state = drm_atomic_sro_state_alloc(&priv->drm);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sro_state);
+
+	KUNIT_EXPECT_PTR_EQ(test, drm_atomic_sro_state_get_device(sro_state),
+			    &priv->drm);
+
+	drm_atomic_sro_state_free(sro_state);
+}
+
+/*
+ * Test that objects with no state stored in the container report no
+ * state.
+ */
+static void drm_test_sro_state_get_unset(struct kunit *test)
+{
+	struct drm_connector *connector;
+	struct drm_private_obj *obj;
+	struct sro_test_priv *priv;
+	struct drm_atomic_sro_state *sro_state;
+	struct drm_plane_state *plane_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector_state *conn_state;
+	struct drm_private_state *obj_state;
+
+	priv = mock_device_with_sro_create(test);
+	connector = &priv->connector;
+	obj = &priv->private_obj;
+
+	sro_state = drm_atomic_sro_state_alloc(&priv->drm);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sro_state);
+
+	/* No state has been stored yet */
+	plane_state = drm_atomic_sro_get_plane_state(sro_state, priv->plane);
+	KUNIT_EXPECT_NULL(test, plane_state);
+
+	crtc_state = drm_atomic_sro_get_crtc_state(sro_state, priv->crtc);
+	KUNIT_EXPECT_NULL(test, crtc_state);
+
+	conn_state = drm_atomic_sro_get_connector_state(sro_state, connector);
+	KUNIT_EXPECT_NULL(test, conn_state);
+
+	obj_state = drm_atomic_sro_get_private_obj_state(sro_state, obj);
+	KUNIT_EXPECT_NULL(test, obj_state);
+
+	drm_atomic_sro_state_free(sro_state);
+}
+
+/*
+ * Test that states stored in the container can be retrieved from it,
+ * and that the container destroys the states that haven't been
+ * installed when it is freed.
+ */
+static void drm_test_sro_state_set_get(struct kunit *test)
+{
+	struct drm_connector *connector;
+	struct drm_private_obj *obj;
+	struct sro_test_priv *priv;
+	struct drm_atomic_sro_state *sro_state;
+	struct drm_plane_state *plane_state, *plane_readback;
+	struct drm_crtc_state *crtc_state, *crtc_readback;
+	struct drm_connector_state *conn_state, *conn_readback;
+	struct drm_private_state *obj_state, *obj_readback;
+
+	priv = mock_device_with_sro_create(test);
+	connector = &priv->connector;
+	obj = &priv->private_obj;
+
+	sro_state = drm_atomic_sro_state_alloc(&priv->drm);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sro_state);
+
+	plane_state = priv->plane->funcs->atomic_create_state(priv->plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_state);
+
+	crtc_state = priv->crtc->funcs->atomic_create_state(priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	conn_state = connector->funcs->atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	obj_state = mock_private_obj_create_state(obj);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, obj_state);
+
+	drm_atomic_sro_set_plane_state(sro_state, priv->plane, plane_state);
+	drm_atomic_sro_set_crtc_state(sro_state, priv->crtc, crtc_state);
+	drm_atomic_sro_set_connector_state(sro_state, connector, conn_state);
+	drm_atomic_sro_set_private_obj_state(sro_state, obj, obj_state);
+
+	plane_readback = drm_atomic_sro_get_plane_state(sro_state, priv->plane);
+	KUNIT_EXPECT_PTR_EQ(test, plane_readback, plane_state);
+
+	crtc_readback = drm_atomic_sro_get_crtc_state(sro_state, priv->crtc);
+	KUNIT_EXPECT_PTR_EQ(test, crtc_readback, crtc_state);
+
+	conn_readback = drm_atomic_sro_get_connector_state(sro_state,
+							   connector);
+	KUNIT_EXPECT_PTR_EQ(test, conn_readback, conn_state);
+
+	obj_readback = drm_atomic_sro_get_private_obj_state(sro_state, obj);
+	KUNIT_EXPECT_PTR_EQ(test, obj_readback, obj_state);
+
+	drm_atomic_sro_state_free(sro_state);
+
+	/* The uninstalled states have been destroyed by the container */
+	KUNIT_EXPECT_EQ(test, priv->connector_destroy_count, 1);
+	KUNIT_EXPECT_EQ(test, priv->private_obj_destroy_count, 1);
+}
+
+/*
+ * Test that drm_atomic_helper_sro_install_state() makes the read out
+ * states the current states of the objects and transfers their
+ * ownership: freeing the container afterwards doesn't destroy them.
+ */
+static void drm_test_sro_state_install(struct kunit *test)
+{
+	struct drm_connector *connector;
+	struct drm_private_obj *obj;
+	struct sro_test_priv *priv;
+	struct drm_atomic_sro_state *sro_state;
+	struct drm_plane_state *plane_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector_state *conn_state;
+	struct drm_private_state *obj_state;
+
+	priv = mock_device_with_sro_create(test);
+	connector = &priv->connector;
+	obj = &priv->private_obj;
+
+	sro_state = drm_atomic_sro_state_alloc(&priv->drm);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sro_state);
+
+	plane_state = priv->plane->funcs->atomic_create_state(priv->plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_state);
+
+	crtc_state = priv->crtc->funcs->atomic_create_state(priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+	crtc_state->enable = true;
+	crtc_state->active = true;
+
+	conn_state = connector->funcs->atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	obj_state = mock_private_obj_create_state(obj);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, obj_state);
+
+	drm_atomic_sro_set_plane_state(sro_state, priv->plane, plane_state);
+	drm_atomic_sro_set_crtc_state(sro_state, priv->crtc, crtc_state);
+	drm_atomic_sro_set_connector_state(sro_state, connector, conn_state);
+	drm_atomic_sro_set_private_obj_state(sro_state, obj, obj_state);
+
+	drm_atomic_helper_sro_install_state(sro_state);
+
+	/* The read out states are now owned by the objects */
+	KUNIT_EXPECT_PTR_EQ(test, priv->plane->state, plane_state);
+	KUNIT_EXPECT_PTR_EQ(test, priv->crtc->state, crtc_state);
+	KUNIT_EXPECT_PTR_EQ(test, connector->state, conn_state);
+	KUNIT_EXPECT_PTR_EQ(test, obj->state, obj_state);
+	KUNIT_EXPECT_TRUE(test, priv->crtc->state->active);
+
+	/*
+	 * Freeing the container after the installation must not destroy
+	 * the installed states.
+	 */
+	drm_atomic_sro_state_free(sro_state);
+
+	KUNIT_EXPECT_PTR_EQ(test, priv->plane->state, plane_state);
+	KUNIT_EXPECT_PTR_EQ(test, priv->crtc->state, crtc_state);
+	KUNIT_EXPECT_PTR_EQ(test, connector->state, conn_state);
+	KUNIT_EXPECT_PTR_EQ(test, obj->state, obj_state);
+
+	/*
+	 * The connector had no state before the installation, while the
+	 * state the private object was initialized with by
+	 * drm_atomic_private_obj_init() has been destroyed when
+	 * replaced by the read out one.
+	 */
+	KUNIT_EXPECT_EQ(test, priv->connector_destroy_count, 0);
+	KUNIT_EXPECT_EQ(test, priv->private_obj_destroy_count, 1);
+}
+
+/*
+ * Test that installing a state on an object that already has one
+ * destroys the state that was installed before.
+ */
+static void drm_test_sro_state_install_replaces_state(struct kunit *test)
+{
+	struct drm_connector *connector;
+	struct sro_test_priv *priv;
+	struct drm_atomic_sro_state *sro_state;
+	struct drm_connector_state *old_state, *new_state;
+
+	priv = mock_device_with_sro_create(test);
+	connector = &priv->connector;
+
+	old_state = connector->funcs->atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
+	connector->state = old_state;
+
+	sro_state = drm_atomic_sro_state_alloc(&priv->drm);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sro_state);
+
+	new_state = connector->funcs->atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
+	drm_atomic_sro_set_connector_state(sro_state, connector, new_state);
+
+	drm_atomic_helper_sro_install_state(sro_state);
+	drm_atomic_sro_state_free(sro_state);
+
+	KUNIT_EXPECT_PTR_EQ(test, connector->state, new_state);
+
+	/* The state that was installed before has been destroyed */
+	KUNIT_EXPECT_EQ(test, priv->connector_destroy_count, 1);
+}
+
+/*
+ * Test that objects with no state in the container are left untouched
+ * by the installation.
+ */
+static void drm_test_sro_state_install_partial(struct kunit *test)
+{
+	struct drm_private_state *initial_obj_state;
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	struct drm_atomic_sro_state *sro_state;
+	struct drm_crtc_state *crtc_state;
+
+	/* The private object is initialized with a state of its own */
+	initial_obj_state = priv->private_obj.state;
+	KUNIT_ASSERT_NOT_NULL(test, initial_obj_state);
+
+	sro_state = drm_atomic_sro_state_alloc(&priv->drm);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sro_state);
+
+	crtc_state = priv->crtc->funcs->atomic_create_state(priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	drm_atomic_sro_set_crtc_state(sro_state, priv->crtc, crtc_state);
+
+	drm_atomic_helper_sro_install_state(sro_state);
+	drm_atomic_sro_state_free(sro_state);
+
+	KUNIT_EXPECT_PTR_EQ(test, priv->crtc->state, crtc_state);
+	KUNIT_EXPECT_NULL(test, priv->plane->state);
+	KUNIT_EXPECT_NULL(test, priv->connector.state);
+
+	/* The private object has been left untouched */
+	KUNIT_EXPECT_PTR_EQ(test, priv->private_obj.state, initial_obj_state);
+	KUNIT_EXPECT_EQ(test, priv->private_obj_destroy_count, 0);
+}
+
+static struct kunit_case drm_atomic_sro_state_tests[] = {
+	KUNIT_CASE(drm_test_sro_state_alloc_free),
+	KUNIT_CASE(drm_test_sro_state_get_unset),
+	KUNIT_CASE(drm_test_sro_state_set_get),
+	KUNIT_CASE(drm_test_sro_state_install),
+	KUNIT_CASE(drm_test_sro_state_install_replaces_state),
+	KUNIT_CASE(drm_test_sro_state_install_partial),
+	{ }
+};
+
+static struct kunit_suite drm_atomic_sro_state_test_suite = {
+	.name = "drm_atomic_sro_state",
+	.test_cases = drm_atomic_sro_state_tests,
+};
+
+/*
+ * Readout tests
+ */
+
+/*
+ * Test that a successful readout calls the readout hook of every
+ * object, including the private objects, and installs the states it
+ * built as the current states of the objects. The connectors are read
+ * out after the CRTCs so that their hooks can look the CRTC states up.
+ */
+static void drm_test_sro_readout_state(struct kunit *test)
+{
+	struct mock_privobj_state *privobj_state;
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	int ret;
+
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* The states read out have been installed on the objects */
+	KUNIT_EXPECT_TRUE(test, priv->crtc->state->enable);
+	KUNIT_EXPECT_TRUE(test, priv->crtc->state->active);
+	KUNIT_EXPECT_TRUE(test, priv->plane->state->visible);
+	KUNIT_EXPECT_EQ(test, priv->plane->state->crtc_x, SRO_TEST_CRTC_X);
+	KUNIT_EXPECT_EQ(test, priv->plane->state->crtc_y, SRO_TEST_CRTC_Y);
+	KUNIT_EXPECT_PTR_EQ(test, priv->connector.state->crtc, priv->crtc);
+
+	KUNIT_ASSERT_NOT_NULL(test, priv->private_obj.state);
+	privobj_state = to_mock_privobj_state(priv->private_obj.state);
+	KUNIT_EXPECT_TRUE(test, privobj_state->readout);
+}
+
+/*
+ * Test that a device without an atomic_sro_build_state helper can't be
+ * read out, and that nothing is installed.
+ */
+static void drm_test_sro_readout_state_no_helper(struct kunit *test)
+{
+	struct sro_test_priv *priv;
+	int ret;
+
+	/*
+	 * Everything is in place for the readout except the
+	 * atomic_sro_build_state helper.
+	 */
+	priv = mock_device_create(test,
+				  &mock_mode_config_with_sro_funcs,
+				  &mock_mode_config_helper_without_sro_funcs,
+				  &mock_plane_with_sro_funcs,
+				  &mock_crtc_with_sro_funcs,
+				  &mock_connector_with_sro_funcs);
+
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, -ENOTSUPP);
+
+	/* Nothing has been installed */
+	KUNIT_EXPECT_NULL(test, priv->crtc->state);
+	KUNIT_EXPECT_NULL(test, priv->plane->state);
+}
+
+/*
+ * Test that a device whose mode configuration doesn't implement the
+ * atomic_sro_readout_state hook can't be read out either.
+ */
+static void drm_test_sro_readout_state_no_hook(struct kunit *test)
+{
+	struct sro_test_priv *priv;
+	int ret;
+
+	/*
+	 * Everything is in place for the readout except the
+	 * atomic_sro_readout_state mode configuration hook.
+	 */
+	priv = mock_device_create(test,
+				  &mock_mode_config_without_sro_with_hw_reset_funcs,
+				  &mock_mode_config_helper_with_sro_funcs,
+				  &mock_plane_with_sro_funcs,
+				  &mock_crtc_with_sro_funcs,
+				  &mock_connector_with_sro_funcs);
+
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, -ENOTSUPP);
+
+	/* Nothing has been installed */
+	KUNIT_EXPECT_NULL(test, priv->crtc->state);
+	KUNIT_EXPECT_NULL(test, priv->plane->state);
+}
+
+/*
+ * Test that a device where an object doesn't implement the readout
+ * hooks can't be read out either.
+ */
+static void drm_test_sro_readout_state_missing_hooks(struct kunit *test)
+{
+	struct sro_test_priv *priv;
+	int ret;
+
+	/*
+	 * The default KUnit helpers object implementations don't have
+	 * any readout hook.
+	 */
+	priv = mock_device_create(test,
+				  &mock_mode_config_with_sro_funcs,
+				  &mock_mode_config_helper_with_sro_funcs,
+				  NULL, NULL,
+				  &mock_connector_with_sro_funcs);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, -ENOTSUPP);
+
+	KUNIT_EXPECT_NULL(test, priv->crtc->state);
+	KUNIT_EXPECT_NULL(test, priv->plane->state);
+}
+
+/*
+ * Test that an error from atomic_sro_build_state() is reported to the
+ * caller as-is, and that no state has been installed.
+ */
+static void drm_test_sro_readout_state_error(struct kunit *test)
+{
+	struct sro_test_priv *priv;
+	int ret;
+
+	priv = mock_device_create(test,
+				  &mock_mode_config_with_sro_funcs,
+				  &mock_mode_config_helper_with_err_funcs,
+				  &mock_plane_with_sro_funcs,
+				  &mock_crtc_with_sro_funcs,
+				  &mock_connector_with_sro_funcs);
+
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	/* Nothing has been installed */
+	KUNIT_EXPECT_NULL(test, priv->crtc->state);
+	KUNIT_EXPECT_NULL(test, priv->plane->state);
+}
+
+/*
+ * Test that drm_atomic_sro_readout_and_compare() builds a fresh state
+ * from the hardware and compares it to the commit: a commit state
+ * duplicated from the state read out of the hardware is identical,
+ * while a modified one is reported as a mismatch.
+ */
+static void drm_test_sro_readout_and_compare(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *commit;
+	struct sro_test_priv *priv;
+	struct drm_crtc_state *crtc_state;
+	bool identical;
+	int ret;
+
+	priv = mock_device_with_sro_create(test);
+
+	/* Install the mock hardware state */
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	commit = drm_kunit_helper_atomic_state_alloc(test, &priv->drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, commit);
+
+	crtc_state = drm_atomic_get_crtc_state(commit, priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	/*
+	 * The commit state has been duplicated from the state read out
+	 * of the mock hardware, so the two are identical.
+	 */
+	identical = drm_atomic_sro_readout_and_compare(commit);
+	KUNIT_EXPECT_TRUE(test, identical);
+
+	crtc_state->active = false;
+	identical = drm_atomic_sro_readout_and_compare(commit);
+	KUNIT_EXPECT_FALSE(test, identical);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that the readout and compare of a commit is scoped to the
+ * objects of the commit: the objects that the commit doesn't contain
+ * are neither read out nor compared.
+ */
+static void drm_test_sro_readout_and_compare_scope(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *commit;
+	struct sro_test_priv *priv;
+	struct drm_crtc_state *crtc_state;
+	bool identical;
+	int ret;
+
+	priv = mock_device_with_sro_create(test);
+
+	/* Install the mock hardware state */
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/*
+	 * The connector readout hook sets connector_readout_called
+	 * when it runs. Reset it so that we can check whether it runs
+	 * again.
+	 */
+	priv->connector_readout_called = false;
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	commit = drm_kunit_helper_atomic_state_alloc(test, &priv->drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, commit);
+
+	/*
+	 * The commit only contains a state for the CRTC, duplicated
+	 * from the state read out of the mock hardware, so the two
+	 * are identical.
+	 */
+	crtc_state = drm_atomic_get_crtc_state(commit, priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	identical = drm_atomic_sro_readout_and_compare(commit);
+	KUNIT_EXPECT_TRUE(test, identical);
+
+	/*
+	 * The connector isn't part of the commit, so its readout hook
+	 * must not have run.
+	 */
+	KUNIT_EXPECT_FALSE(test, priv->connector_readout_called);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that the state installed by the readout lets the first commit
+ * tell whether a modeset is needed: a commit asking for the
+ * configuration already programmed in the hardware doesn't need one,
+ * and a commit changing the configuration does.
+ */
+static void drm_test_sro_readout_no_modeset(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *commit;
+	struct sro_test_priv *priv;
+	struct drm_crtc_state *crtc_state;
+	struct drm_display_mode *mode;
+	int ret;
+
+	priv = mock_device_with_sro_create(test);
+
+	ret = drm_mode_config_create_initial_state(&priv->drm);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/*
+	 * A commit with the same configuration as the hardware
+	 * doesn't need a modeset.
+	 */
+	drm_modeset_acquire_init(&ctx, 0);
+
+	commit = drm_kunit_helper_atomic_state_alloc(test, &priv->drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, commit);
+
+retry_same:
+	crtc_state = drm_atomic_get_crtc_state(commit, priv->crtc);
+	if (PTR_ERR_OR_ZERO(crtc_state) == -EDEADLK)
+		goto backoff_same;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	ret = drm_atomic_check_only(commit);
+	if (ret == -EDEADLK)
+		goto backoff_same;
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, crtc_state->mode_changed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	/* A commit with a different configuration needs a modeset. */
+	drm_modeset_acquire_init(&ctx, 0);
+
+	commit = drm_kunit_helper_atomic_state_alloc(test, &priv->drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, commit);
+
+	mode = drm_kunit_display_mode_from_cea_vic(test, &priv->drm,
+						   SRO_TEST_OTHER_MODE_VIC);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+retry_other:
+	crtc_state = drm_atomic_get_crtc_state(commit, priv->crtc);
+	if (PTR_ERR_OR_ZERO(crtc_state) == -EDEADLK)
+		goto backoff_other;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	ret = drm_atomic_set_mode_for_crtc(crtc_state, mode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	commit->allow_modeset = true;
+
+	ret = drm_atomic_check_only(commit);
+	if (ret == -EDEADLK)
+		goto backoff_other;
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, crtc_state->mode_changed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	return;
+
+backoff_same:
+	drm_atomic_commit_clear(commit);
+	drm_modeset_backoff(&ctx);
+	goto retry_same;
+
+backoff_other:
+	drm_atomic_commit_clear(commit);
+	drm_modeset_backoff(&ctx);
+	goto retry_other;
+}
+
+/*
+ * Test that blanking a pipeline isn't reported as a mismatch. A DPMS
+ * off commit only clears drm_crtc_state.active and leaves the
+ * connector bound to its CRTC, while the hardware readout of a
+ * disabled pipeline reports an unbound connector: the two states
+ * differ, but there is nothing to compare for a pipeline that doesn't
+ * drive a picture anymore.
+ */
+static void drm_test_sro_readout_and_compare_blanked(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_atomic_commit *commit;
+	struct sro_test_priv *priv;
+	struct drm_crtc_state *crtc_state;
+	bool identical;
+	int ret;
+
+	priv = mock_device_with_sro_create(test);
+
+	/* Install the mock hardware state, with the pipeline enabled */
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	commit = drm_kunit_helper_atomic_state_alloc(test, &priv->drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, commit);
+
+retry:
+	crtc_state = drm_atomic_get_crtc_state(commit, priv->crtc);
+	if (PTR_ERR_OR_ZERO(crtc_state) == -EDEADLK)
+		goto backoff;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	conn_state = drm_atomic_get_connector_state(commit, &priv->connector);
+	if (PTR_ERR_OR_ZERO(conn_state) == -EDEADLK)
+		goto backoff;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	/*
+	 * A DPMS off commit only clears active: the connector is still
+	 * bound to its CRTC in the committed state.
+	 */
+	crtc_state->active = false;
+	KUNIT_ASSERT_PTR_EQ(test, conn_state->crtc, priv->crtc);
+
+	/*
+	 * Apply the commit like a blocking commit does before comparing
+	 * its states to the hardware: the comparison expects the
+	 * committed states to be the current ones.
+	 */
+	ret = drm_atomic_helper_swap_state(commit, false);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/* The hardware is now off */
+	priv->hw_active = false;
+
+	identical = drm_atomic_sro_readout_and_compare(commit);
+	KUNIT_EXPECT_TRUE(test, identical);
+
+	/*
+	 * A pipeline that should be driving a picture but isn't is
+	 * still reported as a mismatch. crtc_state is now the current
+	 * state of the CRTC.
+	 */
+	crtc_state->active = true;
+
+	identical = drm_atomic_sro_readout_and_compare(commit);
+	KUNIT_EXPECT_FALSE(test, identical);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	return;
+
+backoff:
+	drm_atomic_commit_clear(commit);
+	drm_modeset_backoff(&ctx);
+	goto retry;
+}
+
+/*
+ * Test that the vblank state of a CRTC read out as inactive is reset
+ * by drm_atomic_helper_sro_install_state(), so that vblank requests on it
+ * are rejected until drm_crtc_vblank_on() is called.
+ */
+static void drm_test_sro_readout_state_vblank_inactive(struct kunit *test)
+{
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	int ret;
+
+	priv->hw_active = false;
+
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_FALSE(test, priv->crtc->state->active);
+	KUNIT_EXPECT_TRUE(test, drm_crtc_vblank_crtc(priv->crtc)->inmodeset);
+}
+
+/*
+ * Test that drm_atomic_helper_sro_install_state() resets the vblank
+ * state of a CRTC read out as active before calling its
+ * atomic_sro_install_state hook, so that the drm_crtc_vblank_on() call
+ * of the hook turns the vblank reporting on.
+ */
+static void drm_test_sro_readout_state_vblank_active(struct kunit *test)
+{
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	int ret;
+
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_TRUE(test, priv->crtc->state->active);
+	KUNIT_EXPECT_FALSE(test, drm_crtc_vblank_crtc(priv->crtc)->inmodeset);
+}
+
+/*
+ * Test that the vblank state of a CRTC read out as active stays reset
+ * when its atomic_sro_install_state hook doesn't take it over and
+ * installs it as inactive.
+ */
+static void drm_test_sro_readout_state_vblank_hook_inactive(struct kunit *test)
+{
+	struct sro_test_priv *priv;
+	int ret;
+
+	priv = mock_device_create(test,
+				  &mock_mode_config_with_sro_funcs,
+				  &mock_mode_config_helper_with_sro_funcs,
+				  &mock_plane_with_sro_funcs,
+				  &mock_crtc_with_sro_install_inactive_funcs,
+				  &mock_connector_with_sro_funcs);
+
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_FALSE(test, priv->crtc->state->active);
+	KUNIT_EXPECT_TRUE(test, drm_crtc_vblank_crtc(priv->crtc)->inmodeset);
+}
+
+static struct kunit_case drm_atomic_sro_readout_tests[] = {
+	KUNIT_CASE(drm_test_sro_readout_state),
+	KUNIT_CASE(drm_test_sro_readout_state_no_helper),
+	KUNIT_CASE(drm_test_sro_readout_state_no_hook),
+	KUNIT_CASE(drm_test_sro_readout_state_missing_hooks),
+	KUNIT_CASE(drm_test_sro_readout_state_error),
+	KUNIT_CASE(drm_test_sro_readout_state_vblank_inactive),
+	KUNIT_CASE(drm_test_sro_readout_state_vblank_active),
+	KUNIT_CASE(drm_test_sro_readout_state_vblank_hook_inactive),
+	KUNIT_CASE(drm_test_sro_readout_and_compare),
+	KUNIT_CASE(drm_test_sro_readout_and_compare_scope),
+	KUNIT_CASE(drm_test_sro_readout_and_compare_blanked),
+	KUNIT_CASE(drm_test_sro_readout_no_modeset),
+	{ }
+};
+
+static struct kunit_suite drm_atomic_sro_readout_test_suite = {
+	.name = "drm_atomic_sro_readout",
+	.test_cases = drm_atomic_sro_readout_tests,
+};
+
+/*
+ * Readout module parameter tests
+ */
+
+/*
+ * The drm.atomic_readout module parameter is global: save the mode
+ * the kernel was booted with before every test case, and restore it
+ * afterwards. The exit hook runs even when an assertion aborts the
+ * test, and KUnit executes the test cases of every suite one at a
+ * time, so no other suite can observe the change.
+ */
+static int drm_test_sro_readout_mode_init(struct kunit *test)
+{
+	test->priv = (void *)(unsigned long)drm_atomic_sro_status;
+
+	return 0;
+}
+
+static void drm_test_sro_readout_mode_exit(struct kunit *test)
+{
+	drm_atomic_sro_status = (unsigned long)test->priv;
+}
+
+/*
+ * Test that a device whose objects all implement the readout and
+ * comparison hooks can be read out, unless the readout is disabled
+ * entirely.
+ */
+static void drm_test_sro_readout_mode_disabled(struct kunit *test)
+{
+	struct sro_test_priv *priv;
+	int ret;
+
+	priv = mock_device_with_sro_create(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	drm_atomic_sro_status = DRM_ATOMIC_SRO_ENABLED;
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	drm_atomic_sro_status = DRM_ATOMIC_SRO_DISABLED;
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, -ENOTSUPP);
+}
+
+/*
+ * Test that a device whose CRTC has no comparison hook can only be
+ * read out by the modes tolerating missing comparison
+ * implementations.
+ */
+static void drm_test_sro_readout_mode_skip_missing_compare(struct kunit *test)
+{
+	struct sro_test_priv *priv;
+	int ret;
+
+	priv = mock_device_create(test,
+				  &mock_mode_config_with_sro_funcs,
+				  &mock_mode_config_helper_with_sro_funcs,
+				  &mock_plane_with_sro_funcs,
+				  &mock_crtc_with_sro_no_compare_funcs,
+				  &mock_connector_with_sro_funcs);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	drm_atomic_sro_status = DRM_ATOMIC_SRO_ENABLED;
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, -ENOTSUPP);
+
+	drm_atomic_sro_status = DRM_ATOMIC_SRO_SKIP_MISSING_COMPARE;
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/*
+ * Test that a device whose plane and CRTC have no readout hook can
+ * only be read out by the mode tolerating missing readout
+ * implementations, and that the objects without a hook then get a
+ * pristine state installed rather than none at all.
+ */
+static void drm_test_sro_readout_mode_skip_missing_readout(struct kunit *test)
+{
+	struct sro_test_priv *priv;
+	int ret;
+
+	priv = mock_device_create(test,
+				  &mock_mode_config_with_sro_funcs,
+				  &mock_mode_config_helper_with_sro_funcs,
+				  NULL, NULL,
+				  &mock_connector_with_sro_funcs);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	drm_atomic_sro_status = DRM_ATOMIC_SRO_ENABLED;
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, -ENOTSUPP);
+	KUNIT_EXPECT_NULL(test, priv->plane->state);
+	KUNIT_EXPECT_NULL(test, priv->crtc->state);
+
+	drm_atomic_sro_status = DRM_ATOMIC_SRO_SKIP_MISSING_READOUT;
+	ret = drm_atomic_helper_sro_readout_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_NOT_NULL(test, priv->plane->state);
+	KUNIT_EXPECT_NOT_NULL(test, priv->crtc->state);
+}
+
+static struct kunit_case drm_atomic_sro_readout_mode_tests[] = {
+	KUNIT_CASE(drm_test_sro_readout_mode_disabled),
+	KUNIT_CASE(drm_test_sro_readout_mode_skip_missing_compare),
+	KUNIT_CASE(drm_test_sro_readout_mode_skip_missing_readout),
+	{ }
+};
+
+static struct kunit_suite drm_atomic_sro_readout_mode_test_suite = {
+	.name = "drm_atomic_sro_readout_mode",
+	.init = drm_test_sro_readout_mode_init,
+	.exit = drm_test_sro_readout_mode_exit,
+	.test_cases = drm_atomic_sro_readout_mode_tests,
+};
+
+/*
+ * Compare helper tests
+ */
+
+/*
+ * Test that two identical plane states compare as equal, without
+ * reporting any mismatch.
+ */
+static void drm_test_sro_compare_plane_identical(struct kunit *test)
+{
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	struct drm_plane_state *state1, *state2;
+	struct drm_printer *p;
+	bool identical;
+
+	p = drm_kunit_helper_printer(test, LOGLEVEL_ERR);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	state1 = priv->plane->funcs->atomic_create_state(priv->plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
+
+	state2 = priv->plane->funcs->atomic_create_state(priv->plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
+
+	identical = drm_atomic_helper_plane_compare_state(priv->plane, p,
+							  state1, state2);
+	KUNIT_EXPECT_TRUE(test, identical);
+
+	priv->plane->funcs->atomic_destroy_state(priv->plane, state1);
+	priv->plane->funcs->atomic_destroy_state(priv->plane, state2);
+}
+
+/*
+ * The mock framebuffers carry no backing buffer: only unregister them
+ * when their last reference is dropped, the memory being owned by
+ * KUnit.
+ */
+static const struct drm_framebuffer_funcs mock_fb_funcs = {
+	.destroy = drm_framebuffer_cleanup,
+};
+
+static void mock_fb_cleanup(void *ptr)
+{
+	drm_framebuffer_put(ptr);
+}
+
+/*
+ * Test that drm_atomic_helper_plane_compare_state() reports a plane
+ * scanning out a cropped part of its framebuffer as identical to the
+ * state read out of the hardware: the framebuffer reconstructed from
+ * the hardware only covers the part of the buffer that is scanned
+ * out, with the source rectangle at its origin, and neither the
+ * source offsets nor the origin of the clipped source rectangle can be
+ * read back.
+ */
+static void drm_test_sro_compare_plane_cropped(struct kunit *test)
+{
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	struct drm_plane_state *expected, *actual;
+	struct drm_framebuffer *fb, *hw_fb;
+	struct drm_printer *p;
+	bool identical;
+	int ret;
+
+	p = drm_kunit_helper_printer(test, LOGLEVEL_ERR);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	/* The framebuffer userspace committed, cropped by the source rectangle */
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+	fb->dev = &priv->drm;
+	fb->format = drm_format_info(DRM_FORMAT_XRGB8888);
+	fb->width = 800;
+	fb->height = 600;
+	fb->pitches[0] = 3200;
+	ret = drm_framebuffer_init(&priv->drm, fb, &mock_fb_funcs);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	kunit_add_action_or_reset(test, mock_fb_cleanup, fb);
+
+	/* The framebuffer the readout reconstructs, as large as the source */
+	hw_fb = kunit_kzalloc(test, sizeof(*hw_fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, hw_fb);
+	hw_fb->dev = &priv->drm;
+	hw_fb->format = drm_format_info(DRM_FORMAT_XRGB8888);
+	hw_fb->width = 640;
+	hw_fb->height = 480;
+	hw_fb->pitches[0] = 3200;
+	ret = drm_framebuffer_init(&priv->drm, hw_fb, &mock_fb_funcs);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	kunit_add_action_or_reset(test, mock_fb_cleanup, hw_fb);
+
+	expected = priv->plane->funcs->atomic_create_state(priv->plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected);
+	drm_framebuffer_get(fb);
+	expected->fb = fb;
+	expected->src_x = 16 << 16;
+	expected->src_y = 16 << 16;
+	expected->src_w = 640 << 16;
+	expected->src_h = 480 << 16;
+	expected->crtc_w = 640;
+	expected->crtc_h = 480;
+	/* As drm_atomic_helper_check_plane_state() would compute them */
+	drm_rect_init(&expected->src, 16 << 16, 16 << 16, 640 << 16, 480 << 16);
+	drm_rect_init(&expected->dst, 0, 0, 640, 480);
+
+	actual = priv->plane->funcs->atomic_create_state(priv->plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, actual);
+	drm_framebuffer_get(hw_fb);
+	actual->fb = hw_fb;
+	actual->src_w = 640 << 16;
+	actual->src_h = 480 << 16;
+	actual->crtc_w = 640;
+	actual->crtc_h = 480;
+	/* The readout roots the source rectangle at the origin */
+	drm_rect_init(&actual->src, 0, 0, 640 << 16, 480 << 16);
+	drm_rect_init(&actual->dst, 0, 0, 640, 480);
+
+	identical = drm_atomic_helper_plane_compare_state(priv->plane, p,
+							  expected, actual);
+	KUNIT_EXPECT_TRUE(test, identical);
+
+	priv->plane->funcs->atomic_destroy_state(priv->plane, expected);
+	priv->plane->funcs->atomic_destroy_state(priv->plane, actual);
+}
+
+/*
+ * Test that plane states differing by a single field compare as
+ * different, and that the mismatching field is reported through the
+ * printer.
+ */
+static void drm_test_sro_compare_plane_mismatch(struct kunit *test)
+{
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	struct drm_plane_state *state1, *state2;
+	struct drm_printer *p;
+	bool identical;
+
+	p = drm_kunit_helper_printer(test, LOGLEVEL_ERR);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	state1 = priv->plane->funcs->atomic_create_state(priv->plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
+
+	state2 = priv->plane->funcs->atomic_create_state(priv->plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
+
+	state2->crtc = priv->crtc;
+
+	identical = drm_atomic_helper_plane_compare_state(priv->plane, p,
+							  state1, state2);
+	KUNIT_EXPECT_FALSE(test, identical);
+
+	priv->plane->funcs->atomic_destroy_state(priv->plane, state1);
+	priv->plane->funcs->atomic_destroy_state(priv->plane, state2);
+}
+
+/*
+ * Test that two identical active CRTC states compare as equal.
+ */
+static void drm_test_sro_compare_crtc_identical(struct kunit *test)
+{
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	struct drm_crtc_state *state1, *state2;
+	struct drm_printer *p;
+	bool identical;
+
+	p = drm_kunit_helper_printer(test, LOGLEVEL_ERR);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	state1 = priv->crtc->funcs->atomic_create_state(priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
+
+	state2 = priv->crtc->funcs->atomic_create_state(priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
+
+	state1->enable = true;
+	state1->active = true;
+	state2->enable = true;
+	state2->active = true;
+
+	identical = drm_atomic_helper_crtc_compare_state(priv->crtc, p,
+							 state1, state2);
+	KUNIT_EXPECT_TRUE(test, identical);
+
+	priv->crtc->funcs->atomic_destroy_state(priv->crtc, state1);
+	priv->crtc->funcs->atomic_destroy_state(priv->crtc, state2);
+}
+
+/*
+ * Test that two inactive CRTCs compare as equal even though their
+ * modes differ: the modes are meaningless while inactive and must not
+ * be compared.
+ */
+static void drm_test_sro_compare_crtc_inactive(struct kunit *test)
+{
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	struct drm_display_mode *mode1, *mode2;
+	struct drm_crtc_state *state1, *state2;
+	struct drm_printer *p;
+	bool identical;
+
+	p = drm_kunit_helper_printer(test, LOGLEVEL_ERR);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	state1 = priv->crtc->funcs->atomic_create_state(priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
+
+	state2 = priv->crtc->funcs->atomic_create_state(priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
+
+	/* Two different but valid modes */
+	mode1 = drm_kunit_display_mode_from_cea_vic(test, &priv->drm, 16);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode1);
+
+	mode2 = drm_kunit_display_mode_from_cea_vic(test, &priv->drm, 4);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode2);
+
+	/*
+	 * Both CRTCs are inactive: the modes are meaningless and must
+	 * not be compared.
+	 */
+	drm_mode_copy(&state1->mode, mode1);
+	drm_mode_copy(&state2->mode, mode2);
+
+	identical = drm_atomic_helper_crtc_compare_state(priv->crtc, p,
+							 state1, state2);
+	KUNIT_EXPECT_TRUE(test, identical);
+
+	priv->crtc->funcs->atomic_destroy_state(priv->crtc, state1);
+	priv->crtc->funcs->atomic_destroy_state(priv->crtc, state2);
+}
+
+/*
+ * Test that an active CRTC and an inactive one compare as different.
+ */
+static void drm_test_sro_compare_crtc_active_mismatch(struct kunit *test)
+{
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	struct drm_crtc_state *state1, *state2;
+	struct drm_printer *p;
+	bool identical;
+
+	p = drm_kunit_helper_printer(test, LOGLEVEL_ERR);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	state1 = priv->crtc->funcs->atomic_create_state(priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
+
+	state2 = priv->crtc->funcs->atomic_create_state(priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
+
+	state1->enable = true;
+	state1->active = true;
+
+	identical = drm_atomic_helper_crtc_compare_state(priv->crtc, p,
+							 state1, state2);
+	KUNIT_EXPECT_FALSE(test, identical);
+
+	priv->crtc->funcs->atomic_destroy_state(priv->crtc, state1);
+	priv->crtc->funcs->atomic_destroy_state(priv->crtc, state2);
+}
+
+/*
+ * Test that two identical connector states compare as equal.
+ */
+static void drm_test_sro_compare_connector_identical(struct kunit *test)
+{
+	struct drm_connector *connector;
+	struct sro_test_priv *priv;
+	struct drm_connector_state *state1, *state2;
+	struct drm_printer *p;
+	bool identical;
+
+	p = drm_kunit_helper_printer(test, LOGLEVEL_ERR);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	priv = mock_device_with_sro_create(test);
+	connector = &priv->connector;
+
+	state1 = connector->funcs->atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
+
+	state2 = connector->funcs->atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
+
+	identical =
+		drm_atomic_helper_connector_compare_state(connector, p,
+							  state1, state2);
+	KUNIT_EXPECT_TRUE(test, identical);
+
+	connector->funcs->atomic_destroy_state(connector, state1);
+	connector->funcs->atomic_destroy_state(connector, state2);
+}
+
+/*
+ * Test that connector states whose CRTCs differ compare as different.
+ */
+static void drm_test_sro_compare_connector_mismatch(struct kunit *test)
+{
+	struct drm_connector *connector;
+	struct sro_test_priv *priv;
+	struct drm_connector_state *state1, *state2;
+	struct drm_printer *p;
+	bool identical;
+
+	p = drm_kunit_helper_printer(test, LOGLEVEL_ERR);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	priv = mock_device_with_sro_create(test);
+	connector = &priv->connector;
+
+	state1 = connector->funcs->atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
+
+	state2 = connector->funcs->atomic_create_state(connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
+
+	/*
+	 * A state bound to a CRTC holds a reference on its connector,
+	 * released by __drm_atomic_helper_connector_destroy_state():
+	 * take it since the crtc pointer is set by hand here.
+	 */
+	drm_connector_get(connector);
+	state2->crtc = priv->crtc;
+
+	identical =
+		drm_atomic_helper_connector_compare_state(connector, p,
+							  state1, state2);
+	KUNIT_EXPECT_FALSE(test, identical);
+
+	connector->funcs->atomic_destroy_state(connector, state1);
+	connector->funcs->atomic_destroy_state(connector, state2);
+}
+
+/*
+ * Test that two identical bridge states compare as equal.
+ */
+static void drm_test_sro_compare_bridge_identical(struct kunit *test)
+{
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	struct drm_bridge_state *state1, *state2;
+	struct drm_printer *p;
+	bool identical;
+
+	p = drm_kunit_helper_printer(test, LOGLEVEL_ERR);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	priv->bridge.funcs = &mock_bridge_funcs;
+	priv->bridge.name = "test bridge";
+
+	state1 = drm_atomic_helper_bridge_create_state(&priv->bridge);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
+
+	state2 = drm_atomic_helper_bridge_create_state(&priv->bridge);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
+
+	identical = drm_atomic_helper_bridge_compare_state(&priv->bridge, p,
+							   state1, state2);
+	KUNIT_EXPECT_TRUE(test, identical);
+
+	priv->bridge.funcs->atomic_destroy_state(&priv->bridge, state1);
+	priv->bridge.funcs->atomic_destroy_state(&priv->bridge, state2);
+}
+
+/*
+ * Test that bridge states whose input bus formats differ compare as
+ * different.
+ */
+static void drm_test_sro_compare_bridge_mismatch(struct kunit *test)
+{
+	struct sro_test_priv *priv = mock_device_with_sro_create(test);
+	struct drm_bridge_state *state1, *state2;
+	struct drm_printer *p;
+	bool identical;
+
+	p = drm_kunit_helper_printer(test, LOGLEVEL_ERR);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	priv->bridge.funcs = &mock_bridge_funcs;
+	priv->bridge.name = "test bridge";
+
+	state1 = drm_atomic_helper_bridge_create_state(&priv->bridge);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
+
+	state2 = drm_atomic_helper_bridge_create_state(&priv->bridge);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
+
+	state2->input_bus_cfg.format = MEDIA_BUS_FMT_RGB888_1X24;
+
+	identical = drm_atomic_helper_bridge_compare_state(&priv->bridge, p,
+							   state1, state2);
+	KUNIT_EXPECT_FALSE(test, identical);
+
+	priv->bridge.funcs->atomic_destroy_state(&priv->bridge, state1);
+	priv->bridge.funcs->atomic_destroy_state(&priv->bridge, state2);
+}
+
+static struct kunit_case drm_atomic_sro_compare_tests[] = {
+	KUNIT_CASE(drm_test_sro_compare_plane_identical),
+	KUNIT_CASE(drm_test_sro_compare_plane_mismatch),
+	KUNIT_CASE(drm_test_sro_compare_plane_cropped),
+	KUNIT_CASE(drm_test_sro_compare_crtc_identical),
+	KUNIT_CASE(drm_test_sro_compare_crtc_inactive),
+	KUNIT_CASE(drm_test_sro_compare_crtc_active_mismatch),
+	KUNIT_CASE(drm_test_sro_compare_connector_identical),
+	KUNIT_CASE(drm_test_sro_compare_connector_mismatch),
+	KUNIT_CASE(drm_test_sro_compare_bridge_identical),
+	KUNIT_CASE(drm_test_sro_compare_bridge_mismatch),
+	{ }
+};
+
+static struct kunit_suite drm_atomic_sro_compare_test_suite = {
+	.name = "drm_atomic_sro_compare",
+	.test_cases = drm_atomic_sro_compare_tests,
+};
+
+/*
+ * drm_mode_config_create_initial_state() tests
+ */
+
+/*
+ * Test that when the readout succeeds,
+ * drm_mode_config_create_initial_state() installs the states it read
+ * out and doesn't reset the hardware.
+ */
+static void drm_test_mode_config_initial_state_readout(struct kunit *test)
+{
+	struct mock_privobj_state *privobj_state;
+	struct sro_test_priv *priv;
+	int ret;
+
+	priv = mock_device_with_sro_create(test);
+
+	ret = drm_mode_config_create_initial_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* The read out states have been installed */
+	KUNIT_EXPECT_TRUE(test, priv->crtc->state->enable);
+	KUNIT_EXPECT_TRUE(test, priv->crtc->state->active);
+	KUNIT_EXPECT_TRUE(test, priv->plane->state->visible);
+	KUNIT_EXPECT_PTR_EQ(test, priv->connector.state->crtc, priv->crtc);
+
+	KUNIT_ASSERT_NOT_NULL(test, priv->private_obj.state);
+	privobj_state = to_mock_privobj_state(priv->private_obj.state);
+	KUNIT_EXPECT_TRUE(test, privobj_state->readout);
+
+	/* No fallback to a hardware reset has been needed */
+	KUNIT_EXPECT_FALSE(test, priv->hw_reset_called);
+}
+
+/*
+ * Test that when the driver reports the hardware configuration as
+ * unsupported, drm_mode_config_create_initial_state() falls back to
+ * the regular initialization path: the hardware is reset and pristine
+ * states are created.
+ */
+static void drm_test_mode_config_initial_state_readout_error(struct kunit *test)
+{
+	struct mock_privobj_state *privobj_state;
+	struct sro_test_priv *priv;
+	int ret;
+
+	priv = mock_device_create(test,
+				  &mock_mode_config_with_sro_err_funcs,
+				  &mock_mode_config_helper_without_sro_funcs,
+				  &mock_plane_with_sro_funcs,
+				  &mock_crtc_with_sro_funcs,
+				  &mock_connector_with_sro_funcs);
+
+	ret = drm_mode_config_create_initial_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* The regular initialization path has been taken */
+	KUNIT_EXPECT_TRUE(test, priv->hw_reset_called);
+
+	/* A pristine state has been created for all the objects */
+	KUNIT_ASSERT_NOT_NULL(test, priv->crtc->state);
+	KUNIT_EXPECT_FALSE(test, priv->crtc->state->enable);
+	KUNIT_EXPECT_FALSE(test, priv->crtc->state->active);
+	KUNIT_ASSERT_NOT_NULL(test, priv->plane->state);
+	KUNIT_ASSERT_NOT_NULL(test, priv->connector.state);
+
+	KUNIT_ASSERT_NOT_NULL(test, priv->private_obj.state);
+	privobj_state = to_mock_privobj_state(priv->private_obj.state);
+	KUNIT_EXPECT_FALSE(test, privobj_state->readout);
+}
+
+/*
+ * Test that when an object readout hook reports the hardware
+ * configuration as unsupported, drm_mode_config_create_initial_state()
+ * falls back to the regular initialization path.
+ */
+static void
+drm_test_mode_config_initial_state_object_readout_error(struct kunit *test)
+{
+	struct sro_test_priv *priv;
+	int ret;
+
+	priv = mock_device_create(test,
+				  &mock_mode_config_with_sro_funcs,
+				  &mock_mode_config_helper_with_sro_funcs,
+				  &mock_plane_with_sro_funcs,
+				  &mock_crtc_with_sro_funcs,
+				  &mock_connector_with_sro_err_funcs);
+
+	ret = drm_mode_config_create_initial_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* The regular initialization path has been taken */
+	KUNIT_EXPECT_TRUE(test, priv->hw_reset_called);
+
+	/* A pristine state has been created for all the objects */
+	KUNIT_ASSERT_NOT_NULL(test, priv->crtc->state);
+	KUNIT_EXPECT_FALSE(test, priv->crtc->state->enable);
+	KUNIT_EXPECT_FALSE(test, priv->crtc->state->active);
+	KUNIT_ASSERT_NOT_NULL(test, priv->plane->state);
+	KUNIT_ASSERT_NOT_NULL(test, priv->connector.state);
+}
+
+/*
+ * Test that a driver without readout support takes the regular
+ * initialization path as well.
+ */
+static void drm_test_mode_config_initial_state_no_readout(struct kunit *test)
+{
+	struct sro_test_priv *priv;
+	int ret;
+
+	priv = mock_device_create(test,
+				  &mock_mode_config_without_sro_with_hw_reset_funcs,
+				  &mock_mode_config_helper_without_sro_funcs,
+				  &mock_plane_with_sro_funcs,
+				  &mock_crtc_with_sro_funcs,
+				  &mock_connector_with_sro_funcs);
+
+	ret = drm_mode_config_create_initial_state(&priv->drm);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* The regular initialization path has been taken */
+	KUNIT_EXPECT_TRUE(test, priv->hw_reset_called);
+
+	KUNIT_ASSERT_NOT_NULL(test, priv->crtc->state);
+	KUNIT_EXPECT_FALSE(test, priv->crtc->state->enable);
+	KUNIT_EXPECT_FALSE(test, priv->crtc->state->active);
+	KUNIT_ASSERT_NOT_NULL(test, priv->plane->state);
+	KUNIT_ASSERT_NOT_NULL(test, priv->connector.state);
+}
+
+static struct kunit_case drm_mode_config_initial_state_tests[] = {
+	KUNIT_CASE(drm_test_mode_config_initial_state_readout),
+	KUNIT_CASE(drm_test_mode_config_initial_state_readout_error),
+	KUNIT_CASE(drm_test_mode_config_initial_state_object_readout_error),
+	KUNIT_CASE(drm_test_mode_config_initial_state_no_readout),
+	{ }
+};
+
+static struct kunit_suite drm_mode_config_initial_state_test_suite = {
+	.name = "drm_mode_config_initial_state",
+	.test_cases = drm_mode_config_initial_state_tests,
+};
+
+/*
+ * GEM DMA object helper tests
+ */
+
+#define SRO_TEST_DMA_ADDR	0x80000000UL
+
+static const struct drm_driver sro_test_gem_driver = {
+	.driver_features = DRIVER_GEM | DRIVER_MODESET,
+};
+
+static struct drm_gem_object *
+sro_test_gem_create_object(struct drm_device *drm, size_t size)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static const struct drm_driver sro_test_gem_custom_driver = {
+	.driver_features = DRIVER_GEM | DRIVER_MODESET,
+	.gem_create_object = sro_test_gem_create_object,
+};
+
+static struct drm_device *
+sro_test_gem_device_create(struct kunit *test, const struct drm_driver *driver)
+{
+	struct drm_device *drm;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device_with_driver(test, dev,
+							      sizeof(*drm), 0,
+							      driver);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	return drm;
+}
+
+static void sro_test_gem_object_put(void *ptr)
+{
+	drm_gem_object_put(ptr);
+}
+
+static struct drm_gem_dma_object *
+sro_test_gem_dma_create(struct kunit *test, size_t size)
+{
+	struct drm_gem_dma_object *dma_obj;
+	struct drm_device *drm;
+	int ret;
+
+	drm = sro_test_gem_device_create(test, &sro_test_gem_driver);
+
+	dma_obj = drm_atomic_helper_sro_create_gem_dma_object(drm,
+							      SRO_TEST_DMA_ADDR,
+							      size);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dma_obj);
+
+	ret = kunit_add_action_or_reset(test, sro_test_gem_object_put,
+					&dma_obj->base);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return dma_obj;
+}
+
+/*
+ * Test that drm_atomic_helper_sro_create_gem_dma_object() creates an
+ * object for the device and DMA address it was given, whose size is
+ * rounded up to a whole number of pages, and that has no CPU mapping.
+ */
+static void drm_test_sro_gem_dma_create(struct kunit *test)
+{
+	struct drm_gem_dma_object *dma_obj;
+
+	dma_obj = sro_test_gem_dma_create(test, PAGE_SIZE + 1);
+
+	KUNIT_EXPECT_EQ(test, (u64)dma_obj->dma_addr, (u64)SRO_TEST_DMA_ADDR);
+	KUNIT_EXPECT_EQ(test, dma_obj->base.size, 2 * PAGE_SIZE);
+	KUNIT_EXPECT_NULL(test, dma_obj->vaddr);
+	KUNIT_EXPECT_NULL(test, dma_obj->sgt);
+	KUNIT_EXPECT_FALSE(test, dma_obj->map_noncoherent);
+}
+
+/*
+ * Test that drm_atomic_helper_sro_create_gem_dma_object() rejects an
+ * empty buffer with -EINVAL.
+ */
+static void drm_test_sro_gem_dma_create_empty(struct kunit *test)
+{
+	struct drm_gem_dma_object *dma_obj;
+	struct drm_device *drm;
+
+	drm = sro_test_gem_device_create(test, &sro_test_gem_driver);
+
+	dma_obj = drm_atomic_helper_sro_create_gem_dma_object(drm,
+							      SRO_TEST_DMA_ADDR,
+							      0);
+	KUNIT_ASSERT_TRUE(test, IS_ERR(dma_obj));
+	KUNIT_EXPECT_EQ(test, PTR_ERR(dma_obj), -EINVAL);
+}
+
+/*
+ * Test that drm_atomic_helper_sro_create_gem_dma_object() refuses to
+ * create an object for a device whose driver provides its own GEM
+ * object type through &drm_driver.gem_create_object: its code would
+ * cast the object to that type. The helper warns and fails with
+ * -EOPNOTSUPP.
+ */
+static void drm_test_sro_gem_dma_create_custom_driver(struct kunit *test)
+{
+	struct drm_gem_dma_object *dma_obj;
+	struct drm_device *drm;
+
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	drm = sro_test_gem_device_create(test, &sro_test_gem_custom_driver);
+
+	kunit_warning_suppress(test) {
+		dma_obj = drm_atomic_helper_sro_create_gem_dma_object(drm,
+								      SRO_TEST_DMA_ADDR,
+								      PAGE_SIZE);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+
+	KUNIT_ASSERT_TRUE(test, IS_ERR(dma_obj));
+	KUNIT_EXPECT_EQ(test, PTR_ERR(dma_obj), -EOPNOTSUPP);
+}
+
+/*
+ * Test that the object created by
+ * drm_atomic_helper_sro_create_gem_dma_object() can't be mapped in the
+ * kernel or in userspace, nor exported, since the memory behind it
+ * might not be accessible from the CPU.
+ */
+static void drm_test_sro_gem_dma_no_mapping(struct kunit *test)
+{
+	struct drm_gem_dma_object *dma_obj;
+
+	dma_obj = sro_test_gem_dma_create(test, PAGE_SIZE);
+
+	KUNIT_EXPECT_NULL(test, dma_obj->base.funcs->vmap);
+	KUNIT_EXPECT_NULL(test, dma_obj->base.funcs->mmap);
+	KUNIT_EXPECT_NULL(test, dma_obj->base.funcs->get_sg_table);
+}
+
+/*
+ * Test that the object created by
+ * drm_atomic_helper_sro_create_gem_dma_object() fails the creation of
+ * a handle for a file with -ENODEV, so that userspace can't get a handle
+ * to it, through GETFB2 for example.
+ */
+static void drm_test_sro_gem_dma_no_handle(struct kunit *test)
+{
+	struct drm_gem_dma_object *dma_obj;
+	int ret;
+
+	dma_obj = sro_test_gem_dma_create(test, PAGE_SIZE);
+
+	KUNIT_ASSERT_NOT_NULL(test, dma_obj->base.funcs->open);
+
+	ret = dma_obj->base.funcs->open(&dma_obj->base, NULL);
+	KUNIT_EXPECT_EQ(test, ret, -ENODEV);
+}
+
+static struct kunit_case drm_atomic_sro_gem_dma_tests[] = {
+	KUNIT_CASE(drm_test_sro_gem_dma_create),
+	KUNIT_CASE(drm_test_sro_gem_dma_create_empty),
+	KUNIT_CASE(drm_test_sro_gem_dma_create_custom_driver),
+	KUNIT_CASE(drm_test_sro_gem_dma_no_mapping),
+	KUNIT_CASE(drm_test_sro_gem_dma_no_handle),
+	{}
+};
+
+static struct kunit_suite drm_atomic_sro_gem_dma_test_suite = {
+	.name = "drm_atomic_sro_gem_dma",
+	.test_cases = drm_atomic_sro_gem_dma_tests,
+};
+
+kunit_test_suites(
+	&drm_atomic_sro_compare_test_suite,
+	&drm_atomic_sro_gem_dma_test_suite,
+	&drm_atomic_sro_readout_test_suite,
+	&drm_atomic_sro_readout_mode_test_suite,
+	&drm_atomic_sro_state_test_suite,
+	&drm_mode_config_initial_state_test_suite,
+);
+
+MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
+MODULE_DESCRIPTION("Kunit test for the DRM atomic state readout");
+MODULE_LICENSE("GPL");

-- 
2.56.1

