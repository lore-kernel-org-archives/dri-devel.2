Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E38DC9831C
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 057FE10F47A;
	Thu, 24 Sep 2026 11:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lRSHosIY";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D372710F477
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790247889;
 bh=haNaa1vTgpxyTcCfqXXR41IYwfwITsSUh39XMWGczo8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lRSHosIYzYj774CP8Xo/cJWcvQQCN9W8iBZfJ+6qK3+o1sv5yC7ENLvUWsEf3fQ4r
 Y6WWNga0wFquCVbyhCqMkh+QghMtTItG8EsXVdteIrQms8yp+KmPqsiOsmUUxzmqQD
 6bcQs5vAjYf/LaPugns9OOuq8/znZjn7kTnQpVJofGo75KStzcQzJkUzoNk10BfwJ3
 2AnvYygGH/2PqxdaZvkWIQeHTR4rwZnuHrLZAv3R1u/GQDOrjxViJwvij26p/Zdejc
 5wWjW+sJM+hW/istAGR6mXj7jVSBb/TqZNLmrwVi87aY8tfMj5W8XSPK+zYv9pVOVG
 ve092JP/d35tg==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 36FF017E0D5D;
 Thu, 24 Sep 2026 13:04:49 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 24 Sep 2026 13:04:42 +0200
Subject: [PATCH v2 5/5] drm/panthor: Remove redundant
 panthor_fix_sparse_map_offset() call
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-panthor-fix-partial-unmap-v2-5-59a68a1f9e14@collabora.com>
References: <20260924-panthor-fix-partial-unmap-v2-0-59a68a1f9e14@collabora.com>
In-Reply-To: <20260924-panthor-fix-partial-unmap-v2-0-59a68a1f9e14@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Akash Goel <akash.goel@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790247886; l=2164;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=haNaa1vTgpxyTcCfqXXR41IYwfwITsSUh39XMWGczo8=;
 b=eMMbyP6t2Qzi8/4M0Ex9oQq2+t4AYFS4pSN1SCSJTLJweJK7ouqPPlzH05Y4iH9GUFntsKJVW
 yiE9zh6eurPAA0Hlhw6t4JbsHFxE4vT5BaGRvgr1ijjRKuqXAjGIPIa
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

op->remap.next->gem.offset is adjusted twice in
panthor_gpuva_sm_step_remap() (once on the remap.next object, and once on
the local map_op). Let's do it only once, and move this adjusment closer
to the place it matters.

Reported-by: Akash Goel <akash.goel@arm.com>
Closes: https://lore.kernel.org/dri-devel/b85679e3-5ca2-4d36-8675-2b968d97cb5b@arm.com/
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 01564d250adf..d8fb29ace5c4 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2397,11 +2397,6 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 
 	drm_gpuva_op_remap_to_unmap_range(&op->remap, &unmap_start, &unmap_range);
 
-	/* op->remap.prev's BO offset is always the same as the unmap va's, but
-	 * that of op->remap.next must be adjusted so as to remain < SZ_2M
-	 */
-	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
-
 	if (!unmap_vma->evicted) {
 		/*
 		 * ARM IOMMU page table management code disallows partial unmaps of huge pages,
@@ -2447,6 +2442,12 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 		u64 addr = op->remap.next->va.addr;
 		u64 size = unmap_start + unmap_range - op->remap.next->va.addr;
 
+		/* op->remap.prev's BO offset is always the same as the unmap
+		 * va's, but that of op->remap.next must be adjusted so as to
+		 * remain < SZ_2M
+		 */
+		panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
+
 		if (!unmap_vma->evicted && size > 0) {
 			struct drm_gpuva_op_map map_op = {
 				.va.addr = addr,
@@ -2454,7 +2455,6 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 				.gem.obj = op->remap.next->gem.obj,
 				.gem.offset = op->remap.next->gem.offset,
 			};
-			panthor_fix_sparse_map_offset(&map_op, unmap_vma->flags);
 
 			ret = panthor_vm_exec_map_op(vm, unmap_vma->flags, &map_op);
 			if (ret)

-- 
2.55.0

