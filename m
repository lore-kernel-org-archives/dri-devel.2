Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7875EC624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A0010F3E2;
	Thu,  3 Sep 2026 07:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MT8sc1Ts";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE43C10F112
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:58:21 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so1081271a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788346701; x=1788951501; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5n4pILB8Comw/tnf+oqPysx0XcGiglgqtePGDPNDzs0=;
 b=MT8sc1Ts7XXsvvtdBBH538LFRS44eNm5zvZaZAWfgvUwKgpz/qpSZnTsiaOPr8kwOy
 +jJW7cNm/qImsjVzykl1BL0PaiLXIT61LbCUrsaKg2mUKJZVL2mvDr3zKrr4iv5MW7aF
 JneLadG9pLmhWy6mr+zP8N75LPWNDsyxsBJUisTnV6Ea2NPGN++3I3Fe3dGxMFMIrFWP
 gL6+QtJ+0vyfED3+RSBKIGoS77HhudsYqcF4j1Fyp1i+3dsBPAJ+OC7e0TiEbwvpW6CT
 iAIxZII1e8TV98ywrdooBzpd+cO7RCr0GAwWC/iMd01s7xSIS8/RmhFagHIyrPMy86sY
 JfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788346701; x=1788951501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5n4pILB8Comw/tnf+oqPysx0XcGiglgqtePGDPNDzs0=;
 b=HNgu6rq5qT2gOH3RphgSCbahoYA1rnuUyIgqLIiPcSTUjgMnDo9M86e51+OD7wiuwn
 /y5gQp7rrW+0PXFPIlzp1H6WMsvTiZgC0dlbJ18rUMI3yTMQ9zOSzKZra9jbcBkVg4+y
 xWhDw/M/XFXwiKq+4MkwM00j2GhmUERdGrTQbEFSfR4sy3LV1BS89zIBSZnX/MWaO/9f
 vqB1T5TaulhdwoP7zo/CKR3HFdqrm7R6r2j/TqJv5AuAUgo/32+nCxEDnvOGktg/7r3f
 GpdWxP3AAEeSINMW3FJBQA1i7vQR4OFR41moMCr+YF/Q6/QU5dX25XTu/P3ttbtC1S+m
 FYgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZ4ucWgDVE6oJe4wIDJGWp1OjAL0ckvpwMSMcJdcwh0AQrqOP4TVxu/lqWM8xDmG6PgSgyExT6gP8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPqycOF+aax8cMYU9wbcXJlOxBoT+WyQeAsSIQwUxmI3rJaaRC
 ZbUoswnjgL0P7hVHBL/Pm2mfz3y3MhAU0Tk+8T9M8+m8kqcyOCBowDw=
X-Gm-Gg: AYBFou0KRQNk6ZarHKGeuP9Un/rjjll4NJurDU2zqlwvA5PniOfQqEhqfZO+DrfuvTA
 85vBeNrqejlaj0g6AWr5YrxTipAsNqaTXf+g0x79FyfTphwMX1JKi59PIKaqUsMf43HoWB4jOVw
 M1Fd3uU8GVw9abBhHGSOQJtWYdmcI9uWcv06RPIDZB1A+CnW7HX3zNFNwSWq1twzfS3PS5+d3Gg
 24Buw64mDo2rvwd0wG/WmkKDZTVAaUxRyb5i2FGl3UYzNmNsYhgb+hBcwdYgwf4nKRQg+35l5ZD
 8X4GxEmKhGk1otHHdYpFHklP7VNu+lAe3VaEyfQPvav3MXOQoDIYYOGfDLZGUZnJ31r4daRyAWy
 /4xesUIwjF2WYTaPKTMJB2mYXXh5H3QOJt0FXUI5jRdXe+gsB8jGaZwNuiWjCux9lz1tgz7xqdH
 PZGRmJmBDrNIQDb3dxa7s9QjIBdH/l4Mk3XtC1qZ/M1QX3tS4a5x9ijbwn5pj2P2h1adWSE+LHV
 pi96OJ9RCMexLMRjHu2T9WegRM=
X-Received: by 2002:a17:90b:4d0a:b0:398:bee5:61d6 with SMTP id
 98e67ed59e1d1-39aee1476d7mr4967532a91.24.1788346701144; 
 Wed, 02 Sep 2026 03:58:21 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae0dfcd65sm4963143a91.3.2026.09.02.03.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 03:58:20 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: tursulin@ursulin.net, phasta@kernel.org, matthew.brost@intel.com,
 dakr@kernel.org
Cc: christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/sched/tests: add a UAF regression test for the
 timeline name
Date: Wed,  2 Sep 2026 19:58:08 +0900
Message-ID: <20260902105808.1541063-3-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902105808.1541063-1-malhyuk97@gmail.com>
References: <20260902105808.1541063-1-malhyuk97@gmail.com>
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

