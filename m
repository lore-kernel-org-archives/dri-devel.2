Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B356E606A339
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MBy03j6g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0097210F36B;
	Tue,  3 Nov 2026 06:17:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B8310F368
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793686618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwFMpGSCFzeJYoNRme4QfWvYKFPbM3x9TfOQ7Wl4QBs=;
 b=MBy03j6g9l1ryk38CvNE5WYC4qlbTV9PLiYbuCPhYNStDO8dhNNw7ndn2wiQZHT82MeHgT
 z0ofx+FJ1epxOpXfG/wF4OZ9nD6rqO8EvVrxgNAe8XYuNFnZpOg7aG7xv2YEikzvYVZexZ
 5LMgposk8jwNFgyY1AEuVshttVyEvlc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-hAw227vJOEiK49cobdcN0g-1; Tue, 03 Nov 2026 01:16:57 -0500
X-MC-Unique: hAw227vJOEiK49cobdcN0g-1
X-Mimecast-MFC-AGG-ID: hAw227vJOEiK49cobdcN0g_1793686616
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5bcf6b5224cso1923009e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793686615; x=1794291415;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PwFMpGSCFzeJYoNRme4QfWvYKFPbM3x9TfOQ7Wl4QBs=;
 b=kAkjm3oNmB/e08VCfojSWRvqvJPWzdUbJjQFi9oyIiCJ09r9bGsps97gwwnmlDHJyD
 EXy8rQcaox3S6txZhMOmeB9wF2O1IIPd4J57lmugHNOO53gxgiNPmZlNWPGHlbTmVLOX
 BgQKvQVZSNFB0V/p9WpXJeDq6Eb08mXqW7WxSb7jQoe7NCJ5JNMzUIS1TZjHUImLqnqM
 pG9R+0eVvmf9K/fONRni0q5h+K8xFtNpoEXNuT+ocnj1LR+rcEnoqr4Yh65RzicyCgNo
 K9ARQVw4FHLtr2WxvF3+E37BlBDorbq2xzmaXRr8iRf2Da0HEQN/hitHAS/+t2I3iaE2
 SmmA==
X-Gm-Message-State: APuU4Z/ZjSN3qFAOisYe78zw8cWOjrj+zNKiP6atb1X/eRRfAWdGOXFD
 Jp7QnfMlamT17+NpVaNMB4jsyZhmyAouTeYeO/6LtZxgbv1KMtCmbl06bRpG+J5NLXBQHIX0LJT
 TzXYeaji3fwQLJdlVra7I6bEz10Ytjp1n1RAlP+99bacFD5JKki/jdthxLhfJWWqRBVP8
X-Gm-Gg: AYBFou1xtsGfrLcZ5pNeBgfwEwmOkSYmCRRGP9kmp+1GDHZB9jkDqRaZ7BNEAF7VrkS
 /zLsgW0HKRCYdFaj09SYOIiF/HXcjOgwlObnm30Ut7x3yjJohkxUj/QgFhZUPcixFVVW6j/EzIR
 TLnO0Yj19N2ZCLQI575eMjliblwBt6YPXkU89rAIKxriX/bBAVUqDskYocjkJVDCSpnS8K/6t0p
 4k5fMOQLe0u390VZ5v8725E6R3eQ+d022dp+utke39HaPKbAa6enV9+SuhGlu85vn5cqxvJRtHP
 DLbLyX26xFB0mLiIUkn5yFilQeWtipPV39dcSt/NTuMMWG74xmkwfMnayF2MD/C8kSAqjWMY86T
 O5hF40uzXLkeYdFChnnoi0DojqC+TkoiAAiv5iU4zRKSuFkG26Y/H1oba4wy40rdWUGbbNw==
X-Received: by 2002:a05:6512:158d:b0:5bf:e799:c7f3 with SMTP id
 2adb3069b0e04-5bfe799c920mr2368429e87.61.1793686615511; 
 Mon, 02 Nov 2026 22:16:55 -0800 (PST)
