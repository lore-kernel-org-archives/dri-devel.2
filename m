Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7ACC98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6868310E386;
	Tue, 22 Sep 2026 05:34:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="KHEwPqmX";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E63810E57F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790055293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggFf9vsm/p6yby6h1KHVQFgSLVs+0wCPIsczXGIceWQ=;
 b=KHEwPqmXNAdSWNjJvjJlHQzdkd52pTIACHAVZ2ZGjmX3Y27EWnKwumQVKuHBpDW/p1fp6R
 ZGFf6KhecGF4W9WO+tv5cRWGex6J5U2ivYm4AUdxO4qrZuzZ74Gj2aVz+mza8/LCYaN4QV
 hKlJkGuP8STqQTsuvbyU3xmaD5t76bI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-ju6zTGpoNOOhu-kiMcezjw-1; Tue, 22 Sep 2026 01:34:50 -0400
X-MC-Unique: ju6zTGpoNOOhu-kiMcezjw-1
X-Mimecast-MFC-AGG-ID: ju6zTGpoNOOhu-kiMcezjw_1790055289
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b4fe10d092so2566787e87.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 22:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790055289; x=1790660089;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ggFf9vsm/p6yby6h1KHVQFgSLVs+0wCPIsczXGIceWQ=;
 b=bQ0fs/O0XXshBUP700s9KHrV9EWqgWUkRATxz1mmfTlKE9auGIHVwXcoTQVCVYgcGH
 BsFJV0lb1xLZiCqmMy0G/APikAlBxU1q3JWCK/FLj/GUiPva39VbLo+Kf7oJYZGJkDkM
 N6bSaSEU5Acwml7Q2SXdHxbuhvE6hIrzwIgtgDdK6LVCj0ia6edIiZdnpdxiT9UN096g
 vcEuq/AJmOjVgfYpJ1FXKSuNkUB23Byo1H1fM+DQzWF+2MWE/ftNg7XocSN9l8NAtKxH
 V4f8uK1BurjgJ6efK2Gpuf8MoT8VwAoCcHlD869bVHmVpepLkqWElBE0K5ok7Q5OsTAT
 n1rg==
X-Gm-Message-State: AFuF++mNav93pJCAS/4HvKF8siPfzlNIhUrSrfe4l96vBU2+KTFZuk3X
 ZmeDbS2iOgtJ0T+aMksOhkw3dqUw3mL2YZZKNk7KhLoPW3WCi0lRXUhHfZxWLgDIDTbildK+fu9
 yTSODRfsupN07pAuR6jAYneA4yWDhB8DzSDoHE4dyj2BT+ngWJ7vUD/u+hW2guz7VLQ8d
X-Gm-Gg: AYBFou2jpwLXLIb10qj7T+K92FIxDQ2DjxJQuIC3L34Qu1iyP9Of2q+OeTL2J14D1dx
 kRKtqYy5YMk+rHsTtVu3HTyqoxfinZRwNT0blbUy9y1oJXmeOTbmN0zrsU0W8cpa1+Ln+u2UuRr
 4e6BAzylKs0afrZKPzXiSOIECIl4M5mMwaBYNH1Gy5WNvR71p86fYR4QxV2/xs2X38H8Y6bT2fH
 h9K/9cQnIQrNj4W6CLI9eakz1Q5ve2L6G49TuXe2Njh7/BADxyEvt3YhgpGhUK1PAt9ikpIsoGU
 7ZdVNgqbfWnUK+5pIuzwcOe4/3w0TX48HeHszdHEfpZnriQfHVV0w7veZrP2QK20i3NHqK4k/d9
 8FdRPsCV4+nuvKodktgQL
X-Received: by 2002:ac2:51c3:0:b0:5b4:b03e:b17 with SMTP id
 2adb3069b0e04-5b8c17f19eemr4703886e87.4.1790055288815; 
 Mon, 21 Sep 2026 22:34:48 -0700 (PDT)
X-Received: by 2002:ac2:51c3:0:b0:5b4:b03e:b17 with SMTP id
 2adb3069b0e04-5b8c17f19eemr4703877e87.4.1790055288311; 
 Mon, 21 Sep 2026 22:34:48 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d46e0966sm191742e87.55.2026.09.21.22.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 22:34:47 -0700 (PDT)
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
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v14 03/12] mm/hmm: preparations for HMM to participate in
 migration
Date: Tue, 22 Sep 2026 08:34:12 +0300
Message-ID: <20260922053421.4092027-4-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922053421.4092027-1-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sbr1rJnVdsLjuE0PcGoJMyCS3Jki3WGRHKzFxxpxil8_1790055289
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

From: Mika Penttilä <mpenttil@redhat.com>

For migration to happen after hmm_range_fault(), the vma has to
retrieved. Luckily, pagewalk already resolves that for us, so
just have to save it for further use. For migration, mmap_lock
has to be hold for the whole operation, so vma stays stable.
In case lock-drop behavior is requested, return an error while
migrating. Also, rename some struct hmm_vma_walk fields to solve
namespace collisions, and we are later introducing more
xxlocked fields so be unambiguous.

