Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8FA606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a4LTnl/U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B30B710E3A7;
	Sat, 21 Nov 2026 09:57:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7029E10E3A5;
 Sat, 21 Nov 2026 09:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795255056; x=1826791056;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=G4pbtfdvN+5JkvK3sNDxdWk/EAzihJACbs62h1aSgbA=;
 b=a4LTnl/UWGGwi5lWKiIhfW9QjRWDvZqJbcvNPb9Ktfy9pmdI3ZcxozJy
 tchqYYfjG6Tjb4QwqvjpXGtmCB52M5QzZR6TOfnoCMCTexFpJNt0dwSuX
 MxIRNK6uqUziCOAw+qFKthkzrE3liZqIj1L4lvwit+p5O6NwcgtEV9TWP
 897Ns4fgt1vgHbHdEY3MprqTJZDruSp1hXiyrfJ7nzHecRBGJqJuI741M
 3joZd+yUkdjAGkaNiEpQAplaifhpKOE4WNmXM/B+LA/lOkJHmwLrMTOGU
 Bf/xNAT4EHpt7RrN6q8lYcLrPizDvbK14dQAbl8gEABhB5poo8t0iAVS1 g==;
X-CSE-ConnectionGUID: 3H0JTmEDQXisL2F9lNbfnA==
X-CSE-MsgGUID: M/QzZ0XZQ1S5CRx9p30lWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4115712"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4115712"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2026 01:57:35 -0800
X-CSE-ConnectionGUID: GgZI4avdQPi6+m4nF9qBRA==
X-CSE-MsgGUID: 6Y0OD3+hSo2jPOwZCXgq+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; d="scan'208";a="10970011"
Received: from cyp05.fm.intel.com ([10.36.55.41])
 by fmviesa005.fm.intel.com with ESMTP; 21 Nov 2026 01:57:34 -0800
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>, intel-xe@lists.freedesktop.org,
 Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/ttm: Don't warn on oversized page directory allocations
Date: Sat, 21 Nov 2026 01:57:00 -0800
Message-ID: <20261121095703.1571697-2-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The page directory size in ttm_tt_alloc_page_directory() and
ttm_dma_tt_alloc_page_directory() comes from the user-supplied BO size.
kvmalloc() warns on requests above INT_MAX unless __GFP_NOWARN is set,
so userspace can trigger a WARN (or a panic with panic_on_warn) by
creating a huge BO, e.g. a 1 TiB sysmem BO on xe with DEFER_BACKING:

  WARNING: mm/slub.c:7144 at __kvmalloc_node_noprof+0x665/0x810
  Call Trace:
   ttm_tt_init+0x1e0/0x2b0
   xe_ttm_tt_create+0x2cf/0x4b0 [xe]
   ttm_tt_create+0x17c/0x310
   ...
   xe_gem_create_ioctl+0x70f/0x12b0 [xe]

The failure is already handled and the ioctl returns -ENOMEM, so pass
__GFP_NOWARN to both allocations.

v2 (Sashiko):
  - Also pass __GFP_NOWARN in ttm_sg_tt_alloc_page_directory(), whose
    size comes from an imported dma-buf

Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/ttm/ttm_tt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index b645a1818184..7d6c9247507b 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -117,7 +117,8 @@ EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_tt_create);
  */
 static int ttm_tt_alloc_page_directory(struct ttm_tt *ttm)
 {
-	ttm->pages = kvcalloc(ttm->num_pages, sizeof(void*), GFP_KERNEL);
+	ttm->pages = kvcalloc(ttm->num_pages, sizeof(void *),
+			      GFP_KERNEL | __GFP_NOWARN);
 	if (!ttm->pages)
 		return -ENOMEM;
 
@@ -127,7 +128,8 @@ static int ttm_tt_alloc_page_directory(struct ttm_tt *ttm)
 static int ttm_dma_tt_alloc_page_directory(struct ttm_tt *ttm)
 {
 	ttm->pages = kvcalloc(ttm->num_pages, sizeof(*ttm->pages) +
-			      sizeof(*ttm->dma_address), GFP_KERNEL);
+			      sizeof(*ttm->dma_address),
+			      GFP_KERNEL | __GFP_NOWARN);
 	if (!ttm->pages)
 		return -ENOMEM;
 
@@ -137,7 +139,8 @@ static int ttm_dma_tt_alloc_page_directory(struct ttm_tt *ttm)
 
 static int ttm_sg_tt_alloc_page_directory(struct ttm_tt *ttm)
 {
-	ttm->dma_address = kvzalloc_objs(*ttm->dma_address, ttm->num_pages);
+	ttm->dma_address = kvzalloc_objs(*ttm->dma_address, ttm->num_pages,
+					 GFP_KERNEL | __GFP_NOWARN);
 	if (!ttm->dma_address)
 		return -ENOMEM;
 

base-commit: 61df0d1929e7e99d38404a1be02c461a8f6a3f5a
-- 
2.43.0

