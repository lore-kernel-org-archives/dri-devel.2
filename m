Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE111606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P94oS/Ac
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17F9110F924;
	Wed, 21 Oct 2026 06:06:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987E210F8FE
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792562767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GgUN3PXGarkTKLbmZsGJ5nfMapb3HVw3zfaBFxuYjaw=;
 b=P94oS/AcwIgP9ZhsUWu27WniWXeysvjJlszKLWtVL5HqlXvFAHnVF8M/QS4tfY6Sf3NgPo
 gFfbp9TtE/H0pko/WbdiMQcYVdfvy5CBVfYXMU01TWoSwadDnPXhI+ld34QisajF+0UdYF
 PQt3yMPz//etoajJ7YKuVopTGv8++XM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-bS1vQHPkN_Cwx6D0rgeHtA-1; Wed, 21 Oct 2026 06:06:04 +0000
X-MC-Unique: bS1vQHPkN_Cwx6D0rgeHtA-1
X-Mimecast-MFC-AGG-ID: bS1vQHPkN_Cwx6D0rgeHtA_1792562763
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48af4a0bd0fso148836f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792562763; x=1793167563;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GgUN3PXGarkTKLbmZsGJ5nfMapb3HVw3zfaBFxuYjaw=;
 b=hjQ9S2GxnZLgzd4ZoS4F/L416A4w66WY+sjn0N+rcWaFSir2NjBMzeZqREJCZEaPOe
 SHdg8Eh03LJ3X8MHtYyV4q1gHtcb578SL7TKryHLpAJ9pgUHQ26r6bF2V4WHR+WEt84i
 9QB99EGfz51blOjOMPc33k0Zc1AC/8bkUerOxGCZ8/3/LOs998FEb+IxR3DHXdjvdiAf
 +l+tbUp1Him42odhsGz9p7yRriXxak8UjG503RL1WLirBd2T7AI/Ck9qFeJyAaDNSLUL
 8pETokAHv0C39ce6fLXQ5CwCb13Z7uK9UpyPEJnL7Svfd8KiCfsKqTiM4/mRsFsZCz4y
 VIrg==
X-Gm-Message-State: AFq9FYLRtd62zRsYsgfhA/nYZDLLTHnk507mTZ1B7pM2v25j1uav2/i1
 xHyfq6uN80kq/oPRoAahLC+X+9zd7oRexDWgaQrOTmrtHFYIYsGfRDEnApz+cDXT4OCXgKNVVqH
 ZOK5t+JwkEQURjME2hu4vzQv3bjYSByYhleE43kzmbsh/GiZ0pswc6svnoL6A9Jxi4DixyWRfiV
 Bm/wk=
X-Gm-Gg: AYBFou2EIuYRpYe/wkJOjgOaoLln80ymE72PF/lEfYEq9ZI8F0hkPYp7U+mCzazBjee
 g7tlq26WnzLCrXXPQVdras0p+whoTQbjcBeR92L+l+twnbnuvzj4fXuOLbS55W3cMLOXbngMRPj
 FL6ulvS27biLbtl7SguUfksA2J0vFWkFftQtEDyel1uT8U/uSXVQSG3paF+gWXL5KeE5oHElWpM
 bbBVsuk5bf4JfkZ2ht+mVA3Y2joNMU5FVdWawTtKw873OK1zv9FuNT+EACam2W+qf7YXmeJlNiY
 0APz7w+2S3RxcT9c08zDUneSebOkr76B71lQWO5dwObohUT70lN3cmsjraPeB1Y9nss18TC0X89
 QVqBR3x5s4MO6cGOnBgJ5vUXWZSTLAIP47zE7
X-Received: by 2002:a5d:5f55:0:b0:48d:ca32:e90f with SMTP id
 ffacd0b85a97d-48e264e905cmr1635324f8f.55.1792562762974; 
 Tue, 20 Oct 2026 23:06:02 -0700 (PDT)
