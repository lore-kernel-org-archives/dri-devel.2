Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F0AC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 13:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354E210E473;
	Sun, 12 Jul 2026 13:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Th/BurNM";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 38E7F10E473
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 13:55:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B8071688;
 Sun, 12 Jul 2026 06:54:58 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E9E83F7D8;
 Sun, 12 Jul 2026 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783864502; bh=BHBRdDyZsgGf3EjWM4xIGTLZE0SyBofZQ7alSwO1G9Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Th/BurNMFudU+nbSDtGLhH4Ontmh6OVDUBBUVQ9CS5YjRLNNvG9Jp7iMP+yypDGOF
 RYuhIVQXU8dL+QkWGYUHuO1IuUSUenoittb2XT5Sj8MWPEruuyB5izrI0K5gTYKqnK
 9cu8lqVfdAHipl1KAsulcg6i9v8BrrGtRf0UAGCk=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH v2 5/7] drm/panthor: Don't allocate protm_suspend_buf
Date: Sun, 12 Jul 2026 15:54:37 +0200
Message-ID: <20260712135439.1546950-6-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260712135439.1546950-1-ketil.johnsen@arm.com>
References: <20260712135439.1546950-1-ketil.johnsen@arm.com>
MIME-Version: 1.0
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

The PROTM suspend buffer is only needed if the group is going to
use PROTM in the first place, so let's not assume we need one until
we're being asked to.

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index dc77a174a3368..86c0f12b09e11 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3642,9 +3642,11 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
 	if (drm_WARN_ON(&ptdev->base, ptdev != group->ptdev))
 		return;
 
-	group->fdinfo.kbo_sizes += group->suspend_buf->obj->size;
-	group->fdinfo.kbo_sizes += group->protm_suspend_buf->obj->size;
 	group->fdinfo.kbo_sizes += group->syncobjs->obj->size;
+	group->fdinfo.kbo_sizes += group->suspend_buf->obj->size;
+
+	if (group->protm_suspend_buf)
+		group->fdinfo.kbo_sizes += group->protm_suspend_buf->obj->size;
 
 	for (i = 0; i < group->queue_count; i++) {
 		queue =	group->queues[i];
@@ -3724,14 +3726,6 @@ int panthor_group_create(struct drm_file *file,
 		goto err_put_group;
 	}
 
-	suspend_size = csg_iface->control->protm_suspend_size;
-	group->protm_suspend_buf = panthor_fw_alloc_suspend_buf_mem(ptdev, suspend_size);
-	if (IS_ERR(group->protm_suspend_buf)) {
-		ret = PTR_ERR(group->protm_suspend_buf);
-		group->protm_suspend_buf = NULL;
-		goto err_put_group;
-	}
-
 	group->syncobjs = panthor_kernel_bo_create(ptdev, group->vm,
 						   group_args->queues.count *
 						   sizeof(struct panthor_syncobj_64b),
-- 
2.43.0