Add a KUnit test that reproduces the drm_sched_fence get_timeline_name()
use-after-free fixed by the previous patch. It holds a reference on a job's
finished drm_sched_fence (standing in for a userspace sync_file), frees the
mock scheduler, then queries the timeline name through the public
dma_fence_timeline_name() API - as a SYNC_IOC_FILE_INFO consumer would.
Before the fix this triggers a KASAN slab-use-after-free read of the freed
scheduler; after it the cached name is returned and the test passes.

The test needs no hardware - it exercises the drm_sched core through the
existing mock scheduler under KASAN. Put it in a new tests_integration.c so
tests_basic.c stays focused on core scheduler behaviour.

Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/scheduler/tests/Makefile      |  1 +
 .../drm/scheduler/tests/tests_integration.c   | 83 +++++++++++++++++++
 2 files changed, 84 insertions(+)
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
index 000000000000..0572f1e3a80b
--- /dev/null
+++ b/drivers/gpu/drm/scheduler/tests/tests_integration.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Jonghyuk Kim(MalHyuk) */
+
+#include <linux/dma-fence.h>
+#include <linux/rcupdate.h>
+
+#include "sched_tests.h"
+
+/*
+ * Integration tests exercising the drm_sched interaction with the wider
+ * dma-fence infrastructure, e.g. fences exported to userspace outliving the
+ * objects they were created from.
+ */
+
+/*
+ * Reproduce the drm_sched_fence get_timeline_name() lifetime bug.
+ *
+ * drm_sched_fence_get_timeline_name() reads the scheduler name, and the
+ * drm_sched_fence ops keep .release set, so the fence is NOT ops-detached on
+ * signal (dma_fence_signal_timestamp_locked() only clears ->ops for fences
+ * without .release/.wait). A driver that frees a per-context drm_gpu_scheduler
+ * while userspace still holds the exported ->finished fence (via sync_file /
+ * drm_syncobj) leaves the scheduler dangling; querying the timeline name then
+ * touches freed slab memory. KASAN reports a slab-use-after-free read in
+ * drm_sched_fence_get_timeline_name(). Confirmed instances: amdxdna, nouveau,
+ * msm; same class as CVE-2025-38703 (xe) and CVE-2025-71302 (panthor).
+ */
+static void drm_sched_dma_fence_timeline_name_uaf(struct kunit *test)
+{
+	struct drm_mock_sched_entity *entity;
+	struct drm_mock_scheduler *sched;
+	struct drm_mock_sched_job *job;
+	struct dma_fence *finished;
+	const char *name;
+	bool done;
+
+	sched = drm_mock_sched_new(test, MAX_SCHEDULE_TIMEOUT);
+	entity = drm_mock_sched_entity_new(test, DRM_SCHED_PRIORITY_NORMAL,
+					   sched);
+	job = drm_mock_sched_job_new(test, entity);
+
+	/* Arm + submit; the s_fence is only created by drm_sched_job_arm(). */
+	drm_mock_sched_job_submit(job);
+
+	/* Independent reference on the finished fence, as a sync_file would. */
+	finished = dma_fence_get(&job->base.s_fence->finished);
+
+	done = drm_mock_sched_job_wait_scheduled(job, HZ);
+	KUNIT_ASSERT_TRUE(test, done);
+	drm_mock_sched_advance(sched, 1);
+	done = drm_mock_sched_job_wait_finished(job, HZ);
+	KUNIT_ASSERT_TRUE(test, done);
+
+	/* Free the per-context scheduler while the finished fence is held. */
+	drm_mock_sched_entity_free(entity);
+	drm_mock_sched_fini(sched);
+	kunit_kfree(test, sched);
+
+	/*
+	 * Query the timeline name through the public dma-fence API, as a
+	 * userspace SYNC_IOC_FILE_INFO consumer would. Before the fix this is a
+	 * use-after-free read of the freed scheduler; after it the cached name
+	 * is returned and the test passes.
+	 */
+	rcu_read_lock();
+	name = (const char *)dma_fence_timeline_name(finished);
+	rcu_read_unlock();
+	kunit_info(test, "get_timeline_name() on stale fence returned %p\n", name);
+
+	dma_fence_put(finished);
+}
+
+static struct kunit_case drm_sched_dma_fence_uaf_tests[] = {
+	KUNIT_CASE(drm_sched_dma_fence_timeline_name_uaf),
+	{}
+};
+
+static struct kunit_suite drm_sched_dma_fence_uaf = {
+	.name = "drm-sched-dma-fence-uaf",
+	.test_cases = drm_sched_dma_fence_uaf_tests,
+};
+
+kunit_test_suite(drm_sched_dma_fence_uaf);
-- 
2.43.0

