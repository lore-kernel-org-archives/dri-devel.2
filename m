Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D3606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FJeikBPj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C43F910E125;
	Mon,  9 Nov 2026 05:55:19 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4F3A10E5B4
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 05:55:05 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-8b309147589so4909437b3.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 21:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794203705; x=1794808505; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zBqjQYHOWAuc+JRAQGuIIdlERuoxbenM2VOhg1whkKE=;
 b=FJeikBPjJEzZNv7ZTkhMlbGjXmSPak6UJvSeNtu+C3y6+CZcC6gO9fOZhqfL5br1GO
 vvCeEG/CShN0FaNN8Vrax+YRyxjX/hdygODptf+ybgB7PtQkXZ73uK8jF9lC53q3hvmK
 7oOEgAP+TIKEhreVbOm0fUaI1fAzBKl4qBXBlyC8yrouxsjzlWlSlZ/3qxW0j6Nf4cdg
 1/z197zrXJI2rz6P78qWgIhsYAPWebS9+6ld/FZpEGd87rtrzdN80nj/YyMDmpP9dwB7
 EUH5y2U1dkTBYtpa6nfhSOIrxFobLdLeZ6JoanjT8QUgw8AUJ1OnPi25CHy+MS9+4Nq/
 EtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794203705; x=1794808505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zBqjQYHOWAuc+JRAQGuIIdlERuoxbenM2VOhg1whkKE=;
 b=tefBilbgJ8WotptuChSm8QtIk/CgGGe87tEd4Ou7ARL0CM8kuze6aYzjh3PSCzmvQ8
 AbGK9LQUuBVjygr/FqqPU8GYPlxuMX/Rp0PrH3wug1Kfi/38D/khdvu51C6bxY7CF1H5
 JcM56MV2PzEHrKPW9c+51XEeF7D6uZarX8c4Ekqpq9ZgowZkdkM2MCM/GlXX59Fan+wI
 kLjwLaoOgiiRLV8kE5SlS/fCncnlHTbFM/iLWZsBJviXOvRxvo49B+frOkwkc7p1CEmN
 EwYPiu/IznzhA5QU7SFaAnMsB3P15ZZMW8DDu0rNHipL61/UwfxReLBfl52OI92pq37r
 8syw==
X-Gm-Message-State: APuU4Z+wnVaDPDTCSBBqgTljBIHlDGJQWfa1Izmgl7TMc1QHV6kZ1iV7
 V0VvX1Rr4MVXVmI+TzKj5bENlnzaL3nBYnpJqcvhWHJzpc/8ZmFqxGrMtju0NIwv
X-Gm-Gg: AYBFou0nOEhxMH7RO4CIF4RRyTyBviLcetaFmzy5IZmQct078AA4gCXIF1WN7/NTZM7
 pFWPvettNSBRzP2TFjavciGsk7128rMRT3sPPjJm/2UrkqEN1qX0Kvfiyy5uf42/+n2i+eGsWND
 bdwP4kQ65QXTYQQltjwvalay4SKj1BxgmgnIB6lPAGrQh+dThBLGRPwkyTrL0L939G4KD0gl68e
 bRpaQ7X/vM5cUaDoNCGSo7Ov0NxXCTZXxHgqfUW1MDWZTUTAORBOTr49uOzLB8qY2OtdxDfNyGp
 aAJ0NPDKkCqhpzy3beti8J4KqO7AA4YsnW6exu85apaTbGqTAXBISIjE3iJuIoE7H4NgBkiMDpx
 pC6A6uYDLEhBD/JxLgVcZeoJ7b+pHa9qi/jDEOPyQGn2ALJW2OzCKe1WkeXtsw5texTB4jpRhWc
 u116HXZZecVOCEjAI5pTgiu5jncz+UaMFTvH4bpH8UoEhIfmkB1NwGNAsIl7yJUEi0E6qt2YpjC
 K2LZm6CPQkHYV6p/xnXSyUQ5HPIgfqDh02EwadOCTJO6X7Cs8eavXjXQ6HwTfHSBO9m2LOS3iMq
 7jZm7K02CsrTEvQaGzDxz1GHDkStNgGlQfU9dDzGWQxQXwiCKB78ByoTL3C107ZWSRQ=