X-Received: by 2002:a05:6512:158d:b0:5bf:e799:c7f3 with SMTP id
 2adb3069b0e04-5bfe799c920mr2368381e87.61.1793686612466; 
 Mon, 02 Nov 2026 22:16:52 -0800 (PST)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe073e0f9sm1964634e87.54.2026.11.02.22.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 22:16:51 -0800 (PST)
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
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v17 03/12] mm/hmm: preparations for HMM to participate in
 migration
Date: Tue,  3 Nov 2026 08:16:20 +0200
Message-ID: <20261103061629.972669-4-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103061629.972669-1-mpenttil@redhat.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SNs7fl7uvB0MzOsdq8pqZTwZIu2jNvD4CSFDeHU3yCw_1793686616
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mika Penttilä <mpenttil@redhat.com>

For migration to happen after hmm_range_fault(), the vma has to be
retrieved. Luckily, pagewalk already resolves that for us, so
just have to save it for further use. For migration, mmap_lock
has to be held for the whole operation, so vma stays stable.
In case lock-drop behavior is requested, return an error while
migrating. Also, rename some struct hmm_vma_walk fields to solve
namespace collisions, and we are later introducing more
xxlocked fields so be unambiguous.

Take care also of firing the mmu_notifier when migrating.

When migrating, requests come only from range->default_flags
(pfn_flags_mask must be 0), so the input range->hmm_pfns carry
nothing and are cleared at the start of hmm_range_fault(). Collected
entries (HMM_PFN_VALID | HMM_PFN_MIGRATE) can then be told apart
reliably during the walk and on rollback. This also means that
HMM_PFN_INOUT_FLAGS such as HMM_PFN_DMA_MAPPED are not preserved
across a migrating call, which is intended since the pages are being
replaced.

Also, prepare for differences of how mm_struct * is retrieved
in fault and migrate_vma paths.

Cc: David Hildenbrand <david@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Suggested-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---
 include/linux/migrate.h |  50 ++++++++++++-
 lib/test_hmm.c          |   2 +-
 mm/hmm.c                | 157 ++++++++++++++++++++++++++++++++++------
 3 files changed, 186 insertions(+), 23 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 280ec9a866c7..dd7dd7ec6995 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -5,6 +5,7 @@
 #include <linux/mm.h>
 #include <linux/hmm.h>
 #include <linux/mempolicy.h>
+#include <linux/mmu_notifier.h>
 #include <linux/migrate_mode.h>
 #include <linux/hugetlb.h>
 
@@ -108,6 +109,29 @@ static inline void softleaf_entry_wait_on_locked(softleaf_t entry, spinlock_t *p
 	spin_unlock(ptl);
 }
 
+enum migrate_vma_info {
+	MIGRATE_VMA_SELECT_NONE = 0,
+	MIGRATE_VMA_SELECT_COMPOUND = MIGRATE_VMA_SELECT_NONE,
+};
+
+static inline enum migrate_vma_info hmm_select_migrate(struct hmm_range *range)
+{
+	return MIGRATE_VMA_SELECT_NONE;
+}
+
+static inline void hmm_fill_migrate_vma(struct hmm_range *range,
+					struct vm_area_struct *vma,
+					unsigned long start,
+					unsigned long end)
+{
+}
+
+#ifdef CONFIG_MMU_NOTIFIER
+static inline struct mm_struct *hmm_range_fault_mm(struct hmm_range *range)
+{
+	return range->notifier->mm;
+}
+#endif
 #endif /* CONFIG_MIGRATION */
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -151,7 +175,8 @@ static inline unsigned long migrate_pfn(unsigned long pfn)
 	return (pfn << MIGRATE_PFN_SHIFT) | MIGRATE_PFN_VALID;
 }
 
