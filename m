Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE1D606A8AF
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YD2ghAZc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250861127C8;
	Fri, 13 Nov 2026 20:26:55 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C52F810E831
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:26:48 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-8b0dba37a7fso16025637b3.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601608; x=1795206408; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ltTM/NlG3PRluJRx5o7ZI2KAePWxyK3Xjf4OeMaKdNw=;
 b=YD2ghAZcYg0K2gXKkRp7O5EzF31bCwM4SMHQOInoYhQA95x5/BzJcj7ybLnOSp0oVK
 EAtm6m00i5fzid1jt+YZVBEQfZldIeEulXsol/1G8JE/rqGqqTZdPb0YCwv58wUyDzXB
 8m1pXdMQzrjjw6LXvPpq1HIAQ7rR9dMwWYJGIZDXReYChyJ53RsNS9LtmWGm8wC3R5JL
 6u/btQuXR4MKpMaQVgiTERDQvBZrmiktS6EIjfXrSXamZf/GKgg/japSHW1/XqEcZzoN
 KAxWEyW1bIjtC/Q3cVREeBhNVuLgdQUJnEouiglekvTU2xPcEUgefJApaA4FBSaTVEXa
 2Ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601608; x=1795206408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ltTM/NlG3PRluJRx5o7ZI2KAePWxyK3Xjf4OeMaKdNw=;
 b=NDor3RxewAZZJDOUZL6shtiplWOk5vXz2baQ8WjxFQcm1xWvzoFOKDsyd7qUB6BlJM
 PW5EQgRtDI7eMyBS9Pgfq74olPr4j0eau4+vK6ZrvVqHz/wOEKG5aFX+MVsvmBYJZO94
 S11rYk9A5cgwjbvkfe1ld6fTUXHbyIhxUUKtWw8N5VGbTZaoWdPo1zaOfx4s/NLNP5Ti
 Gyh4gwOj5+46ThoiJsC4yjGlbOaSr/1YaqFK56NWoVpHgWDvsY4JqeZGDAe6+IUEbhrd
 KgIbLveT9MNrBtVpW6D6Y+WXHJ4QcdY/Zr1jItMgRMElU3SVRakJ2zXckmaTdh1KY/3C
 tA8Q==
X-Gm-Message-State: APuU4Z9JHJi5iZuvufatFfSrTIui1FtNKX+9K0VhbBy4Yh787cVWkSP9
 z8IFkG0zK/IU7cmV1Hpm5BQrdRimck6MRlbge8XRlFgY0i/NcQuSSTssYpWs/t5Ffkk=
X-Gm-Gg: AYBFou2MVKBKx/M/IHqKOUg14jEY0CaxUDJ6grBAMLx2PxNUYvyzifTjX0fhtwswl4U
 2KslzPaPxNtaD8uaL24cYSNzbu2NxTr8ly9IkkE1+HtkQlCY+irbM6Wt6rX1ExfchPBeeM06jUD
 raP/lYuYy+2xqVkMAHRcCMxTgLy5wSU4pnN8pvfAdW2c3K0y3kr8/VVE1lmS0+NohhoCGKPbEDb
 0yTqgUBfE32Iw9R9gjwi/AC52HhaszPH5dmvJUEtF+KnO/SRwCC/e4cZggkjonbnxemY+UnJ9yz
 uyOJgvB2bIga2r6dkLPRZzTQ1tNLbBh/O6aRwMLGzcvVImzUW7jtv6/6qwrHmN8TjhHpC0/2SDK
 ezzI70xyc1snGFL33uhYoHh6xqDjfO1ZCdQEGGPljLZXLxVvIy6i14VEwCRjTgJK8/QDj7sfPwB
 igQgv3ovwNrXyNMDv/D4EKCaKjbEDqC91myb/++o6e0Jp7u/Vun2VUYhKBD4Zt+8wAS2PyMDQ3z
 y+rrLNdPRwZ9MXhYbaPHgC8VYk8r2FHhqO3xHKNx6kYn34tfzqjufsR82u1B7UhmTFAU203pmIx
 JRnnyAn80/+Rt7Xj9jQeDNUZAufui+SJu0MlTJXGWabBZ/v9IKMgtWMALSHXZJ/ywpU=
X-Received: by 2002:a05:690c:315:b0:8b3:6029:e2a3 with SMTP id
 00721157ae682-8b4aa2c3fe9mr23225377b3.43.1794601607759; 
 Fri, 13 Nov 2026 12:26:47 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:fd83:f7ad:7c00:7806])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aaa0ea50sm28424677b3.42.2026.11.13.12.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:26:47 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH 9/10] drm/gma500: make failed MMU insertion safe for GEM error
 cleanup
Date: Fri, 13 Nov 2026 17:26:41 -0300
Message-ID: <20261113202641.15694-1-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
References: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
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

Serialize mapping changes with the write semaphore before the PT
spinlock, reject occupied PTEs and roll back only this insertion's
completed prefix on collision or allocation failure. Flush the
invalidations before returning failure; preserve existing mappings.

Only with exclusive rollback may GEM propagate insertion errors and
release temporary backing pages. Keep the writer-lock change, rollback
and all newly introduced error cleanup in one patch. Stable must not
select an error path that frees pages still referenced by partial PTEs,
or a rollback path whose inserted prefix another writer can change.
Probe also stops on stolen-map failure before installing contexts.

Backport this whole transaction and its range-validation prerequisite;
do not split out err_put_pages or weaken its lock contract. Existing
WC/WB cache-attribute error handling is unchanged.

