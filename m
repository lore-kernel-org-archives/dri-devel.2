Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B767AC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B7410E693;
	Mon, 24 Aug 2026 08:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MNETcf8d";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD65B10E699
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:10:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 106DC601E0;
 Mon, 24 Aug 2026 08:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CAE1F000E9;
 Mon, 24 Aug 2026 08:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787559024;
 bh=5Ne6GW+4LwRVPfK8t/qDouInUQy6qPmyQ9GG5USyyj4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MNETcf8dnbhWHBBlENARFM78rJ+I/7cO2WAtL1bc2j8NMu31kCU6YMTbR93ccC2lc
 e8z76aJGoGMZ2Aqerlw3I66pKQNJbn2LQkESBxF6mQFVrR0Ho42E3PlyozmQnru60p
 m5auqLMbuX79ICsPawjAiHtoMVq6fyk6EhPU0vIpZuGMhMn5k32zg8r+B9l/g9Havw
 aGE6feJLzcwnehjcf1Tc5BNkGksOdpLUq2niBfFOjAphLdGqe3lnMsjaHi82FZ7pR/
 QZcAl29xK245fAsFYBN4wwZY2ZE+axxUkmHnVM31UVeutRZk1L52ekRJV2G28iYgp0
 04mUShod8E6uw==
From: Konstantin Sinyuk <ksinyuk@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ilia Levi <ilia.levi@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/12] drm/fabric: add mutation KUnit tests
Date: Mon, 24 Aug 2026 11:09:39 +0300
Message-ID: <56ac95cbe4dfdfec86f4828bd59e4b3539b9bb39.1787552412.git.ksinyuk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add KUnit coverage for the provisioning core: userspace-fabric lifetime
and its module reference, orphan attach and detach, administrative state,
peer-management authority, and failure paths that must not commit.

Threaded cases verify that mutation serializes against endpoint unregister
and competing fabric-ep-id registration, and that concurrent mutators never
overlap provider callbacks.

Signed-off-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Assisted-by: GitHub-Copilot:claude-opus-4.8
---
 drivers/gpu/drm/fabric/Kconfig           |    3 +-
 drivers/gpu/drm/fabric/drm_fabric_test.c | 1612 ++++++++++++++++++++--
 2 files changed, 1467 insertions(+), 148 deletions(-)

diff --git a/drivers/gpu/drm/fabric/Kconfig b/drivers/gpu/drm/fabric/Kconfig
index 2a70cac85b1d..7f427ac42a27 100644
--- a/drivers/gpu/drm/fabric/Kconfig
+++ b/drivers/gpu/drm/fabric/Kconfig
@@ -29,7 +29,8 @@ config DRM_FABRIC_KUNIT_TEST
 	depends on KUNIT=y || DRM_FABRIC=m
 	default KUNIT_ALL_TESTS
 	help
-	  Enable KUnit coverage for the drm_fabric object model.
+	  KUnit tests for the drm_fabric object model and topology-mutation
+	  paths.
 
 	  The tests are built into drm_fabric itself, so they need no exported
 	  symbols or test-only accessors in the production source.
diff --git a/drivers/gpu/drm/fabric/drm_fabric_test.c b/drivers/gpu/drm/fabric/drm_fabric_test.c
index 863b7cf69068..d2c88d183737 100644
--- a/drivers/gpu/drm/fabric/drm_fabric_test.c
+++ b/drivers/gpu/drm/fabric/drm_fabric_test.c
@@ -11,9 +11,15 @@
 #include <kunit/test.h>
 #include <kunit/device.h>
 
+#include <linux/atomic.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/jiffies.h>
+#include <linux/kthread.h>
 #include <linux/mutex.h>
+#include <linux/sched.h>
 #include <linux/string.h>
 
 #include <drm/drm_fabric.h>
@@ -35,6 +41,36 @@ static struct device *fabrictest_alloc_dev(struct kunit *test)
 	return dev;
 }
 
+static struct drm_fabric *fabrictest_find_fabric(u32 id)
+{
+	struct drm_fabric *fab;
+
+	mutex_lock(&drm_fabric_lock);
+	fab = drm_fabric_find_by_id(id);
+	mutex_unlock(&drm_fabric_lock);
+
+	return fab;
+}
+
+/*
+ * The FD-01 pin/unpin pair is only observable when drm_fabric is a loadable
+ * module; built-in, try_module_get() is a stub. Check this before trusting
+ * fabrictest_module_refcount().
+ */
+static bool fabrictest_module_refcount_observable(void)
+{
+	return IS_ENABLED(CONFIG_MODULE_UNLOAD) && IS_MODULE(CONFIG_DRM_FABRIC);
+}
+
+static int fabrictest_module_refcount(void)
+{
+#if defined(CONFIG_MODULE_UNLOAD) && IS_MODULE(CONFIG_DRM_FABRIC)
+	return module_refcount(THIS_MODULE);
+#else
+	return 0;
+#endif
+}
+
 static void fabrictest_unregister_fabric(void *fab)
 {
 	drm_fabric_unregister(fab);
@@ -759,44 +795,148 @@ static void drm_fabric_test_mesh_kn_topology(struct kunit *test)
 #undef KN_PORTS_PER_EP
 }
 
-static int fabrictest_stats_get(struct drm_fabric_port *port,
-				struct drm_fabric_port_stats *stats)
+/* Trivial provider that accepts every mutation so the core commits it. */
+static int fabrictest_mut_endpoint_set(struct drm_fabric_endpoint *ep,
+				       const struct drm_fabric_endpoint_change *change,
+				       struct drm_fabric *fabric)
 {
-	stats->read_bytes = 4096;
-	stats->write_bytes = 2048;
-	stats->link_down_count = 2;
-	stats->retrain_count = 3;
 	return 0;
 }
 
