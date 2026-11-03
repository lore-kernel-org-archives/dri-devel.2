Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E69606A33B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hLNapVgL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3763510E79A;
	Tue,  3 Nov 2026 06:16:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B531A10F35A
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793686605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nW2XtCU/J0JPyQa2Tmg6J/L9KVt/vCE5uqUG4LBeVzo=;
 b=hLNapVgLe/2AF9ZYQLsSQTATRlLZtK16VRc3qseRg2YKC1wN4Kv49PSivEp+5UiaS+khH0
 Y50Yj1eN80qzQ9A7UWEnaBicQsQLA5UiAAgI6z9+vfw9BOXtbZ3JGTOz9CX623hdvk8NYe
 hQK/VWbpTKWrG3MdtgJYM6ULzh3IytQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-zbhM46GfMB-CYWZmjAhypQ-1; Tue, 03 Nov 2026 01:16:43 -0500
X-MC-Unique: zbhM46GfMB-CYWZmjAhypQ-1
X-Mimecast-MFC-AGG-ID: zbhM46GfMB-CYWZmjAhypQ_1793686602
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5be456fa317so2125098e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793686602; x=1794291402;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nW2XtCU/J0JPyQa2Tmg6J/L9KVt/vCE5uqUG4LBeVzo=;
 b=j9u+ZSsuTU/TXbuexAuNqZ/L6uIpY8OsW9u57Gbz0MbNNKv+ZSibjIutm5fAiXUBat
 cK97h7KdhWFIj/tAOSe+aOG+BFYvduWVS/vjHaRxnR6YUHp3sADmDjX4s9+Dj0WRz7BO
 bfAXiTsaYOeOvl7RZqqaaElOWlYOKHB5l9IymxJA3CyjJhduvFidB4MPJijNfOBIvZ9Z
 4pVuyF6TuMmKato81a9nFHxnAp0TiV67kuuQZkBAOM9vj9LHQ3KNBb7DqkivjvPG55M/
 N7qYPAPE5WXnCjs7/8r6PEo+bIXDOfJ7D6ICfufX2udEeZ9AdHmYWNGSBCh8FjXWOXOu
 wzXw==
X-Gm-Message-State: APuU4Z95KT//F4ABGEmg9sOsLxbSbP60EfHp6/wfukAwBpZ9r9ui8lLY
 UJD4MGoTDnZ75L5mNEA2CDiJsUADH58YyMfDf+L3iMozO2r2liQLlu0WBGn2tm9uwCG0nmWVoi6
 pOCo+whz3JxX9w36zk/LxOOszf+lSwGUEGE5cnknyEZ3dbwXsEYh3wwFTO1ro1jQi8UabjYPK1A
 r4sjk=
X-Gm-Gg: AYBFou2H46X7N0E/ACRAWeyFnRWpSpKIRzevpjnqQUXrUP8RN4Xl72d8MpZ9fjeCovx
 b6rqerXgJ0Pw3Rrkus4oJS7HuujVDwpgZL0aan9XXoGpoEFNiO5KXslnfWlM4k5IxdhkUHsU+K/
 M4DnnYCZnYS4yxyJfA5yXx3QH4O+k2wOkAzG8twjP1xT34jFwwRTNH2XASbU/hreFQ9hlysSbap
 m0ZtQSjf5EsbUq9R4Wj0CdM9r+bd27i0tKXAyQ6Ci4Km1BLT7Y3kAXkjYWGKxFDRHHufuljtamY
 tkyAtein0vY7nXzmJYkLf8SpW+VsgVXZI2UE4omVkKFA4L0Ldb75nqLCw2gqQR1ZD68sJd+ZGrF
 zwkKeVgm1h/W1rNz6jnmF3OnWWHzX8Qe6V8JIRuqrLpXXE/bNdYL/oLqa/uQpjFWxc2Jk2g==
X-Received: by 2002:a05:6512:b93:b0:5be:57a5:52e8 with SMTP id
 2adb3069b0e04-5bfd951d167mr4302298e87.6.1793686601642; 
 Mon, 02 Nov 2026 22:16:41 -0800 (PST)
X-Received: by 2002:a05:6512:b93:b0:5be:57a5:52e8 with SMTP id
 2adb3069b0e04-5bfd951d167mr4302282e87.6.1793686601037; 
 Mon, 02 Nov 2026 22:16:41 -0800 (PST)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe073e0f9sm1964634e87.54.2026.11.02.22.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 22:16:39 -0800 (PST)
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
Subject: [PATCH v17 00/12] migrate on fault for device pages
Date: Tue,  3 Nov 2026 08:16:17 +0200
Message-ID: <20261103061629.972669-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I7D4zWMGWofFaBFGIwGWwdsloazEjp8nImxUHJ2soSI_1793686602
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mika Penttilä <mpenttil@redhat.com>

