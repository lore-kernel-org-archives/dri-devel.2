Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88A5C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42AF110F1A2;
	Wed, 23 Sep 2026 20:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qNd/Ktpd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C71E310F1B6;
 Wed, 23 Sep 2026 20:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=IrmfyULebZBPzoJSufltClhMtshZzIp0+hcOBmBFC+k=; b=qNd/Ktpd14fw/fSPiGChudytRi
 JSmYp0XkPdaThkKLo+kViT6OMsCwsCiEsusBJp063rZFU9/gCHlV8OLjHZ4lhhS6Gz6daF/K+6+0v
 RT9wpsmYgMj/QUWE9PKsSsRitMG/inmJ51RNmdV2099JISz4D//GQ95B8yNmZDmSovSrZ3ykvo1jZ
 lId5vFYmI6NlNfCfTe8fhnBb82gsAzRjAiQccrtc/ZmRti01tXxu4XQa8U/+6Dwe9OA+0IimP7iSO
 SX+m5X1M9UsMPYZLGHc/QrZJkUTYezhyq9eqxVsrmJEgFMXQp67Pw5vb6Vw59eTZPqSt+e9un92WI
 u1q1g0eQ==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9TqP-006KVk-9N; Wed, 23 Sep 2026 22:45:33 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 23 Sep 2026 17:44:44 -0300
Subject: [PATCH i-g-t v7 9/9] tests/cgroup_dmem: add test for dmem.current
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-dmem_max-v7-9-194ea47bbb4d@igalia.com>
References: <20260923-dmem_max-v7-0-194ea47bbb4d@igalia.com>
In-Reply-To: <20260923-dmem_max-v7-0-194ea47bbb4d@igalia.com>
To: igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Christian Koenig <christian.koenig@amd.com>, 
 maarten.lankhorst@linux.intel.com, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Kamil Konieczny <kamil.konieczny@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
X-Mailer: b4 0.16-dev-62088
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

Based on the work of Thomas Hellström to test dmem.max eviction, add a
test for dmem.current usage after allocations and setting dmem.max.

Create a dmem cgroup, allocate close to capacity (or at most 4GiB),
check current usage is within a small slack of the expected allocation.
Then, set max to a small value and check allocations and current usage
are limited to the max set.  Set max to less than a single BO size, then
check no allocations are allowed and current usage is also within the
slack. After each allocation, release memory and check current usage
has gone down.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 tests/cgroup_dmem.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
index 7f3cfe22db2c..1f01037e1cf2 100644
--- a/tests/cgroup_dmem.c
+++ b/tests/cgroup_dmem.c
@@ -36,6 +36,8 @@
 #define BO_SIZE			SZ_64M
 #define MAX_LIMIT		((uint64_t)4 * SZ_1G)
 #define EVICT_STEP		SZ_128M
+#define USAGE_POLL_MS		10
+#define USAGE_DROP_TIMEOUT_MS	1000
 
 #define TEST_INTERRUPTIBLE	(1 << 0)
 #define TEST_NONBLOCK		(1 << 1)
@@ -48,6 +50,20 @@
  *  and configured limits, then destroys the cgroup.
  */
 
