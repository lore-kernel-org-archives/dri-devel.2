Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226D6C98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B6A10E10F;
	Thu, 24 Sep 2026 06:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TiqhQ+bG";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B77D10E10F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790232811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=18Iz/H3HTqpxzrpyaB+gzd+ZartbUyA8DZtWBuWw8Ao=;
 b=TiqhQ+bGnbBBNxjsfW5FhICYyQAggLpa5GunyFKdtvkFIzL7XxL6y3UL7JKey/5pkLZxN+
 czKlqe4+j1Y3epvHmGk+ikamQ0g6VB/0qfEOLpYw60x+DiCvsvTxyocFIaxtu+ySMn0l0x
 gLZbq3B3Gs+1xc79YGKdgbuzoNeRmgw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-VYQpp2vsMFajwDk7g6Ub4A-1; Thu, 24 Sep 2026 02:53:30 -0400
X-MC-Unique: VYQpp2vsMFajwDk7g6Ub4A-1
X-Mimecast-MFC-AGG-ID: VYQpp2vsMFajwDk7g6Ub4A_1790232809
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a592e1e17cso8956871fa.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 23:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790232808; x=1790837608;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=18Iz/H3HTqpxzrpyaB+gzd+ZartbUyA8DZtWBuWw8Ao=;
 b=gqqJt1gWevR90GE/yB98bkbA/YwKIab9cRQkrFnR3iD/lg9Vh3hb716fygyzq1N6rf
 mNzkGOfd5rJrohhUoQILn91dy6Zc934fVmpqtomduO7oOIqKRvKrJB9qkGQ9+fXWc8AP
 iMyKw1scVtJlMfYHEDupyzNclYxxillu2us6i8VYmQn1Q6t9oO6q57LGliEQY/yvY828
 BVdX1aRFIw/LB15DeuqOKjZIbTcvyy5axYgx8rtKRMyuYZhxFTNjmcZP/DSWKlOMfhv3
 Qog8FmSpwWQTtF+eNPl0RQHDQomKuZwZKO5Mi62ctL7GMO/No+RNXEPbw4e8XsS6xQ9N
 C5mg==
X-Gm-Message-State: AFuF++m/GjKsPesuieO2sF4ouVVW73FxbdSFVl1w+HNN7THBJEiUlMUg
 /LduXIQhmxz3c+c4KkisVMbm6xkLJcX86409DktJH+5l+8yWHGXZ8crXVs9zHko5+KPqh/jOwai
 CNu6hNGmsG7+CQ/C+6IzK+g3FyHddMJl28OBUpsMocxghKakXsM9gbXRofWx5B6Yz5tSZ
X-Gm-Gg: AYBFou2QiA53OkVqDVbVUAgoWBGL+0F7lycKhGW3XfOs7lZcXbO1vV7Q3gVwMVGKicU
 htrzUr2PJR/vu9VHpj7NN1IAUHpGEdaqoQN1em69TVUXRQtq5/fcKVR783KFzv5qluChEJ+QDqV
 FBUyUwoTIzK4lprjlZkJJmKSGFu89UxyYZ1bxx3O+10gwmdygAT61HEDGnEG+Z67YsBINic/tls
 NY4uFIFpNU9HTheXwOi7ljyLa2Pzqdgv2qs0JlpTGsa1HqDaCroVr5iQhq5bVPspszjRwdt5i6r
 5Qy2mPFpyUf7wfPeIHo9Px8NZRj1qwlQwCRRAVmaatXaVlyU98TN1x+F0TqosBHjaL8eCcnK3VW
 ASHHmEEWTzUO1L9Z0BtNO
X-Received: by 2002:a2e:bea6:0:b0:3a3:74b9:8a78 with SMTP id
 38308e7fff4ca-3a63c30cd55mr3506531fa.17.1790232808489; 
 Wed, 23 Sep 2026 23:53:28 -0700 (PDT)
X-Received: by 2002:a2e:bea6:0:b0:3a3:74b9:8a78 with SMTP id
 38308e7fff4ca-3a63c30cd55mr3506391fa.17.1790232807841; 
 Wed, 23 Sep 2026 23:53:27 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a63bf57909sm4803141fa.29.2026.09.23.23.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 23:53:26 -0700 (PDT)
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
Subject: [PATCH v15 00/11] migrate on fault for device pages
Date: Thu, 24 Sep 2026 09:53:02 +0300
Message-ID: <20260924065313.899730-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GV9-hAgeLGX5EpKVVp3XHrMLIQTTSsn4intPcDmBiEA_1790232809
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

A quick respin to address Sashiko's concerns..

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
For performance, the migrate throughput tests from the selftests
show similar numbers (within error margin) as unmodified kernel.
Tested also rebased on the
"Remove device private pages from physical address space" series:
https://lore.kernel.org/linux-mm/20260130111050.53670-1-jniethe@nvidia.com/
plus a small patch to adjust with no problems.