-static const struct drm_fabric_ops fabrictest_stats_ops = {
-	.port_stats_get = fabrictest_stats_get,
+static int fabrictest_mut_port_set(struct drm_fabric_port *port,
+				   enum drm_fabric_admin_state admin)
+{
+	return 0;
+}
+
+static int fabrictest_mut_port_peer_new(struct drm_fabric_port *port,
+					const struct drm_fabric_peer *peer)
+{
+	return 0;
+}
+
+static int fabrictest_mut_port_peer_del(struct drm_fabric_port *port)
+{
+	return 0;
+}
+
+static const struct drm_fabric_ops fabrictest_mut_ops = {
+	.endpoint_set	= fabrictest_mut_endpoint_set,
+	.port_set	= fabrictest_mut_port_set,
+	.port_peer_new	= fabrictest_mut_port_peer_new,
+	.port_peer_del	= fabrictest_mut_port_peer_del,
 };
 
-/* This does not exercise netlink dispatch or error propagation. */
-static void drm_fabric_test_port_stats_ops_registration(struct kunit *test)
+/*
+ * Provider that rejects every mutation: the core calls it before committing, so
+ * a failure must leave state, generation and notifications untouched.
+ */
+static int fabrictest_fail_port_set(struct drm_fabric_port *port,
+				    enum drm_fabric_admin_state admin)
 {
-	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
+	return -EIO;
+}
+
+static int fabrictest_fail_port_peer_new(struct drm_fabric_port *port,
+					 const struct drm_fabric_peer *peer)
+{
+	return -EIO;
+}
+
+static const struct drm_fabric_ops fabrictest_fail_ops = {
+	.port_set	= fabrictest_fail_port_set,
+	.port_peer_new	= fabrictest_fail_port_peer_new,
+};
+
+/*
+ * Internal mutators assert drm_fabric_mutation_lock is held, matching the
+ * netlink pre/post_doit contract; wrap each with the lock here.
+ */
+static int fabrictest_ep_set_locked(struct drm_fabric_endpoint *ep,
+				    const struct drm_fabric_endpoint_change *change)
+{
+	int ret;
+
+	mutex_lock(&drm_fabric_mutation_lock);
+	ret = drm_fabric_endpoint_set(ep, change);
+	mutex_unlock(&drm_fabric_mutation_lock);
+	return ret;
+}
+
+static int fabrictest_port_admin_locked(struct drm_fabric_port *port,
+					enum drm_fabric_admin_state admin)
+{
+	int ret;
+
+	mutex_lock(&drm_fabric_mutation_lock);
+	ret = drm_fabric_port_set_admin(port, admin);
+	mutex_unlock(&drm_fabric_mutation_lock);
+	return ret;
+}
+
+static int fabrictest_port_peer_new_locked(struct drm_fabric_port *port,
+					   const struct drm_fabric_peer *peer)
+{
+	int ret;
+
+	mutex_lock(&drm_fabric_mutation_lock);
+	ret = drm_fabric_port_peer_new(port, peer);
+	mutex_unlock(&drm_fabric_mutation_lock);
+	return ret;
+}
+
+static int fabrictest_port_peer_del_locked(struct drm_fabric_port *port)
+{
+	int ret;
+
+	mutex_lock(&drm_fabric_mutation_lock);
+	ret = drm_fabric_port_peer_del(port);
+	mutex_unlock(&drm_fabric_mutation_lock);
+	return ret;
+}
+
+static int fabrictest_user_fabric_new_locked(enum drm_fabric_type type,
+					     u64 instance_id, const char *name,
+					     u32 *fabric_id_out)
+{
+	int ret;
+
+	mutex_lock(&drm_fabric_mutation_lock);
+	ret = drm_fabric_user_fabric_new(type, instance_id, name, fabric_id_out);
+	mutex_unlock(&drm_fabric_mutation_lock);
+	return ret;
+}
+
+static int fabrictest_user_fabric_del_locked(u32 fabric_id)
+{
+	int ret;
+
+	mutex_lock(&drm_fabric_mutation_lock);
+	ret = drm_fabric_user_fabric_del(fabric_id);
+	mutex_unlock(&drm_fabric_mutation_lock);
+	return ret;
+}
+
+static void drm_fabric_test_failed_mutation_no_commit(struct kunit *test)
+{
+	struct device *dev = fabrictest_alloc_dev(test);
 	struct drm_fabric_desc fdesc = {
-		.type = DRM_FABRIC_TYPE_SYNTHETIC,
-		.name = "test-stats",
+		.type = DRM_FABRIC_TYPE_SYNTHETIC, .name = "test-failmut",
+	};
+	/* USERSPACE peer_mode so PORT_PEER_NEW reaches the provider below. */
+	struct drm_fabric_port_desc pdesc = {
+		.index = 0, .max_lane_count = 4,
+		.peer_mode = DRM_FABRIC_PEER_MODE_USERSPACE,
 	};
-	struct drm_fabric_port_desc pdesc = { .index = 0, .max_lane_count = 4 };
 	struct drm_fabric_endpoint_desc edesc = {
-		.fabric_ep_id = 0x5A,
-		.parent = fabrictest_dev,
-		.ops = &fabrictest_stats_ops,
-		.ports = &pdesc,
-		.num_ports = 1,
+		.fabric_ep_id = 0x66, .parent = dev, .ops = &fabrictest_fail_ops,
+		.ports = &pdesc, .num_ports = 1,
 	};
-	struct drm_fabric_endpoint_desc edesc_noops = {
-		.fabric_ep_id = 0x5B,
-		.parent = fabrictest_dev,
-		.ports = &pdesc,
-		.num_ports = 1,
+	struct drm_fabric_peer peer = {
+		.peer_id = 0x67, .peer_type = DRM_FABRIC_PEER_TYPE_ACCEL,
 	};
-	struct drm_fabric_port_stats stats = {};
-	struct drm_fabric_endpoint *ep, *ep_noops;
+	enum drm_fabric_admin_state admin0;
+	struct drm_fabric_endpoint *ep;
 	struct drm_fabric_port *port;
 	struct drm_fabric *fab;
 	u32 gen;
@@ -813,188 +953,194 @@ static void drm_fabric_test_port_stats_ops_registration(struct kunit *test)
 
 	port = fabrictest_port(ep, 0);
 	KUNIT_ASSERT_NOT_NULL(test, port);
+	admin0 = port->admin_state;
+	gen = drm_fabric_base_seq;
 
-	KUNIT_ASSERT_NOT_NULL(test, ep->ops);
-	KUNIT_ASSERT_NOT_NULL(test, ep->ops->port_stats_get);
-
-	/* A stats read is not a topology change: seq must not move. */
-	gen = fabrictest_seq_read();
-	KUNIT_EXPECT_EQ(test, ep->ops->port_stats_get(port, &stats), 0);
-	KUNIT_EXPECT_EQ(test, fabrictest_seq_read(), gen);
-	KUNIT_EXPECT_EQ(test, stats.read_bytes, 4096ULL);
-	KUNIT_EXPECT_EQ(test, stats.write_bytes, 2048ULL);
-	KUNIT_EXPECT_EQ(test, stats.link_down_count, 2ULL);
-	KUNIT_EXPECT_EQ(test, stats.retrain_count, 3ULL);
+	KUNIT_EXPECT_EQ(test,
+			fabrictest_port_admin_locked(port, DRM_FABRIC_ADMIN_STATE_UP), -EIO);
+	KUNIT_EXPECT_EQ(test, port->admin_state, admin0);
+	KUNIT_EXPECT_EQ(test, drm_fabric_base_seq, gen);
 
-	ep_noops = drm_fabric_endpoint_register(fab, &edesc_noops);
-	KUNIT_ASSERT_FALSE(test, IS_ERR(ep_noops));
-	KUNIT_ASSERT_EQ(test, 0,
-			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep_noops));
-	KUNIT_EXPECT_TRUE(test, !ep_noops->ops || !ep_noops->ops->port_stats_get);
+	KUNIT_EXPECT_EQ(test, fabrictest_port_peer_new_locked(port, &peer), -EIO);
+	KUNIT_EXPECT_FALSE(test, port->has_peer);
+	KUNIT_EXPECT_EQ(test, drm_fabric_base_seq, gen);
 }
 
-/*
- * Unregistering an endpoint that has a peer link must clear only that
- * endpoint's own port record; it must not touch the still-registered far
- * side's peer record. (Contrast with drm_fabric_port_unset_peer(), which
- * clears a peer explicitly and is covered separately.)
- */
-static void drm_fabric_test_local_unplug_keeps_edge(struct kunit *test)
+static void drm_fabric_test_orphan_attach_detach(struct kunit *test)
 {
 	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
 	struct drm_fabric_desc fdesc = {
 		.type = DRM_FABRIC_TYPE_SYNTHETIC,
-		.name = "test-unplug",
+		.name = "test-attach",
 	};
 	struct drm_fabric_port_desc pdesc = { .index = 0, .max_lane_count = 4 };
-	struct drm_fabric_endpoint_desc eadesc = {
-		.fabric_ep_id = 0xA0,
-		.name = "unplug-a",
-		.parent = fabrictest_dev,
-		.ports = &pdesc,
-		.num_ports = 1,
-	};
-	struct drm_fabric_endpoint_desc ebdesc = {
-		.fabric_ep_id = 0xB0,
-		.name = "unplug-b",
+	struct drm_fabric_endpoint_desc edesc = {
+		.fabric_ep_id = 0x55,
+		.name = "orphan-ep",
 		.parent = fabrictest_dev,
+		.ops = &fabrictest_mut_ops,
 		.ports = &pdesc,
 		.num_ports = 1,
 	};
-	struct drm_fabric_peer to_b = {
-		.peer_id = 0xB0, .peer_type = DRM_FABRIC_PEER_TYPE_ACCEL,
-	};
-	struct drm_fabric_peer to_a = {
-		.peer_id = 0xA0, .peer_type = DRM_FABRIC_PEER_TYPE_ACCEL,
-	};
+	struct drm_fabric_endpoint_change change;
 	struct drm_fabric *fab;
-	struct drm_fabric_endpoint *ep_a, *ep_b;
-	struct drm_fabric_port *pa, *pb;
+	struct drm_fabric_endpoint *ep;
+	u32 seq;
 
 	fab = drm_fabric_register(&fdesc);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(fab));
 	KUNIT_ASSERT_EQ(test, 0,
 			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, fab));
 
-	ep_a = drm_fabric_endpoint_register(fab, &eadesc);
-	KUNIT_ASSERT_FALSE(test, IS_ERR(ep_a));
-	KUNIT_ASSERT_EQ(test, 0,
-			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep_a));
-
-	ep_b = drm_fabric_endpoint_register(fab, &ebdesc);
-	KUNIT_ASSERT_FALSE(test, IS_ERR(ep_b));
+	ep = drm_fabric_endpoint_register(NULL, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep));
 	KUNIT_ASSERT_EQ(test, 0,
-			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep_b));
-
-	pa = fabrictest_port(ep_a, 0);
-	pb = fabrictest_port(ep_b, 0);
-	KUNIT_ASSERT_NOT_NULL(test, pa);
-	KUNIT_ASSERT_NOT_NULL(test, pb);
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep));
 
-	KUNIT_ASSERT_EQ(test, drm_fabric_port_set_peer(pa, &to_b), 0);
-	KUNIT_ASSERT_EQ(test, drm_fabric_port_set_peer(pb, &to_a), 0);
-	KUNIT_EXPECT_TRUE(test, pa->has_peer);
+	KUNIT_EXPECT_NULL(test, ep->fabric);
+	KUNIT_EXPECT_EQ(test, ep->admin_state, DRM_FABRIC_ADMIN_STATE_DOWN);
 
 	/*
-	 * Remove B without retracting its peer first, modelling abrupt provider
-	 * teardown.
+	 * Membership and admin state are independent in the core; provider
+	 * policy may reject combinations such as admin-up on an orphan.
 	 */
-	kunit_release_action(test, fabrictest_unregister_endpoint, ep_b);
+	seq = drm_fabric_base_seq;
+	change = (struct drm_fabric_endpoint_change){
+		.valid = DRM_FABRIC_EP_CHANGE_ADMIN, .admin = DRM_FABRIC_ADMIN_STATE_UP,
+	};
+	KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(ep, &change), 0);
+	KUNIT_EXPECT_EQ(test, ep->admin_state, DRM_FABRIC_ADMIN_STATE_UP);
+	KUNIT_EXPECT_NE(test, drm_fabric_base_seq, seq);
 
-	/* The surviving half-edge must be byte-unchanged: no field mutated. */
-	KUNIT_EXPECT_TRUE(test, pa->has_peer);
-	KUNIT_EXPECT_MEMEQ(test, &pa->peer, &to_b, sizeof(pa->peer));
+	/* Attaching changes membership only; admin_state is untouched. */
+	change = (struct drm_fabric_endpoint_change){
+		.valid = DRM_FABRIC_EP_CHANGE_FABRIC, .fabric_id = fab->id,
+	};
+	KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(ep, &change), 0);
+	KUNIT_EXPECT_PTR_EQ(test, ep->fabric, fab);
+	KUNIT_EXPECT_EQ(test, ep->admin_state, DRM_FABRIC_ADMIN_STATE_UP);
+
+	/* Detach while admin is UP is accepted: membership clears, admin is kept. */
+	change = (struct drm_fabric_endpoint_change){
+		.valid = DRM_FABRIC_EP_CHANGE_FABRIC, .fabric_id = 0,
+	};
+	KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(ep, &change), 0);
+	KUNIT_EXPECT_NULL(test, ep->fabric);
+	KUNIT_EXPECT_EQ(test, ep->admin_state, DRM_FABRIC_ADMIN_STATE_UP);
+
+	change = (struct drm_fabric_endpoint_change){
+		.valid = DRM_FABRIC_EP_CHANGE_ADMIN, .admin = DRM_FABRIC_ADMIN_STATE_DOWN,
+	};
+	KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(ep, &change), 0);
+	KUNIT_EXPECT_EQ(test, ep->admin_state, DRM_FABRIC_ADMIN_STATE_DOWN);
+
+	change = (struct drm_fabric_endpoint_change){
+		.valid = DRM_FABRIC_EP_CHANGE_FABRIC, .fabric_id = 0,
+	};
+	KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(ep, &change), 0);
+	KUNIT_EXPECT_NULL(test, ep->fabric);
 }
 
 /*
- * A's peer record names a port index, not an object; registering and then
- * unregistering an unrelated third endpoint must not perturb it.
+ * fabric_ep_id must be unique among a fabric's members (peer descriptors
+ * resolve against it); orphan ids do not resolve and may collide.
  */
