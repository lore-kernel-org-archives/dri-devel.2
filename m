Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE360A4AD1
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NTC+qGUL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 010E410F911;
	Wed, 21 Oct 2026 06:05:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B690010F911
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792562739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gtRC5DeWJYXLXVRSk50CDnIivIc/S25arUI35Q6dKwU=;
 b=NTC+qGULGyNZ6mqe7vNgM44F3ixkEFm48cOWEanCkiCsWzue+M3Vgc6y3Z9Zy9V5g3Y2WQ
 1OfYiCHbfG9OR2yWWmJ3I1kPA9lGfioR0qdJAgoCjnQEBGObOAatx45pmDBO0z8ElOeumn
 O6rYhfbQHhdKMAGHzdbqIoebtJCotb0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-JtX9TSZJNAC-gNYBJeuUHA-1; Wed, 21 Oct 2026 06:05:37 +0000
X-MC-Unique: JtX9TSZJNAC-gNYBJeuUHA-1
X-Mimecast-MFC-AGG-ID: JtX9TSZJNAC-gNYBJeuUHA_1792562737
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e17d30a79so185068f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792562736; x=1793167536;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gtRC5DeWJYXLXVRSk50CDnIivIc/S25arUI35Q6dKwU=;
 b=0yzgZLuSRG9ACcVwDSs0vVzTeiGm/4fTWX7bcfxZrckN+zvTTrynV/mfg4g+f/BGq4
 TtGnMKv+EmqQlTjEDln6nfib2yQqmnbOOwytlvYUfdv7hdeQFH7e/o4Ip1q5h8aSkyEa
 pcVYTTUDM7w5Yt1LTTIhv8h0lw8P3+pRWbW8wJ6QItNrdZ2EzTgIYz5brXqeA1ysUyUq
 PbQ7fiBUv9W0tc9keKhm50sp14CvU+jO8yxG721R0FjxuaWRmcsCw1g7NddpIQFIc94e
 ESqnz6voe7Ey/YIHghXjcZzirfhQrLWJ/cTEGRSPnRhOBF4RklLHhcQs5DwIVPNQWHwC
 Uddw==
X-Gm-Message-State: AFq9FYJ4aKtb73aOGtEetaKw1ZEKoE0LXrsKo0/9tzhpxVhEE5eoKirI
 l76RLOCKMtJoVAPP1WR04OpyrbL0gLpuynVKNB2KFEq/3Oe4JbOOCcGMDHgyg6+R12QU08tu1et
 BWMnup6ADC31KNoD2iHTqhAqVp4P72bvgFXaoaEuYlHF1CUyqgGq1C1aiyRcx30ofA2bO
X-Gm-Gg: AYBFou3hDdUUnHgjhIDZK55jphq/xuaclY4Vr6YyQJhggV2rfWCmYwHEbn1hkKASBVM
 EsiFmKG1pxDTiCm8WuBT54UW9yqZtn8PLb4/1rANI2/43VrKoeGVfxg29OtnWok7bRlcKeY3A38
 GYXaWXZsw2dQmiQteeWjhygDD826ZQI1mfq12VpHkFTu98QUolPzzqrpQoDz6Ka4EZ3nD1pyy7z
 uW4oLrYFS5eb6pGRehetI52Hd+UFZapdtCR72MdfBPicavM+tZpWtmfgONAwM+ggS6tNcbb4Wng
 QVdAuqifDFYNmcu4kas2o1DR/dSUxbI4QDu8FMuUpg7/29l4r2rmjHTnRHh68GV/GlG3Bv7wN1s
 94YTlpPLq7TJ+7Pz0xXDSCNw4H7fLPemFL1Go
X-Received: by 2002:a5d:584e:0:b0:48e:f07:160e with SMTP id
 ffacd0b85a97d-48e264f32edmr1555653f8f.38.1792562736490; 
 Tue, 20 Oct 2026 23:05:36 -0700 (PDT)
X-Received: by 2002:a5d:584e:0:b0:48e:f07:160e with SMTP id
 ffacd0b85a97d-48e264f32edmr1555593f8f.38.1792562735959; 
 Tue, 20 Oct 2026 23:05:35 -0700 (PDT)
