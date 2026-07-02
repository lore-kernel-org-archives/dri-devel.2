Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D31C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA1610F361;
	Thu,  2 Jul 2026 13:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GP1c3W3o";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 123EE10F366;
 Thu,  2 Jul 2026 13:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lT15FuhNiGFpf49I/crr9KaNiaPJlLwK5Gm5jsQ8X34=; b=GP1c3W3oH5IW53D51EEkvOxQQO
 Q54Jq4M1aBR5RXg8fPfM8tHoGhnh1PmpmbqUUsagvkol2123e3Sk0aksiG6EX+wwQEiTMREbhS/5g
 5byJyF0CFPUOasqrX0k6WlOT+be1I96FittLxeK6Ajfqe4Sjed7/n6ELn4dlwctmGKhGhbSQcVcMA
 iuEppI2vvsKaCxiBwBc3B7QmKfNS0RrCYmKtGP2bAmCz0Pxh3fvjXqX4YJQbWwD5XDshX4W3bQ+V+
 sVzVPxXttWKOiYVcSdhHkoVRBXPRQGHjLJz+KPeXZvjG/YF8JmY8jKlis5jp7elvhJnHf7eY0igdt
 nCzteSFA==;
Received: from [179.125.94.247] (helo=quatroqueijos.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfH3i-0082Ji-HB; Thu, 02 Jul 2026 15:02:27 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
Subject: [PATCH i-g-t v2 7/7] tests/dmem_cgroups: add test for dmem.current
Date: Thu,  2 Jul 2026 10:00:58 -0300
Message-ID: <20260702130108.1397444-8-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702130108.1397444-1-cascardo@igalia.com>
References: <20260702130108.1397444-1-cascardo@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Based on the work of Thomas Hellström to test dmem.max eviction, add a test
for dmem.current usage after allocations and setting dmem.max.

Create a dmem cgroup, allocate close to capacity (or at most 4GiB), check
current usage is within a small slack of the expected allocation.  Then,
set max to a small value and check allocations and current usage are
limited to the max set.  Set max to 0, then check no allocations are
allowed and current usage is also within the slack.  After each allocation,
release memory and check current usage has gone down.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 tests/dmem_cgroups.c | 245 +++++++++++++++++++++++++++++++++++++++++++
 tests/meson.build    |   1 +
 2 files changed, 246 insertions(+)
 create mode 100644 tests/dmem_cgroups.c

diff --git a/tests/dmem_cgroups.c b/tests/dmem_cgroups.c
new file mode 100644
index 000000000000..da2475a14ff9
--- /dev/null
+++ b/tests/dmem_cgroups.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+/**
+ * TEST: dmem_cgroups
+ * DESCRIPTION: Tests exercising the dmem cgroup controller on devices.
+ * Category: Core
+ * Mega feature: General Core features
+ * Sub-category: cgroup
+ * FUNCTIONALITY: cgroup dmem controller
+ */
+
+#include <errno.h>
+#include <signal.h>
+#include <stdatomic.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "drmtest.h"
+#include "igt.h"
+#include "igt_aux.h"
+#include "igt_cgroup.h"
+#include "igt_dmem_driver.h"
+
+#define BO_SIZE			SZ_64M
+#define MAX_LIMIT		((uint64_t)4 * SZ_1G)
+#define USAGE_SLACK		SZ_4M		/* tolerance above the set max */
+#define USAGE_POLL_MS		10
+#define USAGE_DROP_TIMEOUT_MS	1000
+
+/**
+ * SUBTEST: current
+ * DESCRIPTION:
+ *  Create a dmem cgroup, allocate close to capacity (or at most 4GiB),
+ *  check current usage is within a small slack of the expected allocation.
+ *  Then, set max to a small value and check allocations and current usage
+ *  are limited to the max set.
+ *  Set max to 0, then check no allocations are allowed and current usage
+ *  is also within the slack.
+ *  After each allocation, release memory and check current usage has gone
+ *  down.
+ * REQUIREMENTS: xe or amdgpu device with at least one VRAM region
+ */
+
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
+static int allocate_vram(const struct igt_dmem_driver *drv, void *ctx, int fd, int max_bo, size_t len)
+{
+	int n_bo, err = 0;
+	for (n_bo = 0; n_bo < max_bo; n_bo++) {
+		err = drv->allocate_vram(ctx, n_bo, len);
+		if (err)
+			break;
+	}
+	/* These are expected failures we can ignore. */
+	if (err == -ENOMEM || err == -ENOSPC)
+		err = 0;
+	return err ?: n_bo;
+}
+
+static void free_vram(const struct igt_dmem_driver *drv, void *ctx, int max_bo)
+{
+	int i;
+	for (i = 0; i < max_bo; i++)
+		drv->free_vram(ctx, i);
+}
+
+static void test_current(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv)
+{
+	struct igt_cgroup *cg;
+	void *ctx;
+	uint64_t current, capacity, cg_max;
+	int n_bo = 0, max_bo;
+	int err;
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
+	cg_max = min(MAX_LIMIT, capacity - BO_SIZE - USAGE_SLACK);
+	cg_max = ALIGN_DOWN(cg_max, BO_SIZE);
+
+	/* Create cgroup and move into it */
+	cg = igt_cgroup_new("igt_cgroups_test");
+	igt_cgroup_move_current(cg);
+
+	max_bo = cg_max / BO_SIZE;
+
+	err = drv->init(&ctx, fd, max_bo);
+	igt_assert_f(!err, "Failed to initialize driver");
+
+	n_bo = allocate_vram(drv, ctx, fd, max_bo, BO_SIZE);
+	igt_assert_f(n_bo > 0, "failed to allocate VRAM\n");
+
+	igt_cgroup_dmem_get_current(cg, cg_region, &current);
+	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
+		  "max = %"PRIu64" MiB\n",
+		  current / SZ_1M, cg_max / SZ_1M);
+	igt_assert_f(current < cg_max + USAGE_SLACK && current > cg_max - USAGE_SLACK,
+		     "current usage (%"PRIu64" MiB) is not within margin of allocation (%"PRIu64" MiB)\n",
+		     current / SZ_1M, cg_max / SZ_1M);
+
+	free_vram(drv, ctx, n_bo);
+	wait_for_usage_drop(cg, cg_region, USAGE_SLACK);
+
+	igt_cgroup_dmem_get_current(cg, cg_region, &current);
+	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
+		  "max = %"PRIu64" MiB\n",
+		  current / SZ_1M, cg_max / SZ_1M);
+	igt_assert_f(current < USAGE_SLACK,
+		     "current usage (%"PRIu64" MiB) is not within margin (%d MiB)\n",
+		     current / SZ_1M, USAGE_SLACK / SZ_1M);
+
+	/* Allow for a slack as there might be some extra pages allocated. */
+	igt_cgroup_dmem_set_max(cg, cg_region, 2 * BO_SIZE + USAGE_SLACK, false);
+
+	n_bo = allocate_vram(drv, ctx, fd, max_bo, BO_SIZE);
+	igt_assert_f(n_bo > 0, "failed to allocate VRAM\n");
+
+	igt_cgroup_dmem_get_current(cg, cg_region, &current);
+	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
+		  "max = %"PRIu64" MiB\n",
+		  current / SZ_1M, cg_max / SZ_1M);
+	igt_assert_f(current < 2 * BO_SIZE + USAGE_SLACK && current > 2 * BO_SIZE - USAGE_SLACK,
+		     "current usage (%"PRIu64" MiB) is not within margin of allocation (%"PRIu64" MiB)\n",
+		     current / SZ_1M, cg_max / SZ_1M);
+
+	free_vram(drv, ctx, n_bo);
+	wait_for_usage_drop(cg, cg_region, USAGE_SLACK);
+
+	igt_cgroup_dmem_get_current(cg, cg_region, &current);
+	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
+		  "max = %"PRIu64" MiB\n",
+		  current / SZ_1M, cg_max / SZ_1M);
+	igt_assert_f(current < USAGE_SLACK,
+		     "current usage (%"PRIu64" MiB) is not within margin (%d MiB)\n",
+		     current / SZ_1M, USAGE_SLACK / SZ_1M);
+
+	igt_cgroup_dmem_set_max(cg, cg_region, USAGE_SLACK, false);
+
+	n_bo = allocate_vram(drv, ctx, fd, max_bo, BO_SIZE);
+	igt_assert_f(n_bo != -ENOMEM, "VRAM allocation succeeded despite max set to 0\n");
+
+	igt_cgroup_dmem_get_current(cg, cg_region, &current);
+	igt_debug("After fill: cgroup current = %"PRIu64" MiB, "
+		  "max = %"PRIu64" MiB\n",
+		  current / SZ_1M, cg_max / SZ_1M);
+	igt_assert_f(current < USAGE_SLACK,
+		     "current usage (%"PRIu64" MiB) is not within margin\n",
+		     current / SZ_1M);
+
+	if (n_bo > 0)
+		free_vram(drv, ctx, n_bo);
+	wait_for_usage_drop(cg, cg_region, USAGE_SLACK);
+
+	igt_cgroup_dmem_get_current(cg, cg_region, &current);
+	igt_debug("After free: cgroup current = %"PRIu64" MiB, "
+		  "max = %"PRIu64" MiB\n",
+		  current / SZ_1M, cg_max / SZ_1M);
+	igt_assert_f(current < USAGE_SLACK,
+		     "current usage (%"PRIu64" MiB) is not within margin (%d MiB)\n",
+		     current / SZ_1M, USAGE_SLACK / SZ_1M);
+
+	drv->deinit(ctx);
+	igt_cgroup_free(cg);
+}
+
+static const struct {
+	const char *name;
+	void (*test_fn)(int fd, char *cg_region, unsigned int flags, const struct igt_dmem_driver *drv);
+	unsigned int flags;
+} subtests[] = {
+	{ "current", test_current, 0 },
+	{ }
+};
+
+static const struct {
+	int driver_flag;
+	const struct igt_dmem_driver *driver;
+} drivers[] = {
+	{ DRIVER_XE, &xe_dmem_driver },
+	{ DRIVER_AMDGPU, &amdgpu_dmem_driver },
+	{ },
+};
+
+int igt_main()
+{
+	igt_fixture() {
+		igt_require_f(getuid() == 0, "Test requires root\n");
+		/* Check dmem cgroup controller is available before doing anything else */
+		igt_require_f(igt_cgroup_dmem_available(),
+			      "dmem cgroup controller not available (no cgroup v2 or no registered regions)\n");
+
+	}
+
+	for (int d = 0; drivers[d].driver; d++) {
+		igt_subtest_group() {
+			int fd = -1;
+			char *cg_region;
+			igt_fixture() {
+				fd = drm_open_driver(drivers[d].driver_flag);
+				igt_require_f(fd >= 0,
+					"No %s device found, skipping\n",
+					drivers[d].driver->name);
+				cg_region = drivers[d].driver->get_region_name(fd);
+				igt_require_f(cg_region, "Region not tracked by dmem cgroup controller\n");
+			}
+
+			for (int i = 0; subtests[i].name; i++)
+				igt_subtest_f("%s-%s", drivers[d].driver->name, subtests[i].name)
+					subtests[i].test_fn(fd, cg_region, subtests[i].flags, drivers[d].driver);
+
+			igt_fixture() {
+				if (fd >= 0)
+					drm_close_driver(fd);
+				free(cg_region);
+			}
+		}
+	}
+}
diff --git a/tests/meson.build b/tests/meson.build
index 88a0ce224432..dfdaab41825a 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -11,6 +11,7 @@ test_progs = [
 	'core_sysfs',
 	'dmabuf',
 	'dmabuf_sync_file',
+	'dmem_cgroups',
 	'device_reset',
 	'dumb_buffer',
 	'drm_buddy',
-- 
2.47.3

