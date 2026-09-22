Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA48C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B982D10E644;
	Tue, 22 Sep 2026 05:34:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HOBNsqYZ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5871510E41B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790055294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AT0RwoJ8r2XRPNe8c9sAnpXjwtunlXN+XFUKufZZink=;
 b=HOBNsqYZMM+GhWXjnf1OcFXuZe3S33usCEnkthb1xHvqOXodOlljgmm5MNw1qsaBNIOp2w
 DUX5NlYjx+TSn+an+XSJtF5/3x4j71r/ft/dAcjEYU6Qf0komstZzMjZkoFAwQDwx8SxND
 YDitMYol48fTFr8ioJR4zBu672B8MC4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-FWanFMhlPk6SlrBQhKRVSw-1; Tue, 22 Sep 2026 01:34:53 -0400
X-MC-Unique: FWanFMhlPk6SlrBQhKRVSw-1
X-Mimecast-MFC-AGG-ID: FWanFMhlPk6SlrBQhKRVSw_1790055292
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b4fe10d092so2566806e87.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 22:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790055291; x=1790660091;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AT0RwoJ8r2XRPNe8c9sAnpXjwtunlXN+XFUKufZZink=;
 b=TZCKqUYmAs/ZEejdYf2un4O1iQU6VoDrLvJ1xZNAJ2FrHOHlolT7iTyR7nnsc1CgvU
 TIqMVWRdSdAZUCY0X0CpQGVxM2XL7jVTbTYcMJIXMv7FuZXxEeFe5ylvQ6hQt5dMvyT/
 cD/WRsbz+hnWe6Ho/Tay/ZkLRrRoa/IxGCDk1L0RfoOmnetlvW+7sv20kR0isaDLMyzm
 cO6+GAVIQQEZgteiFi1ddxFGGwrmqay/FsxipWIUy7PhpIVB84H9b1nGIsQZ0WIQ0bzg
 5Zvq5MjZTs54e082dYKOwBbJZUsNGxZtYbEWjVtd6VrXkJchRHyMdqwHDS2XSZAXi6EJ
 lkSw==
X-Gm-Message-State: AFuF++lFpZKkbNG9GePl7BXQZe40fw+i3VF0oXEP7CIHuMBthu5SQczs
 /hhR06YQYMTPgFL/25Zx15OHF18lBPCTnuJIDDlamyXZOjg59RYwJBsdZj5zrlRXdZCetmdspGO
 pBu7DUqIbugJ7ggt4HgHXLQUEEfcOK6eMJdEw4SFDWHcDxaSHcxu11VhN2AH7hLxBppeW
X-Gm-Gg: AYBFou2MLbN0EtZgbl2B+3GylEUhcbUv1AqHIig+M8UwYxwRm0FnQcUvmd+1AP2ziX2
 Vb+pd9bT/KWbqpL6n9GitwMiSiuYVSg7e5MwO/Nfq9Z8XgDoKSYfSVaoei+Tq63J1P/eOyFfMyz
 LZFEhBuqChd/MGj9WcQiKBOEmz8yiqZwv2VyUWsBhvVZ4APDegtauJwr1S/HIiHjbJdmNNiMIAR
 wWfRHSrHBXgs9/Kr6iER5n9P1nDlOFFBGalUCeDHsDDLPWZzqvS68l31wh5UXTiIn96zCylVHer
 bHoxjOU2TcfIESAgzXGWkj61uwBEwvzmBIF9b0A7AXVjFco0UgIXtOmd2SyJbfxtOd8CiNxSXXl
 h1j1eS9vrLLtZ/PKex51W
X-Received: by 2002:a05:6512:39d1:b0:5b4:24a3:ecf9 with SMTP id
 2adb3069b0e04-5b8c180b6ffmr4840061e87.21.1790055291524; 
 Mon, 21 Sep 2026 22:34:51 -0700 (PDT)
X-Received: by 2002:a05:6512:39d1:b0:5b4:24a3:ecf9 with SMTP id
 2adb3069b0e04-5b8c180b6ffmr4840036e87.21.1790055290968; 
 Mon, 21 Sep 2026 22:34:50 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d46e0966sm191742e87.55.2026.09.21.22.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 22:34:49 -0700 (PDT)
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
Subject: [PATCH v14 04/12] mm/hmm: do the plumbing for HMM to participate in
 migration
Date: Tue, 22 Sep 2026 08:34:13 +0300
Message-ID: <20260922053421.4092027-5-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922053421.4092027-1-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gM3CsMaqjPPx9Pbctkue7l7rlaj3z_Renl_wrBRlbqE_1790055292
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

