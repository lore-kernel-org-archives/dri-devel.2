Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0738ECDB470
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644B710EDC5;
	Wed, 24 Jun 2026 07:47:58 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8A3410E179
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 18:20:27 +0000 (UTC)
Received: by cae.in-ulm.de (Postfix, from userid 1000)
 id B3C15140033; Tue, 23 Jun 2026 20:20:25 +0200 (CEST)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panthor: Check VMA boundaries for PMD mappings
Date: Tue, 23 Jun 2026 20:19:42 +0200
Message-Id: <20260623181942.1536598-1-lk@c--e.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

When checking a different patch[1] sashiko AI pointed out that
panthor needs the same fix[2]:

In the ->huge_fault handler do not install a PMD huge page
mapping if the huge page exceeds the boundaries of the VMA.

[1] https://lore.kernel.org/lkml/20260622215718.1532689-1-lk@c--e.de/
[2] https://sashiko.dev/#/patchset/20260622215718.1532689-1-lk%40c--e.de

Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Fixes: 68cbf96b1e9b ("drm/panthor: Part ways with drm_gem_shmem_object")
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

NOTE:
The panthor version is only compile tested because I don't
have the hardware. However, the code is identical to that
fixed in [1] and I have a reproducer for that.

No need for for stable backports. The code is new in 7.1.

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index a1e2eb1ca7bb..54535bae2b0c 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -802,9 +802,13 @@ static vm_fault_t insert_page(struct vm_fault *vmf, unsigned int order, struct p
 	} else if (order == PMD_ORDER) {
 		unsigned long pfn = page_to_pfn(page);
 		unsigned long paddr = pfn << PAGE_SHIFT;
+		struct vm_area_struct *vma = vmf->vma;
+		unsigned long start = ALIGN_DOWN(vmf->address, PMD_SIZE);
+		unsigned long end = start + PMD_SIZE;
+		bool in_range = vma->vm_start <= start && end <= vma->vm_end;
 		bool aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
 
-		if (aligned &&
+		if (aligned && in_range &&
 		    folio_test_pmd_mappable(page_folio(page))) {
 			pfn &= PMD_MASK >> PAGE_SHIFT;
 			return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
-- 
2.43.0

