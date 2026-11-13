Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156E606B2D4
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g9K70reO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5008910E4DF;
	Fri, 13 Nov 2026 16:26:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1565A10E4DF;
 Fri, 13 Nov 2026 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794587155; x=1826123155;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UPBL6CYZiOLgk3Wya2d7czaTmGhGsvKoKKlBggwDPwo=;
 b=g9K70reO+jAAfM47aKTpSwUvxqgGuQAxQgwcIzcNpSknsZU4HJLPD2z4
 sGMt57UaF3Iis9E+OZWNJmqQ/9SWW6Ex20jK3uIZ6ZBXgC8Ema9hFKCjP
 KvapHI0sTB4Y2ehrnKkCvd1cgH6/Pc9xBCQrxKnqbVVwcNT5ytQuY9/LT
 dp+rRa7DKAiXEKQzQoaHXK9LhHgY+V+HVakLmogjWXRmrfCYXljaCEDWJ
 GNvo+Ojfyg3pNN/yjJTJjBQA1VUkFKbGq38TQAscQWauKH/wjCizzEMEg
 Gwbt42nfcyieTJ7AmCB3JzUhq1GuotCh/TNDuMMoRmsuQ+82lqOQKPJoL w==;
X-CSE-ConnectionGUID: 9ywdyFIuQz2DpkR2rnpQcA==
X-CSE-MsgGUID: w54M4gzDRy+m7EADToE+ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3382645"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3382645"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 08:25:55 -0800
X-CSE-ConnectionGUID: rCG2ULUiRKW+rzFItF/tyA==
X-CSE-MsgGUID: pDXxuM1DTTmAqROBanmyjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9226402"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com)
 ([10.245.244.186])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 08:25:53 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] mm/hmm: skip NUMA balancing on protnone faults
Date: Fri, 13 Nov 2026 16:25:22 +0000
Message-ID: <20261112-numa-v1-1-ad9cbca8f49a@intel.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Change-ID: 20261112-numa-3649f4bf57c9
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

When automatic NUMA balancing marks a PTE or PMD as protnone
(PAGE_NONE), hmm_pte_need_fault() requests a fault to restore access
permissions, including _PAGE_RW when write access is needed.

Calling handle_mm_fault() from hmm_do_fault() currently triggers NUMA
balancing in do_numa_page() and do_huge_pmd_numa_page(). When
hmm_range_fault() runs from a device driver or kworker context (such as
a GPU SVM or userptr rebind worker), folios get migrated toward the CPU
node executing the remote fault.

Also, each folio migration invokes try_to_migrate_one() ->
mmu_notifier_invalidate_range_start(), which invalidates the
caller's mmu_interval_notifier while holding mmap_lock. That causes
hmm_range_fault() to abort with -EBUSY after every 2 MiB PMD and exhaust
its retry timeout on large buffers, which has been observed with large
imported Xe userptr buffers.

Add FAULT_FLAG_NO_NUMA and set it in hmm_do_fault() so protnone entries
restore PTE/PMD permissions in-place without performing NUMA balancing,
matching GUP's default !FOLL_HONOR_NUMA_FAULT behaviour.

Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Mika Penttilä <mpenttil@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
---
 include/linux/mm.h       | 3 ++-
 include/linux/mm_types.h | 3 +++
 mm/hmm.c                 | 2 +-
 mm/huge_memory.c         | 3 +++
 mm/memory.c              | 3 +++
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77b5d450fe45..4b6ad3c0b591 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -717,7 +717,8 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
 	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
-	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
+	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }, \
+	{ FAULT_FLAG_NO_NUMA,		"NO_NUMA" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1ed35d258d2e..2ea71c1bb170 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1819,6 +1819,8 @@ enum tlb_flush_reason {
  * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
  *                        We should only access orig_pte if this flag set.
  * @FAULT_FLAG_VMA_LOCK: The fault is handled under VMA lock.
+ * @FAULT_FLAG_NO_NUMA: Do not perform NUMA balancing migration or NUMA
+ *                      task access accounting on protnone faults.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -1857,6 +1859,7 @@ enum fault_flag {
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
 	FAULT_FLAG_VMA_LOCK =		1 << 12,
+	FAULT_FLAG_NO_NUMA =		1 << 13,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
diff --git a/mm/hmm.c b/mm/hmm.c
index 2f1e98c6b644..62cdeb071781 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -648,7 +648,7 @@ static int hmm_do_fault(struct mm_struct *mm,
 	unsigned long addr = hmm_vma_walk->last;
 	unsigned long end = hmm_vma_walk->end;
 	unsigned int required_fault = hmm_vma_walk->required_fault;
-	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE | FAULT_FLAG_NO_NUMA;
 	struct vm_area_struct *vma;
 
 	if (hmm_vma_walk->locked)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0d589be136d2..ea380bf45df0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2361,6 +2361,9 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	if (!folio)
 		goto out_map;
 
+	if (vmf->flags & FAULT_FLAG_NO_NUMA)
+		goto out_map;
+
 	nid = folio_nid(folio);
 
 	target_nid = numa_migrate_check(folio, vmf, haddr, &flags, writable,
diff --git a/mm/memory.c b/mm/memory.c
index fe72e66c9c2e..53c819a6e49a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6404,6 +6404,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 
+	if (vmf->flags & FAULT_FLAG_NO_NUMA)
+		goto out_map;
+
 	nid = folio_nid(folio);
 	nr_pages = folio_nr_pages(folio);
 

---
base-commit: 4318887a3efa4c53d6f083ccfd7105b809a3ac65
change-id: 20261112-numa-3649f4bf57c9
