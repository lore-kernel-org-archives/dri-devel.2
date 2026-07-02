Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4E3C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A03410F367;
	Thu,  2 Jul 2026 13:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Kb5ww/di";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F159110E4D0;
 Thu,  2 Jul 2026 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mflwMRcXuAUzGuzJTgISOnoKNXDcBd5ei+IGhxqxPIo=; b=Kb5ww/diNbG/n6gaHu2GgYxwW6
 TXWbBshXpzEgEGjd8AZJLaTslMTt+Xt/XJJApCN9dCLj4uhW2POktw/5xyiIEpO2kHL6ihD+6/fLp
 RsxUXAFBa9anqzm7HBVh68XxbJgHKZNmaV0Vw0AalkCAehC80YS+LQ1uz4bcZtpmmKTL7rGEl7UlL
 xNlA0WEXjhWAfYRPRmsNaAO+IwPgwxPSiJYAT8TUs6uB+HUmp6sxR38smN6OFlwkF8SzSLfIQdl2O
 wR51PmYxKaDsO5FXgSJG8Q9lkjLrWxzGsefmdgujGDlxg8OA4oxZdU/lTlYjnUL3HZ0+2m3MaQv/V
 0sBdPAvA==;
Received: from [179.125.94.247] (helo=quatroqueijos.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfH3F-0082Ji-EY; Thu, 02 Jul 2026 15:01:58 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
Subject: [PATCH i-g-t v2 2/7] tests/cgroup_dmem: add dmem cgroup controller
 test
Date: Thu,  2 Jul 2026 10:00:53 -0300
Message-ID: <20260702130108.1397444-3-cascardo@igalia.com>
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

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Add a test that exercises the cgroup v2 dmem controller interface using
the new igt_cgroup library.

The test uses igt_simple_main and:
  - Skips if no dmem regions are registered (no cgroup v2 or no
   dmem-capable device).
  - Creates a sub-cgroup and moves the test process into it.
  - Enumerates all registered device memory regions and prints their
   capacity, system-wide current usage, per-cgroup current usage, and
   configured min, low and max limits.
  - Destroys the cgroup on completion.

Assisted-by: GitHub Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 tests/cgroup_dmem.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/meson.build   |  1 +
 2 files changed, 93 insertions(+)
 create mode 100644 tests/cgroup_dmem.c

diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
new file mode 100644
index 000000000000..442c965f9bbf
--- /dev/null
+++ b/tests/cgroup_dmem.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2025 Intel Corporation
+ */
+
+/**
+ * TEST: cgroup dmem
+ * Description: Exercises the cgroup v2 dmem controller interface.  Creates a
+ *              cgroup, moves the process into it, enumerates all dmem regions,
+ *              prints their capacity, system-wide current usage, per-cgroup
+ *              current usage and configured limits, then destroys the cgroup.
+ * Category: Core
+ * Mega feature: General Core features
+ * Sub-category: uapi
+ * Functionality: cgroup
+ * Feature: dmem
+ * Test category: uapi
+ */
+
+#include <inttypes.h>
+
+#include "igt.h"
+#include "igt_cgroup.h"
+
+IGT_TEST_DESCRIPTION("Exercises the cgroup v2 dmem controller interface.");
+
+static void fmt_bytes(uint64_t v, char *buf, size_t len)
+{
+	if (v == IGT_CGROUP_DMEM_MAX)
+		snprintf(buf, len, "max");
+	else
+		snprintf(buf, len, "%" PRIu64, v);
+}
+
+int igt_simple_main()
+{
+	struct igt_cgroup *cg;
+	const char *region;
+	char **regions;
+	uint64_t capacity, sys_current, cg_current, min, low, max;
+	char cap_s[32], sys_s[32], cg_s[32];
+	char min_s[32], low_s[32], max_s[32];
+	int i;
+
+	igt_require_f(igt_cgroup_dmem_available(),
+		      "No dmem regions found; is cgroup v2 with the "
+		      "dmem controller available?\n");
+
+	cg = igt_cgroup_new("igt-cgroup-dmem-test");
+	igt_assert_f(cg, "Failed to create cgroup\n");
+
+	igt_cgroup_move_current(cg);
+
+	regions = igt_cgroup_dmem_regions();
+	igt_assert_f(regions, "Failed to enumerate dmem regions\n");
+
+	igt_info("%-40s %16s %16s %16s %16s %16s %16s\n",
+		 "region", "capacity", "system-current",
+		 "cgroup-current", "min", "low", "max");
+	igt_info("%-40s %16s %16s %16s %16s %16s %16s\n",
+		 "------", "--------", "--------------",
+		 "--------------", "---", "---", "---");
+
+	for (i = 0; regions[i]; i++) {
+		region = regions[i];
+
+		igt_cgroup_dmem_get_capacity(region, &capacity);
+		fmt_bytes(capacity, cap_s, sizeof(cap_s));
+
+		igt_cgroup_dmem_get_system_current(region, &sys_current);
+		fmt_bytes(sys_current, sys_s, sizeof(sys_s));
+
+		igt_cgroup_dmem_get_current(cg, region, &cg_current);
+		fmt_bytes(cg_current, cg_s, sizeof(cg_s));
+
+		igt_cgroup_dmem_get_min(cg, region, &min);
+		fmt_bytes(min, min_s, sizeof(min_s));
+
+		igt_cgroup_dmem_get_low(cg, region, &low);
+		fmt_bytes(low, low_s, sizeof(low_s));
+
+		igt_cgroup_dmem_get_max(cg, region, &max);
+		fmt_bytes(max, max_s, sizeof(max_s));
+
+		igt_info("%-40s %16s %16s %16s %16s %16s %16s\n",
+			 region, cap_s, sys_s, cg_s,
+			 min_s, low_s, max_s);
+	}
+
+	igt_cgroup_dmem_regions_free(regions);
+	igt_cgroup_free(cg);
+}
diff --git a/tests/meson.build b/tests/meson.build
index 96bd6213d192..88a0ce224432 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -1,4 +1,5 @@
 test_progs = [
+	'cgroup_dmem',
 	'core_auth',
 	'core_debugfs',
 	'core_getclient',
-- 
2.47.3