Do the preparations in hmm_range_fault() and pagewalk callbacks to
do the "collecting" part of migration, needed for migration.

These steps include locking for pmd/pte if migrating, and calling the
still dummy hmm_vma_handle_migrate_prepare_pmd() and
hmm_vma_handle_migrate_prepare()  functions in the pagewalk.

When doing migration, have to have pmd/pte table locked for the
duration of both hmm_vma_handle*() and hmm_vma_handle_migrate_prepare*()
walks, and unlock when handling the faults.

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
 mm/hmm.c | 361 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 310 insertions(+), 51 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index be39d2e5403a..4805c88347e6 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -40,6 +40,16 @@ struct hmm_vma_walk {
 	unsigned long			start;
 	unsigned long			end;
 	unsigned long			last;
+	/*
+	 * For migration we need pte/pmd locked for the handle_* and
+	 * prepare_* regions. While faulting we have to drop the locks
+	 * and start again. ptelocked and pmdlocked hold the state
+	 * and tell  if need to drop locks before faulting.
+	 * ptl is the lock held for pte or pmd.
+	 */
+	bool				ptelocked;
+	bool				pmdlocked;
+	spinlock_t			*ptl;
 	/* fault and lock drop related fields */
 	bool				*mmlocked;
 	unsigned long			fault_end;
@@ -61,6 +71,16 @@ struct hmm_vma_walk {
  */
 #define HMM_FAULT_UNLOCKED	-ENOLCK
 
+#define HMM_ASSERT_PTE_LOCKED(hmm_vma_walk, locked)		\
+	WARN_ON_ONCE((hmm_vma_walk)->ptelocked != locked)
+
+#define HMM_ASSERT_PMD_LOCKED(hmm_vma_walk, locked)		\
+	WARN_ON_ONCE((hmm_vma_walk)->pmdlocked != locked)
+
+#define HMM_ASSERT_UNLOCKED(hmm_vma_walk)			\
+	WARN_ON_ONCE((hmm_vma_walk)->ptelocked ||		\
+		     (hmm_vma_walk)->pmdlocked)
+
 enum {
 	HMM_NEED_FAULT = 1 << 0,
 	HMM_NEED_WRITE_FAULT = 1 << 1,
@@ -74,14 +94,38 @@ enum {
 };
 
 static int hmm_pfns_fill(unsigned long addr, unsigned long end,
-			 struct hmm_range *range, unsigned long cpu_flags)
+			 struct hmm_vma_walk *hmm_vma_walk, unsigned long cpu_flags)
 {
+	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned long i = (addr - range->start) >> PAGE_SHIFT;
+	enum migrate_vma_info minfo;
+	bool migrate = false;
+
+	minfo = hmm_select_migrate(range);
+	if (cpu_flags != HMM_PFN_ERROR) {
+		if (minfo && (vma_is_anonymous(hmm_vma_walk->vma))) {
+			cpu_flags |= HMM_PFN_MIGRATE;
+			migrate = true;
+		}
+	}
+
+	if (migrate && thp_migration_supported() &&
+	    (minfo & MIGRATE_VMA_SELECT_COMPOUND) &&
+	    IS_ALIGNED(addr, HPAGE_PMD_SIZE) &&
+	    IS_ALIGNED(end, HPAGE_PMD_SIZE) &&
+		end-addr == HPAGE_PMD_SIZE) {
+		range->hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
+		range->hmm_pfns[i] |= cpu_flags | HMM_PFN_COMPOUND;
+		addr += PAGE_SIZE;
+		i++;
+		cpu_flags = 0;
+	}
 
 	for (; addr < end; addr += PAGE_SIZE, i++) {
 		range->hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
 		range->hmm_pfns[i] |= cpu_flags;
 	}
+
 	return 0;
 }
 
@@ -101,6 +145,7 @@ static int hmm_record_fault(unsigned long addr, unsigned long end,
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 
 	WARN_ON_ONCE(!required_fault);
+	HMM_ASSERT_UNLOCKED(hmm_vma_walk);
 	hmm_vma_walk->last = addr;
 	hmm_vma_walk->fault_end = end;
 	hmm_vma_walk->required_fault = required_fault;
@@ -185,11 +230,16 @@ static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
 	if (!walk->vma) {
 		if (required_fault)
 			return -EFAULT;
-		return hmm_pfns_fill(addr, end, range, HMM_PFN_ERROR);
+		return hmm_pfns_fill(addr, end, hmm_vma_walk, HMM_PFN_ERROR);
 	}
-	if (required_fault)
+	if (required_fault) {
+		if (hmm_vma_walk->pmdlocked) {
+			spin_unlock(hmm_vma_walk->ptl);
+			hmm_vma_walk->pmdlocked = false;
+		}
 		return hmm_record_fault(addr, end, required_fault, walk);
-	return hmm_pfns_fill(addr, end, range, 0);
+	}
+	return hmm_pfns_fill(addr, end, hmm_vma_walk, 0);
 }
 
 static inline unsigned long hmm_pfn_flags_order(unsigned long order)
@@ -222,8 +272,13 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 	cpu_flags = pmd_to_hmm_pfn_flags(range, pmd);
 	required_fault =
 		hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, cpu_flags);
-	if (required_fault)
+	if (required_fault) {
+		if (hmm_vma_walk->pmdlocked) {
+			spin_unlock(hmm_vma_walk->ptl);
+			hmm_vma_walk->pmdlocked = false;
+		}
 		return hmm_record_fault(addr, end, required_fault, walk);
+	}
 
 	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
@@ -303,14 +358,25 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			goto fault;
 
 		if (softleaf_is_migration(entry)) {
-			pte_unmap(ptep);
-			hmm_vma_walk->last = addr;
-			migration_entry_wait(walk->mm, pmdp, addr);
-			return -EBUSY;
+			if (!hmm_select_migrate(range)) {
+				HMM_ASSERT_UNLOCKED(hmm_vma_walk);
+				pte_unmap(ptep);
+				hmm_vma_walk->last = addr;
+				migration_entry_wait(walk->mm, pmdp, addr);
+				return -EBUSY;
+			}
+			return 0;
 		}
 
 		/* Report error for everything else */
-		pte_unmap(ptep);
+
+		if (hmm_vma_walk->ptelocked) {
+			pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
+			hmm_vma_walk->ptelocked = false;
+		} else {
+			pte_unmap(ptep);
+		}
+
 		return -EFAULT;
 	}
 
