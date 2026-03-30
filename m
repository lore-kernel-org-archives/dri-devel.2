Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CD6FB3CE5
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6AF10E53C;
	Mon, 30 Mar 2026 09:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="fcS5/uIs";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E901910E5AC
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774864143;
 bh=+WUXWSj6IIqWB5y4LtoPHS9q0jL9dgUcCPQbcoiHHQo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fcS5/uIsTnn+2aTQixu3x2KvFFZtSSElmalSb2a2MW00SD/WzdIA9TelyMIGqwDBB
 eXfCIaj8Dis/V50gcEg5xIqWv1s5eZgppFH0ZRSqMyKnsDl8CuLgYJ6xvF8Aid5RGM
 BBcnMUtX1ojK/daiegdOW6iL3KbbHF9I5zZIVKVSaG1nv8h1FLQc4P0BPKZNMJiFlQ
 9n8oMe55i8lkCPhqB9M4siMusyFKg6TWRisEA/MkrATjSty75NLRiJrl0mRT3WL/fg
 f5hnnaNEy3SiTM34/6JPDmusRT11VZJ8+rO2ZwaYqWhwNtlR8yq+S+hpss6wQ7vmM8
 UDNZTaS/dHslQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:a2a7:f53:ebb0:945e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EDAF717E41BE;
 Mon, 30 Mar 2026 11:49:02 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Chris Diamand <chris.diamand@arm.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Chia-I Wu <olvaffe@gmail.com>,
 kernel@collabora.com
Subject: [PATCH v6 6/9] drm/panthor: Lazily allocate pages on mmap()
Date: Mon, 30 Mar 2026 11:48:45 +0200
Message-ID: <20260330094848.2169422-7-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330094848.2169422-1-boris.brezillon@collabora.com>
References: <20260330094848.2169422-1-boris.brezillon@collabora.com>
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

Defer pages allocation until their first access.

v2:
- Don't deal with FAULT_FLAG_INTERRUPTIBLE
- Make sure bo->backing.pages is never an ERR_PTR()
- Drop a useless vm_fault_t local var
- Fix comment in panthor_gem_fault()

v3:
- Collect R-bs

v4:
- No changes

v5:
- No changes

v6:
- Fix huge_fault handling

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 118 ++++++++++++++++----------
 1 file changed, 75 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 0723a0dc0127..d9c3a71da29b 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -604,15 +604,6 @@ static int panthor_gem_mmap(struct drm_gem_object *obj, struct vm_area_struct *v
 	if (is_cow_mapping(vma->vm_flags))
 		return -EINVAL;
 
-	dma_resv_lock(obj->resv, NULL);
-	ret = panthor_gem_backing_get_pages_locked(bo);
-	if (!ret)
-		ret = panthor_gem_prep_for_cpu_map_locked(bo);
-	dma_resv_unlock(obj->resv);
-
-	if (ret)
-		return ret;
-
 	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 	if (should_map_wc(bo))
@@ -653,35 +644,95 @@ static vm_fault_t insert_page(struct vm_fault *vmf, unsigned int order, struct p
 	return VM_FAULT_FALLBACK;
 }
 
+static vm_fault_t nonblocking_page_setup(struct vm_fault *vmf,
+					 unsigned int order,
+					 pgoff_t page_offset)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct panthor_gem_object *bo = to_panthor_bo(vma->vm_private_data);
+	vm_fault_t ret;
+
+	if (!dma_resv_trylock(bo->base.resv))
+		return VM_FAULT_RETRY;
+
+	if (bo->backing.pages)
+		ret = insert_page(vmf, order, bo->backing.pages[page_offset]);
+	else
+		ret = VM_FAULT_RETRY;
+
+	dma_resv_unlock(bo->base.resv);
+	return ret;
+}
+
+static vm_fault_t blocking_page_setup(struct vm_fault *vmf, unsigned int order,
+				      struct panthor_gem_object *bo,
+				      pgoff_t page_offset, bool mmap_lock_held)
+{
+	vm_fault_t ret;
+	int err;
+
+	err = dma_resv_lock_interruptible(bo->base.resv, NULL);
+	if (err)
+		return mmap_lock_held ? VM_FAULT_NOPAGE : VM_FAULT_RETRY;
+
+	err = panthor_gem_backing_get_pages_locked(bo);
+	if (!err)
+		err = panthor_gem_prep_for_cpu_map_locked(bo);
+
+	if (err) {
+		ret = mmap_lock_held ? VM_FAULT_SIGBUS : VM_FAULT_RETRY;
+	} else {
+		struct page *page = bo->backing.pages[page_offset];
+
+		if (mmap_lock_held)
+			ret = insert_page(vmf, order, page);
+		else
+			ret = VM_FAULT_RETRY;
+	}
+
+	dma_resv_unlock(bo->base.resv);
+
+	return ret;
+}
+
 static vm_fault_t panthor_gem_any_fault(struct vm_fault *vmf, unsigned int order)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct drm_gem_object *obj = vma->vm_private_data;
 	struct panthor_gem_object *bo = to_panthor_bo(vma->vm_private_data);