-enum migrate_vma_direction {
+enum migrate_vma_info {
+	MIGRATE_VMA_SELECT_NONE = 0,
 	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
 	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
 	MIGRATE_VMA_SELECT_DEVICE_COHERENT = 1 << 2,
@@ -193,6 +218,29 @@ struct migrate_vma {
 	struct page		*fault_page;
 };
 
+// TODO: enable migration
+static inline enum migrate_vma_info hmm_select_migrate(struct hmm_range *range)
+{
+	return 0;
+}
+
+#ifdef CONFIG_MMU_NOTIFIER
+static inline struct mm_struct *hmm_range_fault_mm(struct hmm_range *range)
+{
+	return range->notifier ? range->notifier->mm : range->migrate->vma->vm_mm;
+}
+#endif
+
+static inline void hmm_fill_migrate_vma(struct hmm_range *range,
+					struct vm_area_struct *vma,
+					unsigned long start,
+					unsigned long end)
+{
+	range->migrate->vma   = vma;
+	range->migrate->start = start;
+	range->migrate->end   = end;
+}
+
 int migrate_vma_setup(struct migrate_vma *args);
 void migrate_vma_pages(struct migrate_vma *migrate);
 void migrate_vma_finalize(struct migrate_vma *migrate);
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index b409c42bfe6f..f05f801b8404 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -145,7 +145,7 @@ static bool dmirror_is_private_zone(struct dmirror_device *mdevice)
 		HMM_DMIRROR_MEMORY_DEVICE_PRIVATE);
 }
 
