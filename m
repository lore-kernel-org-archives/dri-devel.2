Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D3ACDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCCB710E9BF;
	Tue, 23 Jun 2026 08:06:53 +0000 (UTC)
X-Greylist: delayed 325 seconds by postgrey-1.36 at gabe;
 Mon, 22 Jun 2026 22:03:22 UTC
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7436E10E0D5
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 22:03:22 +0000 (UTC)
Received: by cae.in-ulm.de (Postfix, from userid 1000)
 id 3B08F140033; Mon, 22 Jun 2026 23:57:54 +0200 (CEST)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: dri-devel@lists.freedesktop.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] drm/shmem_helper: Check VMA boundaries for PMD mappings
Date: Mon, 22 Jun 2026 23:57:17 +0200
Message-Id: <20260622215718.1532689-1-lk@c--e.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:06:53 +0000
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

In the ->huge_fault handler do not install a PMD huge page
mapping if the huge page exceeds the boundaries of the VMA.

All other ->huge_fault handlers have similar checks and the
resulting mapping will trigger a VM_BUG_ON_VMA() if it ever
reaches copy_pmd_range().

Cc: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: stable@vger.kernel.org
Fixes: fc3bbf34e643 ("drm/shmem-helper: Fix huge page mapping in fault handler")
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index c989459eb215..00807039f8d7 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -597,9 +597,13 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	} else if (order == PMD_ORDER) {
 		unsigned long paddr = pfn << PAGE_SHIFT;
+		struct vm_area_struct *vma = vmf->vma;
+		unsigned long start = ALIGN_DOWN(vmf->address, PMD_SIZE);
+		unsigned long end = start + PMD_SIZE;
+		bool in_range = vma->vm_start <= start && end <= vma->vm_end;
 		bool aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
 
-		if (aligned &&
+		if (aligned && in_range &&
 		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
 			vm_fault_t ret;
 
-- 
2.43.0

