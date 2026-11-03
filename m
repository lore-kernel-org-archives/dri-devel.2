Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E1606A330
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pg6ij7HY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B543A10F38B;
	Tue,  3 Nov 2026 06:17:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B247F10F384
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793686635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIc5h4IhkXIt4VgOmF6ym6QfRntQTchoUiwA4snRnC8=;
 b=Pg6ij7HYY463mRWPI3Cplb4CP61HWYdl3QT62t/Fm5yEFtPXCUFOxiQgN93tazHqCCwUgx
 WYSvYBLP37SGr/lZvhV5nqXCR7PPKEOqLxw2rgPMMh1Ixu6iQqSdLXu3OYQyyG5NMm7Yj+
 yNynJp87EWNE54eREvzz5fBSUzwqEqk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-785YxoUwOsWU0AT1AdQcpw-1; Tue, 03 Nov 2026 01:17:14 -0500
X-MC-Unique: 785YxoUwOsWU0AT1AdQcpw-1
X-Mimecast-MFC-AGG-ID: 785YxoUwOsWU0AT1AdQcpw_1793686633
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3ab2de4544cso18512381fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793686633; x=1794291433;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jIc5h4IhkXIt4VgOmF6ym6QfRntQTchoUiwA4snRnC8=;
 b=UuusQH5fE4Ge9TcYbeu+q6n1UiJa+fM9YivhwBtJeYDUApe6/2K9xUrNoUZtQZ2vnW
 eR0NULRb3qfAfSSrZZh/GKydLPbDkGvNk3T+r2ybA5aML4Hx+KrGmyMgH8nJ8SsWpXWc
 rstjmc6IPnki8fUlPmgRJ4EbolSs0Vmo6esyKoflquakGS1wchc7072cEYKvTAlT7Toa
 EqDQyZCYWR3gDGMHCYCrQdGoAgU70oOmGywACws+L/mWKNCJV8+qzviNeO1OpeH8EX2L
 X9LrSblBVPU7qUm/dfWLW5867SlIRkT9U4o9+HDj4+09qjfpc3BwTWRMQLw7eVWZec8b
 SV6g==
X-Gm-Message-State: APuU4Z+q0wA1fWQ4q38mvRU48oJDWDs+vKDjw/0All9yWGjzFFtfKSSF
 RARlPuMlSXo8fLPvWHDb76UwW/qh1vftmfkYLZazVpzKl2lUcTUNTEJenjm6zXrltZEOxFoHC5M
 ZGqfw/LIAVG1fWzahNFq+V0L1MdVzwOSbvzaWMnMUEskW3ZtXwPSBu5sf95JeDDQEWeCm
X-Gm-Gg: AYBFou09+jA7xKCRSJ1trERZVCtRYpIKc67N98vwowGMC+v90d/pZ5QR4K8YIHDdrlI
 Fb8Ik8ZOgr3s3mEsbRxMLwZxLs9Q87RfM96gkw841imR+F/gllugfheSsh1vB2UPs91tSiIinpI
 3WtgU1foAQh/F12eE9zv9PjyC+G4jpgWQqtSfGlB95IxBpnTHbSTFCicMznW77CglDS9Wr/aXRE
 CxPL4UOziHFDvMyJX2EH9Whu0Itt9UT10hfyct0hsm13uGxB47ht9D7+tRvN+1h8JBQgeHsPQ3l
 /3fsIMhLXibere5k/YK4PqkBmDjEDLdnBcdqS4wF0HTHGKw1edb8oDwSOsanuDEAi5nNMtwZrj8
 syFLxnKzCIdNd7+C7/5tWmrJfOZzmKDpztOJqYs7LCLy3v3jBlcEtPQFgUoewN6Uh/yDY6Q==
X-Received: by 2002:a05:6512:ac2:b0:5bf:e32c:51b with SMTP id
 2adb3069b0e04-5bfe32c06cemr2651611e87.6.1793686632937; 
 Mon, 02 Nov 2026 22:17:12 -0800 (PST)
