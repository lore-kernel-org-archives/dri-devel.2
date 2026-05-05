Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61921FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 18:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC78910E472;
	Tue,  5 May 2026 18:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZV/wH+1J";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A3110E0C6
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 18:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778006686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yq9HGaTwKrtLDP/Zy1Q2v2j6ECCTHfEEgkag37r4qvo=;
 b=ZV/wH+1J8Dfx9yo5NAy5mAfnYsIbf44el0LU3G6xReqP7UBH1LVSEucXv6j8yAvag4bvB+
 AXOnS8F8KNOD9saqOQwH14aOBNIHZ7O14xMJqNbJUbxIxSrBVXXCZbs7hmo8iVsu8pfL51
 9hSxgTa+qEbztSinf6hEYud69i7hy8Y=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-nP7hrtkaO2unDaKHD0DITA-1; Tue, 05 May 2026 14:44:45 -0400
X-MC-Unique: nP7hrtkaO2unDaKHD0DITA-1
X-Mimecast-MFC-AGG-ID: nP7hrtkaO2unDaKHD0DITA_1778006683
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39389bc702eso11911981fa.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 11:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778006683; x=1778611483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yq9HGaTwKrtLDP/Zy1Q2v2j6ECCTHfEEgkag37r4qvo=;
 b=d2O+KGcN1FkzqM9HTayQsc49pECS+2rCTI0I3PtPTM5SeYHmjAZVtGDG69A2bjwHvo
 WQ2t3GZQyr+PALwrLv7D1bhx2MdWB/acniCI2oJdNwRESVkEXu66r5UNSJQXlqlw2L87
 GMPJc8bsM/2gX68WoPOjcJWcDjywjlEmPrXd6KlAK915tngVwXTqDZJg37cT0kCR/r10
 QxamMDMo39d4Zsj+aIHLWhGFKc0eL4FT+zgJL3ixbl0cKT5LQboOHaKFMj/0jgrNEPK2
 30d5kZkHuO3BnRqrQGpU09+E1VysHqNRrnW5+R3UFd/dpoanDIYH/OLhfrNLuoDZV6QA
 VMBA==
X-Gm-Message-State: AOJu0YyR2cTkMc38EWYleH+uFAY8W8p3ru/jafknYODf7sXDyx3gKPLE
 yC7RCg0NWcBWkFITixdIrS3A8nK6ZQ3rznjwAJbXLqZWJ7H4pcVexazIBOpEkoGWT7YuF0ThdC4
 UdpagrBhHgFtKxl7Nj5jLh3oHIOrl94jLTQQx60+LwvG/+3g2bZOijMDmE3sJ0JQkA389
X-Gm-Gg: AeBDieudMclbwuQr91DJ5oAwGnfSfz7IF3RgQccg6qrYYq1R3XoxQnCHD3KvG/Nsj2v
 Hlf945v07LJoBDXFy87sQaTvZZrY7mkmg8aHj04fRAC/E1IvE5WUW85uuJ/vhRnFtaZ3on4i0XX
 zA3cBeUZSDR9xlIn2C1uKBmylqQ1s+QgHUiQlTmor1wEnC61eCosTvWVOKpbpImvI8xtkGMa6ZR
 SLvs5lztslb1+gJHkcTBYL1iOE0nQP0UiwUkaGS46EKxdNJOrgBuY/OxX2WOg6BeRQIc5tQaNS2
 pIyiy/IjN0YDXb5wymWkRIYGxDQ+PJ+t6ta2IaiCDYkYN7zrIX5ILe5WhvoNMYyGtCrsosVDirw
 dqw05STW8M3NUchFnU1BELE+TfNPThV/sl+bJYFD1c16CL6Y=
X-Received: by 2002:a05:6512:3a8f:b0:5a4:79e:9669 with SMTP id
 2adb3069b0e04-5a87f1dac48mr1708331e87.21.1778006683290; 
 Tue, 05 May 2026 11:44:43 -0700 (PDT)
X-Received: by 2002:a05:6512:3a8f:b0:5a4:79e:9669 with SMTP id
 2adb3069b0e04-5a87f1dac48mr1708313e87.21.1778006682647; 
 Tue, 05 May 2026 11:44:42 -0700 (PDT)
Received: from fedora (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a86e65fdf6sm2504437e87.78.2026.05.05.11.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 11:44:42 -0700 (PDT)
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
Subject: [PATCH v10 0/5] Migrate on fault for device pages
Date: Tue,  5 May 2026 21:44:16 +0300
Message-ID: <20260505184421.2324798-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Atmr3hqEaEU8iJFZt5SEkXlpGqSh9_FDqdO0FfBSxU4_1778006683
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
  lib/test_hmm:: add a new testcase for the migrate on fault

 include/linux/hmm.h                    |  19 +-
 include/linux/migrate.h                |  26 +-
 lib/test_hmm.c                         | 101 ++-
 lib/test_hmm_uapi.h                    |  19 +-
 mm/Kconfig                             |   2 +
 mm/hmm.c                               | 836 +++++++++++++++++++++++--
 mm/migrate_device.c                    | 583 +++--------------
 tools/testing/selftests/mm/hmm-tests.c |  54 ++
 8 files changed, 1067 insertions(+), 573 deletions(-)

drm-tip
base-commit: 94d56a898a2db27f841b17f6966a81ba502fe63c
-- 
2.50.0