Take care also of firing the mmu_notifier when migrating.

Also, prepare for differencies of how mm_struct * is retrieved
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
 include/linux/migrate.h |  49 +++++++++++++++++-
 lib/test_hmm.c          |   2 +-
 mm/hmm.c                | 107 ++++++++++++++++++++++++++++++++++------
 3 files changed, 141 insertions(+), 17 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 280ec9a866c7..01c5f62a56e9 100644
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
@@ -151,7 +175,7 @@ static inline unsigned long migrate_pfn(unsigned long pfn)
 	return (pfn << MIGRATE_PFN_SHIFT) | MIGRATE_PFN_VALID;
 }
 
-enum migrate_vma_direction {
+enum migrate_vma_info {
 	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
 	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
 	MIGRATE_VMA_SELECT_DEVICE_COHERENT = 1 << 2,
@@ -193,6 +217,29 @@ struct migrate_vma {
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
index 6911daa9f854..cd88e8177d0a 100644
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
index 2f1e98c6b644..be39d2e5403a 100644
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
@@ -28,15 +29,21 @@
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
@@ -95,7 +102,7 @@ static int hmm_record_fault(unsigned long addr, unsigned long end,
 
 	WARN_ON_ONCE(!required_fault);
 	hmm_vma_walk->last = addr;
-	hmm_vma_walk->end = end;
+	hmm_vma_walk->fault_end = end;
 	hmm_vma_walk->required_fault = required_fault;
 	return HMM_FAULT_PENDING;
 }
@@ -400,6 +407,57 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 }
 #endif  /* CONFIG_ARCH_HAS_PMD_SOFTLEAVES */
 
+static int hmm_vma_capture_migrate_range(unsigned long start,
+					 unsigned long end,
+					 struct mm_walk *walk)
+{
+	struct hmm_vma_walk *hmm_vma_walk = walk->private;
+	struct hmm_range *range = hmm_vma_walk->range;
+
+	if (!hmm_select_migrate(range))
+		return 0;
+
+	if (hmm_vma_walk->vma && (hmm_vma_walk->vma != walk->vma))
+		return -ERANGE;
+
+	hmm_vma_walk->vma = walk->vma;
+	hmm_vma_walk->start = start;
+	hmm_vma_walk->end = end;
+
+	if (end - start > range->end - range->start)
+		return -ERANGE;
+
+	if (!hmm_vma_walk->mmu_range.owner) {
+		mmu_notifier_range_init_owner(&hmm_vma_walk->mmu_range, MMU_NOTIFY_MIGRATE, 0,
+					      walk->vma->vm_mm, start, end,
+					      range->dev_private_owner);
+		mmu_notifier_invalidate_range_start(&hmm_vma_walk->mmu_range);
+	}
+
+	return 0;
+}
+
+static void hmm_vma_post_range_fault(struct hmm_vma_walk *hmm_vma_walk)
+{
+
+	struct hmm_range *range = hmm_vma_walk->range;
+
+	if (hmm_select_migrate(range) &&
+	    hmm_vma_walk->mmu_range.owner) {
+		/*
+		 *  The migrate_vma path has the following initialized,
+		 *  so take care of fault path below.
+		 */
+		if (range->notifier) {
+			hmm_fill_migrate_vma(range,
+					     hmm_vma_walk->vma,
+					     hmm_vma_walk->start,
+					     hmm_vma_walk->end);
+		}
+		mmu_notifier_invalidate_range_end(&hmm_vma_walk->mmu_range);
+	}
+}
+
 static int hmm_vma_walk_pmd(pmd_t *pmdp,
 			    unsigned long start,
 			    unsigned long end,
@@ -594,6 +652,11 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	struct vm_area_struct *vma = walk->vma;
+	int r;
+
+	r = hmm_vma_capture_migrate_range(start, end, walk);
+	if (r)
+		return r;
 
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)) &&
 	    vma->vm_flags & VM_READ)
@@ -646,12 +709,12 @@ static int hmm_do_fault(struct mm_struct *mm,
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
@@ -670,8 +733,8 @@ static int hmm_do_fault(struct mm_struct *mm,
 		ret = handle_mm_fault(vma, addr, fault_flags, NULL);
 
 		if (ret & (VM_FAULT_COMPLETED | VM_FAULT_RETRY)) {
-			if (hmm_vma_walk->locked)    /* needed by sparse */
-				*hmm_vma_walk->locked = false;
+			if (hmm_vma_walk->mmlocked)    /* needed by sparse */
+				*hmm_vma_walk->mmlocked = false;
 			else
 				WARN_ON_ONCE(1);    /* broken fault handler */
 			return HMM_FAULT_UNLOCKED;
@@ -694,19 +757,31 @@ static int hmm_range_fault_locked(struct hmm_range *range, bool *locked)
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
@@ -732,6 +807,8 @@ static int hmm_range_fault_locked(struct hmm_range *range, bool *locked)
 		 * output, and all >= are still at their input values.
 		 */
 	} while (ret == -EBUSY);
+
+	hmm_vma_post_range_fault(&hmm_vma_walk);
 	return ret;
 }
 
-- 
2.55.0