X-Received: by 2002:a05:6512:ac2:b0:5bf:e32c:51b with SMTP id
 2adb3069b0e04-5bfe32c06cemr2651592e87.6.1793686632449; 
 Mon, 02 Nov 2026 22:17:12 -0800 (PST)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe073e0f9sm1964634e87.54.2026.11.02.22.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 22:17:11 -0800 (PST)
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
Subject: [PATCH v17 08/12] mm/hmm: implement rollback for device page
 migration in HMM pagewalk
Date: Tue,  3 Nov 2026 08:16:25 +0200
Message-ID: <20261103061629.972669-9-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103061629.972669-1-mpenttil@redhat.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2xX30ZaiP9f66GwZnBZX5evsfMj_r_pRmejN_nWCYNA_1793686633
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

During the migration pagewalk, the PTE table could be cleared and/or
changed into PMD leaf or even another PTE table while dropped locks.

In these cases the possibly inserted migration ptes are gone. We have
to however undo the collecting done so far, so unlock the folios and
drop reference taken.

During the pagewalk we notice such scenarios if going to recollect a pfn
but have already committed to migrate the entry with HMM_PFN_MIGRATE, in
which case do rollback. Rollback clears (HMM_PFN_VALID | HMM_PFN_MIGRATE)
which is safe, as migration is entirely driven by default_flags.

If we encounter migration ptes they are just skipped to allow for restart
own walks.

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
 include/linux/hmm.h |  22 ++++++++
 mm/hmm.c            | 127 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 148 insertions(+), 1 deletion(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 4f56f3419cb4..b08ebc1343dd 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -111,6 +111,28 @@ static inline unsigned int hmm_pfn_to_map_order(unsigned long hmm_pfn)
 	return (hmm_pfn >> HMM_PFN_ORDER_SHIFT) & 0x1F;
 }
 
+/*
+ * hmm_pfn_collected() - is this pfn entry prepared for migration ?
+ * If collected the folio's refcount is increased and the folio
+ * is locked.
+ */
+static inline bool hmm_pfn_collected(unsigned long hmm_pfn)
+{
+	return (hmm_pfn & (HMM_PFN_VALID | HMM_PFN_MIGRATE)) ==
+		(HMM_PFN_VALID | HMM_PFN_MIGRATE);
+}
+
+/*
+ * hmm_pfn_rollback_collected() - undoes the collection of hmm_pfn
+ *
+ * Note for total rollback the folio's refcount has to be put
+ * and folio has to be unlocked.
+ */
+static inline unsigned long hmm_pfn_rollback_collected(unsigned long hmm_pfn)
+{
+	return hmm_pfn & ~(HMM_PFN_VALID | HMM_PFN_MIGRATE | HMM_PFN_COMPOUND);
+}
+
 /*
  * struct hmm_range - track invalidation lock on virtual address range
  *
diff --git a/mm/hmm.c b/mm/hmm.c
index 690b73908f34..1c8a3fa29c4e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -95,6 +95,11 @@ enum {
 			      HMM_PFN_P2PDMA_BUS,
 };
 
+static void hmm_vma_handle_migrate_prepare_rollback(const struct hmm_vma_walk *hmm_vma_walk,
+						    unsigned long start,
+						    unsigned long end,
+						    unsigned long *hmm_pfn);
+
 static int hmm_pfns_fill(unsigned long addr, unsigned long end,
 			 struct hmm_vma_walk *hmm_vma_walk, unsigned long cpu_flags)
 {
@@ -111,6 +116,8 @@ static int hmm_pfns_fill(unsigned long addr, unsigned long end,
 		}
 	}
 
+	hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk, addr, end, &range->hmm_pfns[i]);
+
 	if (migrate && thp_migration_supported() &&
 	    (minfo & MIGRATE_VMA_SELECT_COMPOUND) &&
 	    IS_ALIGNED(addr, HPAGE_PMD_SIZE) &&
@@ -239,6 +246,9 @@ static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
 			spin_unlock(hmm_vma_walk->ptl);
 			hmm_vma_walk->pmdlocked = false;
 		}
+		/* Entries collected from a vanished page table are gone */
+		hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk, addr, end,
+							hmm_pfns);
 		return hmm_record_fault(addr, end, required_fault, walk);
 	}
 	return hmm_pfns_fill(addr, end, hmm_vma_walk, 0);
