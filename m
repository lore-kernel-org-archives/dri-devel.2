Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B03C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F66410E1C0;
	Wed,  9 Sep 2026 11:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mIXo1KEc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2460810E1C0;
 Wed,  9 Sep 2026 11:47:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 436E860120;
 Wed,  9 Sep 2026 11:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCE71F00A3A;
 Wed,  9 Sep 2026 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1788954445;
 bh=z6z+pLAb/s5MlRCV9V2eTOzLbl55cogNJG5WC4FpWgQ=;
 h=Subject:To:Cc:From:Date;
 b=mIXo1KEcDRBJUUQAtkc4EzQx5jIyUYCyspHYpK5IFYhUxNWWgMqDS9szq3TcbWTBO
 yZoIbcPql55137LqyD1ddj/PN76rKXXXqdpouuIoq/Qsf+dEGLg6L0alqHroW0XEhL
 gE6SnK6o/nxZkyxVLty1pDcbm+jgPQ9FFeVGJMpo=
Subject: Patch "drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()" has
 been added to the 6.18-stable tree
To: Arunpravin.PaneerSelvam@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, cascardo@igalia.com, christian.koenig@amd.com,
 dev@lankhorst.se, dri-devel@lists.freedesktop.org, friedrich.vock@gmx.de,
 gregkh@linuxfoundation.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sashiko-bot@kernel.org, thomas.hellstrom@linux.intel.com,
 tj@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:30:37 +0200
Message-ID: <2026090937-mangle-cinema-f62f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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


This is a note to let you know that I've just added the patch titled

    drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amdgpu-fix-init-ordering-in-amdgpu_vram_mgr_init.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From e773798e14ac0aea54ca9676083b91f445e5bc59 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Date: Sat, 25 Jul 2026 12:00:31 +0200
Subject: drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit e773798e14ac0aea54ca9676083b91f445e5bc59 upstream.

drmm_cgroup_register_region() is called before INIT_LIST_HEAD() and
gpu_buddy_init() in amdgpu_vram_mgr_init(). If it fails, the function
returns early and bypasses those initializations.

Since adev->mman.initialized is set to true before amdgpu_vram_mgr_init()
is called, a failure triggers amdgpu_ttm_fini(), which calls
amdgpu_vram_mgr_fini(), which then:

 - Calls list_for_each_entry_safe() on reservations_pending and
   reserved_pages, whose list_head::next pointers are zero-initialized
   (NULL). The loop does not recognize them as empty and dereferences NULL.

 - Calls gpu_buddy_fini(), which iterates free_trees[] unconditionally
   via for_each_free_tree(). Since mm->free_trees is NULL
   (never allocated), this dereferences NULL.

Both result in a kernel panic on the module load error path.

Fix by moving drmm_cgroup_register_region() to after the list and buddy
allocator are fully initialized, so the teardown path is safe to run.

Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260428073116.15687-1-thomas.hellstrom@linux.intel.com?part=4
Fixes: 2b624a2c1865 ("drm/ttm: Handle cgroup based eviction in TTM")
Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>
Cc: Tejun Heo <tj@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org # v6.14+
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-By: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Link: https://patch.msgid.link/20260725100036.2372-2-thomas.hellstrom@linux.intel.com
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -918,9 +918,6 @@ int amdgpu_vram_mgr_init(struct amdgpu_d
 	struct ttm_resource_manager *man = &mgr->manager;
 	int err;
 
-	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
-	if (IS_ERR(man->cg))
-		return PTR_ERR(man->cg);
 	ttm_resource_manager_init(man, &adev->mman.bdev,
 				  adev->gmc.real_vram_size);
 
@@ -935,6 +932,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_d
 	if (err)
 		return err;
 
+	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
+	if (IS_ERR(man->cg))
+		return PTR_ERR(man->cg);
+
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
 	return 0;


Patches currently in stable-queue which might be from thomas.hellstrom@linux.intel.com are

queue-6.18/drm-amdgpu-fix-init-ordering-in-amdgpu_vram_mgr_init.patch
