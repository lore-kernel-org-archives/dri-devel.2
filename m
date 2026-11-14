Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE37606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=k5mGdByu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD8C10F09B;
	Sat, 14 Nov 2026 18:05:16 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEB010E7B5
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679476;
 bh=q8YxitCLXIoiDyHwWcus3cdVy65RpFGHngoEFCcMx6o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=k5mGdByucvJCu/9/LXu64cV+Whyiea554iaACB+BhjTqqSvESi/8kPSw+0ijUEyQ2
 UDifp/O0v+k1iOGLRbWutXXKOBpW4bORwmCHiUlDJDI3fmPDbIuSQ7O+JGWWaXP7Gz
 iom8Q8PzSrWQc6RvLQO8eNyXpTfBSTSFGAmx4NuP8g0yotqJT2vQ7hC5o0WMgmSNgX
 0R5VG7Gp0vXJFQd/7E/9a7KSWLM2qqGApgCyJgDQ+k1KgloRlSI9nJD5TTAFeW882A
 YPmqRSEYbzGLRplQwxScRMC4qE/uHA8CLL5sNjwoaJHIYUgcLEAMzNTWm3LXcCsNAl
 wN8XzCI7fWBRA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2031A17E35C9;
 Sat, 14 Nov 2026 19:04:36 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:49 +0200
Subject: [PATCH 25/25] drm/tests: probe-helper: Add .force_ctx() callback
 coverage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-25-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The .force_ctx() connector helper callback takes precedence over the
.force() connector callback when probing a forced connector.

Add tests to make sure that:

- .force_ctx() is called instead of .force(), with the forced status
  already set and the connection_mutex held through the acquire context
- errors other than -EDEADLK don't prevent the connector from being
  probed
- .force() is still called when .force_ctx() is not provided
- -EDEADLK makes the probe back off and retry, while restoring the
  connector status beforehand, so that the status change gets detected

For the latter, a genuine deadlock is needed, since
drm_modeset_backoff() expects a contended lock.  Create one with an
older acquire context in a kthread, which wounds the probe context by
requesting the connection_mutex while holding a lock that the probe
context tries to take from .force_ctx().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_probe_helper_test.c | 296 ++++++++++++++++++++++++++
 1 file changed, 296 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_probe_helper_test.c b/drivers/gpu/drm/tests/drm_probe_helper_test.c
index ebc0392585e7..5d7dc4725518 100644
--- a/drivers/gpu/drm/tests/drm_probe_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_probe_helper_test.c
@@ -3,6 +3,9 @@
  * Kunit test for drm_probe_helper functions
  */
 
+#include <linux/completion.h>
+#include <linux/kthread.h>
+
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
@@ -11,14 +14,24 @@
 #include <drm/drm_mode.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_modeset_lock.h>
 #include <drm/drm_probe_helper.h>
 
 #include <kunit/test.h>
 