Fixes: 8c8f1c958ab5 ("gma500: introduce the GTT and MMU handling logic")
Fixes: ae012bdc5799 ("drm/gma500: Hook up the MMU")
Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 920847cbc4cd7c8c1fbc4f307f29640e2ac10064..05592a01bae1774dc2e8612b7088e82123bd76ae 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -32,7 +32,7 @@
 	struct drm_gem_object *obj = &pobj->base;
 	struct drm_device *dev = obj->dev;
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
-	u32 gpu_base = dev_priv->gtt.gatt_start;
+	u64 gpu_address = (u64)dev_priv->gtt.gatt_start + pobj->offset;
 	struct page **pages;
 	unsigned int npages;
 	int ret;
@@ -43,6 +43,11 @@
 
 	if (pobj->in_gart || pobj->stolen)
 		goto out; /* already mapped */
+
+	if (gpu_address >= BIT_ULL(32)) {
+		ret = -ERANGE;
+		goto err_dma_resv_unlock;
+	}
 
 	pages = drm_gem_get_pages(obj);
 	if (IS_ERR(pages)) {
@@ -52,12 +57,14 @@
 
 	npages = obj->size / PAGE_SIZE;
 
+	ret = psb_mmu_insert_pages(psb_mmu_get_default_pd(dev_priv->mmu),
+				   pages, gpu_address, npages, 0, 0,
+				   PSB_MMU_CACHED_MEMORY);
+	if (ret)
+		goto err_put_pages;
+
 	set_pages_array_wc(pages, npages);
-
 	psb_gtt_insert_pages(dev_priv, &pobj->resource, pages);
-	psb_mmu_insert_pages(psb_mmu_get_default_pd(dev_priv->mmu), pages,
-			     (gpu_base + pobj->offset), npages, 0, 0,
-			     PSB_MMU_CACHED_MEMORY);
 
 	pobj->pages = pages;
 
@@ -67,6 +74,8 @@
 
 	return 0;
 
+err_put_pages:
+	drm_gem_put_pages(obj, pages, false, false);
 err_dma_resv_unlock:
 	dma_resv_unlock(obj->resv);
 	return ret;
diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index b5854ed29c28cc33205e02018dc2e1ec505b0137..0d98c78706d238a8da754e2edfe502aeae5e9b0d 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -555,6 +555,30 @@
 	return 0;
 }
 
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
@@ -567,7 +591,7 @@
 	if (!num_pages || psb_mmu_check_range(address, num_pages, 0, 0))
 		return;
 
-	down_read(&pd->driver->sem);
+	down_write(&pd->driver->sem);
 
 	addr = address;
 	end = addr + ((u64)num_pages << PAGE_SHIFT);
@@ -590,7 +614,7 @@
 	if (pd->hw_context != -1)
 		psb_mmu_flush_ptes(pd, f_address, num_pages, 1, 1);
 
-	up_read(&pd->driver->sem);
+	up_write(&pd->driver->sem);
 
 	if (pd->hw_context != -1)
 		psb_mmu_flush(pd->driver);
@@ -624,7 +648,7 @@
 	add = (u64)desired_tile_stride << PAGE_SHIFT;
 	row_add = (u64)hw_tile_stride << PAGE_SHIFT;
 
-	down_read(&pd->driver->sem);
+	down_write(&pd->driver->sem);
 
 	/* Make sure we only need to flush this processor's cache */
 
@@ -654,7 +678,7 @@
 		psb_mmu_flush_ptes(pd, f_address, num_pages,
 				   desired_tile_stride, hw_tile_stride);
 
-	up_read(&pd->driver->sem);
+	up_write(&pd->driver->sem);
 
 	if (pd->hw_context != -1)
 		psb_mmu_flush(pd->driver);
@@ -670,6 +694,7 @@
 	u64 end;
 	u64 next;
 	unsigned long f_address = address;
+	u32 inserted = 0;
 	int ret;
 
 	ret = psb_mmu_check_range(address, num_pages, 0, 0);
@@ -678,7 +703,7 @@
 	if ((u64)start_pfn + num_pages > BIT_ULL(20))
 		return -ERANGE;
 
-	down_read(&pd->driver->sem);
+	down_write(&pd->driver->sem);
 
 	addr = address;
 	end = addr + ((u64)num_pages << PAGE_SHIFT);
@@ -691,9 +716,15 @@
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
 
@@ -701,10 +732,12 @@
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
@@ -727,6 +760,7 @@
 	u64 add;
 	u64 row_add;
 	unsigned long f_address = address;
+	u32 inserted = 0;
 	int ret;
 
 	ret = psb_mmu_check_range(address, num_pages,
@@ -748,7 +782,7 @@
 	add = (u64)desired_tile_stride << PAGE_SHIFT;
 	row_add = (u64)hw_tile_stride << PAGE_SHIFT;
 
-	down_read(&pd->driver->sem);
+	down_write(&pd->driver->sem);
 
 	for (i = 0; i < rows; ++i) {
 
@@ -763,10 +797,16 @@
 				goto out;
 			}
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
 
@@ -777,11 +817,14 @@
 
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
index e6d39703718c49a7c6345f8787593acd049e0130..4474718aac777632021507ade9435d37144e2f9d 100644
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
 
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 4102b6de69a2c5b15e74a67676190a8f13c6031d..bf94d0a38d0f61daddab1da182f5ebf1e9887c1d 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -354,6 +354,8 @@
 					  dev_priv->stolen_base >> PAGE_SHIFT,
 					  pg->gatt_start,
 					  pg->stolen_size >> PAGE_SHIFT, 0);
+	if (ret)
+		goto out_err;
 
 	psb_mmu_set_pd_context(psb_mmu_get_default_pd(dev_priv->mmu), 0);
 	psb_mmu_set_pd_context(dev_priv->pf_pd, 1);