Currently, the way device page faulting and migration works
is not optimal, if you want to do both fault handling and
migration at once.

Being able to migrate not present pages (or pages mapped with incorrect
permissions, eg. COW) to the GPU requires doing either of the
following sequences:

1. hmm_range_fault() - fault in non-present pages with correct permissions, etc.
2. migrate_vma_*() - migrate the pages

Or:

1. migrate_vma_*() - migrate present pages
2. If non-present pages detected by migrate_vma_*():
   a) call hmm_range_fault() to fault pages in
   b) call migrate_vma_*() again to migrate now present pages

The problem with the first sequence is that you always have to do two
page walks even when most of the time the pages are present or zero page
mappings so the common case takes a performance hit.

The second sequence is better for the common case, but far worse if
pages aren't present because now you have to walk the page tables three
times (once to find the page is not present, once so hmm_range_fault()
can find a non-present page to fault in and once again to setup the
migration). It is also tricky to code correctly. One page table walk
could costs over 1000 cpu cycles on X86-64, which is a significant hit.

We should be able to walk the page table once, faulting
pages in as required and replacing them with migration entries if
requested.

Add a new flag to HMM APIs, HMM_PFN_REQ_MIGRATE,
which tells to prepare for migration also during fault handling.
For the migrate_vma_setup() call paths, new flags, MIGRATE_VMA_FAULT,
and MIGRATE_VMA_WRITE are added to tell to add fault handling to migrate.

An extra benefit of migrating with hmm_range_fault() path
is the migrate_vma.vma gets populated, so no need to
retrieve that separataly.

This series avoids the problems in current collecting implementation,
where racing MADV_DONTNEED could make the collecting arrays overflow.
This is achieved mainly by having a rollback mechanism and
populating the collecting array as the last step.

Tested in X86-64 VM with HMM test device, passing the selftests.
The main goal of this patchset is to provide a new feature,
migrate efficiently on fault, and not directly improve performance
of current migrate_vma_setup() (which is now routed thru
hmm_range_fault()) callers. That said, the migrate throughput tests
from the selftests show that there is at least no regression for
current migrate_vma_setup() callers.

For nouveau migrate-on-fault test harness was : Fedora 44,
Mesa Rusticl, and a fine-grained-system-SVM OpenCL program.
Nouveau SVM is opt-in via Mesa. The OpenCL program passes
a plain malloc pointer (64 pages, array of integers) to the GPU.
Increments each element on GPU, and verifies on the CPU the result.
So it drives both directions of migration. With svm_migrate_on_fault=1,
no migration at bind happens. The GPU used in testing was Pascal
generation GP102.

Changes in v17:
  - rebased on v7.4-rc1 (drm-tip)
  - addressed sashiko's concerns
  - addressed review comments from Balbir
  - fixed email address of Liam R. Howlett

Sashiko's concerns in v16
https://sashiko.dev/#/patchset/20261021060506.2377545-1-mpenttil%40redhat.com

Answers to sashiko's concerns per patch:
patch 03
  Q "Can this condition in mm/hmm.c:hmm_vma_capture_migrate_range() ever
  be true?"
  A it can't trigger; dropped in v17
  Q "Should this check instead verify that the single VMA covers the
  entire requested range..?"
  A In v17 the single vma must cover the whole range (-ERANGE otherwise,
  like migrate_vma_setup()), and hmm_vma_walk_hole() returns -EFAULT for
  holes outside a vma when migrating. That handles both the leading hole
  and the whole-range hole."  
  Q "is it intentional that hmm_vma_capture_migrate_range() runs before
  validating vma->vm_flags?"
  A  Not intentional. In v17 the capture runs only after the vm_flags check,
  so no MMU_NOTIFY_MIGRATE invalidation is fired for a vma we can't handle,
  and an unsupported vma fails with -EFAULT when migrating. I also added
  the same hugetlb/VM_SPECIAL/DAX restrictions as migrate_vma_setup().
  Q "Should VMA eligibility for both HMM and migration be verified before
  capturing the VMA and arming the MMU notifier?"
  A Fixed in v17
  Q.1 "Invalidation range across faults question"
  A.2 In v17 it's closed before faulting and reopened for the next walk, so
  it only covers walking and collecting
  Q.2 "Nested invalidations make the retry check return -EBUSY"
  A.2 This is pre existig behavior already in hmm_range_walk(). -EBUSY and
  retries is normal HMM behavior and with migration the caller finalizes the
  collected so far entries before retry
  Q.3 "Re-collecting a page without a fresh invalidate_range_start()..?"
  A.3 One start/end pair covers every PTE change in the range until the
  end call

