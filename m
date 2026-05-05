Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D73DCD343B
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 20:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A457A10EBF9;
	Tue,  5 May 2026 20:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BA4538nV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F2210E46F;
 Tue,  5 May 2026 20:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778011489; x=1809547489;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+vdJOqGzlv9/JIZ0U+4WjDwVo9QLi2utFS4WdB91ab0=;
 b=BA4538nV0QJzEsFBdXcw5uKI7xQUBukBF52wflq7N4CKzm7mptEa9B22
 MGPYgRsEeClA1GDXZC92ICEM6AHYqE5B851y79SCgZu/Ul79kvNXzNLg4
 8YkwYM5xBwuS+tQxVcphlEv4bhdO37FouUWMv/LIaEn1i1eTuTGJcH20M
 aPk/0KZhtLP0EypMAWG8IuFTfKU7Lzq54wWdlF7J9IPb5NPGk5SrvJzMj
 yHcnjmCdlA96a8NYmRLUql6WAICpDVkpCdNihmXeHhZw+RWZinNuMD8S3
 0WDe8bAU+hsiBwndzFAR4H0Y2Tv42gC1Mhb5BdE6NPFF4d8q4sgoh/w++ g==;
X-CSE-ConnectionGUID: bLVeJLoJT32gwuKglEFmDw==
X-CSE-MsgGUID: vaRRGB4YT1eQgtzO24qcVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78832983"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="78832983"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 13:04:48 -0700
X-CSE-ConnectionGUID: ZmTOZyjESW6BlhoB2HoqUg==
X-CSE-MsgGUID: KMLQV+y/TGy2dxm6Nrxkww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="232786509"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 13:04:48 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v5 1/2] drm/ttm: Drop tt->restore after successful restore
Date: Tue,  5 May 2026 13:04:42 -0700
Message-Id: <20260505200443.3300962-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505200443.3300962-1-matthew.brost@intel.com>
References: <20260505200443.3300962-1-matthew.brost@intel.com>
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

ttm_pool_restore_and_alloc() can successfully complete the restore
process via ttm_pool_restore_commit(), but tt->restore is not dropped
afterward. As a result, subsequent backup/restore flows observe what
appears to be a completed restore, while in reality shmem handles are
still installed in tt->pages, leading to the stack trace below.

Fix this by freeing and dropping tt->restore in
ttm_pool_restore_and_alloc() upon successful completion of the restore.

20545 [  309.784531] RIP: 0010:sg_alloc_append_table_from_pages+0x38c/0x490
20547 [  309.809570] RSP: 0018:ffffc9000623b838 EFLAGS: 00010206
20548 [  309.814827] RAX: 0000000000001000 RBX: ffff88816e42a160 RCX: 0000000000000000
20549 [  309.821986] RDX: 0000000000002000 RSI: 0000000000000003 RDI: 0000000000001000
20550 [  309.829147] RBP: ffff88816e42a168 R08: 0000000000000002 R09: 000000007ffff000
20551 [  309.836310] R10: ffffc9000623b928 R11: 0000000000000000 R12: 000000007ffff000
20552 [  309.843471] R13: ffff88815ba5a100 R14: 0000000000000000 R15: 0000000000000001
20553 [  309.850634] FS:  00007f9ff305e700(0000) GS:ffff888276c94000(0000) knlGS:0000000000000000
20554 [  309.858749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
20555 [  309.864519] CR2: 00007f9fca701000 CR3: 00000001565e2005 CR4: 0000000008f70ef0
20556 [  309.871678] PKRU: 55555558
20557 [  309.874403] Call Trace:
20558 [  309.876866]  <TASK>
20559 [  309.878988]  sg_alloc_table_from_pages_segment+0x60/0x100
20560 [  309.884415]  ? ttm_resource_manager_usage+0x36/0x60 [ttm]
20561 [  309.889845]  ? xe_tt_map_sg+0x7d/0xd0 [xe]
20562 [  309.894045]  xe_tt_map_sg+0x7d/0xd0 [xe]
20563 [  309.898037]  xe_bo_move+0x927/0xaa0 [xe]
20564 [  309.902029]  ttm_bo_handle_move_mem+0xba/0x170 [ttm]
20565 [  309.907022]  ttm_bo_validate+0xbe/0x190 [ttm]
20566 [  309.911405]  xe_bo_validate+0x9a/0x120 [xe]
20567 [  309.915663]  xe_gpuvm_validate+0xd9/0x140 [xe]
20568 [  309.920206]  drm_gpuvm_validate+0x2f0/0x5b0 [drm_gpuvm]
20569 [  309.925459]  ? drm_exec_lock_obj+0x63/0x210 [drm_exec]
20570 [  309.930627]  xe_vm_validate_rebind+0x46/0xb0 [xe]
20571 [  309.935428]  xe_exec_fn+0x20/0x40 [xe]
20572 [  309.939249]  drm_gpuvm_exec_lock+0x78/0xc0 [drm_gpuvm]
20573 [  309.944410]  xe_validation_exec_lock+0x5a/0xa0 [xe]
20574 [  309.949385]  xe_exec_ioctl+0x806/0xc30 [xe]
20575 [  309.953639]  ? ttwu_queue_wakelist+0xd9/0xf0
20576 [  309.957935]  ? __pfx_xe_exec_fn+0x10/0x10 [xe]
20577 [  309.962449]  ? __wake_up_common+0x73/0xa0
20578 [  309.966482]  ? __pfx_xe_exec_ioctl+0x10/0x10 [xe]
20579 [  309.971263]  drm_ioctl_kernel+0xa3/0x100
20580 [  309.975209]  drm_ioctl+0x213/0x440
20581 [  309.978637]  ? __pfx_xe_exec_ioctl+0x10/0x10 [xe]
20582 [  309.983415]  xe_drm_ioctl+0x67/0xd0 [xe]
20583 [  309.987408]  __x64_sys_ioctl+0x7f/0xd0

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to shrink pages")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

---

v3:
 - Call ttm_pool_apply_caching after freeing local restore (sashiko)
 - Save alloc in snapshot on restore failure (sashiko)
v4:
 - Actual 'Save alloc in snapshot on restore failure (sashiko)'
v5:
 - kfree retore after ttm_pool_apply_caching (sashiko)
---
 drivers/gpu/drm/ttm/ttm_pool.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11ad..d380a3c7fe40 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -902,6 +902,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 {
 	struct ttm_pool_tt_restore *restore = tt->restore;
 	struct ttm_pool_alloc_state alloc;
+	int ret;
 
 	if (WARN_ON(!ttm_tt_is_backed_up(tt)))
 		return -EINVAL;
@@ -925,14 +926,22 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	} else {
 		alloc = restore->snapshot_alloc;
 		if (ttm_pool_restore_valid(restore)) {
-			int ret = ttm_pool_restore_commit(restore, tt->backup,
-							  ctx, &alloc);
+			ret = ttm_pool_restore_commit(restore, tt->backup,
+						      ctx, &alloc);
 
 			if (ret)
 				return ret;
 		}
-		if (!alloc.remaining_pages)
+		if (!alloc.remaining_pages) {
+			ret = ttm_pool_apply_caching(&alloc);
+			if (ret)
+				return ret;
+
+			kfree(tt->restore);
+			tt->restore = NULL;
+
 			return 0;
+		}
 	}
 
 	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
-- 
2.34.1