Changes in v15:
  - addressed Sashiko's concerns
  - collected Balbir's ack for patch 01
  
Sashiko's concerns :
https://sashiko.dev/#/patchset/20260922053421.4092027-1-mpenttil%40redhat.com
Concerns and responses, patch numbering refers to v14 series:

patch 01 mm/Kconfig: changes for migrate on fault for device pages
  Q "Does this regression violate Kconfig dependency rules by selecting HMM_MIRROR
  without inheriting its dependencies?"
  A DEVICE_MIGRATION is def_bool MIGRATION && ZONE_DEVICE, and MIGRATION depends on MMU,
  which HMM_MIRROR also depends on. DEVICE_MIGRATION is not user selectable, and nothing
  selects it explicitly now. If some config would select it in the future, it should have MMU.

patch 03 mm/hmm: preparations for HMM to participate in migration
 Q "Is the tracked start address unconditionally overwritten on every walk restart?"
 A yes, fixed
 Q "Could using the owner field as an initialization flag be problematic here?"
 A yes fixed,  range->dev_private_owner not used as sentinel anymore
 Q "How does this API change affect hmm_range_fault_unlocked_timeout()?"
 A migrate on fault and migrate_vma call hmm_range_fault()

patch 04 mm/hmm: do the plumbing for HMM to participate in migration
  Q "Does this mmu_notifier_invalidate_range_start() become unbalanced if the
  fault path is interrupted?"
  A HMM_FAULT_UNLOCKED can not happen with hmm_range_fault() + migration, however
  made the exit path flow thru hmm_vma_post_range_fault() in these cases also
  even though it is nop.
  Q "Can this early return bypass the TLB flush for pages unmapped in previous
  iterations?"
  A yes, fixed

patch 05 mm/hmm: implement folio split for migrate needs in HMM pagewalk
  Q "Does this create a livelock under contention?"
  Q "Will this spuriously fail migration if the folio is split concurrently?"
  Q "Does this correctly handle cases where fault_page was a tail page?"
  A this helper is removed in v15

patch 06 mm/hmm: migrate collection in HMM pagewalk - pte level
  Q "Does taking the reference via folio_get() before blocking on folio_lock()
  create a livelock when multiple threads fault on the same large folio?"
  A The ref has to be taken before dropping ptl lock. That mirrors current
  implementation. That can be improved on with later patch if wanted
  Q "Can this split_folio() crash if a driver mapped a raw compound page into the
  VMA using vm_insert_page()?"
  A The  folio is either from vm_normal_page(), or a device private/coherent page
  Q "Does this error path unconditionally unlock a folio that the caller might hold
  the lock for?"
  A yes, fixed

patch 07 mm/hmm: migrate collection in HMM pagewalk - pmd level
  Q "Does this code handle non-present PMD leaf entries correctly?"
  Q "Is this branch actually reachable for device-private PMDs?"
  A  PMD size device pages are not present swap like entries

  Q "Will this use the correct subpage for folios larger than 2MB?"
  A only PMD sized THP pages are supported

patch 08 mm/hmm: add lazy MMU mode support for migration in HMM pagewalk
  Q Does this skip a necessary TLB flush on the error path during migration?
  A yes, fixed, same concern as for patch 04

patch 10 mm: enable device page migration from HMM pagewalk
  Q "Does this code cause a permanent MMU notifier imbalance when args->pgmap_owner
  is NULL?"
  A yes, this is same concern as for patch 03. fixed

patch 11 lib/test_hmm: add a new testcase for the migrate on fault
  Q "Does skipping the page table update here leave us vulnerable to concurrently
  unmaps during migration?"
  Q "Can this sequence lead to a use-after-free of device pages if a concurrent
  unmap occurs after we dropped the mutex in dmirror_range_fault()?"
  A yes, the sequence is fixed in v15

Link to v14: https://lore.kernel.org/linux-mm/20260922053421.4092027-1-mpenttil@redhat.com/

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

Mika Penttilä (11):
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

 Documentation/mm/hmm.rst               |  39 +
 include/linux/hmm.h                    |  51 +-
 include/linux/migrate.h                |  58 +-
 lib/test_hmm.c                         | 174 ++++-
 lib/test_hmm_uapi.h                    |  21 +-
 mm/Kconfig                             |   1 +
 mm/hmm.c                               | 956 +++++++++++++++++++++++--
 mm/migrate_device.c                    | 617 +++-------------
 tools/testing/selftests/mm/hmm-tests.c |  54 ++
 9 files changed, 1352 insertions(+), 619 deletions(-)

drm-tip
base-commit: dfe5a8188de9aaddd4e46b0f2410d0bccd5c1c04
-- 
2.55.0

