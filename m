Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C88CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BC310E419;
	Mon, 25 May 2026 08:45:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="iXMgUNdL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4559F10E419
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779698743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rdMdPF6AjRDfJupohBg/unbXMgpat50XT188LnR7nHE=;
 b=iXMgUNdLGUIrA+Cp0PrEyDePTzRMjxnr95tsXy9G390kRmYtE4FRjx56BfmQnqrjcgEVUI
 He82KZDBGN1awwewKo11k4sSVFkZtNGQiXWSrKvpmnGiiKNsL40g/syK3kcEDUXt9AOsMC
 FHPY7/R+rnAW33PMUdtkV0+dNxwFWdw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-ONRjtWQ-P0OapyyBocWcLg-1; Mon, 25 May 2026 04:45:41 -0400
X-MC-Unique: ONRjtWQ-P0OapyyBocWcLg-1
X-Mimecast-MFC-AGG-ID: ONRjtWQ-P0OapyyBocWcLg_1779698740
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-38eeb467db3so36238621fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779698740; x=1780303540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdMdPF6AjRDfJupohBg/unbXMgpat50XT188LnR7nHE=;
 b=K4MnP6z2SFCYOZ8gST4ZSrmxgQBnW7zVryci7zqBGMvaue/BI5Cx44I8lEzVFPQNuR
 lEgDdiigEwOZUM4QHvegGcOQrVc1+6x5oKPCUwZ9s78nnWQBAQLds+co1nXKwvM387Z4
 SkSRaADVmQg1qJLIjlaqFKkwCprGdC1AC+8678u7guxsJXjfJsOCcJ+8QHDL3xWLhiqp
 PIPMw/WEwBswQrs5QufOdbOw5yo/sk92q3nmRTp8WrMmYPaI+eDfLYMNdpCT9SduxWAt
 lS7w1RFv1BbMddhjououj2Q7IRxjGNZN+v6wPOES0GRxlrsB26QP2AW5avEoOBatVR3+
 VBUQ==
X-Gm-Message-State: AOJu0YzjnmrZVgUclToM6sAxhTKBd0iM3H9suN/N/7u6dHWqT8uFABFK
 9tpTJAi7L9hPG0PpiXnE2v9o7YhTv2NzxR+F5G8o9Nut/fduBD+hUWaNIhqDWg2pyKJXNB6dmt8
 FrrV2iZD85M0bZoaUyLmS+ZDMp6RrddzU/KXTieyBmX32qfAcQ+l0FZl78uhvegXs/1uy
X-Gm-Gg: Acq92OE+TXWnsldxShEhxuFjU3ySqi1fG8OzlOY64jzPEN423JxMqpqeBp7gtOsv3nc
 dbgdn90SqN+w9aVGqpeiVdiEJdunIC9MkrYaISl3TGZjQwAJhzHj4sTNTsRkDN5h6SAzY9oHX1M
 ypysX/KVYguNWuxMwqvAaqaeGvjVu075KlKYopvkZ9UyQ/XwlcmJBHWJp6wmt4f83YMbhp7zzec
 PVG9iJ8VkpUarJzbPOsBCnq43Pbdk/ZNlfiFuSb67or7ccMdzYxszNgN85X00rx0OQXGmsbpDOr
 5/mt2mxa8LsfUScl3GHSHtPzWzOJ+r5DpDgOF0h1p/iB6DSgwYFX4QdleqSfG2JX3f14kjGLOVl
 GrPUCLA6fs0QK9SIMCHYNVl05O6Y5TWsZ0Uo4
X-Received: by 2002:a2e:bea0:0:b0:393:4e44:63ba with SMTP id
 38308e7fff4ca-395d8e13013mr47053041fa.29.1779698740133; 
 Mon, 25 May 2026 01:45:40 -0700 (PDT)
X-Received: by 2002:a2e:bea0:0:b0:393:4e44:63ba with SMTP id
 38308e7fff4ca-395d8e13013mr47052741fa.29.1779698739582; 
 Mon, 25 May 2026 01:45:39 -0700 (PDT)
Received: from fedora (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dca7bcddsm21679061fa.16.2026.05.25.01.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:45:39 -0700 (PDT)
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
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v12 0/5] Migrate on fault for device pages
Date: Mon, 25 May 2026 11:45:19 +0300
Message-ID: <20260525084524.139868-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hlKSFvIy-rng1CiBl-6msETgdeMxqH-AsmF6a1OHqEo_1779698740
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
Also, for the migrate_vma_setup() call paths, a flag, MIGRATE_VMA_FAULT,
is added to tell to add fault handling to migrate.

One extra benefit of migrating with hmm_range_fault() path
is the migrate_vma.vma gets populated, so no need to
retrieve that separataly.