patch 04
  Q "about skipping migration entries pte and pmd level"
  A In v17 both paths are fixed: when migrating, a foreign migration entry
  with a fault requested now goes through hmm_do_fault() and waits outside
  the walk, otherwise the pfns are masked as before; our own collected
  entries are recognised and kept. The input pfns are also cleared when
  migrating, so nothing is left uninitialized.
  Q "stale enries after EAGAIN->goto again?"
  A The !ptep rollback did target the wrong range. In v17, after the
  pte lock is dropped (split or table gone) the walk restarts the pmd
  range from start: our own migration entries are recognised
  (collected and same page) and kept, everything else collected is rolled
  back as it's revisited. The pmd migration entry path now rolls back
  before masking, and the own-entry check there requires the same page
  Q "Behavior after failed splits"
  A Fixed that after fail, return what we have so for, no HMM_PFN_ER

patch 05
  Q1 "About folio splits.."
  A But made a fix for v17 so that check if folio is large before split
  so no error if already split
  Q2 Can this trigger a use-after-free when fault_page is a tail subpage
  of a large device-private folio?
  A A fix is in v17
  Q3 "about protnone case for migrate_vma_setup() callers without
  MIGRATE_VMA_FAULT"
  Q4 "Doesn't that make the !pte_present(pte) device-private migration
  path here unreachable unless range->dev_private_owner is also set to
  migrate->pgmap_owner?"
  A yes both fixed in v17
  Q5 "Zero-pfn branch wipes INOUT flags, no vma_is_anonymous() check"
  A fix is in v17
  Q6 "When migrate_vma_split_folio() fails (both here and in the
  !pte_present(pte) branch above), hmm_vma_handle_migrate_prepare() jumps
  to out_error and returns -EFAULT"
  A This is the same as the earlier split-failure comment: in v17 a
  failed split no longer reports HMM_PFN_ERROR, and addr keeps its valid
  pfn (pmd level too). Skipping the rest of the pmd range is intentional
  and matches existing behavior.

  Q6.1: "Could folio_lock held before handle_mm_fault() cause deadlock"
  A No. Collection is anonymous-only: file folios are never collected, so
  page cache and invalidate_lock ordering (truncate -> folio_lock) never
  come into play. Faults are confined to the single vma being migrated,
  and a non-KSM anonymous page is mapped at most once in it ; that mapping
  is our migration entry. A PMD-mapped THP is collected whole, behind its
  PMD migration entry; PTE-mapped large folios are split before collecting.

  We never fault our own entries: when migrating, only the PTE
  that needs a fault is faulted, so migration_entry_wait() on our own
  lock can't happen.

  KSM (the same page at several addresses): the second occurrence fails
  the collection trylock and isn't collected, and breaking COW
  (do_wp_page()) copies without taking the lock.

  A swapcache folio still referenced by other swap entries isn't
  collected (folio_free_swap() check); otherwise do_swap_page(), with
  no retry allowed while migrating, would block on our lock.

  Reclaim and compaction under the fault's allocations: reclaim only
  trylocks, and direct compaction runs with PF_MEMALLOC and never takes
  a blocking folio lock; it also skips our folios because of the
  extra reference. Other tasks reach our folios only through the
  migration entries (migration_entry_wait(), holding no folio locks)
  or via trylock.

  Q6.2 and Q6.3 are addressed in v17:  own migration entries are recognised
  before the required_fault check and kept on re-walk, and the !ptep case
  re-walks from start without the wrong-range rollback, rolling back
  collected entries when revisited

patch 06
  Q1 "Can returning -EBUSY from the split path in
  hmm_vma_handle_migrate_prepare_pmd() leave stale pre-split PMD entries in
  range->hmm_pfns[] across the re-walk?"
  A In v17 the re-walk always rewrites or faults these entries: a migration
  entry is only kept as ours if it's collected (VALID|MIGRATE) and the
  same page, so the stale pmd output never survives; otherwise it's faulted
  or reset via out:. Migration takes requests only from default_flags
  (pfn_flags_mask must be 0, input is cleared), so there are no per-page
  request flags to clobber. v17 clears the pmd-level entries before
  re-walking as PTEs.
  
  for Q2 : done in v17: both the pmd folio_trylock() failure and a
  failed pmd split now return 0, leaving the valid pfns from
  hmm_vma_handle_pmd() without HMM_PFN_MIGRATE, the same as the
  PTE-level trylock failure. The HMM_PFN_ERROR fill in
  hmm_vma_walk_pmd() is gone.

