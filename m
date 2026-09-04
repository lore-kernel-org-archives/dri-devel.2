Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B610C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF88610F8C1;
	Fri,  4 Sep 2026 07:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="YuMDPtMJ";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AFE010F8C1
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Lu
 cGUmViYLeOIbWfZ0Po7eORJRG/Yi9Oov7C9edhbA8=; b=YuMDPtMJlJF6MN/4Ke
 SwUMmrFt6feQFgSnajj3k9wasW4pkYq6CLNxuOoW8ofe4qONz8usJt8qfkBwD/KM
 a90ITnAaL2Hai4Tu6/CAmN8LWZ6Q8w43rpETuIlMGz+6h78qllvptk+SNWJ+InXb
 QphR1hJeMTIRghSWSP8Vg7j8A=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD3n7SPcZpqE9NwAg--.42593S2; 
 Fri, 04 Sep 2026 15:21:53 +0800 (CST)
From: oushixiong1025@163.com
To: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>,
 stable@vger.kernel.org
Subject: [PATCH v3] drm/sched: Create a fake device for KUnit tests
Date: Fri,  4 Sep 2026 15:21:49 +0800
Message-Id: <20260904072149.436181-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3n7SPcZpqE9NwAg--.42593S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW5ur1xJry8Cr1rKw47twb_yoW5XF4xpF
 WkXFWYgr4rtrZFg3y3ua95XFyfGwsrA3yxKr1kX34a9F1qgFyfJr1UKrW3J34UArWkZFWS
 q3Z0qw47Gr4jyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnsqXUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4hHB0GqacZGHcwAA3G
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

The DRM scheduler KUnit tests pass NULL for the dev field in
drm_sched_init_args, which NULL-pointer dereferences in the drm_sched_job
trace event via dev_name() on sched->dev.

Give the mock scheduler a device with kunit_device_register(), which is
also cleaned up at test exit. A per-function counter keeps the device
names unique, since some tests create several mock schedulers.

Fixes: 5a99350794fe ("drm/sched: Add scheduler unit testing infrastructure and some basic tests")
Cc: stable@vger.kernel.org
Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
Acked-by: Maxime Ripard <mripard@kernel.org>

---
v2->v3:
  - Start the mock scheduler device numbering at 0, using
    instance++ instead of ++instance

v1->v2:
  - Switch from faux_device_create() to kunit_device_register(), which also
    cleans the device up automatically at test exit (Maxime Ripard)
  - Build the device name on top of args.name (Philipp Stanner)
  - Make the instance counter a static unsigned int local to
    drm_mock_sched_new() (Philipp Stanner)
  - Add a Fixes: tag and Cc: stable for the NULL dev dereference

 drivers/gpu/drm/scheduler/tests/mock_scheduler.c | 11 ++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
index 8e9ae7d980eb..12dc61f56192 100644
--- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
+++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2025 Valve Corporation */
 
+#include <kunit/device.h>
+
 #include "sched_tests.h"
 
 /*
@@ -288,6 +290,7 @@ static const struct drm_sched_backend_ops drm_mock_scheduler_ops = {
  */
 struct drm_mock_scheduler *drm_mock_sched_new(struct kunit *test, long timeout)
 {
+	static unsigned int instance;
 	struct drm_sched_init_args args = {
 		.ops		= &drm_mock_scheduler_ops,
 		.num_rqs	= DRM_SCHED_PRIORITY_COUNT,
@@ -297,11 +300,19 @@ struct drm_mock_scheduler *drm_mock_sched_new(struct kunit *test, long timeout)
 		.name		= "drm-mock-scheduler",
 	};
 	struct drm_mock_scheduler *sched;
+	struct device *dev;
+	char name[64];
 	int ret;
 
 	sched = kunit_kzalloc(test, sizeof(*sched), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, sched);
 
+	snprintf(name, sizeof(name), "%s-%u", args.name, instance++);
+	dev = kunit_device_register(test, name);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	args.dev = dev;
+
 	ret = drm_sched_init(&sched->base, &args);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-- 
2.43.0

No virus found
		Checked by Hillstone Network AntiVirus

