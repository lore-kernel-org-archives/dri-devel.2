Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E53C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D00010E9A5;
	Tue,  4 Aug 2026 10:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="EM8+xABl";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF92A10E9A4
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SN
 gANdgd3yrICr74L9F+6aCokbWZXBdjOG5TLfF57i0=; b=EM8+xABlybg/grdWbI
 nIV7bue2rg1fslIgpCocinw+vEMPlvVzjTXnu8Smy4AZ187n4dFNqM5dZQrY48ME
 BWfTsghk/2l1VxhFxvoa88SqwS6YzW+APRoSwqhxU/daQJPiz7GGh5l40+g4UbLL
 8khzq4dC27axs1WdnIN7ITZLo=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgDn4hh5unFqgXCiKg--.51693S3;
 Tue, 04 Aug 2026 18:10:04 +0800 (CST)
From: oushixiong1025@163.com
To: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 2/2] drm/sched: Set mock device in KUnit test scheduler
Date: Tue,  4 Aug 2026 18:09:56 +0800
Message-Id: <20260804100956.780316-2-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260804100956.780316-1-oushixiong1025@163.com>
References: <20260804100956.780316-1-oushixiong1025@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgDn4hh5unFqgXCiKg--.51693S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyUKryfCFy3CF4xKr43trb_yoW8WF4UpF
 ZrZr4YgrWrtFW2gay3u395ZFy3Gw4xC3y7Kr1Dt34fCF1vqFyxJr15KrW7JryxAr4xArWS
 q3Z0gw47Ar1jyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2sjUUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4hzE02pxuny0QAAA3A
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

The DRM scheduler KUnit tests do not set the dev field in
drm_sched_init_args, leaving sched->dev as NULL. This causes
a NULL pointer dereference when the drm_sched_job trace event
fires during test execution, as dev_name(NULL) is called.

Provide a static mock device with init_name set so that trace
events and other code paths that reference sched->dev work
correctly during testing.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
index 14403a762335..d14bcb69e318 100644
--- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
+++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2025 Valve Corporation */
 
+#include <linux/device.h>
+
 #include "sched_tests.h"
 
 /*
@@ -288,12 +290,16 @@ static const struct drm_sched_backend_ops drm_mock_scheduler_ops = {
  */
 struct drm_mock_scheduler *drm_mock_sched_new(struct kunit *test, long timeout)
 {
+	static struct device mock_dev = {
+		.init_name = "drm-mock-device",
+	};
 	struct drm_sched_init_args args = {
 		.ops		= &drm_mock_scheduler_ops,
 		.credit_limit	= U32_MAX,
 		.hang_limit	= 1,
 		.timeout	= timeout,
 		.name		= "drm-mock-scheduler",
+		.dev		= &mock_dev,
 	};
 	struct drm_mock_scheduler *sched;
 	int ret;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