-static enum migrate_vma_direction
+static enum migrate_vma_info
 dmirror_select_device(struct dmirror *dmirror)
 {
 	return (dmirror->mdevice->zone_device_type ==
diff --git a/mm/hmm.c b/mm/hmm.c
index 2f1e98c6b644..9220e6648636 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -21,6 +21,7 @@
 #include <linux/pagemap.h>
 #include <linux/leafops.h>
 #include <linux/hugetlb.h>
+#include <linux/migrate.h>
 #include <linux/memremap.h>
 #include <linux/sched/mm.h>
 #include <linux/jump_label.h>
@@ -28,15 +29,23 @@
 #include <linux/pci-p2pdma.h>
 #include <linux/mmu_notifier.h>
 #include <linux/memory_hotplug.h>
+#include <asm/tlbflush.h>
 
 #include "internal.h"
 
 struct hmm_vma_walk {
-	struct hmm_range	*range;
-	bool			*locked;
-	unsigned long		last;
-	unsigned long		end;
-	unsigned int		required_fault;
+	struct mmu_notifier_range	mmu_range;
+	/* Set once mmu_range is armed with mmu_notifier_invalidate_range_start() */
+	bool				mmu_armed;
+	struct vm_area_struct		*vma;
+	struct hmm_range		*range;
+	unsigned long			start;
+	unsigned long			end;
+	unsigned long			last;
+	/* fault and lock drop related fields */
+	bool				*mmlocked;
+	unsigned long			fault_end;
+	unsigned int			required_fault;
 };
 
 /*
@@ -95,7 +104,7 @@ static int hmm_record_fault(unsigned long addr, unsigned long end,
 
 	WARN_ON_ONCE(!required_fault);
 	hmm_vma_walk->last = addr;
-	hmm_vma_walk->end = end;
+	hmm_vma_walk->fault_end = end;
 	hmm_vma_walk->required_fault = required_fault;
 	return HMM_FAULT_PENDING;
 }
@@ -176,7 +185,7 @@ static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
 	required_fault =
 		hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0);
 	if (!walk->vma) {
-		if (required_fault)
+		if (required_fault || hmm_select_migrate(range))
 			return -EFAULT;
 		return hmm_pfns_fill(addr, end, range, HMM_PFN_ERROR);
 	}
@@ -400,6 +409,73 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 }
 #endif  /* CONFIG_ARCH_HAS_PMD_SOFTLEAVES */
 
+static int hmm_vma_capture_migrate_range(unsigned long start,
+					 unsigned long end,
+					 struct mm_walk *walk)
+{
+	struct hmm_vma_walk *hmm_vma_walk = walk->private;
+	struct hmm_range *range = hmm_vma_walk->range;
+	struct vm_area_struct *vma = walk->vma;
+
+	if (!hmm_select_migrate(range))
+		return 0;
+
+	if (!hmm_vma_walk->vma) {
+		/* Same vma restrictions as migrate_vma_setup() */
+		if (!vma_is_mm_backed(vma) || vma_is_hugetlb(vma) ||
+		    vma_is_dax(vma))
+			return -EINVAL;
+		/*
+		 * migrate_vma covers the whole range and indexes src[] from
+		 * range->start, so a single vma must cover the whole range.
+		 */
+		if (vma->vm_start > range->start ||
+		    vma->vm_end < range->end)
+			return -ERANGE;
+		hmm_vma_walk->vma = vma;
+		hmm_vma_walk->start = start;
+		hmm_vma_walk->end = end;
+	}
+
+	/*
+	 * The invalidation is closed before faulting, see
+	 * hmm_range_fault_locked(), so (re)open it for each walk.
+	 */
+	if (!hmm_vma_walk->mmu_armed) {
+		mmu_notifier_range_init_owner(&hmm_vma_walk->mmu_range, MMU_NOTIFY_MIGRATE, 0,
+					      walk->vma->vm_mm, hmm_vma_walk->start,
+					      hmm_vma_walk->end, range->dev_private_owner);
+		mmu_notifier_invalidate_range_start(&hmm_vma_walk->mmu_range);
+		hmm_vma_walk->mmu_armed = true;
+	}
+
+	return 0;
+}
+
+static void hmm_vma_migrate_disarm(struct hmm_vma_walk *hmm_vma_walk)
+{
+	if (hmm_vma_walk->mmu_armed) {
+		mmu_notifier_invalidate_range_end(&hmm_vma_walk->mmu_range);
+		hmm_vma_walk->mmu_armed = false;
+	}
+}
+
+static void hmm_vma_post_range_fault(struct hmm_vma_walk *hmm_vma_walk)
+{
+	struct hmm_range *range = hmm_vma_walk->range;
+
+	/*
+	 * The migrate_vma path has the following initialized. For the fault
+	 * path fill them in, also when the walk failed before capturing the
+	 * vma, so migrate_hmm_range_setup() always sees the range.
+	 */
+	if (hmm_select_migrate(range) && range->notifier)
+		hmm_fill_migrate_vma(range,
+				     hmm_vma_walk->vma,
+				     range->start, range->end);
+	hmm_vma_migrate_disarm(hmm_vma_walk);
+}
+
 static int hmm_vma_walk_pmd(pmd_t *pmdp,
 			    unsigned long start,
 			    unsigned long end,
@@ -594,10 +670,13 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	struct vm_area_struct *vma = walk->vma;
+	/* Migration without faulting moves pages regardless of VM_READ */
+	bool migrate_only = hmm_select_migrate(range) &&
+			    !(range->default_flags & HMM_PFN_REQ_FAULT);
 
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)) &&
-	    vma->vm_flags & VM_READ)
-		return 0;
+	    (vma->vm_flags & VM_READ || migrate_only))
+		return hmm_vma_capture_migrate_range(start, end, walk);
 
 	/*
 	 * vma ranges that don't have struct page backing them or map I/O
@@ -607,10 +686,11 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
 	 * allow write access either. HMM does not support architectures that
 	 * allow write without read.
 	 *
-	 * If a fault is requested for an unsupported range then it is a hard
-	 * failure.
+	 * If a fault or migration is requested for an unsupported range then
+	 * it is a hard failure.
 	 */
