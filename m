Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A03C98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBA1410F30E;
	Thu, 24 Sep 2026 06:54:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gbcjIu2c";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD2F10F30E
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790232837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JpYqOYoRlVZdrcLlVTpkBL4vVH/KqUerRKv2x17E1pA=;
 b=gbcjIu2cykL9bbMtAN1SGD7cXtnE0S+ugYJeeUHdwR+79J0DCx8IlF9vnpLPnxGFToIIhn
 P/KFxhTYUYvm/fgfsc6LUNMRMX8f4Z8/9B8KNTtYRfhoJwexjBRtTPt+tEn6QOiJcJM4CE
 7cy5KX1ZfjFFOEBPTFZHZus6DQ9bDVA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-y21W1F-WOVyk7j3pIoo1Gg-1; Thu, 24 Sep 2026 02:53:55 -0400
X-MC-Unique: y21W1F-WOVyk7j3pIoo1Gg-1
X-Mimecast-MFC-AGG-ID: y21W1F-WOVyk7j3pIoo1Gg_1790232834
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a5b062d0dbso3518711fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 23:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790232834; x=1790837634;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JpYqOYoRlVZdrcLlVTpkBL4vVH/KqUerRKv2x17E1pA=;
 b=XkeEKxYpj5RqzoyjTkOCTUmtkq6inE/yEbDVptfYceUlXqTNsfA6RCOP2Qcbtm+J8I
 zlhBkQ3MxFBL57KxloxBLJT0a7R5MDVhLJiaxSmRQF/oqkQR6WmpO1qv3kAdIN9eHfhQ
 OQleGt1TX+5X35da58vWDgzXsmLkwzJKRWZLYSBdakU43IKN2GeJgCT1RQik8QCR6nr8
 onKeG5tL+JPcLunOsY4APWhl2oI07BSsnCcsWD67IfcuwzLtJBjEijDeAKBG2IZdJ6KO
 cVAGcU1di+OkIgr+Hi+sL5H21HnawIh+wArMJoFAUWdNkKlx7zd8TAZLCUXajInlU5sk
 LqQw==
X-Gm-Message-State: AFuF++lleT2eXIyIlGij/msHBGknLu/+lKym/YeU4qhHfTKUqJ4hQp0D
 umuzl5FxAU9VBuPferKcdx/06RMxC4zYpB+nQ9Tk1uzcs175+ZKbft2NEYpIYQGiR/jidcIfH84
 Bh0QCqg3wEt/uai5cipxspc0O5ISICyUpyuoTPUlxL5t3FYp0adX2JQmVXDe+NZWniFB266DcK8
 5I9cU=
X-Gm-Gg: AYBFou3PmdaI0a450J3XOXGJ/1e8KPX+cc7DyQDNHYTDWCDJ9UgdwPy5Wio5FyTqaHv
 BnQseXfJsTcsc82HM8n52JlNcPg71LorDMYOLhX+kf3dJqcxz4LsThwlSTQnLbw4NjlLuFIX+E+
 D15KjZRpsVTiw85qypvHQSoUmmLmlQ4pAApSxkLcXilC2eRvfzj9yr03vTMXzhFBNBw6OHrfFk1
 C1uZ9m9w/HMk3QaVZZsjOLtmCYdWfEZ3nUhizrYG96o41Qr+y/cSaxAyQARATlq6weW+zWT9l0n
 Qe9uPO/HnpIvO2eSozXnh8vXpEu+omwiuo/FLs34rJX1/9MIzX4UoaoIq5PX1fqFfARcqCZSQAb
 TBU1xbk4aQg5my0avjM6L
X-Received: by 2002:a05:651c:54f:b0:3a4:9881:8de0 with SMTP id
 38308e7fff4ca-3a63bf5cf4cmr3206591fa.7.1790232834189; 
 Wed, 23 Sep 2026 23:53:54 -0700 (PDT)
X-Received: by 2002:a05:651c:54f:b0:3a4:9881:8de0 with SMTP id
 38308e7fff4ca-3a63bf5cf4cmr3206461fa.7.1790232833678; 
 Wed, 23 Sep 2026 23:53:53 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a63bf57909sm4803141fa.29.2026.09.23.23.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 23:53:53 -0700 (PDT)
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
Subject: [PATCH v15 06/11] mm/hmm: migrate collection in HMM pagewalk - pmd
 level
