Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F78EC624DB
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8949510F3E3;
	Thu,  3 Sep 2026 07:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HVHATUtx";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3144D10F22C
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 14:42:17 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso1205366b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788360137; x=1788964937; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T4rzi1j9WrZOHI2yOdIU+qwSR0bj2vsquJxO94rhuiw=;
 b=HVHATUtxJe/am3Q0iawSP8ODvISwVY/jCMs506M+vmKd7RPW4CTdGqYxuyfEsc+hW0
 8hnvwh00adTI+imFNNZZcOQ8AV2CUv8NOnIZsCb1RghsQ5evSvhGQy5OUif0e8pea3nK
 WySDX7pTyVOysHBRMRWAtzeH0UcLcQqgcdtlSLtLyxbvL8rBsoudAlHBymirCwV+A1ux
 5l65ZLO5Raej+IKcQQCSDLkYrLzeuNYrmX9AwYxO4huQ/AKaW0GMPdBtUy3QuM8M9xI8
 yY9JffS5tPIYYA7qulVwkOR6y/xTNFVvwOYEFQTTCeQ7XLnZaDgco3pViBHRREsbhDVh
 LbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788360137; x=1788964937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T4rzi1j9WrZOHI2yOdIU+qwSR0bj2vsquJxO94rhuiw=;
 b=RsWvSj3PiND603OQSbCbxCk3Znaj0lgwMXo71UcsWIWCEa8LwluRIvAGC5JJclftW/
 M29axLVCkaumsPVxj1Vy6fHcwCbkqQH9G5Qw8iPNaegYWAwG3Y1EKtDG/HJJkhi6Txnk
 ESga4hysvxxEKt+xlddoDpF9EayCRFuA42NwN6Vh381EL6ZwxKxf7gFQ3s9ynVQG6VEs
 cZyJcRJsJecPzJxeTcrEYDoKbMAb3zz/1GUoWF8OFVOLPw4aN1poOrObUn4chyoSGh6m
 TZDg48vEOb8eWYe9ZGySkzOCmZQCrQDEUeZsQh3/yWIquvJCohckcukoVSrkvHD1t1RI
 uPJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxrACeh0dyfqpyQw62UCU7B2uO+qNNTWXFkSqYbQz/Vhh+Wvofev07jSUmMnQPDCnCbihrWrXPolI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mYhyTjEwIXRCz8m95fw77eUb2xHY5ZpuNxyfmVaDEqvCU/Dz6P
 BCRMV5alKmKw8elECZKusRrLh01T48ZISncC+pD8e3OGiu+R+kvWtB4=
X-Gm-Gg: AYBFou38ZZNOqoFsiOI9FpnMXm1KIiz++0En63+g7Nh/Pf3FbnoRIC5B/izFBVjDeXS
 u/643thmUc0BHNCK3PNRiNqy440jItdHqFTY6ksRUfnUBZH+jMXeyWMimvaMK1gWm0HV88ml+6D
 fhqR79l+VNR222q3GXmehaZNRtpnvh6ilgeNiezxuJX//nGj6XiXc7mBkl3cRJl+q4BSiK1ciiG
 Xn3mgdPkE6Y6Dt6dSWegNKdVFRZTo/lZtRd9fkeKR7FD32SpQRC9thwCYUr8Ebnp5VpCtwM+W8I
 ALFaqsjHl4E8XmkCqlPdK4GwSaJvLDVLDRdafKkqQ+t1vMovt9xdwSDYLwcyzqDUjKBDgeMVn4r
 hcyI9juqcwM0yAbiuPK4JpIPgLyDUCZG6217Ku8BQGJVHgmzs8a/ZPzxkk2VKMPjjHt8iJlxpwu
 /tRn3g9EGXYtUrkhBvRfNHw+XUHeuGieatxSsAqEVFAnG3yY2FBMGi92mOtFJ60MShyBhSKeT92
 lprRtZhYCb8hnFhPefy5se85Dk=
X-Received: by 2002:a05:6a00:e19:b0:857:73c3:4468 with SMTP id
 d2e1a72fcca58-85f453a2973mr3154986b3a.23.1788360136614; 
 Wed, 02 Sep 2026 07:42:16 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85db23f8d8asm1655776b3a.12.2026.09.02.07.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:42:16 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: tursulin@ursulin.net, phasta@kernel.org, matthew.brost@intel.com,
 dakr@kernel.org
Cc: christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
Subject: [PATCH v3 2/2] drm/sched/tests: add a UAF regression test for the
 timeline name
Date: Wed,  2 Sep 2026 23:42:04 +0900
Message-ID: <20260902144204.1843670-3-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902144204.1843670-1-malhyuk97@gmail.com>
References: <20260902144204.1843670-1-malhyuk97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

Add a KUnit test that reproduces the drm_sched_fence timeline-name
use-after-free fixed by the previous patch. It submits a job on the mock
scheduler, takes an independent reference on the finished fence (standing
in for a userspace sync_file), lets the job finish, frees the scheduler,
and then queries the timeline name through dma_fence_timeline_name().

Without the fix the finished fence keeps its ops attached after
signalling, so this dereferences fence->sched of the freed scheduler and
KASAN reports a slab-use-after-free read in
drm_sched_fence_get_timeline_name(); with the fix the ops are detached on
signalling and a static string is returned.