-	if (hmm_range_need_fault(hmm_vma_walk,
+	if (hmm_select_migrate(range) ||
+	    hmm_range_need_fault(hmm_vma_walk,
 				 range->hmm_pfns +
 					 ((start - range->start) >> PAGE_SHIFT),
 				 (end - start) >> PAGE_SHIFT, 0))
@@ -646,12 +726,12 @@ static int hmm_do_fault(struct mm_struct *mm,
 			struct hmm_vma_walk *hmm_vma_walk)
 {
 	unsigned long addr = hmm_vma_walk->last;
-	unsigned long end = hmm_vma_walk->end;
+	unsigned long end = hmm_vma_walk->fault_end;
 	unsigned int required_fault = hmm_vma_walk->required_fault;
 	unsigned int fault_flags = FAULT_FLAG_REMOTE;
 	struct vm_area_struct *vma;
 
-	if (hmm_vma_walk->locked)
+	if (hmm_vma_walk->mmlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	vma = vma_lookup(mm, addr);
@@ -670,8 +750,8 @@ static int hmm_do_fault(struct mm_struct *mm,
 		ret = handle_mm_fault(vma, addr, fault_flags, NULL);
 
 		if (ret & (VM_FAULT_COMPLETED | VM_FAULT_RETRY)) {
-			if (hmm_vma_walk->locked)    /* needed by sparse */
-				*hmm_vma_walk->locked = false;
+			if (hmm_vma_walk->mmlocked)    /* needed by sparse */
+				*hmm_vma_walk->mmlocked = false;
 			else
 				WARN_ON_ONCE(1);    /* broken fault handler */
 			return HMM_FAULT_UNLOCKED;
@@ -694,19 +774,45 @@ static int hmm_range_fault_locked(struct hmm_range *range, bool *locked)
 {
 	struct hmm_vma_walk hmm_vma_walk = {
 		.range = range,
-		.locked = locked,
+		.mmlocked = locked,
 		.last = range->start,
 	};
-	struct mm_struct *mm = range->notifier->mm;
+	/*
+	 *  Could be serving a device fault or come from migrate
+	 *  entry point. For the former we have not resolved the vma
+	 *  yet, and the latter we don't have a notifier (but have a vma).
+	 *
+	 */
+	struct mm_struct *mm = hmm_range_fault_mm(range);
 	int ret;
 
+	/* Migration is incompatible with mmap lock drop */
+	if (locked && hmm_select_migrate(range))
+		return -EINVAL;
+
+	/*
+	 * Migration takes its requests only from default_flags, so the input
+	 * pfns carry nothing. Clear them so that collected entries can be
+	 * told apart reliably during the walk and on rollback.
+	 */
+	if (hmm_select_migrate(range)) {
+		WARN_ON_ONCE(range->pfn_flags_mask);
+		WARN_ON_ONCE(range->dev_private_owner !=
+			     range->migrate->pgmap_owner);
+		memset(range->hmm_pfns, 0,
+		       ((range->end - range->start) >> PAGE_SHIFT) *
+		       sizeof(*range->hmm_pfns));
+	}
+
 	mmap_assert_locked(mm);
 
 	do {
 		/* If range is no longer valid force retry. */
-		if (mmu_interval_check_retry(range->notifier,
-					     range->notifier_seq))
-			return -EBUSY;
+		if (range->notifier && mmu_interval_check_retry(range->notifier,
+								range->notifier_seq)) {
+			ret =  -EBUSY;
+			break;
+		}
 		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
 				      &hmm_walk_ops, &hmm_vma_walk);
 		/*
@@ -718,6 +824,13 @@ static int hmm_range_fault_locked(struct hmm_range *range, bool *locked)
 		 * now-present entries.
 		 */
 		if (ret == HMM_FAULT_PENDING) {
+			/*
+			 * Don't hold the migrate invalidation across a
+			 * possibly sleeping fault. Already collected entries
+			 * stay locked and referenced, and the next walk
+			 * reopens the invalidation.
+			 */
+			hmm_vma_migrate_disarm(&hmm_vma_walk);
 			ret = hmm_do_fault(mm, &hmm_vma_walk);
 			if (ret == HMM_FAULT_UNLOCKED) {
 				if (fatal_signal_pending(current))
@@ -732,6 +845,8 @@ static int hmm_range_fault_locked(struct hmm_range *range, bool *locked)
 		 * output, and all >= are still at their input values.
 		 */
 	} while (ret == -EBUSY);
+
+	hmm_vma_post_range_fault(&hmm_vma_walk);
 	return ret;
 }
 
-- 
2.55.0

