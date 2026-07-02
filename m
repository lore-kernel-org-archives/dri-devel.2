Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BB6C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 21:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E0710E512;
	Thu,  2 Jul 2026 21:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TqDsLoRP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005B210E511;
 Thu,  2 Jul 2026 21:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783028903; x=1814564903;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2A4OCL9PO6OKf1xo0SboDzLbLoVNYqX7VoF34UVzdvM=;
 b=TqDsLoRPtH3qe6Lut76wU3RV2GUbpLPMUBtPKNQ5MVe1aG/0w+sVfC6g
 pNSVufokT7aNWLYAFZL7RqX9GMjYsfHxnITOX0xWyDQUuoYpBVQ2lHl9o
 aMxPKz2ofCAQzlkJHsFnF94HabrJqshgCydK07qM3nHgy1WOuAPLZ4cwD
 u2ZdvWTUs1G21mBG+bKzU0h4Wu0o1IYIbn1dbFoVVAe8hpEDs/u97WP7g
 DYeLC4qAt8vdk6XHVJViI2GzGlQFDNSadX8Hee/hare449M/ox9hHBiAo
 PQ/QL361ylGQIM186P2OaXX8+Rrk3r+IehednJ3oLulaxkLJx4BkAPHbu g==;
X-CSE-ConnectionGUID: 67DJp28zQ0Cby0NgQa1kwA==
X-CSE-MsgGUID: IBFCzo7bQYaetI4FiiEoQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="71308875"
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; d="scan'208";a="71308875"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 14:48:23 -0700
X-CSE-ConnectionGUID: 6yjCdr7hRHa+cFFBJiaQjw==
X-CSE-MsgGUID: +VP2jtGLTAeMcN7Syeyo6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; d="scan'208";a="249612085"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 14:48:22 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/ttm: Account for NULL and handle pages in ttm_pool_backup
Date: Thu,  2 Jul 2026 14:48:15 -0700
Message-Id: <20260702214815.4009271-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

Pages in ttm_pool_backup can be NULL or backup handles
(ttm_backup_page_ptr_is_handle()), neither of which can be passed to
set_pages_array_wb() or freed. Add a dedicated WB pass before the
dma/purge loop that walks allocations using the same i += num_pages
stride, skipping NULL and handle entries, and calls set_pages_array_wb()
once per contiguous run of real pages. Apply the same NULL/handle guard
to the dma/purge loop.

Fixes the following oops:

Oops: general protection fault, kernel NULL pointer dereference 0x0: 0000 [#1] SMP NOPTI
RIP: 0010:__cpa_process_fault+0xf8/0x770
RSP: 0018:ffffc90000a87718 EFLAGS: 00010287
RAX: 0000000000000000 RBX: ffffc90000a87868 RCX: 0000000000000000
RDX: 0000000000001000 RSI: 0005088000000000 RDI: ffffffff827c5f34
RBP: 0005088000000000 R08: ffffc90000a877cb R09: ffffc90000a877d0
R10: 0000000000000000 R11: 000000000000001b R12: 000ffffffffff000
R13: ffffc90000a87868 R14: ffffc90000a87868 R15: ffff88815b882ae0
FS:  0000000000000000(0000) GS:ffff8884ec840000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f930b844000 CR3: 000000000262e003 CR4: 0000000008f70ef0
PKRU: 55555554
Call Trace:
 <TASK>
 __change_page_attr_set_clr+0x989/0xe90
 ? __purge_vmap_area_lazy+0x6c/0x3a0
 ? _vm_unmap_aliases+0x250/0x2a0
 set_pages_array_wb+0x7f/0x120
 ttm_pool_backup+0x4c9/0x5b0 [ttm]
 ? dma_resv_wait_timeout+0x3b/0xf0
 ttm_tt_backup+0x32/0x60 [ttm]
 ttm_bo_shrink+0x66/0x110 [ttm]
 xe_bo_shrink_purge+0x12b/0x1b0 [xe]
 xe_bo_shrink+0xbb/0x270 [xe]
 __xe_shrinker_walk+0xf7/0x160 [xe]
 xe_shrinker_walk+0x9d/0xc0 [xe]
 xe_shrinker_scan+0x11f/0x210 [xe]
 do_shrink_slab+0x13b/0x270
 shrink_slab+0xf1/0x400
 shrink_node+0x352/0x8a0
 balance_pgdat+0x32c/0x700
 kswapd+0x205/0x2f0
 ? __pfx_autoremove_wake_function+0x10/0x10
 ? __pfx_kswapd+0x10/0x10
 kthread+0xd1/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1b1/0x200
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to shrink pages")
Cc: stable@vger.kernel.org
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 3d5f2ae0a456..ff043420d517 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1065,9 +1065,31 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 		return -EBUSY;
 
 #ifdef CONFIG_X86
-	/* Anything returned to the system needs to be cached. */
-	if (tt->caching != ttm_cached)
-		set_pages_array_wb(tt->pages, tt->num_pages);
+	/* Anything returned to the system needs to be cached. Walk allocations
+	 * skipping NULL pages and issue set_pages_array_wb() per contiguous run.
+	 */
+	if (tt->caching != ttm_cached) {
+		pgoff_t run_start = 0, run_count = 0;
+
+		for (i = 0; i < tt->num_pages; i += num_pages) {
+			page = tt->pages[i];
+			if (unlikely(!page || ttm_backup_page_ptr_is_handle(page))) {
+				if (run_count) {
+					set_pages_array_wb(&tt->pages[run_start],
+							   run_count);
+					run_count = 0;
+				}
+				num_pages = 1;
+				continue;
+			}
+			num_pages = 1UL << ttm_pool_page_order(pool, page);
+			if (!run_count)
+				run_start = i;
+			run_count += num_pages;
+		}
+		if (run_count)
+			set_pages_array_wb(&tt->pages[run_start], run_count);
+	}
 #endif
 
 	if (tt->dma_address || flags->purge) {
@@ -1075,7 +1097,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 			unsigned int order;
 
 			page = tt->pages[i];
-			if (unlikely(!page)) {
+			if (unlikely(!page || ttm_backup_page_ptr_is_handle(page))) {
 				num_pages = 1;
 				continue;
 			}
-- 
2.34.1