X-Received: by 2002:a5d:5f55:0:b0:48d:ca32:e90f with SMTP id
 ffacd0b85a97d-48e264e905cmr1635242f8f.55.1792562762356; 
 Tue, 20 Oct 2026 23:06:02 -0700 (PDT)
Received: from fedora.redhat.corp (89-27-86-246.bb.dnainternet.fi.
 [89.27.86.246]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254f02f1sm3413741f8f.3.2026.10.20.23.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:06:00 -0700 (PDT)
From: mpenttil@redhat.com
To: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v16 12/12] drm/nouveau/svm: add support for migrate on fault
Date: Wed, 21 Oct 2026 09:05:06 +0300
Message-ID: <20261021060506.2377545-13-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021060506.2377545-1-mpenttil@redhat.com>
References: <20261021060506.2377545-1-mpenttil@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DLJ98W-baJPbdRtm86wvEisVh6RUVIVXcpjpfB2C-88_1792562763
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mika Penttilä <mpenttil@redhat.com>

Add a direct user for the new HMM_PFN_REQ_MIGRATE flag and
implement migrate on fault for nouveau driver. It is gated
by the svm_migrate_on_fault module parameter, default off.

Added nouveau_dmem_migrate_fault() that faults a range in and
does migrate collecting in a single hmm_range_fault() walk.

As an optimization, a migration policy - deciding which faulting
ranges are worth migrating to VRAM and which are better left
mirrored in system memory - would be useful. This patch
establishes the migrate-on-fault mechanism as a basis for later
refinement.

Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 281 ++++++++++++++++++++++++-
 drivers/gpu/drm/nouveau/nouveau_dmem.h |  12 ++
 drivers/gpu/drm/nouveau/nouveau_svm.c  | 141 +++++++++----
 drivers/gpu/drm/nouveau/nouveau_svm.h  |   5 +
 4 files changed, 384 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index e74d7bb975a8..998c63e2ae78 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -40,6 +40,9 @@
 #include <linux/hmm.h>
 #include <linux/memremap.h>
 #include <linux/migrate.h>
+#include <linux/jiffies.h>
+#include <linux/delay.h>
+#include <linux/mmu_notifier.h>
 
 /*
  * FIXME: this is ugly right now we are using TTM to allocate vram and we pin
@@ -139,10 +142,12 @@ static void nouveau_dmem_folio_free(struct folio *folio)
 	spin_unlock(&dmem->lock);
 }
 
-static void nouveau_dmem_fence_done(struct nouveau_fence **fence)
+static int nouveau_dmem_fence_done(struct nouveau_fence **fence)
 {
+	int ret = 0;
+
 	if (fence) {
-		nouveau_fence_wait(*fence, true, false);
+		ret = nouveau_fence_wait(*fence, true, false);
 		nouveau_fence_unref(fence);
 	} else {
 		/*
@@ -150,6 +155,32 @@ static void nouveau_dmem_fence_done(struct nouveau_fence **fence)
 		 * the hmem object.
 		 */
 	}
