Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D6606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oML5+BmW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A008C10F054;
	Mon,  9 Nov 2026 06:33:34 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D6510F043
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:33:17 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-8b309147589so5102017b3.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 22:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794205997; x=1794810797; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MDYm+wKdpfftzqJZPkAt3O7GNAJT1wvZ7Nj3EGFVnmI=;
 b=oML5+BmWTdR9eTQIISn/8lLLAlY94/DI7fkJ0EPpeiFjdAtnHtOLtm2lZK5HtG4aEF
 Y0hsianuEPa75+4/hgSJLLutyTWVZ0rhYL/M5nPfrw+zcJNfzExcQ8Zf1NJfhPQcJjl3
 V8eFtnIIpfqivn4U00UmT0TmrvDR6Lkdkt//9CUxv6TO80XRKc43MoH0EokCiwVbB+gn
 wiJIaIKLI1XMAvKzs9Gn9VdRqJjs6vgW1T8top8NwEBWLXl25YE+/G+UXVr9hOVy0Ubn
 p8ppUw/Qk7Hk9RES37YSyChe2aL3lqq1iCMwRcY3oVIrq381V0+krum9YJhHLmMI93UN
 rksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794205997; x=1794810797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MDYm+wKdpfftzqJZPkAt3O7GNAJT1wvZ7Nj3EGFVnmI=;
 b=fjc5eW93ib8/yXcnUEIeFj6r9/GN5RSNSR9jYKNIR0NOKagAYmUhc8eqGdAMzD48Wu
 JO9FFOdHsCVAzyiRtUTGTQ4hiDL0/4eU9g99ZWzZR/RIbEdEL+X2KDv+rPddJ1cW/UUn
 0vuDF6RXODgfiG+LdJekTALrB9BugwfoaEzf45C4f6zbCimuaB2r07topk459p52dsJx
 6MyIrLKc7O2Wgvt4XRqCRMXZZmj1yE33kbFYmmDeH3C/p0g8v99sYDWMWLeZsfQflT4J
 CkCc7kJC6Gn+IM1FKypj1GXXxBjuZQQ73VLMtRqcq75UHiXP8D4GedvMYKY6Ypsqev6/
 SFXw==
X-Gm-Message-State: APuU4Z9Hc8vCNwDdgY72pvGDiNZ+kI5c1rQJIdm5yArV1PFLR9c8x6xe
 tsI8JdEqclqYyxozsity4YhAiOG+3eckY4drkb6zg8SQfPmX6+xFIBP3oe541A==
X-Gm-Gg: AYBFou1DsV1+4bmRpkx1KanannQjnhQ+ffP+iMqMM6/mSftuAUZa3LSf8F0KJHcwgou
 2ajSjY6XqOYjNapXGWCoroUCu5E40S5SmTzyuIgeGxgqbs2yWgywiPrU4mF0gDsnJFygtFY8suO
 SGzL/dSzBrvgoXfw9Yh8YWOobeb/UyJgYP557oVll/et+JNXZNF7t6SVpe1/C5pooHtp17OHCwt
 XUWFgbmphnF03r0OhoP4p3NrWANAJYSjX8lWKvVrAvh+zD1Xb2tW1SIWvrt7SLA6LCbDvHKYDlk
 2EPK3vEUNszxpgjZNdQox5sjcaH11+MC5Z5I6Tp4HLMZTspd5MjwClsj1fgfqCmRA4f76xgh/7+
 aGvPRbkIINvqnUxiM9LVgPcajwy1VaMwCniTUhl5accVocig2V2k2gNfiSlHY1XuVJ6RBH2manW
 KbNTQBSl9sLZS9McvpPuPeMKb9yJw7B5Wo/mvYrv4YaLEf/57QxUFK90rNp/7HfMXfKrgkentMc
 SxLCz6Qx0UJAWiAR2MzEK+FsYwsqA4ggEGV35irVe1VhWn/lwcnMcHlmHrTCnyg62nN/Y3lwr8w
 zHdk75djya3CZ0p/0ISFRNM4Oi+cbzNKwoNGqOg+xB9LYTz4IFTBA0ZsVeLAjrmF/FevyqaTVfu
 Z3fvro1GHnFbg
X-Received: by 2002:a05:690c:d8f:b0:8b0:9e1a:b122 with SMTP id
 00721157ae682-8b36cad7396mr19906007b3.56.1794205996758; 
 Sun, 08 Nov 2026 22:33:16 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b36bc43733sm29035827b3.33.2026.11.08.22.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 22:33:16 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com
Subject: [RFC PATCH v2 4/6] drm/gma500: Make SGX MMU insertion checked and
 transactional
Date: Mon,  9 Nov 2026 03:33:01 -0300
Message-ID: <20261109063303.32658-5-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
References: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
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
 
