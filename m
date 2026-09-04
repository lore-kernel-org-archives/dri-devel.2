Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70368C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 823AE10E5FB;
	Sat,  5 Sep 2026 15:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hruv7rW3";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A08010E54F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:06:34 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so575466a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788509194; x=1789113994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QaFo74pEjy74IX81W7yJ+GS8RxmbNRM1kYRnfOPg9z4=;
 b=Hruv7rW3o+vZzO71cHSMCrjnye1LGuNeFGfMifBVtKyIfPTUVaUT0j4dU5X2PhHF4W
 rF2DTrCKt1mTa+NWcd4IKS3VHJV+aPDTI7mjyvqc3jSCDlOV3O1NqT1Pfmqcf9HcqU8H
 GeR7d/+lU7vy3MKCa+4T3ocwRC38CZM96poRHHSsQrMyyMW/U6m97EjtrfZM7QRV78tc
 fzct4Q5I1F2ZNexkBr0uKW2P1+fVVhZvzsAqaq27RpIAzGjwr5IANua9DbIHD6g33O4t
 R/tGywMpodQucAEr5NG4nYkL4DjTKSnJrd2/npUPgJW+b3XHKtVoZ3VVljObgjxE5otZ
 wW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788509194; x=1789113994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QaFo74pEjy74IX81W7yJ+GS8RxmbNRM1kYRnfOPg9z4=;
 b=EHy5uebTE2asEug4Dmm8Zps228yicIHMnQ+cLA7sJRr0r51r7+9sgM+ueDJGR3ugrL
 VNjUJY7uCNsMmzc6iwWDjShUtxDAuiv4UryKKLWmF9phdeiQ9Gaxpin0xr7Jc4coQ2a2
 T/d43+afHYV5zm7iaOlzRCrjzoe5DksBVKfDN1hukTIQ0awjoY6G0sLJ+d/S3ZAj1LES
 BQPiDovMiZOgLDuxBUkx2a+7db//ZuFup5UvoiKrJqapoiZGqiXUSCnar4ICW4Q0BzNL
 68so01trc93vf6qSDw1Xa45CbK9DLvCJ50qnsthf1WmcozF+luk+YYdJ0oKNduBJjIc1
 XjjQ==
X-Gm-Message-State: AFuF++k05KRwlLP10fj4qEGH/DHGQImeVzY1UX+lISwr1IiVmxHGFXGR
 U2GJEAWnsukpQXpplIEvLZBQMOqu3S5gfELYz8jrcjwVKCxC8neFLzk=
X-Gm-Gg: AYBFou3IcKjrl2vNIWuSobdH7rJZqENBDwVp3/qmCwN0vvYaPK2nkLEUcbErHwXIGeq
 JdwwIO7i9VlZBIXXbSpXa8GawWCkdrqK4ghcxMYdJmfRpWTKSVrTbLFsg6ueeuKwJpIiYrVybPF
 w5QqimZNifr3K0kP+PQzORASDi2Z9WcpWlbV/k4OgO9FLYImE34enF5f6gdOxZrfYTKOl1XxAv7
 51UziFntqwofWa+f/7DJQB+8WTq0oPu4wHn6Jz0nAsdp9oXPJfhiixSirbtn3rrzTzhoVsRY55l
 OmTjI1Ve7PLWagAxD6C9Cj/jF0XqZlTTikJBhtnu3l7FQhz0NGADDmTnwuIEUJBPuSLTky6LsnI
 jmkbNTlPXXA71ktnzOgxgBzhJ0HWXsZ9paEuBHzYA/LHRSyVU6AncbxAGzhFCe0e71JBXGW9k9C
 9o4GpOQGIA2D6uQ/f33i1Ohkwp9+6uusxUp1PjoVEqFLiqZdvjiQ6Sbokd+PL3UKPkR0ECRD1Sa
 uK5ZUS8r8AS9kQep46ZovHuoM4=
X-Received: by 2002:a17:90b:5705:b0:36d:9e0b:3801 with SMTP id
 98e67ed59e1d1-39b2617ed3bmr7586853a91.8.1788509193780; 
 Fri, 04 Sep 2026 01:06:33 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b261549f3sm3181153a91.16.2026.09.04.01.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:06:32 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: phasta@kernel.org, christian.koenig@amd.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
Subject: [PATCH v4 3/3] drm/sched/tests: add a UAF regression test for the
 timeline name
Date: Fri,  4 Sep 2026 17:06:18 +0900
Message-ID: <20260904080618.2098450-4-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904080618.2098450-1-malhyuk97@gmail.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

Without the fix get_timeline_name() dereferences fence->sched of the freed
scheduler and KASAN reports a slab-use-after-free read in
drm_sched_fence_get_timeline_name(); with the fix the name was cached at
init and the freed scheduler is never touched.

The test needs no hardware - it exercises the drm_sched core through the
existing mock scheduler under KASAN. Per review it lives in a new
tests_integration.c rather than in tests_basic.c, since it is about the
scheduler's interaction with the dma-fence API rather than scheduler
behaviour in isolation.

Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/scheduler/tests/Makefile      |  1 +
 .../drm/scheduler/tests/tests_integration.c   | 88 +++++++++++++++++++
 2 files changed, 89 insertions(+)
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
index 000000000000..4a2d5571440d
--- /dev/null
+++ b/drivers/gpu/drm/scheduler/tests/tests_integration.c
@@ -0,0 +1,88 @@
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
+ * drm_sched_fence_get_timeline_name() used to dereference fence->sched->name.
+ * A driver may free a per-context/per-queue/per-VM drm_gpu_scheduler while
+ * userspace still holds the exported ->finished fence (via sync_file /
+ * drm_syncobj). Querying the timeline name afterwards must not touch the freed
+ * scheduler.
+ *
+ * Without the fix this reads fence->sched->name from freed slab memory and
+ * KASAN reports a slab-use-after-free in drm_sched_fence_get_timeline_name();
+ * with the fix the name is cached at init and the freed scheduler is never
+ * dereferenced. Same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
+ * (drm/panthor).
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
+	 * Query the timeline name of the now-stale fence. With the fix the name
+	 * was cached at init, so the freed scheduler is not dereferenced;
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
+	.name = "drm_sched_dma_fence_uaf_tests",
+	.test_cases = drm_sched_dma_fence_tests,
+};
+
+kunit_test_suite(drm_sched_dma_fence);
-- 
2.43.0