+
+	/* 0 on completion, -EBUSY on timeout, or other errno; propagated. */
+	return ret;
+}
+
+/*
+ * Poll the copy fence instead of the lazy (interrupt-driven) wait since
+ * completion IRQ is randomly missed, hitting the timeout.
+ *
+ * Returns 0 on completion, -EBUSY on timeout. Consumes the fence reference.
+ */
+static int nouveau_dmem_fence_poll(struct nouveau_fence **fence)
+{
+	unsigned long deadline = jiffies + 30 * HZ;
+	int ret = 0;
+
+	while (!nouveau_fence_done(*fence)) {
+		if (time_after(jiffies, deadline)) {
+			ret = -EBUSY;
+			break;
+		}
+		schedule_timeout_uninterruptible(msecs_to_jiffies(1));
+	}
+	nouveau_fence_unref(fence);
+
+	return ret;
 }
 
 static int nouveau_dmem_copy_folio(struct nouveau_drm *drm,
@@ -188,7 +219,7 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 	struct nouveau_svmm *svmm;
 	struct page *dpage;
 	vm_fault_t ret = 0;
-	int err;
+	int err, fret = 0;
 	struct migrate_vma args = {
 		.vma		= vmf->vma,
 		.pgmap_owner	= drm->dev,
@@ -233,10 +264,12 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 	 * than just one page on CPU fault. When such fault happens it is very
 	 * likely that more surrounding page will CPU fault too.
 	 */
-	if (migrate_vma_setup(&args) < 0)
-		return VM_FAULT_SIGBUS;
+	if (migrate_vma_setup(&args) < 0) {
+		ret = VM_FAULT_SIGBUS;
+		goto err;
+	}
 	if (!args.cpages)
-		return 0;
+		goto done;
 
 	if (order)
 		dpage = folio_page(vma_alloc_folio(GFP_HIGHUSER | __GFP_ZERO,
@@ -266,9 +299,12 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 
 	nouveau_fence_new(&fence, dmem->migrate.chan);
 	migrate_vma_pages(&args);
-	nouveau_dmem_fence_done(&fence);
+	fret = nouveau_dmem_fence_poll(&fence);
 	dma_unmap_page(drm->dev->dev, dma_info.dma_addr, dma_info.size,
 				DMA_BIDIRECTIONAL);
+	if (fret)
+		/* Copy failed; the pte now points at possibly stale sysram data. */
+		ret = VM_FAULT_SIGBUS;
 done:
 	migrate_vma_finalize(&args);
 err:
@@ -794,11 +830,12 @@ static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm,
 	return 0;
 }
 
-static void nouveau_dmem_migrate_chunk(struct nouveau_drm *drm,
+static unsigned long
+nouveau_dmem_migrate_alloc_and_copy(struct nouveau_drm *drm,
 		struct nouveau_svmm *svmm, struct migrate_vma *args,
-		struct nouveau_dmem_dma_info *dma_info, u64 *pfns)
+		struct nouveau_dmem_dma_info *dma_info, u64 *pfns,
+		unsigned long *nr_dma_out, unsigned long *order_out)
 {
-	struct nouveau_fence *fence;
 	unsigned long addr = args->start, nr_dma = 0, i;
 	unsigned long order = 0;
 
@@ -820,6 +857,21 @@ static void nouveau_dmem_migrate_chunk(struct nouveau_drm *drm,
 		addr += (1 << order) * PAGE_SIZE;
 	}
 
+	*nr_dma_out = nr_dma;
+	*order_out = order;
+	return i;
+}
+
+static void nouveau_dmem_migrate_chunk(struct nouveau_drm *drm,
+		struct nouveau_svmm *svmm, struct migrate_vma *args,
+		struct nouveau_dmem_dma_info *dma_info, u64 *pfns)
+{
+	struct nouveau_fence *fence;
+	unsigned long nr_dma, order, i;
+
+	i = nouveau_dmem_migrate_alloc_and_copy(drm, svmm, args, dma_info, pfns,
+						&nr_dma, &order);
+
 	nouveau_fence_new(&fence, drm->dmem->migrate.chan);
 	migrate_vma_pages(args);
 	nouveau_dmem_fence_done(&fence);
@@ -832,6 +884,215 @@ static void nouveau_dmem_migrate_chunk(struct nouveau_drm *drm,
 	migrate_vma_finalize(args);
 }
 
+/*
+ * Encode an hmm_range_fault() pfn for @start into the nouveau PFNMAP format,
+ * shared by nouveau_hmm_convert_pfn() and the in-place map in
+ * nouveau_dmem_migrate_fault().
+ */
+u64 nouveau_dmem_hmm_pfn_to_map(unsigned long hmm_pfn, unsigned long start,
+				unsigned long *map_addr, unsigned int *page_shift)
+{
+	unsigned long order;
+	struct page *page;
+	u64 pfn;
+
+	*map_addr = start;
+	*page_shift = PAGE_SHIFT;
+
+	if (!(hmm_pfn & HMM_PFN_VALID))
+		return NVIF_VMM_PFNMAP_V0_NONE;
+
+	page = hmm_pfn_to_page(hmm_pfn);
+
+	order = hmm_pfn_to_map_order(hmm_pfn);
+	if (order) {
+		*page_shift = order + PAGE_SHIFT;
+		*map_addr = start & ~((1UL << *page_shift) - 1);
+		page -= (start - *map_addr) >> PAGE_SHIFT;
+	}
+
+	if (is_device_private_page(page))
+		pfn = nouveau_dmem_page_addr(page) |
+			NVIF_VMM_PFNMAP_V0_V | NVIF_VMM_PFNMAP_V0_VRAM;
+	else
+		pfn = page_to_phys(page) |
+			NVIF_VMM_PFNMAP_V0_V | NVIF_VMM_PFNMAP_V0_HOST;
+	if (hmm_pfn & HMM_PFN_WRITE)
+		pfn |= NVIF_VMM_PFNMAP_V0_W;
+
+	return pfn;
+}
+
+/*
+ * Fault a range in and migrate it to VRAM.
+ * Returns 0 on success, or an error (so the caller
+ * falls back to nouveau_range_fault()) if nothing could be mapped.
+ */
+int
+nouveau_dmem_migrate_fault(struct nouveau_drm *drm, struct nouveau_svmm *svmm,
+			   struct mmu_interval_notifier *notifier,
+			   unsigned long start, unsigned long end,
+			   unsigned long hmm_flags,
+			   u64 *out_pfn0, unsigned long *out_addr,
+			   unsigned int *out_shift)
+{
+	unsigned long timeout =
+		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long npages = (end - start) >> PAGE_SHIFT;
+	struct mm_struct *mm = notifier->mm;
+	struct nouveau_dmem_dma_info *dma_info;
+	struct nouveau_fence *fence = NULL;
+	struct migrate_vma migrate = {
+		.start		= start,
+		.end		= end,
+		.pgmap_owner	= drm->dev,
+		.flags		= MIGRATE_VMA_SELECT_SYSTEM,
+	};
+	struct hmm_range range = {
+		.notifier		= notifier,
+		.start			= start,
+		.end			= end,
+		.dev_private_owner	= drm->dev,
+		.migrate		= &migrate,
+		.default_flags		= hmm_flags | HMM_PFN_REQ_MIGRATE,
+	};
+	unsigned long nr_dma, order, n, i;
+	unsigned long hmm_pfn0 = 0;
+	bool migrated;
+	u64 *pfns;
+	int ret, fret = 0;
+
+	if (!drm->dmem)
+		return -ENODEV;
+
+	migrate.src = kcalloc(npages, sizeof(*migrate.src), GFP_KERNEL);
+	if (!migrate.src)
+		return -ENOMEM;
+	migrate.dst = kcalloc(npages, sizeof(*migrate.dst), GFP_KERNEL);
+	if (!migrate.dst) {
+		ret = -ENOMEM;
+		goto out_free_src;
+	}
+	dma_info = kmalloc_objs(*dma_info, npages);
+	if (!dma_info) {
+		ret = -ENOMEM;
+		goto out_free_dst;
+	}
+	pfns = nouveau_pfns_alloc(npages);
+	if (!pfns) {
+		ret = -ENOMEM;
+		goto out_free_dma;
+	}
+
+	/* hmm_range_fault() shares the source pfn array with migrate_vma. */
+	range.hmm_pfns = migrate.src;
+
+	do {
+		mmap_read_lock(mm);
+		range.notifier_seq = mmu_interval_read_begin(notifier);
+
+		ret = hmm_range_fault(&range);
+		/*
+		 * Snapshot the pfn before migrate_hmm_range_setup() overwrites the
+		 * shared array; used to map in place if nothing migrates.
+		 */
+		if (!ret)
+			hmm_pfn0 = range.hmm_pfns[0];
+		migrate_hmm_range_setup(&range);
+		if (ret) {
+			migrate_vma_pages(&migrate);
+			migrate_vma_finalize(&migrate);
+			goto unlock;
+		}
+
+		n = nouveau_dmem_migrate_alloc_and_copy(drm, svmm, &migrate,
+							dma_info, pfns,
+							&nr_dma, &order);
+
+		/* Only a migrated page has an in-flight CE copy to unblock below. */
+		for (i = 0, migrated = false; i < npages; i++) {
+			if (migrate.dst[i]) {
+				migrated = true;
+				break;
+			}
+		}
+
+		/*
+		 * Track a copy fence only when a copy was enqueued; waiting on an
+		 * empty fence would block until the fault's CTXSW_TIMEOUT.
+		 */
+		if (migrated)
+			nouveau_fence_new(&fence, drm->dmem->migrate.chan);
+		migrate_vma_pages(&migrate);
+
+		/*
+		 * The fault-in path must replay the faulting channel before waiting on
+		 * the copy fence: with the fault still unreplayed the copy does not
+		 * make progress. GPU has no mapping so it might refault, until it
+		 * gets the migrated or mirrored mapping.
+		 */
+		if (drm->svm && migrated)
+			nouveau_svm_fault_replay(drm->svm);
+
+		if (migrated)
+			fret = nouveau_dmem_fence_poll(&fence);
+
+		mutex_lock(&svmm->mutex);
+		if (fret) {
+			/* Copy did not complete; don't map a half-copied page. */
+			ret = -EIO;
+		} else if (mmu_interval_read_retry(notifier, range.notifier_seq)) {
+			ret = -EBUSY;
+		} else {
+			unsigned long map_addr = migrate.start;
+			unsigned int page_shift = PAGE_SHIFT + order;
+
+			/*
+			 * If nothing migrated might still be able to mirror.
+			 * In that case use the snapshot hmm_pfn.
+			 * npages == 1 always today.
+			 */
+			if (npages == 1 && !(pfns[0] & NVIF_VMM_PFNMAP_V0_V))
+				pfns[0] = nouveau_dmem_hmm_pfn_to_map(hmm_pfn0,
+						start, &map_addr, &page_shift);
+
+			__nouveau_pfns_map_locked(svmm, map_addr, pfns, n,
+						  page_shift);
+
+			*out_pfn0 = pfns[0];
+			*out_addr = map_addr;
+			*out_shift = page_shift;
+		}
+		mutex_unlock(&svmm->mutex);
+
+		if (fret)
+			NV_ERROR(drm,
+				 "svm: migrate copy did not complete (%d) for %lx-%lx\n",
+				 fret, start, end);
+
+		while (nr_dma--) {
+			dma_unmap_page(drm->dev->dev, dma_info[nr_dma].dma_addr,
+				       dma_info[nr_dma].size, DMA_BIDIRECTIONAL);
+		}
+		migrate_vma_finalize(&migrate);
+unlock:
+		mmap_read_unlock(mm);
+	} while (ret == -EBUSY && !time_after(jiffies, timeout));
+
+	/* Nothing migrated or mappable in place, fallback to nouveau_range_fault(). */
+	if (!ret && !(pfns[0] & NVIF_VMM_PFNMAP_V0_V))
+		ret = -ENOENT;
+
+	nouveau_pfns_free(pfns);
+out_free_dma:
+	kfree(dma_info);
+out_free_dst:
+	kfree(migrate.dst);
+out_free_src:
+	kfree(migrate.src);
+	return ret;
+}
+
 int
 nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 			 struct nouveau_svmm *svmm,
diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.h b/drivers/gpu/drm/nouveau/nouveau_dmem.h
index 64da5d3635c8..91e8910cadbf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.h
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.h
@@ -27,6 +27,7 @@ struct drm_file;
 struct nouveau_drm;
 struct nouveau_svmm;
 struct hmm_range;
+struct mmu_interval_notifier;
 
 #if IS_ENABLED(CONFIG_DRM_NOUVEAU_SVM)
 void nouveau_dmem_init(struct nouveau_drm *);
@@ -39,7 +40,18 @@ int nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 			     struct vm_area_struct *vma,
 			     unsigned long start,
 			     unsigned long end);
+int nouveau_dmem_migrate_fault(struct nouveau_drm *drm,
+			       struct nouveau_svmm *svmm,
+			       struct mmu_interval_notifier *notifier,
+			       unsigned long start,
+			       unsigned long end,
+			       unsigned long hmm_flags,
+			       u64 *out_pfn0,
+			       unsigned long *out_addr,
+			       unsigned int *out_shift);
 unsigned long nouveau_dmem_page_addr(struct page *page);
+u64 nouveau_dmem_hmm_pfn_to_map(unsigned long hmm_pfn, unsigned long start,
+				unsigned long *map_addr, unsigned int *page_shift);
 
 #else /* IS_ENABLED(CONFIG_DRM_NOUVEAU_SVM) */
 static inline void nouveau_dmem_init(struct nouveau_drm *drm) {}
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index c519c28164fa..960cbf8af974 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -37,6 +37,7 @@
 #include <linux/hmm.h>
 #include <linux/memremap.h>
 #include <linux/rmap.h>
+#include <linux/moduleparam.h>
 
 struct nouveau_svm {
 	struct nouveau_drm *drm;
@@ -78,6 +79,13 @@ struct nouveau_svm {
 #define SVM_DBG(s,f,a...) NV_DEBUG((s)->drm, "svm: "f"\n", ##a)
 #define SVM_ERR(s,f,a...) NV_WARN((s)->drm, "svm: "f"\n", ##a)
 
+/* When set, migrate the faulting range to VRAM on GPU fault (default off). */
+static bool nouveau_svm_migrate_on_fault;
+module_param_named(svm_migrate_on_fault, nouveau_svm_migrate_on_fault, bool,
+		   0644);
+MODULE_PARM_DESC(svm_migrate_on_fault,
+		 "migrate system memory to VRAM on GPU fault (default off)");
+
 struct nouveau_pfnmap_args {
 	struct nvif_ioctl_v0_hdr i;
 	struct nvif_ioctl_mthd_v0_hdr m;
@@ -182,9 +190,10 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
 
 		addr = max(addr, vma->vm_start);
 		next = min(vma->vm_end, end);
-		/* This is a best effort so we ignore errors */
-		nouveau_dmem_migrate_vma(cli->drm, cli->svm.svmm, vma, addr,
-					 next);
+		/* Best effort; skipped when migrate-on-fault does the migration. */
+		if (!nouveau_svm_migrate_on_fault)
+			nouveau_dmem_migrate_vma(cli->drm, cli->svm.svmm, vma,
+						 addr, next);
 		addr = next;
 	}
 
@@ -390,7 +399,7 @@ nouveau_svmm_init(struct drm_device *dev, void *data,
 }
 
 /* Issue fault replay for GPU to retry accesses that faulted previously. */
-static void
+void
 nouveau_svm_fault_replay(struct nouveau_svm *svm)
 {
 	SVM_DBG(svm, "replay");
@@ -527,6 +536,14 @@ static bool nouveau_svm_range_invalidate(struct mmu_interval_notifier *mni,
 	    range->owner == sn->svmm->vmm->cli->drm->dev)
 		return true;
 
+	/*
+	 * Ignore our own migrate-on-fault invalidation; otherwise its
+	 * MMU_NOTIFY_MIGRATE bumps the seq and read_retry() spins to timeout.
+	 */
+	if (range->event == MMU_NOTIFY_MIGRATE &&
+	    range->owner == sn->svmm->vmm->cli->drm->dev)
+		return true;
+
 	/*
 	 * serializes the update to mni->invalidate_seq done by caller and
 	 * prevents invalidation of the PTE from progressing while HW is being
@@ -551,48 +568,25 @@ static void nouveau_hmm_convert_pfn(struct nouveau_drm *drm,
 				    struct hmm_range *range,
 				    struct nouveau_pfnmap_args *args)
 {
-	struct page *page;
+	unsigned long map_addr;
+	unsigned int page_shift;
 
 	/*
 	 * The address prepared here is passed through nvif_object_ioctl()
 	 * to an eventual DMA map in something like gp100_vmm_pgt_pfn()
 	 *
 	 * This is all just encoding the internal hmm representation into a
-	 * different nouveau internal representation.
+	 * different nouveau internal representation; see the shared encoder
+	 * nouveau_dmem_hmm_pfn_to_map() (also widens to the CPU folio order).
 	 */
-	if (!(range->hmm_pfns[0] & HMM_PFN_VALID)) {
-		args->p.phys[0] = 0;
-		return;
+	args->p.phys[0] = nouveau_dmem_hmm_pfn_to_map(range->hmm_pfns[0],
+						      args->p.addr, &map_addr,
+						      &page_shift);
+	if (page_shift != PAGE_SHIFT) {
+		args->p.addr = map_addr;
+		args->p.page = page_shift;
+		args->p.size = 1UL << page_shift;
 	}
-
-	page = hmm_pfn_to_page(range->hmm_pfns[0]);
-	/*
-	 * Only map compound pages to the GPU if the CPU is also mapping the
-	 * page as a compound page. Otherwise, the PTE protections might not be
-	 * consistent (e.g., CPU only maps part of a compound page).
-	 * Note that the underlying page might still be larger than the
-	 * CPU mapping (e.g., a PUD sized compound page partially mapped with
-	 * a PMD sized page table entry).
-	 */
-	if (hmm_pfn_to_map_order(range->hmm_pfns[0])) {
-		unsigned long addr = args->p.addr;
-
-		args->p.page = hmm_pfn_to_map_order(range->hmm_pfns[0]) +
-				PAGE_SHIFT;
-		args->p.size = 1UL << args->p.page;
-		args->p.addr &= ~(args->p.size - 1);
-		page -= (addr - args->p.addr) >> PAGE_SHIFT;
-	}
-	if (is_device_private_page(page))
-		args->p.phys[0] = nouveau_dmem_page_addr(page) |
-				NVIF_VMM_PFNMAP_V0_V |
-				NVIF_VMM_PFNMAP_V0_VRAM;
-	else
-		args->p.phys[0] = page_to_phys(page) |
-				NVIF_VMM_PFNMAP_V0_V |
-				NVIF_VMM_PFNMAP_V0_HOST;
-	if (range->hmm_pfns[0] & HMM_PFN_WRITE)
-		args->p.phys[0] |= NVIF_VMM_PFNMAP_V0_W;
 }
 
 static int nouveau_atomic_range_fault(struct nouveau_svmm *svmm,
@@ -728,6 +722,44 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 	return ret;
 }
 
+static int nouveau_range_fault_and_migrate(struct nouveau_svmm *svmm,
+					   struct nouveau_drm *drm,
+					   struct nouveau_pfnmap_args *args,
+					   unsigned long hmm_flags,
+					   struct svm_notifier *notifier)
+{
+	struct mm_struct *mm = svmm->notifier.mm;
+	unsigned long start = args->p.addr;
+	unsigned long end = start + args->p.size;
+	unsigned long map_addr;
+	unsigned int page_shift;
+	u64 pfn0;
+	int ret;
+
+	ret = mmu_interval_notifier_insert(&notifier->notifier, mm,
+					   start, args->p.size,
+					   &nouveau_svm_mni_ops);
+	if (ret)
+		return ret;
+
+	ret = nouveau_dmem_migrate_fault(drm, svmm, &notifier->notifier,
+					 start, end, hmm_flags,
+					 &pfn0, &map_addr, &page_shift);
+
+	if (!ret) {
+		args->p.phys[0] = pfn0;
+		if (page_shift != PAGE_SHIFT) {
+			args->p.addr = map_addr;
+			args->p.page = page_shift;
+			args->p.size = 1UL << page_shift;
+		}
+	}
+
+	mmu_interval_notifier_remove(&notifier->notifier);
+
+	return ret;
+}
+
 static void
 nouveau_svm_fault(struct work_struct *work)
 {
@@ -843,14 +875,25 @@ nouveau_svm_fault(struct work_struct *work)
 		}
 
 		notifier.svmm = svmm;
-		if (atomic)
+		if (atomic) {
 			ret = nouveau_atomic_range_fault(svmm, svm->drm, args,
 							 __struct_size(args),
 							 &notifier);
-		else
+		} else if (nouveau_svm_migrate_on_fault &&
+			   buffer->fault[fi]->access != FAULT_ACCESS_PREFETCH) {
+			/* Fault+migrate in one walk; fall back if nothing migrated. */
+			ret = nouveau_range_fault_and_migrate(svmm, svm->drm,
+							      args, hmm_flags,
+							      &notifier);
+			if (ret)
+				ret = nouveau_range_fault(svmm, svm->drm, args,
+							  __struct_size(args),
+							  hmm_flags, &notifier);
+		} else {
 			ret = nouveau_range_fault(svmm, svm->drm, args,
 						  __struct_size(args),
 						  hmm_flags, &notifier);
+		}
 		mmput(mm);
 
 		limit = args->p.addr + args->p.size;
@@ -935,21 +978,29 @@ nouveau_pfns_free(u64 *pfns)
 }
 
 void
-nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
-		 unsigned long addr, u64 *pfns, unsigned long npages,
-		 unsigned int page_shift)
+__nouveau_pfns_map_locked(struct nouveau_svmm *svmm, unsigned long addr,
+			  u64 *pfns, unsigned long npages,
+			  unsigned int page_shift)
 {
 	struct nouveau_pfnmap_args *args = nouveau_pfns_to_args(pfns);
 
+	lockdep_assert_held(&svmm->mutex);
+
 	args->p.addr = addr;
 	args->p.size = npages << page_shift;
 	args->p.page = page_shift;
 
-	mutex_lock(&svmm->mutex);
-
 	nvif_object_ioctl(&svmm->vmm->vmm.object, args,
 			  struct_size(args, p.phys, npages), NULL);
+}
 
+void
+nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
+		 unsigned long addr, u64 *pfns, unsigned long npages,
+		 unsigned int page_shift)
+{
+	mutex_lock(&svmm->mutex);
+	__nouveau_pfns_map_locked(svmm, addr, pfns, npages, page_shift);
 	mutex_unlock(&svmm->mutex);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.h b/drivers/gpu/drm/nouveau/nouveau_svm.h
index 3fd78662f17e..0e7ff03f80ea 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.h
@@ -5,6 +5,7 @@
 struct drm_device;
 struct drm_file;
 struct nouveau_drm;
+struct nouveau_svm;
 
 struct nouveau_svmm {
 	struct mmu_notifier notifier;
@@ -35,6 +36,10 @@ void nouveau_pfns_free(u64 *pfns);
 void nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
 		      unsigned long addr, u64 *pfns, unsigned long npages,
 		      unsigned int page_shift);
+void __nouveau_pfns_map_locked(struct nouveau_svmm *svmm, unsigned long addr,
+			       u64 *pfns, unsigned long npages,
+			       unsigned int page_shift);
+void nouveau_svm_fault_replay(struct nouveau_svm *svm);
 #else /* IS_ENABLED(CONFIG_DRM_NOUVEAU_SVM) */
 static inline void nouveau_svm_init(struct nouveau_drm *drm) {}
 static inline void nouveau_svm_fini(struct nouveau_drm *drm) {}
-- 
2.55.0

