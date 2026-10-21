Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75096606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a/ajLXsr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D14E110F8F3;
	Wed, 21 Oct 2026 06:05:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925EF10F8F3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792562722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fkDeNsEKQP2qp4cRwqP/yX9WA/UKES9gmaTfQ1sp/cg=;
 b=a/ajLXsrVOsUYlHqoqCVGZjZmeNn0e/SjLAKJ4ULxaEs3LqpzzaHT3GsPy3X/hxPN1kcT/
 1v4BMTwOe1JU56bOXbjs4Hr+6tpIKDHySqickw8NRdhI/gLu3nXDLKJ5AiyWK+N3lfhl2X
 8RVH/2eeYahFy9b7eEipcIajl9P8WfQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-YsRaqClhMa6eMJCaT5h-gQ-1; Wed, 21 Oct 2026 02:05:17 -0400
X-MC-Unique: YsRaqClhMa6eMJCaT5h-gQ-1
X-Mimecast-MFC-AGG-ID: YsRaqClhMa6eMJCaT5h-gQ_1792562716
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48b0a199b20so293203f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792562716; x=1793167516;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fkDeNsEKQP2qp4cRwqP/yX9WA/UKES9gmaTfQ1sp/cg=;
 b=AT2FCdRdBAdCRmEklLVh/9kFvKaD8V61E8Vt/6enZ+ZxFV+Ue5tN18Fju4R2aOINpQ
 N0ZC6ZrtmXQEvCK4InehV9bNoiBFhoblgWOzycHFBcgyrATs/iq80iEAOk4d3cvQ2PNk
 ndrFX4xdOmrHFto65rIXkwIc6qSDXa9IN8lx1s/aRK7bbou4zlyXQRkkJ03qRbmoOV3k
 tPTDcqQ/Q1xkW0cAzgSLlHYV9NztOf4qwybXATp4aTe8Dlt0b4CitMkltx9HQpmCKmqy
 RztEf/EHguGfyzg3iKOeuqcUO3hfUGooVVpkfY/0w29xPEccXdDP6BPt9yly40UmHAGF
 +FAA==
X-Gm-Message-State: AFq9FYLEP2VfG+f7hHrRSEu1fabWKnkOqmQquAZbai9fN0OCuzEqOTnc
 BCU3xzLxN767h1GgW7wlQper6PeAPFziZjVFNs0+l8vljRbcVfbyjhqQdGNppCFEDIhWidQ+TLF
 HTEk417LVvCPOnjG2WmSVGypZRdK1/l9ErwiVH9QGjY5wDu8Kwi8P06VAlwThYGvFUKk/
X-Gm-Gg: AYBFou1RBqjDAnOTHCA+OAuB79NCu9WIMIfiAGedWIrydp5OPCp4MGb0usHhj6VNq2Y
 mS5F21lY6Wh/qcat39WWzbAac2dr3PMBJsgKTgt+gEAd4OSKrrLBe/gKKxGvA89455ZQsZtH8PM
 SoQiVjE8k74EzRjmGGidhMw9N1m1bA9vVG3i7Slp9ijPh8FoHwI0ByFvY5M8JfxNUj25PbtKyCh
 jeZCEeEwXNApQeWGNe9phXXDtThLPTiekfyOPVv0+Be7K5xN58UFaY+XlLyS8T0ME2R0Fai972J
 9RVyTAxC38Wa5ptYfeIN7qjV549AbAl89L2KhaXXgvlI92+OQb2jjsrx61Jc12L0tZeyCxCdzev
 DsIlx4GpSt1zsdG6HTpUC2SUNQOGETlZkuN0Z
X-Received: by 2002:a05:6000:46cc:b0:48e:1b11:7ee5 with SMTP id
 ffacd0b85a97d-48e264a1fdfmr1118327f8f.11.1792562716033; 
 Tue, 20 Oct 2026 23:05:16 -0700 (PDT)
X-Received: by 2002:a05:6000:46cc:b0:48e:1b11:7ee5 with SMTP id
 ffacd0b85a97d-48e264a1fdfmr1118280f8f.11.1792562715531; 
 Tue, 20 Oct 2026 23:05:15 -0700 (PDT)