@@ -274,6 +284,9 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 	cpu_flags = pmd_to_hmm_pfn_flags(range, pmd);
 	required_fault =
 		hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, cpu_flags);
+	/* Entries collected from a vanished page table are gone */
+	hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk, addr,
+						end, hmm_pfns);
 	if (required_fault) {
 		if (hmm_vma_walk->pmdlocked) {
 			spin_unlock(hmm_vma_walk->ptl);
@@ -331,6 +344,15 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	if (!pte_present(pte)) {
 		const softleaf_t entry = softleaf_from_pte(pte);
 
+		/*
+		 * Our own migration entry, collected earlier in this walk:
+		 * keep the collected pfn, don't fault or roll it back.
+		 */
+		if (softleaf_is_migration(entry) && hmm_select_migrate(range) &&
+		    hmm_pfn_collected(*hmm_pfn) &&
+		    hmm_pfn_to_page(*hmm_pfn) == softleaf_to_page(entry))
+			return 0;
+
 		/*
 		 * Don't fault in device private pages owned by the caller,
 		 * just report the PFN.
@@ -416,6 +438,9 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 
 	new_pfn_flags = pte_pfn(pte) | cpu_flags;
 out:
+	hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk, addr,
+						addr + PAGE_SIZE,
+						hmm_pfn);
 	*hmm_pfn = (*hmm_pfn & HMM_PFN_INOUT_FLAGS) | new_pfn_flags;
 	return 0;
 
@@ -427,7 +452,19 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	} else {
 		pte_unmap(ptep);
 	}
-	/* Fault any virtual address we were asked to fault */
+	/*
+	 * This pte needs a fault, so it is not our migration entry: a pfn
+	 * collected here earlier is gone, roll it back before faulting.
+	 */
+	hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk, addr,
+						addr + PAGE_SIZE, hmm_pfn);
+	/*
+	 * Fault any virtual address we were asked to fault. When migrating,
+	 * only this page: later ptes may be our own migration entries or
+	 * caller owned device private pages, which must not be faulted.
+	 */
+	if (hmm_select_migrate(range))
+		end = addr + PAGE_SIZE;
 	return hmm_record_fault(addr, end, required_fault, walk);
 }
 
@@ -454,6 +491,9 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 		if (softleaf_is_device_private_write(entry))
 			cpu_flags |= HMM_PFN_WRITE;
 
+		hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk,
+							start, end,
+							hmm_pfns);
 		/*
 		 * Fully populate the PFN list though subsequent PFNs could be
 		 * inferred, because drivers which are not yet aware of large
@@ -475,6 +515,10 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 				spin_unlock(hmm_vma_walk->ptl);
 				hmm_vma_walk->pmdlocked = false;
 			}
+			/* Entries collected from a vanished page table are gone */
+			hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk,
+								addr, end,
+								hmm_pfns);
 			return hmm_record_fault(addr, end, required_fault, walk);
 		}
 		else
@@ -561,6 +605,51 @@ static int migrate_vma_split_folio(struct folio *folio,
 	return __migrate_vma_split_folio(folio, fault_page);
 }
 
