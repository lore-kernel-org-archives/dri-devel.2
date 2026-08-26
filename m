Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD69C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4813510E267;
	Wed, 26 Aug 2026 08:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="EZKx7opF";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FDF0890BB
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Hq
 +PQvivij3P3MEGYcAKZIRnspRAwgEpPvp+39rTTpk=; b=EZKx7opF/Rug+ks6kT
 NJbc3Bv6nRKu55seIrP5z7RMripn0m045My98LFUO/lQLZKwHTzuCuHpwrUx5AsD
 h38Hzm8QMoNYM2M/zIJDMQVfXiFxBzFokUB03AqcCegzEeu+GRB4rhQg76rStNam
 5BhssaqSmXUz6dQjDwtXp4yVA=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wA3FQuwoI5qcmjaRA--.53472S2; 
 Wed, 26 Aug 2026 16:15:45 +0800 (CST)
From: oushixiong1025@163.com
To: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/sched: Create faux device for KUnit tests
Date: Wed, 26 Aug 2026 16:15:43 +0800
Message-Id: <20260826081543.508257-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3FQuwoI5qcmjaRA--.53472S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1kGw1kKryktF43JF48Xrb_yoW5urW5pa
 9rZFWYgrWrtFyDKrW7ua1rZFyfGw4xC347Kr1DK34Y9F1vqFy5tr4DGrW3Jry7ArW7ZFWS
 vwnIgw47GF4jyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeFAJUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-hGSoWqOoLH4GQAA3I
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

From: Shixiong Ou <oushixiong@kylinos.cn>

The DRM scheduler KUnit tests currently pass NULL for the dev field in
drm_sched_init_args, which causes a NULL pointer dereference in the
drm_sched_job trace event when it calls dev_name() on sched->dev.

Use faux_device_create() to create a fake device for the mock scheduler,
so the scheduler always has a valid device pointer. This avoids the
trace event crash without requiring the production code to accept a NULL
device pointer, which conceptually makes no sense for a scheduler.

An atomic counter is used to generate unique device names, since
multiple mock schedulers can exist simultaneously across different
test suites.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c | 14 ++++++++++++++
 drivers/gpu/drm/scheduler/tests/sched_tests.h    |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
index 14403a762335..cd87e405bb1e 100644
--- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
+++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2025 Valve Corporation */
 
+#include <linux/device/faux.h>
+
 #include "sched_tests.h"
 
 /*
@@ -10,6 +12,8 @@
  * Test cases are implemented in a separate file.
  */
 
+static atomic_t drm_mock_sched_instance = ATOMIC_INIT(0);
+
 /**
  * drm_mock_sched_entity_new - Create a new mock scheduler entity
  *
@@ -296,11 +300,20 @@ struct drm_mock_scheduler *drm_mock_sched_new(struct kunit *test, long timeout)
 		.name		= "drm-mock-scheduler",
 	};
 	struct drm_mock_scheduler *sched;
+	char name[64];
 	int ret;
 
 	sched = kunit_kzalloc(test, sizeof(*sched), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, sched);
 
+	snprintf(name, sizeof(name), "drm-mock-scheduler-%d",
+		 atomic_inc_return(&drm_mock_sched_instance));
+
+	sched->faux_dev = faux_device_create(name, NULL, NULL);
+	KUNIT_ASSERT_NOT_NULL(test, sched->faux_dev);
+
+	args.dev = &sched->faux_dev->dev;
+
 	ret = drm_sched_init(&sched->base, &args);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -323,6 +336,7 @@ struct drm_mock_scheduler *drm_mock_sched_new(struct kunit *test, long timeout)
 void drm_mock_sched_fini(struct drm_mock_scheduler *sched)
 {
 	drm_sched_fini(&sched->base);
+	faux_device_destroy(sched->faux_dev);
 }
 
 /**
diff --git a/drivers/gpu/drm/scheduler/tests/sched_tests.h b/drivers/gpu/drm/scheduler/tests/sched_tests.h
index 553d45abd057..bbf4da585866 100644
--- a/drivers/gpu/drm/scheduler/tests/sched_tests.h
+++ b/drivers/gpu/drm/scheduler/tests/sched_tests.h
@@ -7,6 +7,7 @@
 #include <kunit/test.h>
 #include <linux/atomic.h>
 #include <linux/completion.h>
+#include <linux/device/faux.h>
 #include <linux/dma-fence.h>
 #include <linux/hrtimer.h>
 #include <linux/ktime.h>
@@ -44,6 +45,7 @@ struct drm_mock_scheduler {
 	struct drm_gpu_scheduler base;
 
 	struct kunit		*test;
+	struct faux_device	*faux_dev;
 
 	spinlock_t		lock;
 	struct list_head	job_list;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