Received: from fedora.redhat.corp (89-27-86-246.bb.dnainternet.fi.
 [89.27.86.246]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254f02f1sm3413741f8f.3.2026.10.20.23.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:05:14 -0700 (PDT)
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
Subject: [PATCH v16 00/12] migrate on fault for device pages
Date: Wed, 21 Oct 2026 09:04:54 +0300
Message-ID: <20261021060506.2377545-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2T_tne6fldgAz08uYvVszXTL2XGxYNwz37mIdH8dLkI_1792562716
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
The migrate throughput tests from the selftests show similar numbers
(within error margin) as an unmodified kernel, verifying not
regressing with current workloads.

For nouveau migrate-on-fault test harness was : Fedora 44,
Mesa Rusticl, and a fine-grained-system-SVM OpenCL program.
Nouveau SVM is opt-in via Mesa. The OpenCL program passes a plain
malloc pointer (64 pages, array of integers) to the GPU. Increments
each element on GPU, and verifies on the CPU the result. So it drives
both directions of migration. With svm_migrate_on_fault=1, no
migration at bind happens so it's full lazy. The GPU used in testing
was Pascal generation GP102 (selected based on what nouveau
supports for SVM).

Tested also rebased on the
"Remove device private pages from physical address space" series:
https://lore.kernel.org/linux-mm/20260130111050.53670-1-jniethe@nvidia.com/
plus a small patch to adjust with no problems.

Changes in v16:
  - rebased to 7.3.0 (drm-tip)
  - addressed sashiko's concerns
  - added patch 12 - drm/nouveau/svm: add support for migrate on fault

Sashiko's concerns :
https://sashiko.dev/#/patchset/20260924065313.899730-1-mpenttil%40redhat.com

patch 01 mm/Kconfig: changes for migrate on fault for device pages
  Q  "Does selecting HMM_MIRROR under DEVICE_MIGRATION require an explicit
  dependency on MMU?"  
  A   A DEVICE_MIGRATION is def_bool MIGRATION && ZONE_DEVICE,  and MIGRATION depends on MMU,
  which HMM_MIRROR also depends on. DEVICE_MIGRATION is not user selectable, and nothing
  selects it explicitly now. If some config would select it in the future, it should have MMU.

patch 03 mm/hmm: preparations for HMM to participate in migration
  Q  "This is not a bug, but could we add MIGRATE_VMA_SELECT_NONE to this enum
  under CONFIG_MIGRATION?"
  A  Yes, added.

patch 05 mm/hmm: migrate collection in HMM pagewalk - pte level
  Q  "Can this cause a livelock when splitting the folio?"
  A  the ref is taken under ptl before dropping it (no UAF), and the split either succeeds
  (progress) or fails -> HMM_PFN_ERROR + return 0 (termination). No unbounded retry,
  no livelock. The -EAGAIN -> goto again path only re-walks when state actually changed.
  Q  "Does this code operate on uninitialized folio metadata if a driver maps an
  uninitialized compound page to userspace?"
  A  The folio is either from vm_normal_page(), or a device private/coherent page
  and properly initialized so no.
  Q "Can a transient split failure result in valid pages being falsely marked as
  inaccessible?"
  A  a split failure reports HMM_PFN_ERROR for that walk only; the consumer can re-fault
  and a later split can succeed. The page isn't lost or permanently marked.

patch 06 mm/hmm: migrate collection in HMM pagewalk - pmd level
  Q "Can this lead to a use-after-free on an unlocked tail page?"
  A  For that branch, it has to be fault folio. fault_page (of fault folio)
  is always device-private -> the tail new_fault_folio is a ZONE_DEVICE
  page, which reclaim never scans. So not possible.

patch 08 mm/hmm: implement rollback for device page migration in HMM pagewalk
  Q "Will hmm_pfn_rollback_collected() destroy the user's per-PFN request flags?"
  A migration is entirely driven by default_flags, and (HMM_PFN_VALID|HMM_PFN_MIGRATE)
  is used as a sentinel for already pinned and migrate collected pfns. The sentinel
  is safe to be erased from per pfn flags.
  Q "Can this regression lead to memory corruption via an uninitialized PFN
  unlock/put?"
  A  "rollback only unlocks/puts entries carrying the (HMM_PFN_VALID|HMM_PFN_MIGRATE) sentinel
  ,i.e. ones actually collected (locked+ref'd), so no uninitialized pfn is ever unlocked or put
  Q "Is there an infinite loop in hmm_range_fault_locked() when a THP split fails?"
  A yes, fixed in v16. A split failure now fills HMM_PFN_ERROR and returns 0 instead of -EBUSY
  
patch 10 lib/test_hmm: add a new testcase for the migrate on fault
  Q "Will skipping the device page table update here create an inconsistent state
  that migrate_vma_finalize() permanently commits? (in case parallel unmap)"
  A Concurrent unmap is fine. In that case migrate_vma_finalize() frees dst pages,
  and retry migrates on next round. So no ping-pong, it is self-healing.

Link to v15: https://lore.kernel.org/linux-mm/20260924065313.899730-1-mpenttil@redhat.com/

Cc: David Hildenbrand <david@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
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

 Documentation/mm/hmm.rst               |  39 +
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 281 +++++++-
 drivers/gpu/drm/nouveau/nouveau_dmem.h |  12 +
 drivers/gpu/drm/nouveau/nouveau_svm.c  | 141 ++--
 drivers/gpu/drm/nouveau/nouveau_svm.h  |   5 +
 include/linux/hmm.h                    |  51 +-
 include/linux/migrate.h                |  59 +-
 lib/test_hmm.c                         | 174 ++++-
 lib/test_hmm_uapi.h                    |  21 +-
 mm/Kconfig                             |   1 +
 mm/hmm.c                               | 959 +++++++++++++++++++++++--
 mm/migrate_device.c                    | 617 +++-------------
 tools/testing/selftests/mm/hmm-tests.c |  54 ++
 13 files changed, 1740 insertions(+), 674 deletions(-)

drm-tip
base-commit: b0311e0de50840c3f35aafa2e95c14bf38f4a767
-- 
2.55.0