Date: Thu, 24 Sep 2026 09:53:08 +0300
Message-ID: <20260924065313.899730-7-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924065313.899730-1-mpenttil@redhat.com>
References: <20260924065313.899730-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JJSIldrLmArwbHkT0_coMZnfp_sPkB0UHsBDQz5tWaU_1790232834
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

Implement the needed hmm_vma_handle_migrate_prepare_pmd() function
which is mostly carried over from migrate_device.c's
migrate_vma_collect_huge_pmd() function.

With HMM pagewalk based migration, the idea is that
hmm_vma_handle_*() are responsible for faulting,
and the pfn collecting part. hmm_vma_handle_migrate_prepare*()
do the migration decisions (with HMM_PFN_MIGRATE), possibly split
folios, and insert migration ptes/pmds.

HMM pagewalk based migration is enabled in later commit, for now
now hmm_select_migrate() returns 0.

Also avoid the problems present in the migrate_vma_collect_huge_pmd()
split fallback path this HMM path supersedes:

      - extra refcount for fault_folio makes split_folio() fail
      - wrong folio unlocked after split_folio()

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
 mm/hmm.c | 173 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 151 insertions(+), 22 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index a60b66963049..ea77429c5178 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -492,31 +492,19 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 
 #ifdef CONFIG_DEVICE_MIGRATION
 /**
- * migrate_vma_split_folio() - Helper function to split a THP folio
+ * __migrate_vma_split_folio() - split a folio and move the lock/ref to the
+ * order-0 folio backing @fault_page after the split
  * @folio: the folio to split
- * @fault_page: struct page associated with the fault if any
- * @hmm_vma_walk: walk in progress
- * @ptep: pte_t * for unmap and unlock ptl
+ * @fault_page: fault page if any
  *
- * Returns 0 on success
+ * Returns 0 on success.
  */