@@ -327,7 +393,13 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	if (!vm_normal_page(walk->vma, addr, pte) &&
 	    !is_zero_pfn(pte_pfn(pte))) {
 		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
-			pte_unmap(ptep);
+			if (hmm_vma_walk->ptelocked) {
+				pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
+				hmm_vma_walk->ptelocked = false;
+			} else {
+				pte_unmap(ptep);
+			}
+
 			return -EFAULT;
 		}
 		new_pfn_flags = HMM_PFN_ERROR;
@@ -340,7 +412,12 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	return 0;
 
 fault:
-	pte_unmap(ptep);
+	if (hmm_vma_walk->ptelocked) {
+		pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
+		hmm_vma_walk->ptelocked = false;
+	} else {
+		pte_unmap(ptep);
+	}
 	/* Fault any virtual address we were asked to fault */
 	return hmm_record_fault(addr, end, required_fault, walk);
 }
@@ -384,13 +461,18 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 	required_fault = hmm_range_need_fault(hmm_vma_walk, hmm_pfns,
 					      npages, 0);
 	if (required_fault) {
-		if (softleaf_is_device_private(entry))
+		if (softleaf_is_device_private(entry)) {
+			if (hmm_vma_walk->pmdlocked) {
+				spin_unlock(hmm_vma_walk->ptl);
+				hmm_vma_walk->pmdlocked = false;
+			}
 			return hmm_record_fault(addr, end, required_fault, walk);
+		}
 		else
 			return -EFAULT;
 	}
 
-	return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
+	return hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR);
 }
 #else
 static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
@@ -398,15 +480,72 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 				     pmd_t pmd)
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
-	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned long npages = (end - start) >> PAGE_SHIFT;
 
 	if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
 		return -EFAULT;
-	return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
+	return hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR);
 }
 #endif  /* CONFIG_ARCH_HAS_PMD_SOFTLEAVES */
 
+#ifdef CONFIG_DEVICE_MIGRATION
+static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
+					      pmd_t *pmdp,
+					      unsigned long start,
+					      unsigned long end,
+					      unsigned long *hmm_pfn)
+{
+	// TODO: implement migration entry insertion
+	return 0;
+}
+
+static int hmm_vma_handle_migrate_prepare(const struct mm_walk *walk,
+					  pmd_t *pmdp,
+					  pte_t *ptep,
+					  unsigned long addr,
+					  unsigned long *hmm_pfn,
+					  bool *unmapped)
+{
+	// TODO: implement migration entry insertion
+	return 0;
+}
+
+static int hmm_vma_walk_split(pmd_t *pmdp,
+			      unsigned long addr,
+			      struct mm_walk *walk)
+{
+	// TODO : implement split
+	return 0;
+}
+
+#else
+static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
+					      pmd_t *pmdp,
+					      unsigned long start,
+					      unsigned long end,
+					      unsigned long *hmm_pfn)
+{
+	return 0;
+}
+
+static int hmm_vma_handle_migrate_prepare(const struct mm_walk *walk,
+					  pmd_t *pmdp,
+					  pte_t *ptep,
+					  unsigned long addr,
+					  unsigned long *hmm_pfn,
+					  bool *unmapped)
+{
+	return 0;
+}
+
+static int hmm_vma_walk_split(pmd_t *pmdp,
+			      unsigned long addr,
+			      struct mm_walk *walk)
+{
+	return 0;
+}
+#endif
+
 static int hmm_vma_capture_migrate_range(unsigned long start,
 					 unsigned long end,
 					 struct mm_walk *walk)
