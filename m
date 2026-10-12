Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887A5CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C489E10F087;
	Mon, 12 Oct 2026 13:00:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 26F5310F087
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:00:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 685B61A00;
 Mon, 12 Oct 2026 06:00:02 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71D643F66F;
 Mon, 12 Oct 2026 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791810005; bh=0XK4Sh6FpW40ECLF40/dTs4Z7JBcexbzlxyt6d0Q/SE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cUPkWs2y+W9Nvi5qiDXFR/paUUe3abraXdfy/Ay3i24ZHy/QnRAzMf024GH+tCheh
 eTG9AkG+W4TdZa9wOS/vqNxNA/hNrN/dY01s5O6/Nx0W6IbnPr7U1qc/hoT6BYokq9
 RvLZ+dkAvJQZWZr3gLQUCJG92H2A4DXdOBbKBVqk=
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
Subject: [PATCH v4 04/12] drm/panthor: Don't allocate protm_suspend_buf
Date: Mon, 12 Oct 2026 14:59:32 +0200
Message-ID: <20261012125940.3291951-5-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012125940.3291951-1-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 3bd6be9407097..db801705f0d27 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3641,9 +3641,11 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
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