patch 08
  Q "What happens if entries in hmm_pfns were previously collected,
  locks were dropped, and on re-walk the page table entry now requires
  a fault, fails with -EFAULT, or is a PMD migration entry?"
  A these should roll back first. fixed in v17
  Q "Could reaching the out: label in hmm_vma_handle_pte() prematurely
  roll back a migration PTE that this walk already installed?"
  A Addressed in v17. Our own migration entries are recognised before the
  required_fault check (collected and the same page) and kept, so a
  re-walk never rolls them back under a live migration pte. A migration
  entry that isn't ours is rolled back (at out:, or before faulting) and,
  with REQ_FAULT while migrating, goes through hmm_do_fault() so
  handle_mm_fault() waits for that migration outside the walk.
  Q "Does this rollback miss entries collected in [start, addr)
  when the PTE lock is dropped partway through a PMD?"
  A The !ptep rollback over the wrong range fixed in v17

patch 09
   same concerns as for patch 03-05 and 08 and addressed in v17

patch 10
  Q "What happens in do_fault_and_migrate() if mmu_interval_read_retry()
  returns true after migrate_vma_pages() has already migrated the folios?"
  A The state is always consistent: any invalidation also clears the
  device page table, so there's never a stale device mapping.
  Normally the trip comes from an unmap/zap: our migration ptes are gone,
  migrate_vma_finalize() releases the dst pages, and the -EBUSY retry
  re-migrates. In the remaining case (e.g. a huge zero pmd split in
  migrate_vma_insert_page()) the pages end up committed with no device
  mapping yet, which is legal and filled in by the next device fault
  with real HW. The selftest never hits that case, since the buffer
  is written first.
  Q "Does TEST_F(hmm, migrate_on_fault) actually trigger page faults
  during hmm_range_fault()?"
  A  Agreed, with the whole buffer written it never faulted. In v17
  the test uses hmm_buffer_alloc() and, like anon_read, leaves the
  first two pages unwritten: page 0 stays pte_none so hmm_range_fault()
  has to fault it in before migrating, and page 1 maps the zero page.
  Both are checked to read back as zero from the device.

patch 11
  sashiko flags some previously flagged issues in the documentation
  patch