@@ -465,46 +604,128 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
-	unsigned long *hmm_pfns =
-		&range->hmm_pfns[(start - range->start) >> PAGE_SHIFT];
 	unsigned long npages = (end - start) >> PAGE_SHIFT;
+	struct mm_struct *mm = walk->vma->vm_mm;
+	unsigned long *hmm_pfns, *hmm_pfns_start;
+	enum migrate_vma_info minfo;
 	unsigned long addr = start;
+	bool unmapped = false;
+	unsigned long i;
 	pte_t *ptep;
 	pmd_t pmd;
+	int r = 0;
 
+	minfo = hmm_select_migrate(range);
+	hmm_pfns_start = &range->hmm_pfns[(start - range->start) >> PAGE_SHIFT];
 again:
-	pmd = pmdp_get_lockless(pmdp);
-	if (pmd_none(pmd))
-		return hmm_vma_walk_hole(start, end, -1, walk);
+	hmm_pfns = &range->hmm_pfns[(addr - range->start) >> PAGE_SHIFT];
+	hmm_vma_walk->ptelocked = false;
+	hmm_vma_walk->pmdlocked = false;
+
+	if (minfo) {
+		hmm_vma_walk->ptl = pmd_lock(mm, pmdp);
+		hmm_vma_walk->pmdlocked = true;
+		pmd = pmdp_get(pmdp);
+	} else
+		pmd = pmdp_get_lockless(pmdp);
+
+	if (pmd_none(pmd)) {
+		r = hmm_vma_walk_hole(start, end, -1, walk);
+
+		if (hmm_vma_walk->pmdlocked) {
+			spin_unlock(hmm_vma_walk->ptl);
+			hmm_vma_walk->pmdlocked = false;
+		}
+		return r;
+	}
 
 	if (thp_migration_supported() && pmd_is_migration_entry(pmd)) {
-		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0)) {
-			hmm_vma_walk->last = addr;
-			pmd_migration_entry_wait(walk->mm, pmdp);
-			return -EBUSY;
+		if (!minfo) {
+			if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns_start, npages, 0)) {
+				hmm_vma_walk->last = addr;
+				pmd_migration_entry_wait(walk->mm, pmdp);
+				return -EBUSY;
+			}
+			for (i = 0; start < end; start += PAGE_SIZE, i++)
+				hmm_pfns_start[i] &= HMM_PFN_INOUT_FLAGS;
+		}
+
+		if (hmm_vma_walk->pmdlocked) {
+			spin_unlock(hmm_vma_walk->ptl);
+			hmm_vma_walk->pmdlocked = false;
 		}
-		return hmm_pfns_fill(start, end, range, 0);
+
+		return 0;
 	}
 