-static void drm_fabric_test_remote_peer_retained(struct kunit *test)
+static void drm_fabric_test_ep_id_unique(struct kunit *test)
 {
-	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
+	struct device *dev = fabrictest_alloc_dev(test);
 	struct drm_fabric_desc fdesc = {
-		.type = DRM_FABRIC_TYPE_SYNTHETIC,
-		.name = "test-remote",
+		.type = DRM_FABRIC_TYPE_SYNTHETIC, .name = "test-epid",
 	};
 	struct drm_fabric_port_desc pdesc = { .index = 0, .max_lane_count = 4 };
-	struct drm_fabric_endpoint_desc eadesc = {
-		.fabric_ep_id = 0xA0,
-		.name = "remote-a",
-		.parent = fabrictest_dev,
-		.ports = &pdesc,
-		.num_ports = 1,
-	};
-	struct drm_fabric_endpoint_desc ecdesc = {
-		.fabric_ep_id = 0xC0,
-		.name = "remote-c",
-		.parent = fabrictest_dev,
-		.ports = &pdesc,
-		.num_ports = 1,
-	};
-	/* 0xBEEF has no local endpoint object. */
-	struct drm_fabric_peer remote = {
-		.peer_id = 0xBEEF, .peer_type = DRM_FABRIC_PEER_TYPE_ACCEL,
+	struct drm_fabric_endpoint_desc edesc = {
+		.name = "epid", .parent = dev, .ops = &fabrictest_mut_ops,
+		.ports = &pdesc, .num_ports = 1,
 	};
+	struct drm_fabric_endpoint_change attach;
+	struct drm_fabric_endpoint *ep_a, *ep_dup, *orphan_a, *orphan_b, *orphan_c;
 	struct drm_fabric *fab;
-	struct drm_fabric_endpoint *ep_a, *ep_c;
-	struct drm_fabric_port *pa;
 
 	fab = drm_fabric_register(&fdesc);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(fab));
 	KUNIT_ASSERT_EQ(test, 0,
 			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, fab));
 
-	ep_a = drm_fabric_endpoint_register(fab, &eadesc);
+	edesc.fabric_ep_id = 0x42;
+	ep_a = drm_fabric_endpoint_register(fab, &edesc);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(ep_a));
 	KUNIT_ASSERT_EQ(test, 0,
 			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep_a));
 
-	pa = fabrictest_port(ep_a, 0);
-	KUNIT_ASSERT_NOT_NULL(test, pa);
+	/* A second member reusing that id is rejected. */
+	edesc.fabric_ep_id = 0x42;
+	ep_dup = drm_fabric_endpoint_register(fab, &edesc);
+	KUNIT_EXPECT_TRUE(test, IS_ERR(ep_dup));
+	KUNIT_EXPECT_EQ(test, PTR_ERR(ep_dup), -EEXIST);
 
-	KUNIT_ASSERT_EQ(test, drm_fabric_port_set_peer(pa, &remote), 0);
-	KUNIT_EXPECT_TRUE(test, pa->has_peer);
+	edesc.fabric_ep_id = 0x43;
+	ep_dup = drm_fabric_endpoint_register(fab, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep_dup));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep_dup));
 
-	ep_c = drm_fabric_endpoint_register(fab, &ecdesc);
-	KUNIT_ASSERT_FALSE(test, IS_ERR(ep_c));
+	/* Orphans do not resolve peers, so two may share an id. */
+	edesc.fabric_ep_id = 0x42;
+	orphan_a = drm_fabric_endpoint_register(NULL, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(orphan_a));
 	KUNIT_ASSERT_EQ(test, 0,
-			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep_c));
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, orphan_a));
 
-	kunit_release_action(test, fabrictest_unregister_endpoint, ep_c);
+	edesc.fabric_ep_id = 0x42;
+	orphan_b = drm_fabric_endpoint_register(NULL, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(orphan_b));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, orphan_b));
 
-	KUNIT_EXPECT_TRUE(test, pa->has_peer);
-	KUNIT_EXPECT_MEMEQ(test, &pa->peer, &remote, sizeof(pa->peer));
+	/* Attaching an orphan whose id collides with a member is rejected. */
+	attach = (struct drm_fabric_endpoint_change){
+		.valid = DRM_FABRIC_EP_CHANGE_FABRIC, .fabric_id = fab->id,
+	};
+	KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(orphan_a, &attach), -EEXIST);
+	KUNIT_EXPECT_NULL(test, orphan_a->fabric);
+
+	edesc.fabric_ep_id = 0x44;
+	orphan_c = drm_fabric_endpoint_register(NULL, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(orphan_c));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, orphan_c));
+
+	KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(orphan_c, &attach), 0);
+	KUNIT_EXPECT_PTR_EQ(test, orphan_c->fabric, fab);
 }
 
-/*
- * Removing an endpoint with multiple peered ports must bump the topology
- * generation exactly once, not once per port torn down.
- */
-static void drm_fabric_test_subtree_delete_single_bump(struct kunit *test)
+static void drm_fabric_test_port_admin_peer(struct kunit *test)
 {
 	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
 	struct drm_fabric_desc fdesc = {
 		.type = DRM_FABRIC_TYPE_SYNTHETIC,
-		.name = "test-subtree",
+		.name = "test-portadmin",
 	};
-	struct drm_fabric_port_desc pdescs[3] = {
-		{ .index = 0, .max_lane_count = 4 },
-		{ .index = 1, .max_lane_count = 4 },
-		{ .index = 2, .max_lane_count = 4 },
+	/* userspace-managed so this test can drive the PORT_PEER_NEW path. */
+	struct drm_fabric_port_desc pdesc = {
+		.index = 0, .max_lane_count = 4,
+		.peer_mode = DRM_FABRIC_PEER_MODE_USERSPACE,
 	};
 	struct drm_fabric_endpoint_desc edesc = {
-		.fabric_ep_id = 0xD0,
-		.name = "subtree-ep",
+		.fabric_ep_id = 0x77,
 		.parent = fabrictest_dev,
-		.ports = pdescs,
-		.num_ports = 3,
+		.ops = &fabrictest_mut_ops,
+		.ports = &pdesc,
+		.num_ports = 1,
 	};
 	struct drm_fabric_peer peer = {
-		.peer_id = 0xD1, .peer_type = DRM_FABRIC_PEER_TYPE_ACCEL,
+		.peer_id = 0x88,
+		.peer_type = DRM_FABRIC_PEER_TYPE_ACCEL,
+		.port_index = 2,
 	};
 	struct drm_fabric *fab;
 	struct drm_fabric_endpoint *ep;
+	struct drm_fabric_port *port;
+	u32 seq;
 
 	fab = drm_fabric_register(&fdesc);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(fab));
@@ -1006,13 +1152,1173 @@ static void drm_fabric_test_subtree_delete_single_bump(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, 0,
 			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep));
 
-	/* Two of the three ports carry a half-edge. */
-	KUNIT_ASSERT_EQ(test, drm_fabric_port_set_peer(fabrictest_port(ep, 0), &peer), 0);
-	KUNIT_ASSERT_EQ(test, drm_fabric_port_set_peer(fabrictest_port(ep, 1), &peer), 0);
+	port = fabrictest_port(ep, 0);
+	KUNIT_ASSERT_NOT_NULL(test, port);
 