-static int migrate_vma_split_folio(struct folio *folio,
-				   struct page *fault_page,
-				   struct hmm_vma_walk *hmm_vma_walk,
-				   pte_t *ptep)
+static int __migrate_vma_split_folio(struct folio *folio,
+				     struct page *fault_page)
 {
-	int ret;
 	struct folio *fault_folio = fault_page ? page_folio(fault_page) : NULL;
 	struct folio *new_fault_folio = NULL;
-
-	if (folio != fault_folio)
-		folio_get(folio);
-
-	pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
-	hmm_vma_walk->ptelocked = false;
-
-	if (folio != fault_folio)
-		folio_lock(folio);
+	int ret;
 
 	ret = split_folio(folio);
 	if (ret) {
@@ -548,14 +536,145 @@ static int migrate_vma_split_folio(struct folio *folio,
 	return 0;
 }
 
+/**
+ * migrate_vma_split_folio() - drop the pte lock and split a THP folio
+ * @folio: the folio to split
+ * @fault_page: struct page associated with the fault if any
+ * @hmm_vma_walk: walk in progress
+ * @ptep: pte_t * for unmap and unlock ptl
+ *
+ * Returns 0 on success
+ */
+static int migrate_vma_split_folio(struct folio *folio,
+				   struct page *fault_page,
+				   struct hmm_vma_walk *hmm_vma_walk,
+				   pte_t *ptep)
+{
+	struct folio *fault_folio = fault_page ? page_folio(fault_page) : NULL;
+
+	if (folio != fault_folio)
+		folio_get(folio);
+
+	pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
+	hmm_vma_walk->ptelocked = false;
+
+	if (folio != fault_folio)
+		folio_lock(folio);
+
+	return __migrate_vma_split_folio(folio, fault_page);
+}
+
 static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
 					      pmd_t *pmdp,
 					      unsigned long start,
 					      unsigned long end,
 					      unsigned long *hmm_pfn)
 {
-	// TODO: implement migration entry insertion
-	return 0;
+	struct hmm_vma_walk *hmm_vma_walk = walk->private;
+	struct hmm_range *range = hmm_vma_walk->range;
+	struct migrate_vma *migrate = range->migrate;
+	struct folio *fault_folio = NULL;
+	enum migrate_vma_info minfo;
+	struct folio *folio;
+	unsigned long i;
+	int r = 0;
+
+	// Do we want to migrate at all?
+	minfo = hmm_select_migrate(range);
+	if (!minfo)
+		return r;
+
+	WARN_ON_ONCE(!migrate);
+	HMM_ASSERT_PMD_LOCKED(hmm_vma_walk, true);
+
+	fault_folio = migrate->fault_page ?
+		page_folio(migrate->fault_page) : NULL;
+
+	if (pmd_none(*pmdp))
+		return hmm_pfns_fill(start, end, hmm_vma_walk, 0);
+
+	if (!(hmm_pfn[0] & HMM_PFN_VALID))
+		goto out;
+
+	if (pmd_trans_huge(*pmdp)) {
+		if (!(minfo & MIGRATE_VMA_SELECT_SYSTEM))
+			goto out;
+
+		folio = pmd_folio(*pmdp);
+		if (is_huge_zero_folio(folio))
+			return hmm_pfns_fill(start, end, hmm_vma_walk, 0);
+
+	} else if (!pmd_present(*pmdp)) {
+		const softleaf_t entry = softleaf_from_pmd(*pmdp);
+
+		if (!softleaf_is_device_private(entry))
+			goto out;
+
+		if (!(minfo & MIGRATE_VMA_SELECT_DEVICE_PRIVATE))
+			goto out;
+
+		folio = softleaf_to_folio(entry);
+		if (folio->pgmap->owner != migrate->pgmap_owner)
+			goto out;
+	} else {
+		hmm_vma_walk->last = start;
+		return -EBUSY;
+	}
+
+	folio_get(folio);
+
+	if (folio != fault_folio && unlikely(!folio_trylock(folio))) {
+		folio_put(folio);
+		hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR);
+		return 0;
+	}
+
+	if (thp_migration_supported() &&
+	    (migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
+	    (IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
+	     IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
+		struct page_vma_mapped_walk pvmw = {
+			.ptl = hmm_vma_walk->ptl,
+			.address = start,
+			.pmd = pmdp,
+			.vma = walk->vma,
+		};
+
+		hmm_pfn[0] |= HMM_PFN_MIGRATE | HMM_PFN_COMPOUND;
+
+		r = set_pmd_migration_entry(&pvmw, folio_page(folio, 0));
+		if (r) {
+			hmm_pfn[0] &= ~(HMM_PFN_MIGRATE | HMM_PFN_COMPOUND);
+			goto split;	/* fall back to splitting the pmd */
+		}
+		for (i = 1, start += PAGE_SIZE; start < end; start += PAGE_SIZE, i++)
+			hmm_pfn[i] &= HMM_PFN_INOUT_FLAGS;
+
+	} else {
+		goto split;		/* fall back to splitting the pmd */
+	}
+
+out:
+	return r;
+
+split:
+	spin_unlock(hmm_vma_walk->ptl);
+	hmm_vma_walk->pmdlocked = false;
+
+	/*
+	 * folio_get() above took an extra reference. For the fault folio the
+	 * caller still holds a reference and the lock, which is the
+	 * precondition of __migrate_vma_split_folio(), so drop the extra one.
+	 */
+	if (folio == fault_folio)
+		folio_put(folio);
+
+	r = __migrate_vma_split_folio(folio, migrate->fault_page);
+	if (r)
+		return r;
+
+	hmm_vma_walk->last = start;
+	return -EBUSY;
 }
 
 /*
@@ -958,8 +1077,18 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 			hmm_vma_walk->pmdlocked = false;
 		}
 
+		/*
+		 * hmm_vma_handle_migrate_prepare_pmd() splits the huge pmd in
+		 * place when needed and returns -EBUSY to re-walk the range as
+		 * PTEs; any other error means the split failed.
+		 */
+		if (r == -EBUSY)
+			return -EBUSY;
+		if (r) {
+			/* Split not successful, skip */
+			return hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR);
+		}
 		return r;
-
 	}
 
 	if (hmm_vma_walk->pmdlocked) {
-- 
2.55.0

