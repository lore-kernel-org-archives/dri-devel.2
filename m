Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBDAC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A2410F7BF;
	Thu,  3 Sep 2026 22:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AsqNTuzN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B9FE10F7CA;
 Thu,  3 Sep 2026 22:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=XFjpr/028iCComgfestI43c11Qk9ooWihFeg47m+Cqc=; b=AsqNTuzNbdrZ1nUSssEQ1c9Jmd
 9lTqaZT6sl9AtafK9FQy+SpRsw4qOdz+PIByfpfCab0XD3uIl05XemxtYXs5PHRAx3xVB+ZZK7Z68
 54r+Gp5IJ7u+Bk7H4/THXt+xdVeMdAHqyc9sS7Ir9XnDSU1L049/v+NFyxVfYkayjnnGjfvNCn6FT
 5dVgb6IP4xvkBYc3c5V50TXAUFE477p7tJweq66nQN+cW2hEC5rEE8fLdAlA0PZJIkDznRGHvH7Hl
 fBmH6kZJ6nBVy6odrnH2tyRQJRzY69obT+cmtEWIAprpjwZ3G0mPo6DBB425PyxBOXEA3op++MWF8
 KYsV/0mQ==;
Received: from [187.43.152.48] (helo=[127.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x2FV3-00EbUz-EO; Fri, 04 Sep 2026 00:01:37 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 03 Sep 2026 19:00:31 -0300
Subject: [PATCH i-g-t v6 9/9] tests/cgroup_dmem: add
 write_eviction_nonblock subtest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-dmem_max-v6-9-61dc62970fae@igalia.com>
References: <20260903-dmem_max-v6-0-61dc62970fae@igalia.com>
In-Reply-To: <20260903-dmem_max-v6-0-61dc62970fae@igalia.com>
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

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Add write_eviction_nonblock to exercise the O_NONBLOCK path of the dmem
cgroup max interface.  After filling VRAM to the cgroup limit, each
limit-lowering step writes dmem.max with O_NONBLOCK so that synchronous
eviction is skipped.  The test then verifies that usage has not yet
dropped below the new limit, allocates a small BO to trigger eviction
explicitly, and finally confirms that usage falls within bounds.

Assisted-by: GitHub Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 tests/cgroup_dmem.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/tests/cgroup_dmem.c b/tests/cgroup_dmem.c
index 0d3b415acd54..ee6345c17878 100644
--- a/tests/cgroup_dmem.c
+++ b/tests/cgroup_dmem.c
@@ -41,6 +41,7 @@
 #define USAGE_DROP_TIMEOUT_MS	1000
 
 #define TEST_INTERRUPTIBLE	(1 << 0)
+#define TEST_NONBLOCK		(1 << 1)
 
 /**
  * SUBTEST: simple
@@ -90,6 +91,18 @@
  * REQUIREMENTS: must run as root; xe device with at least one VRAM region
  */
 
+/**
+ * SUBTEST: write_eviction_nonblock
+ * DESCRIPTION:
+ *   Same fill phase as write_eviction.  In the limit-lowering phase dmem.max
+ *   is written with O_NONBLOCK, which causes the kernel to skip synchronous
+ *   eviction.  After each nonblock write the test verifies that usage has not
+ *   yet dropped below the new limit, then triggers eviction explicitly by
+ *   allocating a small BO.  Finally verifies that usage falls within bounds
+ *   after the forced eviction.
+ * REQUIREMENTS: must run as root; xe device with at least one VRAM region
+ */
+
 static atomic_int signal_count;
 static struct sigaction sigcont_oldact;
 
@@ -277,7 +290,7 @@ static void test_write_eviction(int fd, char *cg_region, unsigned int flags, con
 	struct igt_cgroup *cg;
 	void **handles;
 	int max_bo;
-	uint64_t current, capacity, cg_max, limit, after;
+	uint64_t current, capacity, cg_max, limit, after, before;
 	int err;
 
 	igt_cgroup_dmem_get_capacity(cg_region, &capacity);
@@ -322,14 +335,31 @@ static void test_write_eviction(int fd, char *cg_region, unsigned int flags, con
 	while (limit >= EVICT_STEP) {
 
 		limit -= EVICT_STEP;
-		igt_cgroup_dmem_set_max(cg, cg_region, limit, false);
+
+		if (flags & TEST_NONBLOCK)
+			igt_cgroup_dmem_get_current(cg, cg_region, &before);
+
+		igt_cgroup_dmem_set_max(cg, cg_region, limit,
+					!!(flags & TEST_NONBLOCK));
 
 		igt_cgroup_dmem_get_current(cg, cg_region, &after);
 		igt_debug("Lowered max to %"PRIu64" MiB: usage = %"PRIu64" MiB\n",
 			  limit / SZ_1M, after / SZ_1M);
 
+		if (flags & TEST_NONBLOCK) {
+			/*
+			 * O_NONBLOCK skips eviction: verify usage has not
+			 * dropped below the new limit yet.
+			 */
+			igt_assert_f(after == before,
+				     "Expected no eviction with O_NONBLOCK, but "
+				     "usage dropped from %"PRIu64" MiB to %"PRIu64" MiB "
+				     "(limit %"PRIu64" MiB)\n",
+				     before / SZ_1M, after / SZ_1M, limit / SZ_1M);
+		}
+
 		if (limit > EVICT_STEP) {
-			if ((flags & TEST_INTERRUPTIBLE) && after > limit) {
+			if ((flags & (TEST_INTERRUPTIBLE | TEST_NONBLOCK)) && after > limit) {
 				/* Let a new bo creation trigger eviction. */
 				void *handle;
 				err = drv->allocate_vram(ctx, BO_SIZE / 8, &handle);
@@ -368,6 +398,7 @@ static const struct {
 	{ "current", test_current, 0 },
 	{ "write_eviction", test_write_eviction, 0 },
 	{ "write_eviction_interruptible", test_write_eviction, TEST_INTERRUPTIBLE },
+	{ "write_eviction_nonblock", test_write_eviction, TEST_NONBLOCK },
 	{ }
 };
 

-- 
2.47.3