-	loff_t num_pages = obj->size >> PAGE_SHIFT;
-	vm_fault_t ret;
+	loff_t num_pages = bo->base.size >> PAGE_SHIFT;
 	pgoff_t page_offset;
+	vm_fault_t ret;
 
 	if (order && order != PMD_ORDER)
 		return VM_FAULT_FALLBACK;
 
 	/* Offset to faulty address in the VMA. */
 	page_offset = vmf->pgoff - vma->vm_pgoff;
+	if (page_offset >= num_pages)
+		return VM_FAULT_SIGBUS;
 
-	dma_resv_lock(bo->base.resv, NULL);
+	ret = nonblocking_page_setup(vmf, order, page_offset);
+	if (ret != VM_FAULT_RETRY)
+		return ret;
 
-	if (page_offset >= num_pages ||
-	    drm_WARN_ON_ONCE(obj->dev, !bo->backing.pages)) {
-		ret = VM_FAULT_SIGBUS;
-		goto out;
+	/* Check if we're allowed to retry. */
+	if (fault_flag_allow_retry_first(vmf->flags)) {
+		/* If we're allowed to retry but not wait here, return
+		 * immediately, the wait will be done when the fault
+		 * handler is called again, with the mmap_lock held.
+		 */
+		if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
+			return VM_FAULT_RETRY;
+
+		/* Wait with the mmap lock released, if we're allowed to. */
+		drm_gem_object_get(&bo->base);
+		mmap_read_unlock(vmf->vma->vm_mm);
+		ret = blocking_page_setup(vmf, order, bo, page_offset, false);
+		drm_gem_object_put(&bo->base);
+		return ret;
 	}
 
-	ret = insert_page(vmf, order, bo->backing.pages[page_offset]);
-
- out:
-	dma_resv_unlock(bo->base.resv);
-
-	return ret;
+	return blocking_page_setup(vmf, order, bo, page_offset, true);
 }
 
 static vm_fault_t panthor_gem_fault(struct vm_fault *vmf)
@@ -689,31 +740,12 @@ static vm_fault_t panthor_gem_fault(struct vm_fault *vmf)
 	return panthor_gem_any_fault(vmf, 0);
 }
 
-static void panthor_gem_vm_open(struct vm_area_struct *vma)
-{
-	struct panthor_gem_object *bo = to_panthor_bo(vma->vm_private_data);
-
-	drm_WARN_ON(bo->base.dev, drm_gem_is_imported(&bo->base));
-
-	dma_resv_lock(bo->base.resv, NULL);
-
-	/* We should have already pinned the pages when the buffer was first
-	 * mmap'd, vm_open() just grabs an additional reference for the new
-	 * mm the vma is getting copied into (ie. on fork()).
-	 */
-	drm_WARN_ON_ONCE(bo->base.dev, !bo->backing.pages);
-
-	dma_resv_unlock(bo->base.resv);
-
-	drm_gem_vm_open(vma);
-}
-
 static const struct vm_operations_struct panthor_gem_vm_ops = {
 	.fault = panthor_gem_fault,
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	.huge_fault = panthor_gem_any_fault,
 #endif
-	.open = panthor_gem_vm_open,
+	.open = drm_gem_vm_open,
 	.close = drm_gem_vm_close,
 };
 
-- 
2.53.0

