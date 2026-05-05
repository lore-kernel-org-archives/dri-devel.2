Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40FDCD3441
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75FE10E457;
	Tue,  5 May 2026 14:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ueNYOVD9";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3D1FB10E457
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:05:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61DEC24C0;
 Tue,  5 May 2026 07:05:51 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40ACC3F763;
 Tue,  5 May 2026 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777989956; bh=C/HPVhAFNazZLtwqgmXIczamjt4yPbAq/jYAjnd19+Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ueNYOVD9kubk4sYtRy9DR4f5wtZSWKw5rtSXMp4ZLjhwgwh+PGLr/5j+wnjkNYR0e
 43fSiim7+DW2GxEZ1FFtajXYSiMT0yg41SnB/LR8RK/+ubBqvc+l6kVEdkRcAOU9d0
 bL17Dwe0tuiIVK5IbFF8rMoz4zVG6E1olq+7461A=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH 6/8] drm/panthor: Explicit expansion of locked VM region
Date: Tue,  5 May 2026 16:05:12 +0200
Message-ID: <20260505140516.1372388-7-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505140516.1372388-1-ketil.johnsen@arm.com>
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
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

Currently the panthor_vm_lock_region() function will implicitly expand
an already locked VM region. This can be problematic because the caller
do not reliably know if it needs to call panthor_vm_unlock_region()
or not.

Worth noting, there is currently no known issues with this as the code
is written today.

This change introduces panthor_vm_expand_region() which will only work
if there is already a locked VM region. This again means that the
original lock and unlock functions can work as a pair. This pairing is
needed for subsequent protected memory changes.

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 69 +++++++++++++++++++--------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index fc930ee158a52..07f54176ec1bf 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1701,15 +1701,36 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	struct panthor_device *ptdev = vm->ptdev;
 	int ret = 0;
 
-	/* sm_step_remap() can call panthor_vm_lock_region() to account for
-	 * the wider unmap needed when doing a partial huge page unamp. We
-	 * need to ignore the lock if it's already part of the locked region.
-	 */
-	if (start >= vm->locked_region.start &&
-	    start + size <= vm->locked_region.start + vm->locked_region.size)
-		return 0;
+	if (drm_WARN_ON(&ptdev->base, vm->locked_region.size))
+		return -EINVAL;
+
+	mutex_lock(&ptdev->mmu->as.slots_lock);
+	if (vm->as.id >= 0 && size) {
+		/* Lock the region that needs to be updated */
+		gpu_write64(ptdev, AS_LOCKADDR(vm->as.id),
+			    pack_region_range(ptdev, &start, &size));
+
+		/* If the lock succeeded, update the locked_region info. */
+		ret = as_send_cmd_and_wait(ptdev, vm->as.id, AS_COMMAND_LOCK);
+	}
 
-	/* sm_step_remap() may need a locked region that isn't a strict superset
+	if (!ret) {
+		vm->locked_region.start = start;
+		vm->locked_region.size = size;
+	}
+	mutex_unlock(&ptdev->mmu->as.slots_lock);
+
+	return ret;
+}
+
+static int panthor_vm_expand_region(struct panthor_vm *vm, u64 start, u64 size)
+{
+	struct panthor_device *ptdev = vm->ptdev;
+	u64 end;
+	int ret = 0;
+
+	/* This function is here to handle the following case:
+	 * sm_step_remap() may need a locked region that isn't a strict superset
 	 * of the original one because of having to extend unmap boundaries beyond
 	 * it to deal with partial unmaps of transparent huge pages. What we want
 	 * in those cases is to lock the union of both regions. The new region must
@@ -1717,16 +1738,24 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	 * boundaries in a remap operation can only shift up or down respectively,
 	 * but never otherwise.
 	 */
-	if (vm->locked_region.size) {
-		u64 end = max(vm->locked_region.start + vm->locked_region.size,
-			      start + size);
 
-		drm_WARN_ON_ONCE(&vm->ptdev->base, (start + size <= vm->locked_region.start) ||
-				 (start >= vm->locked_region.start + vm->locked_region.size));
+	/* This function can only expand an already locked region */
+	if (drm_WARN_ON(&ptdev->base, !vm->locked_region.size))
+		return -EINVAL;
 
-		start = min(start, vm->locked_region.start);
-		size = end - start;
-	}
+	/* Early out if requested range is already locked */
+	if (start >= vm->locked_region.start &&
+	    start + size <= vm->locked_region.start + vm->locked_region.size)
+		return 0;
+
+	end = max(vm->locked_region.start + vm->locked_region.size,
+		  start + size);
+
+	drm_WARN_ON_ONCE(&ptdev->base, (start + size <= vm->locked_region.start) ||
+			 (start >= vm->locked_region.start + vm->locked_region.size));
+
+	start = min(start, vm->locked_region.start);
+	size = end - start;
 
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
@@ -2252,11 +2281,13 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
 
 	/* If the range changed, we might have to lock a wider region to guarantee
-	 * atomicity. panthor_vm_lock_region() bails out early if the new region
-	 * is already part of the locked region, so no need to do this check here.
+	 * atomicity.
 	 */
 	if (!unmap_vma->evicted) {
-		panthor_vm_lock_region(vm, unmap_start, unmap_range);
+		ret = panthor_vm_expand_region(vm, unmap_start, unmap_range);
+		if (ret)
+			return ret;
+
 		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
 	}
 
-- 
2.43.0