+/*
+ * Due to dropping ptl locks for splitting for instance, would we
+ * overwrite already collected pfns? This could happen when pmd
+ * pointing to a page table has vanished and been replaced with
+ * a leaf pmd, or another page table. In that case unref and unlock
+ * the folios, the pfns of which were collected from the disappeared
+ * page tables.
+ *
+ * Migrate mode drives fault/migration requests only via range->default_flags.
+ * (HMM_PFN_VALID | HMM_PFN_MIGRATE) denotes a collected entry and can safely
+ * be cleared from hmm_pfn[].
+ */
+static void hmm_vma_handle_migrate_prepare_rollback(const struct hmm_vma_walk *hmm_vma_walk,
+						    unsigned long start,
+						    unsigned long end,
+						    unsigned long *hmm_pfn)
+{
+	struct hmm_range *range = hmm_vma_walk->range;
+	struct migrate_vma *migrate = range->migrate;
+	struct folio *fault_folio = NULL;
+	enum migrate_vma_info minfo;
+	struct folio *folio;
+	unsigned long i;
+
+	minfo = hmm_select_migrate(range);
+	if (!minfo)
+		return;
+
+	WARN_ON_ONCE(!migrate);
+
+	fault_folio = migrate->fault_page ?
+		page_folio(migrate->fault_page) : NULL;
+
+	for (i = 0; start < end; start += PAGE_SIZE, i++) {
+		if (hmm_pfn_collected(hmm_pfn[i])) {
+			folio = page_folio(hmm_pfn_to_page(hmm_pfn[i]));
+			if (folio != fault_folio)
+				folio_unlock(folio);
+			folio_put(folio);
+			hmm_pfn[i] = hmm_pfn_rollback_collected(hmm_pfn[i]);
+
+		}
+	}
+}
+
 static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
 					      pmd_t *pmdp,
 					      unsigned long start,
@@ -731,6 +820,11 @@ static int hmm_vma_handle_migrate_prepare(const struct mm_walk *walk,
 	pte = ptep_get(ptep);
 
 	if (pte_none(pte)) {
+		hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk,
+							addr,
+							addr + PAGE_SIZE,
+							hmm_pfn);
+
 		if (vma_is_anonymous(walk->vma)) {
 			*hmm_pfn &= HMM_PFN_INOUT_FLAGS;
 			*hmm_pfn |= HMM_PFN_MIGRATE;
@@ -783,6 +877,10 @@ static int hmm_vma_handle_migrate_prepare(const struct mm_walk *walk,
 		pfn = pte_pfn(pte);
 		if (is_zero_pfn(pfn) &&
 		    (minfo & MIGRATE_VMA_SELECT_SYSTEM)) {
+			hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk,
+								addr,
+								addr + PAGE_SIZE,
+								hmm_pfn);
 			/* Like pte_none(): only anonymous memory can be populated */
 			if (!vma_is_anonymous(walk->vma))
 				goto out;
@@ -929,6 +1027,13 @@ static int hmm_vma_handle_migrate_prepare(const struct mm_walk *walk,
 }
 
 #else
+static void hmm_vma_handle_migrate_prepare_rollback(const struct hmm_vma_walk *hmm_vma_walk,
+						    unsigned long start,
+						    unsigned long end,
+						    unsigned long *hmm_pfn)
+{
+}
+
 static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
 					      pmd_t *pmdp,
 					      unsigned long start,
@@ -1068,6 +1173,16 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 			hmm_vma_walk->pmdlocked = false;
 		}
 
+		/* Our own migration entry, collected earlier in this walk */
+		if (minfo && hmm_pfn_collected(hmm_pfns_start[0]) &&
+		    hmm_pfn_to_page(hmm_pfns_start[0]) ==
+		    softleaf_to_page(softleaf_from_pmd(pmd)))
+			return 0;
+
+		/* Not ours: entries collected from a vanished page table are gone */
+		hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk, start, end,
+							hmm_pfns_start);
+
 		if (required_fault) {
 			/*
 			 * Someone else's migration: when migrating, wait in
@@ -1171,6 +1286,10 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		ptep = pte_offset_map(pmdp, addr);
 	}
 	if (!ptep) {
+		/*
+		 * The pte table is gone: re-walk from start, entries collected
+		 * from the old table are rolled back as they are revisited.
+		 */
 		addr = start;
 		goto again;
 	}
@@ -1192,6 +1311,12 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 				flush_tlb_range(walk->vma, start, addr);
 				unmapped = false;
 			}
+			/*
+			 * The pte lock was dropped and the pte table may have
+			 * changed: re-walk from start. Our own migration entries
+			 * are kept, anything else collected is rolled back.
+			 */
+			addr = start;
 			goto again;
 		}
 		if (r) {
-- 
2.55.0