Tested in X86-64 VM with HMM test device, passing the selftests.
For performance, the migrate throughput tests from the selftests
show similar numbers (within error margin) as unmodified kernel.
Tested also rebased on the
"Remove device private pages from physical address space" series:
https://lore.kernel.org/linux-mm/20260130111050.53670-1-jniethe@nvidia.com/
plus a small patch to adjust with no problems.

Changes v11-v12
  - Fix for issue found by Intel CI in patch 3

Changes v10-v11
  - Fix nested mmap_read_lock in test suite
  - Addressed review comments from David

Changes v9-v10
  - Fix for issue Intel CI found, forgotten pte_unmap() before
    migration_entry_wait()

Changes v8-v9
  - rebase on drm-tip
  - fixed uaf around  migrate_vma_split_folio() usage
  - added missing pmd unlock

Changes v7-v8
  - rebase on 7.0
  - fixed subject in two patches
  - enhanced commit messages
  - squashed patch 6 into patch 4 to fix kernel test robot warning
  - readded dropped Cc block from cover letter
  - fixed white space

Changes v6-v7
  - rebase on 7.0.0-rc6
  - added documentation and comments
  - denote to be migrated zero page as HMM_PFN_MIGRATE alone
  - got rid of HMM_PFN_INOUT_FLAGS movement in patch 2
  - picked up Acked-By from David for patch 1
  
Changes v5-v6
  - rebase on 7.0.0-rc4
  - use range based TLB flushing while unmapping ptes
  - gate migration behind HMM_PFN_REQ_MIGRATE for fault and
    migrate paths
  - always infer migration flags from migrate->flags only

Changes v4-v5
  - rebase on 6.19
  - fixed David's email address
  - fixed link issue without CONFIG_TRANSPARENT_HUGEPAGE
  - refactored into smaller commits
  - added more comments to code

Changes v3-v4:
  - rebase on 6.19-rc8
  - fixed issues found by kernel test robot with random configs
  - fixed typos

Changes v2-v3:
  - rebase on 6.19-rc7
  - fixed issues found by kernel test robot
  - fixed smatch issues reported by Dan Carpenter <dan.carpenter@linaro.org>
  - fixes to lock handling (pmd/pte) on errors
  - added assertions for pmd/pte lock states
  - other issues discovered by Matthew, thanks!

Changes v1-v2:
  - rebase on 6.19-rc6
  - fixed issues found by kernel test robot
  - fixed locking (pmd/ptl) to cover handle_ and prepare_ regions
    parts if migrating
  - other issues discovered by Matthew, thanks!

Changes RFC-v1:
  - rebase on 6.19-rc5
  - adjust for the device THP
  - changes from feedback

Revisions:
  - RFC https://lore.kernel.org/linux-mm/20250814072045.3637192-1-mpenttil@redhat.com/
  - v1: https://lore.kernel.org/all/20260114091923.3950465-1-mpenttil@redhat.com/
  - v2: https://lore.kernel.org/all/20260119112502.645059-1-mpenttil@redhat.com/
  - v3: https://lore.kernel.org/all/20260126111939.1332983-2-mpenttil@redhat.com/
  - v4: https://lore.kernel.org/all/20260202112622.2104213-1-mpenttil@redhat.com/
  - v5: https://lore.kernel.org/linux-mm/20260211081301.2940672-1-mpenttil@redhat.com/
  - v6: https://lore.kernel.org/linux-mm/20260316062407.3354636-1-mpenttil@redhat.com/
  - v7: https://lore.kernel.org/linux-mm/20260330115611.347988-1-mpenttil@redhat.com/
  - v8: https://lore.kernel.org/linux-mm/20260414041226.1539439-1-mpenttil@redhat.com/
  - v9: https://lore.kernel.org/linux-mm/20260505051658.2219537-1-mpenttil@redhat.com/
  - v10: https://lore.kernel.org/linux-mm/20260505184421.2324798-1-mpenttil@redhat.com/
  - v11: https://lore.kernel.org/linux-mm/20260525050830.100254-1-mpenttil@redhat.com/

Cc: David Hildenbrand <david@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>

Mika Penttilä (5):
  mm/Kconfig: changes for migrate on fault for device pages
  mm: Add helper to convert HMM pfn to migrate pfn
  mm/hmm: do the plumbing for HMM to participate in migration
  mm: setup device page migration in HMM pagewalk
  lib/test_hmm: add a new testcase for the migrate on fault

 include/linux/hmm.h                    |  19 +-
 include/linux/migrate.h                |  26 +-
 lib/test_hmm.c                         | 118 +++-
 lib/test_hmm_uapi.h                    |  19 +-
 mm/Kconfig                             |   2 +
 mm/hmm.c                               | 843 +++++++++++++++++++++++--
 mm/migrate_device.c                    | 583 +++--------------
 tools/testing/selftests/mm/hmm-tests.c |  54 ++
 8 files changed, 1086 insertions(+), 578 deletions(-)

drm-tip
base-commit: a79fb6644b307c0ced7b8fe967cdcac8ea884e03
-- 
2.50.0