-	fabrictest_seed_seq(test, 100);
-	kunit_release_action(test, fabrictest_unregister_endpoint, ep);
-	KUNIT_EXPECT_EQ(test, fabrictest_seq_read(), 101);
+	seq = drm_fabric_base_seq;
+	KUNIT_EXPECT_EQ(test, fabrictest_port_admin_locked(port, DRM_FABRIC_ADMIN_STATE_UP), 0);
+	KUNIT_EXPECT_EQ(test, port->admin_state, DRM_FABRIC_ADMIN_STATE_UP);
+	KUNIT_EXPECT_NE(test, drm_fabric_base_seq, seq);
+
+	drm_fabric_port_set_oper(port, DRM_FABRIC_PORT_STATE_ACTIVE);
+
+	seq = drm_fabric_base_seq;
+	KUNIT_EXPECT_EQ(test, fabrictest_port_admin_locked(port, DRM_FABRIC_ADMIN_STATE_DOWN), 0);
+	KUNIT_EXPECT_EQ(test, port->admin_state, DRM_FABRIC_ADMIN_STATE_DOWN);
+	KUNIT_EXPECT_NE(test, drm_fabric_base_seq, seq);
+	/* Admin and operational state are independent; admin-down preserves oper. */
+	KUNIT_EXPECT_EQ(test, port->oper_state, DRM_FABRIC_PORT_STATE_ACTIVE);
+
+	seq = drm_fabric_base_seq;
+	KUNIT_EXPECT_EQ(test, fabrictest_port_peer_new_locked(port, &peer), 0);
+	KUNIT_EXPECT_TRUE(test, port->has_peer);
+	KUNIT_EXPECT_EQ(test, port->peer.peer_id, 0x88ULL);
+	KUNIT_EXPECT_NE(test, drm_fabric_base_seq, seq);
+
+	KUNIT_EXPECT_EQ(test, fabrictest_port_peer_new_locked(port, &peer), -EEXIST);
+
+	seq = drm_fabric_base_seq;
+	KUNIT_EXPECT_EQ(test, fabrictest_port_peer_del_locked(port), 0);
+	KUNIT_EXPECT_FALSE(test, port->has_peer);
+	KUNIT_EXPECT_NE(test, drm_fabric_base_seq, seq);
+
+	KUNIT_EXPECT_EQ(test, fabrictest_port_peer_del_locked(port), -ENOENT);
+}
+
+/*
+ * PROVIDER ports take peers only from drm_fabric_port_set_peer() (kernel side);
+ * USERSPACE ports take peers only through the locked PEER_NEW/DEL mutators.
+ * Each rejects the other's path with -EOPNOTSUPP.
+ */
+static void drm_fabric_test_peer_mode(struct kunit *test)
+{
+	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
+	struct drm_fabric_desc fdesc = {
+		.type = DRM_FABRIC_TYPE_SYNTHETIC,
+		.name = "test-peermode",
+	};
+	struct drm_fabric_port_desc pdescs[2] = {
+		{ .index = 0, .max_lane_count = 4,
+		  .peer_mode = DRM_FABRIC_PEER_MODE_PROVIDER },
+		{ .index = 1, .max_lane_count = 4,
+		  .peer_mode = DRM_FABRIC_PEER_MODE_USERSPACE },
+	};
+	struct drm_fabric_endpoint_desc edesc = {
+		.fabric_ep_id = 0x91,
+		.parent = fabrictest_dev,
+		.ops = &fabrictest_mut_ops,
+		.ports = pdescs,
+		.num_ports = 2,
+	};
+	struct drm_fabric_peer peer = {
+		.peer_id = 0xA1,
+		.peer_type = DRM_FABRIC_PEER_TYPE_ACCEL,
+		.port_index = 1,
+	};
+	struct drm_fabric *fab;
+	struct drm_fabric_endpoint *ep;
+	struct drm_fabric_port *pport, *uport;
+
+	fab = drm_fabric_register(&fdesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(fab));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, fab));
+
+	ep = drm_fabric_endpoint_register(fab, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep));
+
+	pport = fabrictest_port(ep, 0);
+	uport = fabrictest_port(ep, 1);
+	KUNIT_ASSERT_NOT_NULL(test, pport);
+	KUNIT_ASSERT_NOT_NULL(test, uport);
+
+	/* Provider-managed port: the provider programs it; the user path is refused. */
+	KUNIT_EXPECT_EQ(test, drm_fabric_port_set_peer(pport, &peer), 0);
+	KUNIT_EXPECT_TRUE(test, pport->has_peer);
+	KUNIT_EXPECT_EQ(test, fabrictest_port_peer_new_locked(pport, &peer), -EOPNOTSUPP);
+	KUNIT_EXPECT_EQ(test, fabrictest_port_peer_del_locked(pport), -EOPNOTSUPP);
+	/* The refused user calls leave the provider's peer intact. */
+	KUNIT_EXPECT_TRUE(test, pport->has_peer);
+	/* Same-source duplicate/absent errors are preserved. */
+	KUNIT_EXPECT_EQ(test, drm_fabric_port_set_peer(pport, &peer), -EEXIST);
+	KUNIT_EXPECT_EQ(test, drm_fabric_port_unset_peer(pport), 0);
+	KUNIT_EXPECT_EQ(test, drm_fabric_port_unset_peer(pport), -ENOENT);
+
+	/* Userspace-managed port: the user path programs it; the provider is refused. */
+	KUNIT_EXPECT_EQ(test, fabrictest_port_peer_new_locked(uport, &peer), 0);
+	KUNIT_EXPECT_TRUE(test, uport->has_peer);
+	KUNIT_EXPECT_EQ(test, drm_fabric_port_set_peer(uport, &peer), -EOPNOTSUPP);
+	KUNIT_EXPECT_EQ(test, drm_fabric_port_unset_peer(uport), -EOPNOTSUPP);
+	/* The refused provider calls leave the userspace peer intact. */
+	KUNIT_EXPECT_TRUE(test, uport->has_peer);
+	KUNIT_EXPECT_EQ(test, uport->peer.peer_id, 0xA1ULL);
+	KUNIT_EXPECT_EQ(test, fabrictest_port_peer_new_locked(uport, &peer), -EEXIST);
+	KUNIT_EXPECT_EQ(test, fabrictest_port_peer_del_locked(uport), 0);
+	KUNIT_EXPECT_EQ(test, fabrictest_port_peer_del_locked(uport), -ENOENT);
+}
+
+/*
+ * Model A reports operational state from the provisioning callback.
+ * drm_fabric_lock must be dropped across the callback to avoid recursion.
+ */
+struct fabrictest_model_a_ctx {
+	unsigned int	calls;
+	bool		mutation_lock_held;
+	bool		fabric_lock_held;
+};
+
+static int fabrictest_model_a_port_set(struct drm_fabric_port *port,
+				       enum drm_fabric_admin_state admin)
+{
+	struct fabrictest_model_a_ctx *ctx = port->endpoint->priv;
+
+	ctx->calls++;
+#ifdef CONFIG_LOCKDEP
+	ctx->mutation_lock_held = lockdep_is_held(&drm_fabric_mutation_lock);
+	ctx->fabric_lock_held = lockdep_is_held(&drm_fabric_lock);
+#endif
+
+	lockdep_assert_held(&drm_fabric_mutation_lock);
+	lockdep_assert_not_held(&drm_fabric_lock);
+
+	/* Takes drm_fabric_lock: a core that had not dropped it would deadlock here. */
+	drm_fabric_port_set_oper(port, DRM_FABRIC_PORT_STATE_ACTIVE);
+	return 0;
+}
+
+static const struct drm_fabric_ops fabrictest_model_a_ops = {
+	.port_set = fabrictest_model_a_port_set,
+};
+
+static void drm_fabric_test_model_a_oper_report(struct kunit *test)
+{
+	struct device *dev = fabrictest_alloc_dev(test);
+	struct drm_fabric_desc fdesc = {
+		.type = DRM_FABRIC_TYPE_SYNTHETIC, .name = "test-modela",
+	};
+	struct drm_fabric_port_desc pdesc = {
+		.index = 0, .max_lane_count = 4,
+		.peer_mode = DRM_FABRIC_PEER_MODE_USERSPACE,
+	};
+	struct fabrictest_model_a_ctx ctx = {};
+	struct drm_fabric_endpoint_desc edesc = {
+		.fabric_ep_id = 0x5a,
+		.parent = dev,
+		.ops = &fabrictest_model_a_ops,
+		.priv = &ctx,
+		.ports = &pdesc,
+		.num_ports = 1,
+	};
+	struct drm_fabric *fab;
+	struct drm_fabric_endpoint *ep;
+	struct drm_fabric_port *port;
+	u32 seq;
+
+	fab = drm_fabric_register(&fdesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(fab));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, fab));
+
+	ep = drm_fabric_endpoint_register(fab, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep));
+
+	port = fabrictest_port(ep, 0);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+
+	KUNIT_ASSERT_NE(test, port->admin_state, DRM_FABRIC_ADMIN_STATE_UP);
+	KUNIT_ASSERT_NE(test, port->oper_state, DRM_FABRIC_PORT_STATE_ACTIVE);
+
+	seq = drm_fabric_base_seq;
+
+	KUNIT_EXPECT_EQ(test,
+			fabrictest_port_admin_locked(port, DRM_FABRIC_ADMIN_STATE_UP), 0);
+
+	KUNIT_EXPECT_EQ(test, ctx.calls, 1u);
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		KUNIT_EXPECT_TRUE(test, ctx.mutation_lock_held);
+		KUNIT_EXPECT_FALSE(test, ctx.fabric_lock_held);
+	}
+
+	/*
+	 * The synchronous oper report committed inside the callback and the
+	 * administrative state committed after it, with no recursive deadlock.
+	 */
+	KUNIT_EXPECT_EQ(test, port->oper_state, DRM_FABRIC_PORT_STATE_ACTIVE);
+	KUNIT_EXPECT_EQ(test, port->admin_state, DRM_FABRIC_ADMIN_STATE_UP);
+
+	KUNIT_EXPECT_NE(test, drm_fabric_base_seq, seq);
+
+	/*
+	 * Repeating the same admin state is a no-op: no second provider call,
+	 * no second seq bump.
+	 */
+	seq = drm_fabric_base_seq;
+	KUNIT_EXPECT_EQ(test,
+			fabrictest_port_admin_locked(port, DRM_FABRIC_ADMIN_STATE_UP), 0);
+	KUNIT_EXPECT_EQ(test, ctx.calls, 1u);
+	KUNIT_EXPECT_EQ(test, drm_fabric_base_seq, seq);
+}
+
+struct fabrictest_unreg_race {
+	struct drm_fabric_endpoint *ep;
+	struct completion started;
+	struct completion finished;
+};
+
+static int fabrictest_unreg_thread(void *arg)
+{
+	struct fabrictest_unreg_race *r = arg;
+
+	complete(&r->started);
+	drm_fabric_endpoint_unregister(r->ep);
+	complete(&r->finished);
+
+	/* Stay alive until the test reaps us, so kthread_stop() is valid. */
+	while (!kthread_should_stop())
+		schedule_timeout_interruptible(msecs_to_jiffies(10));
+	return 0;
+}
+
+/*
+ * drm_fabric_endpoint_unregister() must take mutation_lock itself, so it cannot
+ * race a concurrent mutator: it blocks until the lock is free.
+ */
+static void drm_fabric_test_unregister_serializes_mutation(struct kunit *test)
+{
+	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
+	struct drm_fabric_desc fdesc = {
+		.type = DRM_FABRIC_TYPE_SYNTHETIC,
+		.name = "test-unreg",
+	};
+	struct drm_fabric_port_desc pdesc = { .index = 0, .max_lane_count = 4 };
+	struct drm_fabric_endpoint_desc edesc = {
+		.fabric_ep_id = 0x99,
+		.parent = fabrictest_dev,
+		.ops = &fabrictest_mut_ops,
+		.ports = &pdesc,
+		.num_ports = 1,
+	};
+	struct fabrictest_unreg_race r;
+	struct drm_fabric *fab;
+	struct drm_fabric_endpoint *ep;
+	struct task_struct *task;
+
+	fab = drm_fabric_register(&fdesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(fab));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, fab));
+
+	/* The worker owns this endpoint's unregister, so no kunit teardown action. */
+	ep = drm_fabric_endpoint_register(fab, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep));
+
+	r.ep = ep;
+	init_completion(&r.started);
+	init_completion(&r.finished);
+
+	mutex_lock(&drm_fabric_mutation_lock);
+
+	task = kthread_run(fabrictest_unreg_thread, &r, "fabrtest-unreg");
+	if (IS_ERR(task)) {
+		/* A fatal assertion would skip cleanup; unwind before failing. */
+		mutex_unlock(&drm_fabric_mutation_lock);
+		drm_fabric_endpoint_unregister(ep);
+		KUNIT_FAIL(test, "kthread_run failed: %pe", task);
+		return;
+	}
+
+	KUNIT_EXPECT_GT(test,
+			wait_for_completion_timeout(&r.started, msecs_to_jiffies(1000)),
+			0);
+	msleep(50);
+
+	/* Racer entered unregister() but is still stuck waiting for the lock. */
+	KUNIT_EXPECT_FALSE(test, try_wait_for_completion(&r.finished));
+
+	/* Release => unregister proceeds and must finish promptly. */
+	mutex_unlock(&drm_fabric_mutation_lock);
+	KUNIT_EXPECT_GT(test,
+			wait_for_completion_timeout(&r.finished, msecs_to_jiffies(5000)),
+			0);
+
+	kthread_stop(task);
+}
+
+static void fabrictest_stop_thread(void *t)
+{
+	kthread_stop(t);
+}
+
+/*
+ * Attach and endpoint registration compete for one fabric_ep_id.
+ * mutation_lock makes registration wait, then fail with -EEXIST.
+ */
+struct fabrictest_l4 {
+	struct completion cb_entered;
+	struct completion cb_release;
+	struct completion attach_done;
+	struct completion reg_done;
+	int attach_ret;
+	struct drm_fabric_endpoint *reg_ep;
+	struct drm_fabric *fab;
+	struct drm_fabric_endpoint *orphan;
+	struct device *dev;
+	u64 ep_id;
+};
+
+/*
+ * Stalls inside the provider callback (mutation_lock held) so a second thread
+ * can be started and observed to block on the same fabric_ep_id.
+ */
+static int fabrictest_l4_endpoint_set(struct drm_fabric_endpoint *ep,
+				      const struct drm_fabric_endpoint_change *change,
+				      struct drm_fabric *fabric)
+{
+	struct fabrictest_l4 *l4 = ep->priv;
+
+	complete(&l4->cb_entered);
+	/* Bounded so a test abort can never wedge teardown on this thread. */
+	wait_for_completion_timeout(&l4->cb_release, msecs_to_jiffies(10000));
+	return 0;
+}
+
+static const struct drm_fabric_ops fabrictest_l4_ops = {
+	.endpoint_set = fabrictest_l4_endpoint_set,
+};
+
+static int fabrictest_l4_attach_thread(void *arg)
+{
+	struct fabrictest_l4 *l4 = arg;
+	struct drm_fabric_endpoint_change attach = {
+		.valid = DRM_FABRIC_EP_CHANGE_FABRIC,
+		.fabric_id = l4->fab->id,
+	};
+
+	l4->attach_ret = fabrictest_ep_set_locked(l4->orphan, &attach);
+	complete(&l4->attach_done);
+
+	while (!kthread_should_stop())
+		schedule_timeout_interruptible(msecs_to_jiffies(10));
+	return 0;
+}
+
+static int fabrictest_l4_register_thread(void *arg)
+{
+	struct fabrictest_l4 *l4 = arg;
+	struct drm_fabric_port_desc pdesc = { .index = 0, .max_lane_count = 4 };
+	struct drm_fabric_endpoint_desc edesc = {
+		.fabric_ep_id = l4->ep_id,
+		.name = "l4-b",
+		.parent = l4->dev,
+		.ops = &fabrictest_l4_ops,
+		.ports = &pdesc,
+		.num_ports = 1,
+	};
+
+	l4->reg_ep = drm_fabric_endpoint_register(l4->fab, &edesc);
+	complete(&l4->reg_done);
+
+	while (!kthread_should_stop())
+		schedule_timeout_interruptible(msecs_to_jiffies(10));
+	return 0;
+}
+
+static void drm_fabric_test_attach_register_collision(struct kunit *test)
+{
+	struct device *dev = fabrictest_alloc_dev(test);
+	struct drm_fabric_desc fdesc = {
+		.type = DRM_FABRIC_TYPE_SYNTHETIC, .name = "test-l4",
+	};
+	struct drm_fabric_port_desc pdesc = { .index = 0, .max_lane_count = 4 };
+	struct drm_fabric_endpoint_desc edesc;
+	struct fabrictest_l4 *l4;
+	struct task_struct *t1, *t2;
+
+	l4 = kunit_kzalloc(test, sizeof(*l4), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, l4);
+	init_completion(&l4->cb_entered);
+	init_completion(&l4->cb_release);
+	init_completion(&l4->attach_done);
+	init_completion(&l4->reg_done);
+	l4->dev = dev;
+	l4->ep_id = 0x4242;
+
+	l4->fab = drm_fabric_register(&fdesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(l4->fab));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, l4->fab));
+
+	/* Orphan A with fabric_ep_id X and a blocking endpoint_set callback. */
+	edesc = (struct drm_fabric_endpoint_desc){
+		.fabric_ep_id = l4->ep_id,
+		.name = "l4-a",
+		.parent = dev,
+		.ops = &fabrictest_l4_ops,
+		.priv = l4,
+		.ports = &pdesc,
+		.num_ports = 1,
+	};
+	l4->orphan = drm_fabric_endpoint_register(NULL, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(l4->orphan));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test,
+						  fabrictest_unregister_endpoint,
+						  l4->orphan));
+
+	/*
+	 * T1 attaches A -> F and blocks inside the provider callback while it
+	 * holds drm_fabric_mutation_lock.
+	 */
+	t1 = kthread_run(fabrictest_l4_attach_thread, l4, "fabrtest-l4-a");
+	KUNIT_ASSERT_FALSE(test, IS_ERR(t1));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_stop_thread, t1));
+	KUNIT_ASSERT_GT(test,
+			wait_for_completion_timeout(&l4->cb_entered, msecs_to_jiffies(5000)),
+			0);
+
+	/* T2 races to register B with the same id directly into F. */
+	t2 = kthread_run(fabrictest_l4_register_thread, l4, "fabrtest-l4-b");
+	KUNIT_ASSERT_FALSE(test, IS_ERR(t2));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_stop_thread, t2));
+
+	/* Register thread is queued behind the stalled attach, not finished. */
+	msleep(50);
+	KUNIT_EXPECT_FALSE(test, try_wait_for_completion(&l4->reg_done));
+
+	/* Release A's callback: the attach commits and claims X. */
+	complete(&l4->cb_release);
+	KUNIT_EXPECT_GT(test,
+			wait_for_completion_timeout(&l4->attach_done, msecs_to_jiffies(5000)),
+			0);
+	KUNIT_EXPECT_EQ(test, l4->attach_ret, 0);
+	KUNIT_EXPECT_PTR_EQ(test, l4->orphan->fabric, l4->fab);
+
+	/* B then proceeds and must fail: X is now owned by A. */
+	KUNIT_EXPECT_GT(test,
+			wait_for_completion_timeout(&l4->reg_done, msecs_to_jiffies(5000)),
+			0);
+	if (!IS_ERR(l4->reg_ep)) {
+		KUNIT_ASSERT_EQ(test, 0,
+				kunit_add_action_or_reset(test,
+							  fabrictest_unregister_endpoint,
+							  l4->reg_ep));
+		KUNIT_FAIL(test, "racing registration unexpectedly succeeded");
+		return;
+	}
+
+	KUNIT_EXPECT_EQ(test, PTR_ERR(l4->reg_ep), -EEXIST);
+}
+
+static int fabrictest_stats_get(struct drm_fabric_port *port,
+				struct drm_fabric_port_stats *stats)
+{
+	/* The statistics callback may sleep and runs without either fabric lock. */
+	lockdep_assert_not_held(&drm_fabric_lock);
+	lockdep_assert_not_held(&drm_fabric_mutation_lock);
+
+	stats->read_bytes = 4096;
+	stats->write_bytes = 2048;
+	stats->link_down_count = 2;
+	stats->retrain_count = 3;
+	return 0;
+}
+
+static const struct drm_fabric_ops fabrictest_stats_ops = {
+	.port_stats_get = fabrictest_stats_get,
+};
+
+/* This does not exercise netlink dispatch or error propagation. */
+static void drm_fabric_test_port_stats_ops_registration(struct kunit *test)
+{
+	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
+	struct drm_fabric_desc fdesc = {
+		.type = DRM_FABRIC_TYPE_SYNTHETIC,
+		.name = "test-stats",
+	};
+	struct drm_fabric_port_desc pdesc = { .index = 0, .max_lane_count = 4 };
+	struct drm_fabric_endpoint_desc edesc = {
+		.fabric_ep_id = 0x5A,
+		.parent = fabrictest_dev,
+		.ops = &fabrictest_stats_ops,
+		.ports = &pdesc,
+		.num_ports = 1,
+	};
+	struct drm_fabric_endpoint_desc edesc_noops = {
+		.fabric_ep_id = 0x5B,
+		.parent = fabrictest_dev,
+		.ports = &pdesc,
+		.num_ports = 1,
+	};
+	struct drm_fabric_port_stats stats = {};
+	struct drm_fabric_endpoint *ep, *ep_noops;
+	struct drm_fabric_port *port;
+	struct drm_fabric *fab;
+	u32 gen;
+
+	fab = drm_fabric_register(&fdesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(fab));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, fab));
+
+	ep = drm_fabric_endpoint_register(fab, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep));
+
+	port = fabrictest_port(ep, 0);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+
+	KUNIT_ASSERT_NOT_NULL(test, ep->ops);
+	KUNIT_ASSERT_NOT_NULL(test, ep->ops->port_stats_get);
+
+	/* A stats read is not a topology change: seq must not move. */
+	gen = fabrictest_seq_read();
+	KUNIT_EXPECT_EQ(test, ep->ops->port_stats_get(port, &stats), 0);
+	KUNIT_EXPECT_EQ(test, fabrictest_seq_read(), gen);
+	KUNIT_EXPECT_EQ(test, stats.read_bytes, 4096ULL);
+	KUNIT_EXPECT_EQ(test, stats.write_bytes, 2048ULL);
+	KUNIT_EXPECT_EQ(test, stats.link_down_count, 2ULL);
+	KUNIT_EXPECT_EQ(test, stats.retrain_count, 3ULL);
+
+	ep_noops = drm_fabric_endpoint_register(fab, &edesc_noops);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep_noops));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep_noops));
+	KUNIT_EXPECT_TRUE(test, !ep_noops->ops || !ep_noops->ops->port_stats_get);
+}
+
+static void drm_fabric_test_user_fabric_new_del(struct kunit *test)
+{
+	bool refcount_observable = fabrictest_module_refcount_observable();
+	int baseline = refcount_observable ? fabrictest_module_refcount() : 0;
+	struct drm_fabric *fab;
+	u32 fid = 0;
+	int ret;
+
+	ret = fabrictest_user_fabric_new_locked(DRM_FABRIC_TYPE_SYNTHETIC, 0x1234, "vpod0", &fid);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_NE(test, fid, 0);
+	if (ret || !fid)
+		return;
+
+	fab = fabrictest_find_fabric(fid);
+	KUNIT_EXPECT_NOT_NULL(test, fab);
+	if (fab)
+		KUNIT_EXPECT_EQ(test, fab->type, DRM_FABRIC_TYPE_SYNTHETIC);
+
+	/* FD-01: publishing a userspace fabric must pin the module. */
+	if (refcount_observable)
+		KUNIT_EXPECT_EQ(test, fabrictest_module_refcount(), baseline + 1);
+
+	KUNIT_EXPECT_EQ(test, fabrictest_user_fabric_del_locked(fid), 0);
+
+	fab = fabrictest_find_fabric(fid);
+	KUNIT_EXPECT_NULL(test, fab);
+
+	/* FD-01: removing it must release that pin again. */
+	if (refcount_observable)
+		KUNIT_EXPECT_EQ(test, fabrictest_module_refcount(), baseline);
+}
+
+/*
+ * Keyed by id, not pointer: after deletion this returns -ENOENT instead of
+ * touching freed memory.
+ */
+static void fabrictest_user_fabric_del(void *p)
+{
+	fabrictest_user_fabric_del_locked(*(u32 *)p);
+}
+
+/*
+ * FD-01: a rejected FABRIC_NEW must not publish a fabric or leak a module
+ * reference. Invalid type is refused before try_module_get(); a duplicate
+ * (type, instance_id) is refused after it, so only that path tests module_put().
+ */
+static void drm_fabric_test_user_fabric_new_reject_no_module_ref(struct kunit *test)
+{
+	bool refcount_observable = fabrictest_module_refcount_observable();
+	int baseline = refcount_observable ? fabrictest_module_refcount() : 0;
+	u32 *fid = kunit_kzalloc(test, sizeof(*fid), GFP_KERNEL);
+	u32 dup_fid = 0;
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, fid);
+
+	ret = fabrictest_user_fabric_new_locked((enum drm_fabric_type)0, 0xa1a1,
+						"test-new-invalid", NULL);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	if (refcount_observable)
+		KUNIT_EXPECT_EQ(test, fabrictest_module_refcount(), baseline);
+
+	ret = fabrictest_user_fabric_new_locked(DRM_FABRIC_TYPE_SYNTHETIC, 0xa2a2,
+						"test-new-dup", fid);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_user_fabric_del, fid));
+
+	ret = fabrictest_user_fabric_new_locked(DRM_FABRIC_TYPE_SYNTHETIC, 0xa2a2,
+						"test-new-dup2", &dup_fid);
+	KUNIT_EXPECT_EQ(test, ret, -EEXIST);
+	KUNIT_EXPECT_EQ(test, dup_fid, 0);
+	KUNIT_EXPECT_NOT_NULL(test, fabrictest_find_fabric(*fid));
+
+	/* Only the first, successful registration should still be pinning us. */
+	if (refcount_observable)
+		KUNIT_EXPECT_EQ(test, fabrictest_module_refcount(), baseline + 1);
+}
+
+/*
+ * Sweep of the endpoint_set()/user_fabric_del() error paths: no-op change,
+ * nonexistent fabric, already-attached, and provider-vs-user ownership.
+ */
+static void drm_fabric_test_reject_paths(struct kunit *test)
+{
+	bool refcount_observable = fabrictest_module_refcount_observable();
+	int baseline = refcount_observable ? fabrictest_module_refcount() : 0;
+	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
+	/* Distinct instance_ids: this case needs two live fabrics, not a
+	 * uniqueness collision (which (type, instance_id) equality would now
+	 * trigger -- including for instance_id 0).
+	 */
+	struct drm_fabric_desc fdesc = {
+		.type = DRM_FABRIC_TYPE_SYNTHETIC,
+		.name = "test-reject",
+		.instance_id = 0x2001,
+	};
+	struct drm_fabric_desc fdesc2 = {
+		.type = DRM_FABRIC_TYPE_SYNTHETIC,
+		.name = "test-reject2",
+		.instance_id = 0x2002,
+	};
+	struct drm_fabric_port_desc pdesc = { .index = 0, .max_lane_count = 4 };
+	struct drm_fabric_endpoint_desc edesc = {
+		.fabric_ep_id = 0x99,
+		.name = "reject-ep",
+		.parent = fabrictest_dev,
+		.ops = &fabrictest_mut_ops,
+		.ports = &pdesc,
+		.num_ports = 1,
+	};
+	struct drm_fabric_endpoint_change change;
+	struct drm_fabric *fab, *fab2;
+	struct drm_fabric_endpoint *ep;
+
+	fab = drm_fabric_register(&fdesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(fab));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, fab));
+
+	fab2 = drm_fabric_register(&fdesc2);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(fab2));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, fab2));
+
+	ep = drm_fabric_endpoint_register(NULL, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep));
+
+	/* An empty change request is a core no-op; netlink maps no-attrs to -EINVAL. */
+	change = (struct drm_fabric_endpoint_change){ .valid = 0 };
+	KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(ep, &change), 0);
+
+	change = (struct drm_fabric_endpoint_change){
+		.valid = DRM_FABRIC_EP_CHANGE_FABRIC, .fabric_id = 0x7fffffff,
+	};
+	KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(ep, &change), -ENOENT);
+
+	change = (struct drm_fabric_endpoint_change){
+		.valid = DRM_FABRIC_EP_CHANGE_FABRIC, .fabric_id = fab->id,
+	};
+	KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(ep, &change), 0);
+	KUNIT_EXPECT_PTR_EQ(test, ep->fabric, fab);
+
+	change = (struct drm_fabric_endpoint_change){
+		.valid = DRM_FABRIC_EP_CHANGE_FABRIC, .fabric_id = fab2->id,
+	};
+	KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(ep, &change), -EBUSY);
+	KUNIT_EXPECT_PTR_EQ(test, ep->fabric, fab);
+
+	/* Full FABRIC_DEL ownership/emptiness matrix. */
+
+	/* Unknown id: not found, before any ownership or emptiness check. */
+	KUNIT_EXPECT_EQ(test, fabrictest_user_fabric_del_locked(0x7fffffff), -ENOENT);
+
+	/*
+	 * Provider-owned fabrics are refused with -EPERM whether empty (fab2) or
+	 * non-empty (fab holds @ep): a provider keeps sole ownership of its
+	 * fabric's lifetime, and -EPERM is checked before the -EBUSY emptiness
+	 * test.
+	 */
+	KUNIT_EXPECT_EQ(test, fabrictest_user_fabric_del_locked(fab->id), -EPERM);
+	KUNIT_EXPECT_EQ(test, fabrictest_user_fabric_del_locked(fab2->id), -EPERM);
+
+	/*
+	 * FD-01: provider-owned fabrics never took a module reference, and a
+	 * rejected delete must not touch either the object or a reference.
+	 */
+	KUNIT_EXPECT_PTR_EQ(test, fabrictest_find_fabric(fab->id), fab);
+	KUNIT_EXPECT_PTR_EQ(test, fabrictest_find_fabric(fab2->id), fab2);
+	if (refcount_observable)
+		KUNIT_EXPECT_EQ(test, fabrictest_module_refcount(), baseline);
+
+	/*
+	 * Userspace-owned fabrics: non-empty is -EBUSY, empty is deletable.
+	 * Reuse @ep (moved out of @fab) to make the userspace fabric non-empty.
+	 */
+	{
+		struct drm_fabric_endpoint_change detach = {
+			.valid = DRM_FABRIC_EP_CHANGE_FABRIC, .fabric_id = 0,
+		};
+		struct drm_fabric_endpoint_change attach = {
+			.valid = DRM_FABRIC_EP_CHANGE_FABRIC,
+		};
+		u32 *uid = kunit_kzalloc(test, sizeof(*uid), GFP_KERNEL);
+		int ret;
+
+		KUNIT_ASSERT_NOT_NULL(test, uid);
+		ret = fabrictest_user_fabric_new_locked(DRM_FABRIC_TYPE_SYNTHETIC,
+							0x2003, "test-user-del",
+							uid);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+		KUNIT_ASSERT_EQ(test, 0,
+				kunit_add_action_or_reset(test,
+							  fabrictest_user_fabric_del,
+							  uid));
+		if (refcount_observable)
+			KUNIT_EXPECT_EQ(test, fabrictest_module_refcount(), baseline + 1);
+
+		KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(ep, &detach), 0);
+		attach.fabric_id = *uid;
+		KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(ep, &attach), 0);
+
+		KUNIT_EXPECT_EQ(test, fabrictest_user_fabric_del_locked(*uid), -EBUSY);
+
+		/*
+		 * FD-01: the -EBUSY rejection must leave the fabric resolvable
+		 * and its module reference held, exactly as before the attempt.
+		 */
+		KUNIT_EXPECT_NOT_NULL(test, fabrictest_find_fabric(*uid));
+		if (refcount_observable)
+			KUNIT_EXPECT_EQ(test, fabrictest_module_refcount(), baseline + 1);
+
+		KUNIT_EXPECT_EQ(test, fabrictest_ep_set_locked(ep, &detach), 0);
+		KUNIT_EXPECT_EQ(test, fabrictest_user_fabric_del_locked(*uid), 0);
+
+		/* FD-01: a successful delete drops both the object and the pin. */
+		KUNIT_EXPECT_NULL(test, fabrictest_find_fabric(*uid));
+		if (refcount_observable)
+			KUNIT_EXPECT_EQ(test, fabrictest_module_refcount(), baseline);
+	}
+}
+
+/*
+ * Unregistering an endpoint that has a peer link must clear only that
+ * endpoint's own port record; it must not touch the still-registered far
+ * side's peer record. (Contrast with drm_fabric_port_unset_peer(), which
+ * clears a peer explicitly and is covered separately.)
+ */
+static void drm_fabric_test_local_unplug_keeps_edge(struct kunit *test)
+{
+	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
+	struct drm_fabric_desc fdesc = {
+		.type = DRM_FABRIC_TYPE_SYNTHETIC,
+		.name = "test-unplug",
+	};
+	struct drm_fabric_port_desc pdesc = { .index = 0, .max_lane_count = 4 };
+	struct drm_fabric_endpoint_desc eadesc = {
+		.fabric_ep_id = 0xA0,
+		.name = "unplug-a",
+		.parent = fabrictest_dev,
+		.ports = &pdesc,
+		.num_ports = 1,
+	};
+	struct drm_fabric_endpoint_desc ebdesc = {
+		.fabric_ep_id = 0xB0,
+		.name = "unplug-b",
+		.parent = fabrictest_dev,
+		.ports = &pdesc,
+		.num_ports = 1,
+	};
+	struct drm_fabric_peer to_b = {
+		.peer_id = 0xB0, .peer_type = DRM_FABRIC_PEER_TYPE_ACCEL,
+	};
+	struct drm_fabric_peer to_a = {
+		.peer_id = 0xA0, .peer_type = DRM_FABRIC_PEER_TYPE_ACCEL,
+	};
+	struct drm_fabric *fab;
+	struct drm_fabric_endpoint *ep_a, *ep_b;
+	struct drm_fabric_port *pa, *pb;
+
+	fab = drm_fabric_register(&fdesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(fab));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, fab));
+
+	ep_a = drm_fabric_endpoint_register(fab, &eadesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep_a));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep_a));
+
+	ep_b = drm_fabric_endpoint_register(fab, &ebdesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep_b));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep_b));
+
+	pa = fabrictest_port(ep_a, 0);
+	pb = fabrictest_port(ep_b, 0);
+	KUNIT_ASSERT_NOT_NULL(test, pa);
+	KUNIT_ASSERT_NOT_NULL(test, pb);
+
+	KUNIT_ASSERT_EQ(test, drm_fabric_port_set_peer(pa, &to_b), 0);
+	KUNIT_ASSERT_EQ(test, drm_fabric_port_set_peer(pb, &to_a), 0);
+	KUNIT_EXPECT_TRUE(test, pa->has_peer);
+
+	/*
+	 * Remove B without retracting its peer first, modelling abrupt provider
+	 * teardown.
+	 */
+	kunit_release_action(test, fabrictest_unregister_endpoint, ep_b);
+
+	/* The surviving half-edge must be byte-unchanged: no field mutated. */
+	KUNIT_EXPECT_TRUE(test, pa->has_peer);
+	KUNIT_EXPECT_MEMEQ(test, &pa->peer, &to_b, sizeof(pa->peer));
+}
+
+/*
+ * A's peer record names a port index, not an object; registering and then
+ * unregistering an unrelated third endpoint must not perturb it.
+ */
+static void drm_fabric_test_remote_peer_retained(struct kunit *test)
+{
+	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
+	struct drm_fabric_desc fdesc = {
+		.type = DRM_FABRIC_TYPE_SYNTHETIC,
+		.name = "test-remote",
+	};
+	struct drm_fabric_port_desc pdesc = { .index = 0, .max_lane_count = 4 };
+	struct drm_fabric_endpoint_desc eadesc = {
+		.fabric_ep_id = 0xA0,
+		.name = "remote-a",
+		.parent = fabrictest_dev,
+		.ports = &pdesc,
+		.num_ports = 1,
+	};
+	struct drm_fabric_endpoint_desc ecdesc = {
+		.fabric_ep_id = 0xC0,
+		.name = "remote-c",
+		.parent = fabrictest_dev,
+		.ports = &pdesc,
+		.num_ports = 1,
+	};
+	/* 0xBEEF has no local endpoint object. */
+	struct drm_fabric_peer remote = {
+		.peer_id = 0xBEEF, .peer_type = DRM_FABRIC_PEER_TYPE_ACCEL,
+	};
+	struct drm_fabric *fab;
+	struct drm_fabric_endpoint *ep_a, *ep_c;
+	struct drm_fabric_port *pa;
+
+	fab = drm_fabric_register(&fdesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(fab));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, fab));
+
+	ep_a = drm_fabric_endpoint_register(fab, &eadesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep_a));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep_a));
+
+	pa = fabrictest_port(ep_a, 0);
+	KUNIT_ASSERT_NOT_NULL(test, pa);
+
+	KUNIT_ASSERT_EQ(test, drm_fabric_port_set_peer(pa, &remote), 0);
+	KUNIT_EXPECT_TRUE(test, pa->has_peer);
+
+	ep_c = drm_fabric_endpoint_register(fab, &ecdesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep_c));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep_c));
+
+	kunit_release_action(test, fabrictest_unregister_endpoint, ep_c);
+
+	KUNIT_EXPECT_TRUE(test, pa->has_peer);
+	KUNIT_EXPECT_MEMEQ(test, &pa->peer, &remote, sizeof(pa->peer));
+}
+
+/*
+ * Removing an endpoint with multiple peered ports must bump the topology
+ * generation exactly once, not once per port torn down.
+ */
+static void drm_fabric_test_subtree_delete_single_bump(struct kunit *test)
+{
+	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
+	struct drm_fabric_desc fdesc = {
+		.type = DRM_FABRIC_TYPE_SYNTHETIC,
+		.name = "test-subtree",
+	};
+	struct drm_fabric_port_desc pdescs[3] = {
+		{ .index = 0, .max_lane_count = 4 },
+		{ .index = 1, .max_lane_count = 4 },
+		{ .index = 2, .max_lane_count = 4 },
+	};
+	struct drm_fabric_endpoint_desc edesc = {
+		.fabric_ep_id = 0xD0,
+		.name = "subtree-ep",
+		.parent = fabrictest_dev,
+		.ports = pdescs,
+		.num_ports = 3,
+	};
+	struct drm_fabric_peer peer = {
+		.peer_id = 0xD1, .peer_type = DRM_FABRIC_PEER_TYPE_ACCEL,
+	};
+	struct drm_fabric *fab;
+	struct drm_fabric_endpoint *ep;
+
+	fab = drm_fabric_register(&fdesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(fab));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, fab));
+
+	ep = drm_fabric_endpoint_register(fab, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep));
+
+	/* Two of the three ports carry a half-edge. */
+	KUNIT_ASSERT_EQ(test, drm_fabric_port_set_peer(fabrictest_port(ep, 0), &peer), 0);
+	KUNIT_ASSERT_EQ(test, drm_fabric_port_set_peer(fabrictest_port(ep, 1), &peer), 0);
+
+	fabrictest_seed_seq(test, 100);
+	kunit_release_action(test, fabrictest_unregister_endpoint, ep);
+	KUNIT_EXPECT_EQ(test, fabrictest_seq_read(), 101);
+}
+
+#define FABRICTEST_CONC_THREADS	4
+#define FABRICTEST_CONC_ITERS	200
+
+struct fabrictest_conc_ctx {
+	/* Sampled *inside* the provider hook (under the core lock). */
+	atomic_t	in_flight;
+	atomic_t	max_in_flight;
+	atomic_t	calls;
+	/* Sampled *around* the core mutation call (incl. lock wait). */
+	atomic_t	contenders;
+	atomic_t	max_contenders;
+	atomic_t	started;
+	atomic_t	done;
+	int		nthreads;
+};
+
+/* Lock-free running maximum; cmpxchg retries until the value only grows. */
+static void fabrictest_bump_max(atomic_t *max, int cur)
+{
+	int old = atomic_read(max);
+
+	while (cur > old)
+		old = atomic_cmpxchg(max, old, cur);
+}
+
+/* Record concurrent callback entry, then sleep to widen the overlap window. */
+static void fabrictest_conc_enter(struct fabrictest_conc_ctx *ctx)
+{
+	fabrictest_bump_max(&ctx->max_in_flight,
+			    atomic_inc_return(&ctx->in_flight));
+	atomic_inc(&ctx->calls);
+	usleep_range(20, 60);
+	atomic_dec(&ctx->in_flight);
+}
+
+static int fabrictest_mock_port_set(struct drm_fabric_port *port,
+				    enum drm_fabric_admin_state admin)
+{
+	fabrictest_conc_enter(port->endpoint->priv);
+	return 0;
+}
+
+static int fabrictest_mock_endpoint_set(struct drm_fabric_endpoint *ep,
+					const struct drm_fabric_endpoint_change *change,
+					struct drm_fabric *fabric)
+{
+	fabrictest_conc_enter(ep->priv);
+	return 0;
+}
+
+static const struct drm_fabric_ops fabrictest_conc_ops = {
+	.port_set = fabrictest_mock_port_set,
+	.endpoint_set = fabrictest_mock_endpoint_set,
+};
+
+struct fabrictest_worker {
+	struct drm_fabric_endpoint	*ep;
+	struct drm_fabric_port		*port;
+	struct fabrictest_conc_ctx	*ctx;
+	int				kind;	/* 0: PORT_SET, 1: ENDPOINT_SET */
+	int				iters;
+};
+
+/*
+ * All worker state lives in one kunit-managed allocation so the kthreads never
+ * dereference the test function's stack.  Combined with the per-thread stop
+ * action below, an assert-abort during spawn can still reap every worker before
+ * its backing memory (and the endpoint it touches) is torn down.
+ */
+struct fabrictest_conc_harness {
+	struct fabrictest_conc_ctx	ctx;
+	struct fabrictest_worker	workers[FABRICTEST_CONC_THREADS];
+	struct task_struct		*threads[FABRICTEST_CONC_THREADS];
+};
+
+static int fabrictest_mutator(void *arg)
+{
+	struct fabrictest_worker *w = arg;
+	struct fabrictest_conc_ctx *ctx = w->ctx;
+	unsigned long deadline;
+	int i;
+
+	/*
+	 * Barrier: don't start hammering until every worker is up, so the
+	 * contention window is as wide as possible.
+	 */
+	atomic_inc(&ctx->started);
+	deadline = jiffies + msecs_to_jiffies(1000);
+	while (atomic_read(&ctx->started) < ctx->nthreads &&
+	       time_before(jiffies, deadline))
+		cond_resched();
+
+	for (i = 0; i < w->iters; i++) {
+		enum drm_fabric_admin_state admin =
+			(i & 1) ? DRM_FABRIC_ADMIN_STATE_UP : DRM_FABRIC_ADMIN_STATE_DOWN;
+
+		/*
+		 * Count threads in/awaiting the mutator (the locked wrapper
+		 * blocks on drm_fabric_mutation_lock if another worker holds it),
+		 * so the test can prove real contention happened rather than
+		 * passing vacuously.
+		 */
+		fabrictest_bump_max(&ctx->max_contenders,
+				    atomic_inc_return(&ctx->contenders));
+		if (w->kind == 0) {
+			fabrictest_port_admin_locked(w->port, admin);
+		} else {
+			struct drm_fabric_endpoint_change change = {
+				.valid = DRM_FABRIC_EP_CHANGE_ADMIN,
+				.admin = admin,
+			};
+
+			fabrictest_ep_set_locked(w->ep, &change);
+		}
+		atomic_dec(&ctx->contenders);
+		cond_resched();
+	}
+
+	atomic_inc(&ctx->done);
+
+	/* Idle until the test reaps us so the threadfn never exits early. */
+	while (!kthread_should_stop())
+		schedule_timeout_interruptible(msecs_to_jiffies(2));
+
+	return 0;
+}
+
+/*
+ * FABRICTEST_CONC_THREADS racers alternate port-admin and endpoint-admin
+ * mutators; mutation_lock must serialize them into the provider hook.
+ */
+static void drm_fabric_test_concurrent_mutation(struct kunit *test)
+{
+	struct device *fabrictest_dev = fabrictest_alloc_dev(test);
+	struct drm_fabric_desc fdesc = {
+		.type = DRM_FABRIC_TYPE_SYNTHETIC,
+		.name = "test-conc",
+	};
+	struct drm_fabric_port_desc pdesc = { .index = 0, .max_lane_count = 4 };
+	struct fabrictest_conc_harness *h;
+	struct drm_fabric_endpoint_desc edesc;
+	struct drm_fabric *fab;
+	struct drm_fabric_endpoint *ep;
+	struct drm_fabric_port *port;
+	unsigned long deadline;
+	int i;
+
+	h = kunit_kzalloc(test, sizeof(*h), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, h);
+	h->ctx.nthreads = FABRICTEST_CONC_THREADS;
+
+	edesc = (struct drm_fabric_endpoint_desc){
+		.fabric_ep_id = 0xC0,
+		.name = "conc-ep",
+		.parent = fabrictest_dev,
+		.ops = &fabrictest_conc_ops,
+		.priv = &h->ctx,
+		.ports = &pdesc,
+		.num_ports = 1,
+	};
+
+	fab = drm_fabric_register(&fdesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(fab));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_fabric, fab));
+
+	ep = drm_fabric_endpoint_register(fab, &edesc);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(ep));
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, fabrictest_unregister_endpoint, ep));
+
+	port = fabrictest_port(ep, 0);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+
+	for (i = 0; i < FABRICTEST_CONC_THREADS; i++) {
+		h->workers[i] = (struct fabrictest_worker){
+			.ep = ep,
+			.port = port,
+			.ctx = &h->ctx,
+			.kind = i & 1,
+			.iters = FABRICTEST_CONC_ITERS,
+		};
+		h->threads[i] = kthread_run(fabrictest_mutator, &h->workers[i],
+					    "fabrtest-conc/%d", i);
+		KUNIT_ASSERT_FALSE(test, IS_ERR(h->threads[i]));
+		/* Reap this worker if a later assertion aborts the test. */
+		KUNIT_ASSERT_EQ(test, 0,
+				kunit_add_action_or_reset(test,
+							  fabrictest_stop_thread,
+							  h->threads[i]));
+	}
+
+	deadline = jiffies + msecs_to_jiffies(10000);
+	while (atomic_read(&h->ctx.done) < FABRICTEST_CONC_THREADS &&
+	       time_before(jiffies, deadline))
+		schedule_timeout_interruptible(msecs_to_jiffies(20));
+
+	/* Correctness: no deadlock / lost wakeup, every worker completed. */
+	KUNIT_EXPECT_EQ(test, atomic_read(&h->ctx.done), FABRICTEST_CONC_THREADS);
+	KUNIT_EXPECT_GT(test, atomic_read(&h->ctx.calls), 0);
+
+	/* Correctness: the object model is consistent after the storm. */
+	KUNIT_EXPECT_PTR_EQ(test, ep->fabric, fab);
+	KUNIT_EXPECT_LE(test, (int)port->admin_state, (int)DRM_FABRIC_ADMIN_STATE_UP);
+	KUNIT_EXPECT_LE(test, (int)ep->admin_state, (int)DRM_FABRIC_ADMIN_STATE_UP);
+
+	/*
+	 * Prove real contention occurred while the provider callback stayed
+	 * serialized.
+	 */
+	KUNIT_EXPECT_GE_MSG(test, atomic_read(&h->ctx.max_contenders), 2,
+			    "workers never contended; concurrency not exercised");
+
+	/*
+	 * Provider callbacks must not overlap. max_contenders >= 2 makes this
+	 * assertion non-vacuous.
+	 */
+	KUNIT_EXPECT_EQ_MSG(test, atomic_read(&h->ctx.max_in_flight), 1,
+			    "provider hooks overlapped; mutations did not serialise");
 }
 
 static void drm_fabric_test_switch_topology(struct kunit *test)