X-Received: by 2002:a05:690e:4393:b0:676:97e6:d7ac with SMTP id
 956f58d0204a3-67c3d9c3c2emr1337206d50.43.1794203704520; 
 Sun, 08 Nov 2026 21:55:04 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c3b83e8bdsm3312398d50.1.2026.11.08.21.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 21:55:04 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com,
 Gabriel Gama <operatingsystemsdepression@gmail.com>
Subject: [RFC PATCH 4/6] drm/gma500: Make SGX MMU insertion checked and
 transactional
Date: Mon,  9 Nov 2026 02:54:48 -0300
Message-ID: <20261109055451.17458-5-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
References: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Validate 32-bit mapping extents, PFNs and tiled geometry before changing
PTEs. Serialize changes with the write semaphore and undo only the
inserted prefix on allocation failure or collision, preserving existing
entries. Do not allocate tables or decrement counts when removing holes.

Use 64-bit exclusive endpoints so mapping the last GPU page does not wrap
on i386. Zero-page requests remain no-ops.

Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>

---
 drivers/gpu/drm/gma500/mmu.c | 211 +++++++++++++++++++++++++----------
 drivers/gpu/drm/gma500/mmu.h |   5 +-
 2 files changed, 158 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index 34ae0f125..0d98c7870 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -136,10 +136,9 @@ void psb_mmu_set_pd_context(struct psb_mmu_pd *pd, int hw_context)
 
 }
 
-static inline unsigned long psb_pd_addr_end(unsigned long addr,
-					    unsigned long end)
+static inline u64 psb_pd_addr_end(u64 addr, u64 end)
 {
-	addr = (addr + PSB_PDE_MASK + 1) & ~PSB_PDE_MASK;
+	addr = (addr + PSB_PDE_MASK + 1) & ~(u64)PSB_PDE_MASK;
 	return (addr < end) ? addr : end;
 }
 