+struct drm_probe_helper_contender;
+
 struct drm_probe_helper_test_priv {
 	struct drm_device *drm;
 	struct device *dev;
 	struct drm_connector connector;
+
+	unsigned int force_count;
+	unsigned int force_ctx_count;
+	int force_ctx_ret;
+	bool force_ctx_locked;
+	enum drm_connector_status force_ctx_status;
+	struct drm_probe_helper_contender *contender;
 };
 
 static const struct drm_connector_helper_funcs drm_probe_helper_connector_helper_funcs = {
@@ -212,6 +225,289 @@ static struct kunit_suite drm_test_connector_helper_tv_get_modes_suite = {
 
 kunit_test_suite(drm_test_connector_helper_tv_get_modes_suite);
 
+/*
+ * Runs an acquire context older than the probe one, which first takes @lock,
+ * then waits to be told to also request the connection_mutex held by the
+ * probe context.  Being older, it wounds the probe context, which will get
+ * -EDEADLK as soon as it tries to take @lock.
+ */
+struct drm_probe_helper_contender {
+	struct drm_device *drm;
+	struct drm_modeset_lock lock;
+	struct completion locked;
+	struct completion go;
+	struct completion done;
+	int ret;
+};
+
+static int drm_probe_helper_contender_fn(void *data)
+{
+	struct drm_probe_helper_contender *contender = data;
+	struct drm_modeset_acquire_ctx ctx;
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	contender->ret = drm_modeset_lock(&contender->lock, &ctx);
+	complete(&contender->locked);
+
+	if (!contender->ret) {
+		if (wait_for_completion_timeout(&contender->go, 5 * HZ))
+			contender->ret =
+				drm_modeset_lock(&contender->drm->mode_config.connection_mutex,
+						 &ctx);
+		else
+			contender->ret = -ETIMEDOUT;
+	}
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	complete(&contender->done);
+
+	return 0;
+}
+
+static struct drm_probe_helper_test_priv *
+connector_to_probe_priv(struct drm_connector *connector)
+{
+	return container_of(connector, struct drm_probe_helper_test_priv, connector);
+}
+
+static void drm_probe_helper_test_force(struct drm_connector *connector)
+{
+	connector_to_probe_priv(connector)->force_count++;
+}
+
+static int drm_probe_helper_test_force_ctx(struct drm_connector *connector,
+					   struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_probe_helper_test_priv *priv = connector_to_probe_priv(connector);
+	struct drm_probe_helper_contender *contender = priv->contender;
+	int ret;
+
+	priv->force_ctx_count++;
+	priv->force_ctx_status = connector->status;
+	priv->force_ctx_locked =
+		drm_modeset_is_locked(&connector->dev->mode_config.connection_mutex);
+
+	if (contender && priv->force_ctx_count == 1) {
+		complete(&contender->go);
+
+		ret = drm_modeset_lock(&contender->lock, ctx);
+		if (ret)
+			return ret;
+	}
+
+	return priv->force_ctx_ret;
+}
+
+static int drm_probe_helper_test_get_modes(struct drm_connector *connector)
+{
+	return 0;
+}
+
+static const struct drm_connector_helper_funcs drm_probe_helper_force_ctx_helper_funcs = {
+	.get_modes	= drm_probe_helper_test_get_modes,
+	.force_ctx	= drm_probe_helper_test_force_ctx,
+};
+
+static const struct drm_connector_helper_funcs drm_probe_helper_force_helper_funcs = {
+	.get_modes	= drm_probe_helper_test_get_modes,
+};
+
+static const struct drm_connector_funcs drm_probe_helper_force_connector_funcs = {
+	.force			= drm_probe_helper_test_force,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
+	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
+	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
+};
+
+static int drm_probe_helper_force_test_init(struct kunit *test)
+{
+	struct drm_probe_helper_test_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+	test->priv = priv;
+
+	priv->dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
+
+	priv->drm = __drm_kunit_helper_alloc_drm_device(test, priv->dev,
+							sizeof(*priv->drm), 0,
+							DRIVER_MODESET | DRIVER_ATOMIC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->drm);
+
+	ret = drmm_connector_init(priv->drm, &priv->connector,
+				  &drm_probe_helper_force_connector_funcs,
+				  DRM_MODE_CONNECTOR_HDMIA,
+				  NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_connector_helper_add(&priv->connector,
+				 &drm_probe_helper_force_ctx_helper_funcs);
+
+	priv->connector.force = DRM_FORCE_ON;
+
+	return 0;
+}
+
+static int drm_probe_helper_test_probe(struct drm_probe_helper_test_priv *priv)
+{
+	int count;
+
+	mutex_lock(&priv->drm->mode_config.mutex);
+
+	count = drm_helper_probe_single_connector_modes(&priv->connector, 1920, 1080);
+
+	mutex_unlock(&priv->drm->mode_config.mutex);
+
+	return count;
+}
+
+/*
+ * Test that probing a forced connector calls .force_ctx(), in favour of
+ * .force(), with the forced status already set and the connection_mutex held
+ * through the acquire context.
+ */
+static void drm_test_probe_helper_force_ctx(struct kunit *test)
+{
+	struct drm_probe_helper_test_priv *priv = test->priv;
+	int count;
+
+	count = drm_probe_helper_test_probe(priv);
+	KUNIT_EXPECT_GT(test, count, 0);
+
+	KUNIT_EXPECT_EQ(test, priv->force_ctx_count, 1);
+	KUNIT_EXPECT_EQ(test, priv->force_count, 0);
+	KUNIT_EXPECT_EQ(test, priv->force_ctx_status, connector_status_connected);
+	KUNIT_EXPECT_TRUE(test, priv->force_ctx_locked);
+	KUNIT_EXPECT_EQ(test, priv->connector.status, connector_status_connected);
+}
+
+/*
+ * Test that probing a connector forced off calls .force_ctx() with the
+ * disconnected status set.
+ */
+static void drm_test_probe_helper_force_ctx_off(struct kunit *test)
+{
+	struct drm_probe_helper_test_priv *priv = test->priv;
+	int count;
+
+	priv->connector.force = DRM_FORCE_OFF;
+
+	count = drm_probe_helper_test_probe(priv);
+	KUNIT_EXPECT_EQ(test, count, 0);
+
+	KUNIT_EXPECT_EQ(test, priv->force_ctx_count, 1);
+	KUNIT_EXPECT_EQ(test, priv->force_ctx_status, connector_status_disconnected);
+	KUNIT_EXPECT_EQ(test, priv->connector.status, connector_status_disconnected);
+}
+
+/*
+ * Test that a .force_ctx() error other than -EDEADLK doesn't prevent the
+ * forced connector from being probed.
+ */
+static void drm_test_probe_helper_force_ctx_error(struct kunit *test)
+{
+	struct drm_probe_helper_test_priv *priv = test->priv;
+	int count;
+
+	priv->force_ctx_ret = -EIO;
+
+	count = drm_probe_helper_test_probe(priv);
+	KUNIT_EXPECT_GT(test, count, 0);
+
+	KUNIT_EXPECT_EQ(test, priv->force_ctx_count, 1);
+	KUNIT_EXPECT_EQ(test, priv->connector.status, connector_status_connected);
+}
+
+/*
+ * Test that a .force_ctx() returning -EDEADLK makes the probe back off and
+ * retry, while restoring the connector status beforehand, so that the status
+ * change still gets detected.
+ */
+static void drm_test_probe_helper_force_ctx_deadlock(struct kunit *test)
+{
+	struct drm_probe_helper_test_priv *priv = test->priv;
+	struct drm_probe_helper_contender *contender;
+	struct task_struct *task;
+	int count = 0;
+	bool done;
+
+	KUNIT_ASSERT_EQ(test, priv->connector.status, connector_status_unknown);
+	KUNIT_ASSERT_FALSE(test, priv->drm->mode_config.delayed_event);
+
+	contender = kunit_kzalloc(test, sizeof(*contender), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, contender);
+
+	contender->drm = priv->drm;
+	drm_modeset_lock_init(&contender->lock);
+	init_completion(&contender->locked);
+	init_completion(&contender->go);
+	init_completion(&contender->done);
+
+	task = kthread_run(drm_probe_helper_contender_fn, contender,
+			   "drm-probe-contender");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, task);
+
+	/* Make sure the contender context is the older one */
+	wait_for_completion(&contender->locked);
+	if (!contender->ret) {
+		priv->contender = contender;
+		count = drm_probe_helper_test_probe(priv);
+	}
+
+	/* The contender must be gone before releasing its resources */
+	done = wait_for_completion_timeout(&contender->done, 10 * HZ);
+	KUNIT_ASSERT_TRUE(test, done);
+	KUNIT_ASSERT_EQ(test, contender->ret, 0);
+
+	KUNIT_EXPECT_GT(test, count, 0);
+	KUNIT_EXPECT_EQ(test, priv->force_ctx_count, 2);
+	KUNIT_EXPECT_EQ(test, priv->force_ctx_status, connector_status_connected);
+	KUNIT_EXPECT_EQ(test, priv->connector.status, connector_status_connected);
+	KUNIT_EXPECT_TRUE(test, priv->drm->mode_config.delayed_event);
+}
+
+/*
+ * Test that probing a forced connector still calls .force() when no
+ * .force_ctx() is provided.
+ */
+static void drm_test_probe_helper_force(struct kunit *test)
+{
+	struct drm_probe_helper_test_priv *priv = test->priv;
+	int count;
+
+	drm_connector_helper_add(&priv->connector,
+				 &drm_probe_helper_force_helper_funcs);
+
+	count = drm_probe_helper_test_probe(priv);
+	KUNIT_EXPECT_GT(test, count, 0);
+
+	KUNIT_EXPECT_EQ(test, priv->force_count, 1);
+	KUNIT_EXPECT_EQ(test, priv->force_ctx_count, 0);
+	KUNIT_EXPECT_EQ(test, priv->connector.status, connector_status_connected);
+}
+
+static struct kunit_case drm_test_probe_helper_force_tests[] = {
+	KUNIT_CASE(drm_test_probe_helper_force_ctx),
+	KUNIT_CASE(drm_test_probe_helper_force_ctx_off),
+	KUNIT_CASE(drm_test_probe_helper_force_ctx_error),
+	KUNIT_CASE(drm_test_probe_helper_force_ctx_deadlock),
+	KUNIT_CASE(drm_test_probe_helper_force),
+	{ }
+};
+
+static struct kunit_suite drm_test_probe_helper_force_suite = {
+	.name = "drm_probe_helper_force",
+	.init = drm_probe_helper_force_test_init,
+	.test_cases = drm_test_probe_helper_force_tests,
+};
+
+kunit_test_suite(drm_test_probe_helper_force_suite);
+
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_DESCRIPTION("Kunit test for drm_probe_helper functions");
 MODULE_LICENSE("GPL");

-- 
2.56.0