Received: from fedora.redhat.corp (89-27-86-246.bb.dnainternet.fi.
 [89.27.86.246]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254f02f1sm3413741f8f.3.2026.10.20.23.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:05:34 -0700 (PDT)
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
Subject: [PATCH v16 05/12] mm/hmm: migrate collection in HMM pagewalk - pte
 level
Date: Wed, 21 Oct 2026 09:04:59 +0300
Message-ID: <20261021060506.2377545-6-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021060506.2377545-1-mpenttil@redhat.com>
References: <20261021060506.2377545-1-mpenttil@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H2zPlbBBF5aYS9XBSvMyLJ3ReDDS02k01qcvaaOTrnA_1792562737
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

Implement the needed hmm_vma_handle_migrate_prepare() function
which is mostly carried over from migrate_device.c's
migrate_vma_collect_pmd() function.

Also implement the migrate_vma_split_folio(), for splitting
pte mapped large folios. It is also mostly from migrate_device.c,
with care taken to reference folio before relasing page table
lock.

With HMM pagewalk based migration, the idea is that
hmm_vma_handle_*() are responsible for faulting,
and the pfn collecting part. hmm_vma_handle_migrate_prepare*()
do the migration decisions (with HMM_PFN_MIGRATE), possibly split
folios, and insert migration ptes/pmds.

HMM pagewalk based migration is enabled in later commit, for now
now hmm_select_migrate() returns 0.

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
 mm/hmm.c | 263 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 262 insertions(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 119e70dbca56..0ce947d0e572 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -491,6 +491,63 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 #endif  /* CONFIG_ARCH_HAS_PMD_SOFTLEAVES */
 
 #ifdef CONFIG_DEVICE_MIGRATION
+/**
+ * migrate_vma_split_folio() - Helper function to split a THP folio
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
+	int ret;
+	struct folio *fault_folio = fault_page ? page_folio(fault_page) : NULL;
+	struct folio *new_fault_folio = NULL;
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
+	ret = split_folio(folio);
+	if (ret) {
+		if (folio != fault_folio) {
+			folio_unlock(folio);
+			folio_put(folio);
+		}
+		return ret;
+	}
+
+	new_fault_folio = fault_page ? page_folio(fault_page) : NULL;
+
+	/*
+	 * Ensure the lock is held on the correct
+	 * folio after the split
+	 */
+	if (!new_fault_folio) {
+		folio_unlock(folio);
+		folio_put(folio);
+	} else if (folio != new_fault_folio) {
+		if (new_fault_folio != fault_folio) {
+			folio_get(new_fault_folio);
+			folio_lock(new_fault_folio);
+		}
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	return 0;
+}
+
 static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
 					      pmd_t *pmdp,
 					      unsigned long start,
@@ -501,6 +558,11 @@ static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
 	return 0;
 }
 
+/*
+ * Install migration entries if migration requested, either from fault
+ * or migrate paths.
+ *
+ */
 static int hmm_vma_handle_migrate_prepare(const struct mm_walk *walk,
 					  pmd_t *pmdp,
 					  pte_t *ptep,
@@ -508,8 +570,207 @@ static int hmm_vma_handle_migrate_prepare(const struct mm_walk *walk,
 					  unsigned long *hmm_pfn,
 					  bool *unmapped)
 {
-	// TODO: implement migration entry insertion
+	struct hmm_vma_walk *hmm_vma_walk = walk->private;
+	struct hmm_range *range = hmm_vma_walk->range;
+	struct migrate_vma *migrate = range->migrate;
+	struct mm_struct *mm = walk->vma->vm_mm;
+	struct folio *fault_folio = NULL;
+	enum migrate_vma_info minfo;
+	struct dev_pagemap *pgmap;
+	bool anon_exclusive;
+	struct folio *folio;
+	unsigned long pfn;
+	struct page *page;
+	softleaf_t entry;
+	pte_t pte, swp_pte;
+	bool writable = false;
+
+	// Do we want to migrate at all?
+	minfo = hmm_select_migrate(range);
+	if (!minfo)
+		return 0;
+
+	WARN_ON_ONCE(!migrate);
+	HMM_ASSERT_PTE_LOCKED(hmm_vma_walk, true);
+
+	fault_folio = migrate->fault_page ?
+		page_folio(migrate->fault_page) : NULL;
+
+	pte = ptep_get(ptep);
+
+	if (pte_none(pte)) {
+		if (vma_is_anonymous(walk->vma)) {
+			*hmm_pfn &= HMM_PFN_INOUT_FLAGS;
+			*hmm_pfn |= HMM_PFN_MIGRATE;
+			goto out;
+		}
+	}
+
+	if (!(hmm_pfn[0] & HMM_PFN_VALID))
+		goto out;
+
+	if (!pte_present(pte)) {
+		/*
+		 * Only care about unaddressable device page special
+		 * page table entry. Other special swap entries are not
+		 * migratable, and we ignore regular swapped page.
+		 */
+		entry = softleaf_from_pte(pte);
+		if (!softleaf_is_device_private(entry))
+			goto out;
+
+		if (!(minfo & MIGRATE_VMA_SELECT_DEVICE_PRIVATE))
+			goto out;
+
+		page = softleaf_to_page(entry);
+		folio = page_folio(page);
+		if (folio->pgmap->owner != migrate->pgmap_owner)
+			goto out;
+
+		if (folio_test_large(folio)) {
+			int ret;
+
+			ret = migrate_vma_split_folio(folio,
+						      migrate->fault_page,
+						      hmm_vma_walk,
+						      ptep);
+			if (ret)
+				goto out_error;
+			return -EAGAIN;
+		}
+
+		pfn = page_to_pfn(page);
+		if (softleaf_is_device_private_write(entry))
+			writable = true;
+	} else {
+		pfn = pte_pfn(pte);
+		if (is_zero_pfn(pfn) &&
+		    (minfo & MIGRATE_VMA_SELECT_SYSTEM)) {
+			*hmm_pfn = HMM_PFN_MIGRATE;
+			goto out;
+		}
+		page = vm_normal_page(walk->vma, addr, pte);
+		if (page && !is_zone_device_page(page) &&
+		    !(minfo & MIGRATE_VMA_SELECT_SYSTEM)) {
+			goto out;
+		} else if (page && is_device_coherent_page(page)) {
+			pgmap = page_pgmap(page);
+
+			if (!(minfo &
+			      MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
+			    pgmap->owner != migrate->pgmap_owner)
+				goto out;
+		}
+
+		folio = page ? page_folio(page) : NULL;
+		if (folio && folio_test_large(folio)) {
+			int ret;
+
+			ret = migrate_vma_split_folio(folio,
+						      migrate->fault_page,
+						      hmm_vma_walk,
+						      ptep);
+			if (ret)
+				goto out_error;
+			return -EAGAIN;
+		}
+
+		writable = pte_write(pte);
+	}
+
+	if (!page || !page->mapping)
+		goto out;
+
+	/*
+	 * By getting a reference on the folio we pin it and that blocks
+	 * any kind of migration. Side effect is that it "freezes" the
+	 * pte.
+	 *
+	 * We drop this reference after isolating the folio from the lru
+	 * for non device folio (device folio are not on the lru and thus
+	 * can't be dropped from it).
+	 */
+	folio = page_folio(page);
+	folio_get(folio);
+
+	/*
+	 * We rely on folio_trylock() to avoid deadlock between
+	 * concurrent migrations where each is waiting on the others
+	 * folio lock. If we can't immediately lock the folio we fail this
+	 * migration as it is only best effort anyway.
+	 *
+	 * If we can lock the folio it's safe to set up a migration entry
+	 * now. In the common case where the folio is mapped once in a
+	 * single process setting up the migration entry now is an
+	 * optimisation to avoid walking the rmap later with
+	 * try_to_migrate().
+	 */
+
+	if (fault_folio == folio || folio_trylock(folio)) {
+		anon_exclusive = folio_test_anon(folio) &&
+			PageAnonExclusive(page);
+
+		if (pte_present(pte))
+			flush_cache_page(walk->vma, addr, pfn);
+
+		if (anon_exclusive) {
+			pte = ptep_clear_flush(walk->vma, addr, ptep);
+
+			if (folio_try_share_anon_rmap_pte(folio, page)) {
+				set_pte_at(mm, addr, ptep, pte);
+				if (fault_folio != folio)
+					folio_unlock(folio);
+				folio_put(folio);
+				goto out;
+			}
+		} else {
+			pte = ptep_get_and_clear(mm, addr, ptep);
+		}
+
+		if (pte_present(pte) && pte_dirty(pte))
+			folio_mark_dirty(folio);
+
+		/* Setup special migration page table entry */
+		if (writable)
+			entry = make_writable_migration_entry(pfn);
+		else if (anon_exclusive)
+			entry = make_readable_exclusive_migration_entry(pfn);
+		else
+			entry = make_readable_migration_entry(pfn);
+
+		if (pte_present(pte)) {
+			if (pte_young(pte))
+				entry = make_migration_entry_young(entry);
+			if (pte_dirty(pte))
+				entry = make_migration_entry_dirty(entry);
+		}
+
+		swp_pte = swp_entry_to_pte(entry);
+		if (pte_present(pte)) {
+			if (pte_soft_dirty(pte))
+				swp_pte = pte_swp_mksoft_dirty(swp_pte);
+			if (pte_uffd(pte))
+				swp_pte = pte_swp_mkuffd(swp_pte);
+		} else {
+			if (pte_swp_soft_dirty(pte))
+				swp_pte = pte_swp_mksoft_dirty(swp_pte);
+			if (pte_swp_uffd(pte))
+				swp_pte = pte_swp_mkuffd(swp_pte);
+		}
+
+		set_pte_at(mm, addr, ptep, swp_pte);
+		folio_remove_rmap_pte(folio, page, walk->vma);
+		folio_put(folio);
+		*hmm_pfn |= HMM_PFN_MIGRATE;
+		if (pte_present(pte))
+			*unmapped = true;
+	} else {
+		folio_put(folio);
+	}
+out:
 	return 0;
+out_error:
+	return -EFAULT;
 }
 
 #else
-- 
2.55.0