@@ -484,13 +483,13 @@ static void psb_mmu_flush_ptes(struct psb_mmu_pd *pd, unsigned long address,
 	struct psb_mmu_pt *pt;
 	uint32_t rows = 1;
 	uint32_t i;
-	unsigned long addr;
-	unsigned long end;
-	unsigned long next;
-	unsigned long add;
-	unsigned long row_add;
+	u64 addr;
+	u64 end;
+	u64 next;
+	u64 add;
+	u64 row_add;
 	unsigned long clflush_add = pd->driver->clflush_add;
-	unsigned long clflush_mask = pd->driver->clflush_mask;
+	u64 clflush_mask = ~((u64)clflush_add - 1);
 
 	if (!pd->driver->has_clflush)
 		return;
@@ -500,8 +499,8 @@ static void psb_mmu_flush_ptes(struct psb_mmu_pd *pd, unsigned long address,
 	else
 		desired_tile_stride = num_pages;
 
-	add = desired_tile_stride << PAGE_SHIFT;
-	row_add = hw_tile_stride << PAGE_SHIFT;
+	add = (u64)desired_tile_stride << PAGE_SHIFT;
+	row_add = (u64)hw_tile_stride << PAGE_SHIFT;
 	mb();
 	for (i = 0; i < rows; ++i) {
 
@@ -525,38 +524,97 @@ static void psb_mmu_flush_ptes(struct psb_mmu_pd *pd, unsigned long address,
 	mb();
 }
 
+/* Validate the complete mapping before touching page tables. */
+static int psb_mmu_check_range(unsigned long address, u32 num_pages,
+			       u32 desired_tile_stride, u32 hw_tile_stride)
+{
+	u64 span;
+	u32 rows;
+
+	if (!IS_ALIGNED(address, PAGE_SIZE))
+		return -EINVAL;
+	if (((u64)address >> 32) || num_pages > BIT(20))
+		return -ERANGE;
+	if (!num_pages)
+		return 0;
+
+	if (hw_tile_stride) {
+		if (!desired_tile_stride ||
+		    num_pages % desired_tile_stride ||
+		    hw_tile_stride < desired_tile_stride)
+			return -EINVAL;
+		rows = num_pages / desired_tile_stride;
+		span = (u64)(rows - 1) * hw_tile_stride + desired_tile_stride;
+	} else {
+		span = num_pages;
+	}
+
+	if (span > (BIT_ULL(32) - address) >> PAGE_SHIFT)
+		return -ERANGE;
+
+	return 0;
+}
+
+/* The caller holds driver->sem for write; only its inserted prefix is undone. */
+static void psb_mmu_rollback_pages(struct psb_mmu_pd *pd,
+				   unsigned long address, u32 inserted,
+				   u32 desired_tile_stride, u32 hw_tile_stride)
+{
+	struct psb_mmu_pt *pt;
+	u64 offset;
+	u32 i;
+
+	for (i = 0; i < inserted; i++) {
+		if (hw_tile_stride)
+			offset = (u64)(i / desired_tile_stride) * hw_tile_stride +
+				 i % desired_tile_stride;
+		else
+			offset = i;
+		pt = psb_mmu_pt_map_lock(pd, address + (offset << PAGE_SHIFT));
+		if (WARN_ON_ONCE(!pt))
+			continue;
+		psb_mmu_invalidate_pte(pt, address + (offset << PAGE_SHIFT));
+		pt->count--;
+		psb_mmu_pt_unmap_unlock(pt);
+	}
+}
+
 void psb_mmu_remove_pfn_sequence(struct psb_mmu_pd *pd,
 				 unsigned long address, uint32_t num_pages)
 {
 	struct psb_mmu_pt *pt;
-	unsigned long addr;
-	unsigned long end;
-	unsigned long next;
+	u64 addr;
+	u64 end;
+	u64 next;
 	unsigned long f_address = address;
 
-	down_read(&pd->driver->sem);
+	if (!num_pages || psb_mmu_check_range(address, num_pages, 0, 0))
+		return;
+
+	down_write(&pd->driver->sem);
 
 	addr = address;
-	end = addr + (num_pages << PAGE_SHIFT);
+	end = addr + ((u64)num_pages << PAGE_SHIFT);
 
 	do {
 		next = psb_pd_addr_end(addr, end);
-		pt = psb_mmu_pt_alloc_map_lock(pd, addr);
+		pt = psb_mmu_pt_map_lock(pd, addr);
 		if (!pt)
-			goto out;
+			continue;
 		do {
-			psb_mmu_invalidate_pte(pt, addr);
-			--pt->count;
+			if (pt->v[psb_mmu_pt_index(addr)] != pd->invalid_pte) {
+				psb_mmu_invalidate_pte(pt, addr);
+				--pt->count;
+			}
 		} while (addr += PAGE_SIZE, addr < next);
 		psb_mmu_pt_unmap_unlock(pt);
 
 	} while (addr = next, next != end);
 
-out:
 	if (pd->hw_context != -1)
 		psb_mmu_flush_ptes(pd, f_address, num_pages, 1, 1);
 
-	up_read(&pd->driver->sem);
+	up_write(&pd->driver->sem);
 
 	if (pd->hw_context != -1)
 		psb_mmu_flush(pd->driver);
@@ -571,22 +629,26 @@ void psb_mmu_remove_pages(struct psb_mmu_pd *pd, unsigned long address,
 	struct psb_mmu_pt *pt;
 	uint32_t rows = 1;
 	uint32_t i;
-	unsigned long addr;
-	unsigned long end;
-	unsigned long next;
-	unsigned long add;
-	unsigned long row_add;
+	u64 addr;
+	u64 end;
+	u64 next;
+	u64 add;
+	u64 row_add;
 	unsigned long f_address = address;
 
+	if (!num_pages || psb_mmu_check_range(address, num_pages,
+					      desired_tile_stride, hw_tile_stride))
+		return;
+
 	if (hw_tile_stride)
 		rows = num_pages / desired_tile_stride;
 	else
 		desired_tile_stride = num_pages;
 
-	add = desired_tile_stride << PAGE_SHIFT;
-	row_add = hw_tile_stride << PAGE_SHIFT;
+	add = (u64)desired_tile_stride << PAGE_SHIFT;
+	row_add = (u64)hw_tile_stride << PAGE_SHIFT;
 
-	down_read(&pd->driver->sem);
+	down_write(&pd->driver->sem);
 
 	/* Make sure we only need to flush this processor's cache */
 
@@ -601,8 +663,10 @@ void psb_mmu_remove_pages(struct psb_mmu_pd *pd, unsigned long address,
 			if (!pt)
 				continue;
 			do {
-				psb_mmu_invalidate_pte(pt, addr);
-				--pt->count;
+				if (pt->v[psb_mmu_pt_index(addr)] != pd->invalid_pte) {
+					psb_mmu_invalidate_pte(pt, addr);
+					--pt->count;
+				}
 
 			} while (addr += PAGE_SIZE, addr < next);
 			psb_mmu_pt_unmap_unlock(pt);
@@ -614,7 +678,7 @@ void psb_mmu_remove_pages(struct psb_mmu_pd *pd, unsigned long address,
 		psb_mmu_flush_ptes(pd, f_address, num_pages,
 				   desired_tile_stride, hw_tile_stride);
 
-	up_read(&pd->driver->sem);
+	up_write(&pd->driver->sem);
 
 	if (pd->hw_context != -1)
 		psb_mmu_flush(pd->driver);
@@ -626,16 +690,23 @@ int psb_mmu_insert_pfn_sequence(struct psb_mmu_pd *pd, uint32_t start_pfn,
 {
 	struct psb_mmu_pt *pt;
 	uint32_t pte;
-	unsigned long addr;
-	unsigned long end;
-	unsigned long next;
+	u64 addr;
+	u64 end;
+	u64 next;
 	unsigned long f_address = address;
-	int ret = -ENOMEM;
+	u32 inserted = 0;
+	int ret;
+
+	ret = psb_mmu_check_range(address, num_pages, 0, 0);
+	if (ret || !num_pages)
+		return ret;
+	if ((u64)start_pfn + num_pages > BIT_ULL(20))
+		return -ERANGE;
 
-	down_read(&pd->driver->sem);
+	down_write(&pd->driver->sem);
 
 	addr = address;
-	end = addr + (num_pages << PAGE_SHIFT);
+	end = addr + ((u64)num_pages << PAGE_SHIFT);
 
 	do {
 		next = psb_pd_addr_end(addr, end);
@@ -645,9 +716,15 @@ int psb_mmu_insert_pfn_sequence(struct psb_mmu_pd *pd, uint32_t start_pfn,
 			goto out;
 		}
 		do {
+			if (pt->v[psb_mmu_pt_index(addr)] != pd->invalid_pte) {
+				psb_mmu_pt_unmap_unlock(pt);
+				ret = -EBUSY;
+				goto out;
+			}
 			pte = psb_mmu_mask_pte(start_pfn++, type);
 			psb_mmu_set_pte(pt, addr, pte);
 			pt->count++;
+			inserted++;
 		} while (addr += PAGE_SIZE, addr < next);
 		psb_mmu_pt_unmap_unlock(pt);
 
@@ -655,10 +732,12 @@ int psb_mmu_insert_pfn_sequence(struct psb_mmu_pd *pd, uint32_t start_pfn,
 	ret = 0;
 
 out:
+	if (ret)
+		psb_mmu_rollback_pages(pd, f_address, inserted, 0, 0);
 	if (pd->hw_context != -1)
 		psb_mmu_flush_ptes(pd, f_address, num_pages, 1, 1);
 
-	up_read(&pd->driver->sem);
+	up_write(&pd->driver->sem);
 
 	if (pd->hw_context != -1)
 		psb_mmu_flush(pd->driver);
@@ -675,26 +754,35 @@ int psb_mmu_insert_pages(struct psb_mmu_pd *pd, struct page **pages,
 	uint32_t rows = 1;
 	uint32_t i;
 	uint32_t pte;
-	unsigned long addr;
-	unsigned long end;
-	unsigned long next;
-	unsigned long add;
-	unsigned long row_add;
+	u64 addr;
+	u64 end;
+	u64 next;
+	u64 add;
+	u64 row_add;
 	unsigned long f_address = address;
-	int ret = -ENOMEM;
+	u32 inserted = 0;
+	int ret;
+
+	ret = psb_mmu_check_range(address, num_pages,
+				  desired_tile_stride, hw_tile_stride);
+	if (ret || !num_pages)
+		return ret;
+	if (!pages)
+		return -EINVAL;
+	for (i = 0; i < num_pages; i++) {
+		if (!pages[i] || page_to_pfn(pages[i]) >= BIT_ULL(20))
+			return -ERANGE;
+	}
 
-	if (hw_tile_stride) {
-		if (num_pages % desired_tile_stride != 0)
-			return -EINVAL;
+	if (hw_tile_stride)
 		rows = num_pages / desired_tile_stride;
-	} else {
+	else
 		desired_tile_stride = num_pages;
-	}
 
-	add = desired_tile_stride << PAGE_SHIFT;
-	row_add = hw_tile_stride << PAGE_SHIFT;
+	add = (u64)desired_tile_stride << PAGE_SHIFT;
+	row_add = (u64)hw_tile_stride << PAGE_SHIFT;
 
-	down_read(&pd->driver->sem);
+	down_write(&pd->driver->sem);
 
 	for (i = 0; i < rows; ++i) {
 
@@ -704,13 +792,21 @@ int psb_mmu_insert_pages(struct psb_mmu_pd *pd, struct page **pages,
 		do {
 			next = psb_pd_addr_end(addr, end);
 			pt = psb_mmu_pt_alloc_map_lock(pd, addr);
-			if (!pt)
+			if (!pt) {
+				ret = -ENOMEM;
 				goto out;
+			}
 			do {
+				if (pt->v[psb_mmu_pt_index(addr)] != pd->invalid_pte) {
+					psb_mmu_pt_unmap_unlock(pt);
+					ret = -EBUSY;
+					goto out;
+				}
 				pte = psb_mmu_mask_pte(page_to_pfn(*pages++),
 						       type);
 				psb_mmu_set_pte(pt, addr, pte);
 				pt->count++;
+				inserted++;
 			} while (addr += PAGE_SIZE, addr < next);
 			psb_mmu_pt_unmap_unlock(pt);
 
@@ -721,11 +817,14 @@ int psb_mmu_insert_pages(struct psb_mmu_pd *pd, struct page **pages,
 
 	ret = 0;
 out:
+	if (ret)
+		psb_mmu_rollback_pages(pd, f_address, inserted, desired_tile_stride,
+				       hw_tile_stride);
 	if (pd->hw_context != -1)
 		psb_mmu_flush_ptes(pd, f_address, num_pages,
 				   desired_tile_stride, hw_tile_stride);
 
-	up_read(&pd->driver->sem);
+	up_write(&pd->driver->sem);
 
 	if (pd->hw_context != -1)
 		psb_mmu_flush(pd->driver);
diff --git a/drivers/gpu/drm/gma500/mmu.h b/drivers/gpu/drm/gma500/mmu.h
index e6d397037..4474718aa 100644
--- a/drivers/gpu/drm/gma500/mmu.h
+++ b/drivers/gpu/drm/gma500/mmu.h
@@ -9,8 +9,9 @@
 #define __MMU_H
 
 struct psb_mmu_driver {
-	/* protects driver- and pd structures. Always take in read mode
-	 * before taking the page table spinlock.
+	/*
+	 * Protects driver and page-directory structures. Mapping changes take
+	 * this semaphore for write, before the page-table spinlock.
 	 */
 	struct rw_semaphore sem;
 