+/**
+ * SUBTEST: current
+ * DESCRIPTION:
+ *  Create a dmem cgroup, allocate close to capacity (or at most 4GiB),
+ *  check current usage is within a small slack of the expected allocation.
+ *  Then, set max to a small value and check allocations and current usage
+ *  are limited to the max set.
+ *  Set max to less than a single BO size, then check no allocations are allowed
+ *  and current usage is also within the slack.
+ *  After each allocation, release memory and check current usage has gone
+ *  down.
+ *  This subtest requires GPU device with at least one VRAM region.
+ */
+
 /**
  * SUBTEST: write_eviction
  * DESCRIPTION:
@@ -116,6 +132,23 @@ static void install_sigcont_counter(void)
 	sigaction(SIGCONT, &sa, &sigcont_oldact);
 }
 
+static uint64_t wait_for_usage_drop(struct igt_cgroup *cg, const char *region,
+				    uint64_t limit)
+{
+	uint64_t current;
+	unsigned int elapsed = 0;
+
+	do {
+		igt_cgroup_dmem_get_current(cg, region, &current);
+		if (current <= limit)
+			return current;
+		usleep(USAGE_POLL_MS * 1000);
+		elapsed += USAGE_POLL_MS;
+	} while (elapsed < USAGE_DROP_TIMEOUT_MS);
+
+	return current;
+}
+
 static int allocate_vram(void **handles, const struct igt_dmem_driver *drv,
 			 void *ctx, int max_bo, size_t len)
 {
@@ -137,6 +170,119 @@ static int allocate_vram(void **handles, const struct igt_dmem_driver *drv,
 	return err;
 }
 
+static void free_vram(void **handles, const struct igt_dmem_driver *drv,
+		      void *ctx, int max_bo)
+{
+	int i;
+	for (i = 0; i < max_bo; i++)
+		drv->free_vram(ctx, handles[i]);
+}
+
+static void test_current(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv, void *ctx)
+{
+	struct igt_cgroup *cg;
+	void **handles;
+	uint64_t current, capacity, cg_max;
+	int n_bo = 0, max_bo;
+
+	igt_cgroup_dmem_get_capacity(cg_region, &capacity);
+	igt_require_f(capacity >= 4 * BO_SIZE,
+		      "VRAM capacity (%"PRIu64" MiB) too small to test\n",
+		      capacity / SZ_1M);
+
+	/*
+	 * Use up to 4 GiB, or the full capacity if the device has less.
+	 * Leave one BO_SIZE worth of headroom so the device isn't completely
+	 * exhausted before the cgroup limit is hit.
+	 */
+	cg_max = min(MAX_LIMIT, capacity - BO_SIZE);
+	cg_max = ALIGN_DOWN(cg_max, BO_SIZE);
+
+	/* Create cgroup and move into it */
+	cg = igt_cgroup_new("igt_cgroups_test");
+	igt_cgroup_move_current(cg);
+
+	max_bo = cg_max / BO_SIZE;
+
+	handles = calloc(max_bo, sizeof(handles[0]));
+	igt_assert_f(handles, "failed to allocate handles array");
+
+	n_bo = allocate_vram(handles, drv, ctx, max_bo, BO_SIZE);
+	igt_assert_f(n_bo > 0, "failed to allocate VRAM\n");
+
+	igt_cgroup_dmem_get_current(cg, cg_region, &current);
+	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
+		  "max = %"PRIu64" MiB\n",
+		  current / SZ_1M, cg_max / SZ_1M);
+	igt_assert_f(current == cg_max,
+		     "current usage (%"PRIu64" MiB) is not requested allocation (%"PRIu64" MiB)\n",
+		     current / SZ_1M, cg_max / SZ_1M);
+
+	free_vram(handles, drv, ctx, n_bo);
+	wait_for_usage_drop(cg, cg_region, 0);
+
+	igt_cgroup_dmem_get_current(cg, cg_region, &current);
+	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
+		  "max = %"PRIu64" MiB\n",
+		  current / SZ_1M, cg_max / SZ_1M);
+	igt_assert_f(current == 0,
+		     "current usage (%"PRIu64" MiB) is not zero\n",
+		     current / SZ_1M);
+
+	igt_cgroup_dmem_set_max(cg, cg_region, 2 * BO_SIZE, false);
+
+	n_bo = allocate_vram(handles, drv, ctx, max_bo, BO_SIZE);
+	igt_assert_f(n_bo > 0, "failed to allocate VRAM\n");
+
+	igt_cgroup_dmem_get_current(cg, cg_region, &current);
+	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
+		  "max = %"PRIu64" MiB\n",
+		  current / SZ_1M, cg_max / SZ_1M);
+	igt_assert_f(current == 2 * BO_SIZE,
+		     "current usage (%"PRIu64" MiB) is not requested max allocation (%"PRIu64" MiB)\n",
+		     current / SZ_1M, cg_max / SZ_1M);
+
+	free_vram(handles, drv, ctx, n_bo);
+	wait_for_usage_drop(cg, cg_region, 0);
+
+	igt_cgroup_dmem_get_current(cg, cg_region, &current);
+	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
+		  "max = %"PRIu64" MiB\n",
+		  current / SZ_1M, cg_max / SZ_1M);
+	igt_assert_f(current == 0,
+		     "current usage (%"PRIu64" MiB) is not zero\n",
+		     current / SZ_1M);
+
+	igt_cgroup_dmem_set_max(cg, cg_region, 0, false);
+
+	n_bo = allocate_vram(handles, drv, ctx, max_bo, BO_SIZE);
+
+	/*
+	 * amdgpu may succeed the allocation, by falling back to GTT, so no assertion here.
+	 * Verify by reading current usage.
+	 */
+
+	igt_cgroup_dmem_get_current(cg, cg_region, &current);
+	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
+		  "max = %"PRIu64" MiB\n",
+		  current / SZ_1M, cg_max / SZ_1M);
+	igt_assert_f(current == 0,
+		     "current usage (%"PRIu64" MiB) is not zero\n",
+		     current / SZ_1M);
+
+	if (n_bo > 0)
+		free_vram(handles, drv, ctx, n_bo);
+	wait_for_usage_drop(cg, cg_region, 0);
+
+	igt_cgroup_dmem_get_current(cg, cg_region, &current);
+	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
+		  "max = %"PRIu64" MiB\n",
+		  current / SZ_1M, cg_max / SZ_1M);
+	igt_assert_f(current == 0,
+		     "current usage (%"PRIu64" MiB) is not zero\n",
+		     current / SZ_1M);
+}
+
 static void test_write_eviction(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv, void *ctx)
 {
 	struct igt_cgroup *cg;
@@ -246,6 +392,7 @@ static const struct {
 	void (*test_fn)(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv, void *ctx);
 	unsigned int flags;
 } subtests[] = {
+	{ "current", test_current, 0 },
 	{ "write_eviction", test_write_eviction, 0 },
 	{ "write_eviction_interruptible", test_write_eviction, TEST_INTERRUPTIBLE },
 	{ "write_eviction_nonblock", test_write_eviction, TEST_NONBLOCK },

-- 
2.47.3