@@ -1299,10 +2605,22 @@ static struct kunit_case drm_fabric_test_cases[] = {
 	KUNIT_CASE(drm_fabric_test_port_oper_state_rejects_invalid),
 	KUNIT_CASE(drm_fabric_test_register_rejects_invalid_type),
 	KUNIT_CASE(drm_fabric_test_mesh_kn_topology),
+	KUNIT_CASE(drm_fabric_test_orphan_attach_detach),
+	KUNIT_CASE(drm_fabric_test_ep_id_unique),
+	KUNIT_CASE(drm_fabric_test_failed_mutation_no_commit),
+	KUNIT_CASE(drm_fabric_test_port_admin_peer),
+	KUNIT_CASE(drm_fabric_test_peer_mode),
+	KUNIT_CASE(drm_fabric_test_model_a_oper_report),
+	KUNIT_CASE_SLOW(drm_fabric_test_unregister_serializes_mutation),
+	KUNIT_CASE_SLOW(drm_fabric_test_attach_register_collision),
 	KUNIT_CASE(drm_fabric_test_port_stats_ops_registration),
+	KUNIT_CASE(drm_fabric_test_user_fabric_new_del),
+	KUNIT_CASE(drm_fabric_test_user_fabric_new_reject_no_module_ref),
+	KUNIT_CASE(drm_fabric_test_reject_paths),
 	KUNIT_CASE(drm_fabric_test_local_unplug_keeps_edge),
 	KUNIT_CASE(drm_fabric_test_remote_peer_retained),
 	KUNIT_CASE(drm_fabric_test_subtree_delete_single_bump),
+	KUNIT_CASE_SLOW(drm_fabric_test_concurrent_mutation),
 	KUNIT_CASE(drm_fabric_test_switch_topology),
 	KUNIT_CASE_PARAM(drm_fabric_test_topology_param,
 			 fabrictest_topo_gen_params),
-- 
2.43.0