-	if (!pmd_present(pmd))
-		return hmm_vma_handle_absent_pmd(walk, start, end, hmm_pfns,
-						 pmd);
+	if (pmd_trans_huge(pmd) || !pmd_present(pmd)) {
+		if (!pmd_present(pmd)) {
+			r = hmm_vma_handle_absent_pmd(walk, start, end, hmm_pfns_start,
+						      pmd);
+			// If not migrating we are done
+			if (r || !minfo) {
+				if (hmm_vma_walk->pmdlocked) {
+					spin_unlock(hmm_vma_walk->ptl);
+					hmm_vma_walk->pmdlocked = false;
+				}
+				return r;
+			}
+		}
 
-	if (pmd_trans_huge(pmd)) {
-		/*
-		 * No need to take pmd_lock here, even if some other thread
-		 * is splitting the huge pmd we will get that event through
-		 * mmu_notifier callback.
-		 *
-		 * So just read pmd value and check again it's a transparent
-		 * huge or device mapping one and compute corresponding pfn
-		 * values.
-		 */
-		pmd = pmdp_get_lockless(pmdp);
-		if (!pmd_trans_huge(pmd))
-			goto again;
+		if (pmd_trans_huge(pmd)) {
+			/*
+			 * No need to take pmd_lock here if not migrating,
+			 * even if some other thread is splitting the huge
+			 * pmd we will get that event through mmu_notifier callback.
+			 *
+			 * So just read pmd value and check again it's a transparent
+			 * huge or device mapping one and compute corresponding pfn
+			 * values.
+			 */
+
+			if (!minfo) {
+				pmd = pmdp_get_lockless(pmdp);
+				if (!pmd_trans_huge(pmd))
+					goto again;
+			}
+
+			r = hmm_vma_handle_pmd(walk, start, end, hmm_pfns_start, pmd);
 
-		return hmm_vma_handle_pmd(walk, addr, end, hmm_pfns, pmd);
+			// If not migrating we are done
+			if (r || !minfo) {
+				if (hmm_vma_walk->pmdlocked) {
+					spin_unlock(hmm_vma_walk->ptl);
+					hmm_vma_walk->pmdlocked = false;
+				}
+				return r;
+			}
+		}
+
+		r = hmm_vma_handle_migrate_prepare_pmd(walk, pmdp, start, end, hmm_pfns_start);
+
+		if (hmm_vma_walk->pmdlocked) {
+			spin_unlock(hmm_vma_walk->ptl);
+			hmm_vma_walk->pmdlocked = false;
+		}
+
+		if (r == -ENOENT) {
+			r = hmm_vma_walk_split(pmdp, addr, walk);
+			if (r) {
+				/* Split not successful, skip */
+				return hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR);
+			}
+
+			/* Split successful, reloop */
+			hmm_vma_walk->last = addr;
+			return -EBUSY;
+		}
+		return r;
+
+	}
+
+	if (hmm_vma_walk->pmdlocked) {
+		spin_unlock(hmm_vma_walk->ptl);
+		hmm_vma_walk->pmdlocked = false;
 	}
 
 	/*
@@ -514,24 +735,62 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	 * recover.
 	 */
 	if (pmd_bad(pmd)) {
-		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
+		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns_start, npages, 0))
 			return -EFAULT;
-		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
+		return hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR);
 	}
 
-	ptep = pte_offset_map(pmdp, addr);
-	if (!ptep)
+	if (minfo) {
+		ptep = pte_offset_map_lock(mm, pmdp, addr, &hmm_vma_walk->ptl);
+		if (ptep)
+			hmm_vma_walk->ptelocked = true;
+	} else {
+		ptep = pte_offset_map(pmdp, addr);
+	}
+	if (!ptep) {
+		addr = start;
 		goto again;
+	}
+
 	for (; addr < end; addr += PAGE_SIZE, ptep++, hmm_pfns++) {
-		int r;
 
 		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, hmm_pfns);
 		if (r) {
-			/* hmm_vma_handle_pte() did pte_unmap() */
+			/* hmm_vma_handle_pte() did pte_unmap() / pte_unmap_unlock */
 			return r;
 		}
+
+		r = hmm_vma_handle_migrate_prepare(walk, pmdp, ptep, addr, hmm_pfns, &unmapped);
+		if (r == -EAGAIN) {
+			HMM_ASSERT_UNLOCKED(hmm_vma_walk);
+			if (unmapped) {
+				flush_tlb_range(walk->vma, start, addr);
+				unmapped = false;
+			}
+			goto again;
+		}
+		if (r) {
+			/* A non -EAGAIN error here means migrate_vma_split_folio()
+			 * already dropped the PTE lock and cleared ptelocked.
+			 */
+			HMM_ASSERT_UNLOCKED(hmm_vma_walk);
+			if (unmapped)
+				flush_tlb_range(walk->vma, start, addr);
+			hmm_pfns_fill(addr, end, hmm_vma_walk, HMM_PFN_ERROR);
+			return 0;
+		}
 	}
-	pte_unmap(ptep - 1);
+
+	if (unmapped)
+		flush_tlb_range(walk->vma, start, addr);
+
+	if (hmm_vma_walk->ptelocked) {
+		pte_unmap_unlock(ptep - 1, hmm_vma_walk->ptl);
+		hmm_vma_walk->ptelocked = false;
+	} else {
+		pte_unmap(ptep - 1);
+	}
+
 	return 0;
 }
 
@@ -679,7 +938,7 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
 				 (end - start) >> PAGE_SHIFT, 0))
 		return -EFAULT;
 
-	hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
+	hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR);
 
 	/* Skip this vma and continue processing the next vma. */
 	return 1;
-- 
2.55.0

