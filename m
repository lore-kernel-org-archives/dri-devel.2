Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6953C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09CB710E58F;
	Thu, 23 Jul 2026 10:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KC7bkzr3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8929910E495;
 Thu, 23 Jul 2026 10:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784801063; x=1816337063;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Zp2zjRlEvckKg9VI/3+sNo4w7X6/TyKXFfHRa8YX7aE=;
 b=KC7bkzr3RUah5C0/v3qRgXT9RwzGToEPb+q6IXAXxgCMkrTsglYihSfE
 7tYu9kRkEveiwMweryrK+zytetp53ytK9rCVVqUBZeQVpz74xBZHPdoHI
 UeSXibuiXzqmFKqjSbdQytF3jT9t+t8Rb41UEG5Sz/Pax0rpdkc0eRhDn
 HvCKAqSbf9xQ4ZeBAPV17M26881kouJVQigGfdxj5uwoV90XtbzGxEAau
 HObJeGuur4rxKsBw5UHjI/oEMLjQETagXJzUzKK/ZgVR8X+/TS4K8aRX/
 Eo17k4PpG/ToQ/bxYTODdqwmhm8M0oyDdUAlU7qFR0Qjz/8FZouoSCFhh A==;
X-CSE-ConnectionGUID: Ysniy43CTsC2xjXKZBS9eA==
X-CSE-MsgGUID: q4DScn4BT8mQfkpzZth+OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="87991856"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="87991856"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:04:23 -0700
X-CSE-ConnectionGUID: JZsi+HLORwG6+nPXFDCYfw==
X-CSE-MsgGUID: +cmy2FnKSv6Z/BCEEXNptg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="254984853"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO fedora)
 ([10.245.244.122])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:04:17 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Sashiko-bot <sashiko-bot@kernel.org>,
 Friedrich Vock <friedrich.vock@gmx.de>,
 Maarten Lankhorst <dev@lankhorst.se>, Tejun Heo <tj@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/6] drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()
Date: Thu, 23 Jul 2026 12:03:45 +0200
Message-ID: <20260723100350.16895-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723100350.16895-1-thomas.hellstrom@linux.intel.com>
References: <20260723100350.16895-1-thomas.hellstrom@linux.intel.com>
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
Cc: <stable@vger.kernel.org> # v6.14+
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 2a241a5b12c4..ac3f71d77140 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -918,9 +918,6 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	struct ttm_resource_manager *man = &mgr->manager;
 	int err;
 
-	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
-	if (IS_ERR(man->cg))
-		return PTR_ERR(man->cg);
 	ttm_resource_manager_init(man, &adev->mman.bdev,
 				  adev->gmc.real_vram_size);
 
@@ -935,6 +932,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	if (err)
 		return err;
 
+	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
+	if (IS_ERR(man->cg))
+		return PTR_ERR(man->cg);
+
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
 	return 0;
-- 
2.55.0