patch 12
  Q What happens in nouveau_dmem_fence_poll() in
  drivers/gpu/drm/nouveau/nouveau_dmem.c when nouveau_fence_new()
  fails in its callers?
  A Agreed, the return value was ignored, as in the existing
  nouveau_dmem code. In v17 both paths that use the poll initialize
  the fence to NULL, check nouveau_fence_new(), and treat a failure
  as an unconfirmed copy: readback returns VM_FAULT_SIGBUS, and the
  fault path doesn't map the page. The same pattern in the existing
  bulk migration path can be fixed separately.
  
  Q "When the retry loop in nouveau_dmem_migrate_fault() in
  drivers/gpu/drm/nouveau/nouveau_dmem.c repeats after
  ret == -EBUSY (either from hmm_range_fault() or from
  mmu_interval_read_retry()), does migrate.src (aliased by
  range.hmm_pfns) retain stale migrate_pfn values from the
  previous iteration?"
  A In v17 hmm_range_fault() clears range->hmm_pfns[] at the
  start of every migrating walk (requests come only from default_flags),
  so each retry starts from zero, the same as migrate_vma_setup()
  zeroing args->src, and there's no early-return path left
  that keeps an input entry. migrate_hmm_range_setup() also
  resets dst[] for every entry.
  
  Q Question about drm->dmem->migrate.chan synchronization
  A Copies from migrate_to_ram(), the SVM fault worker, bulk
  migration and eviction could write commands and fences into
  the shared migrate channel concurrently.
  In v17 those writes are serialized by a dmem migrate mutex,
  held only around the command writes and fence creation,
  not across page allocation. Serializing against TTM's own use
  of the channel is outside this series.
  
  Q "If nouveau_dmem_fence_poll(&fence) times out and returns
  -EBUSY here in nouveau_dmem_migrate_fault()
  (or above in nouveau_dmem_migrate_to_ram()) in
  drivers/gpu/drm/nouveau/nouveau_dmem.c, doesn't the page
  migration still get committed with uncopied data while DMA
  may still be active?"
  A In v17 the migration is committed only after the copy
  fence completes: migrate_vma_pages() now runs after the
  wait (the fault path still replays before waiting). If the
  copy can't be confirmed (timeout or no fence), the entries
  are marked not migrated, so finalize restores the original
  ptes and the source stays valid; the GPU fallback then maps
  the original page. Since a wedged copy engine may still use
  the pages, their DMA mappings and the destination folios
  are leaked on purpose rather than unmapped and freed.
  
  Q "Can nouveau_dmem_migrate_fault() in
  drivers/gpu/drm/nouveau/nouveau_dmem.c
  map a VRAM page into the GPU that migrate_vma_pages() rejected
  and that migrate_vma_finalize() is about to free?"
  A  In v17 the fault path clears the GPU pfn for every entry
  that migrate_vma_pages() didn't migrate
  (MIGRATE_PFN_MIGRATE cleared), so a rejected destination page
  is never mapped. The existing fallback then maps the original
  source page in place, which finalize restores.
  
  Q "Why is __nouveau_pfns_map_locked() called before checking
  whether pfns[0] & NVIF_VMM_PFNMAP_V0_V is set in
  nouveau_dmem_migrate_fault() in
  drivers/gpu/drm/nouveau/nouveau_dmem.c?"
  A In v17 the GPU is only mapped when the resulting pfn is valid.
  If nothing migrated and the snapshot isn't mappable
  (huge zero folio, error entry, failed VRAM allocation), leave
  the existing GPU mapping untouched and return -ENOENT, so the
  caller falls back to nouveau_range_fault().
  
  Q "Doesn't ignoring all MMU_NOTIFY_MIGRATE events with
  range->owner == sn->svmm->vmm->cli->drm->dev in
  nouveau_svm_range_invalidate() in
  drivers/gpu/drm/nouveau/nouveau_svm.c also ignore concurrent
  migrations triggered by other paths on the same device, allowing
  freed VRAM or system RAM pages to be mapped into the GPU VMM?"  
  A In v17 only the invalidations raised by this fault's own
  migration are ignored: the per-fault notifier records the
  task running the walk, and only MIGRATE events from that
  task while it migrates skip the seq bump.

  Q "Should __nouveau_pfns_map_locked() in
  drivers/gpu/drm/nouveau/nouveau_svm.c propagate the return value
  of nvif_object_ioctl() to nouveau_dmem_migrate_fault()?"
  A  Yes. In v17 __nouveau_pfns_map_locked() returns the
  nvif_object_ioctl() result and nouveau_dmem_migrate_fault()
  propagates it
  
Link to v16:
https://lore.kernel.org/linux-mm/20261021060506.2377545-1-mpenttil@redhat.com/

Cc: David Hildenbrand <david@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>

Mika Penttilä (12):
  mm/Kconfig: changes for migrate on fault for device pages
  mm: add helper to convert HMM pfn to migrate pfn
  mm/hmm: preparations for HMM to participate in migration
  mm/hmm: do the plumbing for HMM to participate in migration
  mm/hmm: migrate collection in HMM pagewalk - pte level
  mm/hmm: migrate collection in HMM pagewalk - pmd level
  mm/hmm: add lazy MMU mode support for migration in HMM pagewalk
  mm/hmm: implement rollback for device page migration in HMM pagewalk
  mm: enable device page migration from HMM pagewalk
  lib/test_hmm: add a new testcase for the migrate on fault
  Documentation/mm/hmm: document migration through hmm_range_fault()
  drm/nouveau/svm: add support for migrate on fault

 Documentation/mm/hmm.rst               |   45 +
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  402 ++++++++-
 drivers/gpu/drm/nouveau/nouveau_dmem.h |   12 +
 drivers/gpu/drm/nouveau/nouveau_svm.c  |  155 ++--
 drivers/gpu/drm/nouveau/nouveau_svm.h  |    5 +
 include/linux/hmm.h                    |   51 +-
 include/linux/migrate.h                |   59 +-
 lib/test_hmm.c                         |  174 +++-
 lib/test_hmm_uapi.h                    |   21 +-
 mm/Kconfig                             |    1 +
 mm/hmm.c                               | 1075 ++++++++++++++++++++++--
 mm/migrate_device.c                    |  618 +++-----------
 tools/testing/selftests/mm/hmm-tests.c |   56 ++
 13 files changed, 1984 insertions(+), 690 deletions(-)

drm-tip
base-commit: abc364961b361ab626fa5a09568b22744f1e0393
-- 
2.55.0