The test needs no hardware - it exercises the drm_sched core through the
existing mock scheduler under KASAN. Per review it lives in a new
tests_integration.c rather than in tests_basic.c, since it is about the
scheduler's interaction with the dma-fence API rather than scheduler
behaviour in isolation.

Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/scheduler/tests/Makefile      |  1 +
 .../drm/scheduler/tests/tests_integration.c   | 92 +++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 drivers/gpu/drm/scheduler/tests/tests_integration.c

diff --git a/drivers/gpu/drm/scheduler/tests/Makefile b/drivers/gpu/drm/scheduler/tests/Makefile
index 9ec185fbbc15..10abe07c06d2 100644
--- a/drivers/gpu/drm/scheduler/tests/Makefile
+++ b/drivers/gpu/drm/scheduler/tests/Makefile
@@ -3,6 +3,7 @@
 drm-sched-tests-y := \
         mock_scheduler.o \
         tests_basic.o \
+        tests_integration.o \
         tests_scheduler.o
 
 obj-$(CONFIG_DRM_SCHED_KUNIT_TEST) += drm-sched-tests.o
diff --git a/drivers/gpu/drm/scheduler/tests/tests_integration.c b/drivers/gpu/drm/scheduler/tests/tests_integration.c
new file mode 100644
index 000000000000..5e1ca6c6fa5a
--- /dev/null
+++ b/drivers/gpu/drm/scheduler/tests/tests_integration.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-fence.h>
+#include <linux/rcupdate.h>
+
+#include "sched_tests.h"
+
+/*
+ * Integration-style regression tests that exercise the interaction between the
+ * DRM scheduler and the dma-fence API, rather than scheduler behaviour in
+ * isolation.
+ */
+
+/*
+ * Reproduce the drm_sched_fence timeline-name use-after-free.
+ *
+ * drm_sched_fence_get_timeline_name() dereferences fence->sched. A driver may
+ * free a per-context/per-queue/per-VM drm_gpu_scheduler while userspace still
+ * holds the exported ->finished fence (via sync_file / drm_syncobj). Querying
+ * the timeline name afterwards must not touch the freed scheduler.
+ *
+ * The dma-fence contract only permits access to driver-provided data (which
+ * includes the memory reached through &dma_fence.ops) before the fence is
+ * signalled. dma_fence_timeline_name() enforces this by returning a static
+ * string once the ops have been detached on signalling. For that detach to
+ * happen the finished fence must not carry a .release (or .wait) callback.
+ *
+ * Without the fix (finished fence keeps a .release callback) the ops are never
+ * detached, so this reads fence->sched->name from freed slab memory and KASAN
+ * reports a slab-use-after-free. Same class as CVE-2025-38703 (drm/xe) and
+ * CVE-2025-71302 (drm/panthor).
+ */
+static void drm_sched_dma_fence_uaf(struct kunit *test)
+{
+	struct drm_mock_sched_entity *entity;
+	struct drm_mock_scheduler *sched;
+	struct drm_mock_sched_job *job;
+	struct dma_fence *finished;
+	const char __rcu *name;
+	bool done;
+
+	sched = drm_mock_sched_new(test, MAX_SCHEDULE_TIMEOUT);
+	entity = drm_mock_sched_entity_new(test, DRM_SCHED_PRIORITY_NORMAL,
+					   sched);
+	job = drm_mock_sched_job_new(test, entity);
+
+	/* The s_fence is only created by drm_sched_job_arm(). */
+	drm_mock_sched_job_submit(job);
+
+	/* Independent reference on the finished fence == userspace sync_file. */
+	finished = dma_fence_get(&job->base.s_fence->finished);
+
+	/* Let the job get scheduled (hw fence created), then signal + finish. */
+	done = drm_mock_sched_job_wait_scheduled(job, HZ);
+	KUNIT_ASSERT_TRUE(test, done);
+	drm_mock_sched_advance(sched, 1);
+	done = drm_mock_sched_job_wait_finished(job, HZ);
+	KUNIT_ASSERT_TRUE(test, done);
+
+	/*
+	 * Free the per-context scheduler while the finished fence is held.
+	 * kunit_kfree() releases the backing memory immediately (rather than at
+	 * test teardown) so that fence->sched becomes a dangling pointer now.
+	 */
+	drm_mock_sched_entity_free(entity);
+	drm_mock_sched_fini(sched);
+	kunit_kfree(test, sched);
+
+	/*
+	 * Query the timeline name of the now-stale fence. With the fix the ops
+	 * have been detached on signalling and a static string is returned;
+	 * without it this is a use-after-free read of the freed scheduler.
+	 */
+	rcu_read_lock();
+	name = dma_fence_timeline_name(finished);
+	KUNIT_EXPECT_NOT_NULL(test, name);
+	rcu_read_unlock();
+
+	dma_fence_put(finished);
+}
+
+static struct kunit_case drm_sched_dma_fence_tests[] = {
+	KUNIT_CASE(drm_sched_dma_fence_uaf),
+	{}
+};
+
+static struct kunit_suite drm_sched_dma_fence = {
+	.name = "drm-sched-dma-fence-uaf",
+	.test_cases = drm_sched_dma_fence_tests,
+};
+
+kunit_test_suite(drm_sched_dma_fence);
-- 
2.43.0

