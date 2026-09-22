Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3609BC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EECF10E3B1;
	Tue, 22 Sep 2026 05:34:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cO3Bzx1s";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC3D810E3B1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790055282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ExYdezdvpHVo92DuelngyydogrRLZoYOU57jNd3LbOI=;
 b=cO3Bzx1sxdkxN0mExoG8fzNtmlfS5zy2ahDFORZ5AvwKmG1/rD77F/TV7JeOE7/6SrOq3r
 xTRwRckPH4CW//MliMJXEh2RZzyuaoJvL9HCDNajaJTD/skVOH6xKmZc08UaezreY2yuq4
 wv9AdLSdD6/u0sHaEgfAG1VTz64v5Ho=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-tshmFw6FNzWX--P9mbk1pg-1; Tue, 22 Sep 2026 01:34:40 -0400
X-MC-Unique: tshmFw6FNzWX--P9mbk1pg-1
X-Mimecast-MFC-AGG-ID: tshmFw6FNzWX--P9mbk1pg_1790055279
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a59ac42cd8so14645081fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 22:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790055279; x=1790660079;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ExYdezdvpHVo92DuelngyydogrRLZoYOU57jNd3LbOI=;
 b=l+Tr7u1k45UXB8LWAtljQew2tXKZ0J+DI9q2fiFDEerydp+FpTVE7YPsv+FwQhi8kh
 unLn7AjjEIXUBjP+flwNnsHQFrjEWcFlCPPIi+wGByIumDbc0k7n3r5XnWw77q5XNzT/
 q7rhLo1cTFPU83aruO3g4YsUFeHHLbnH3glqlLjL1JkIxXW6WOeMb+AnLHy2vUXThsLD
 qDMHEKx6USDXTjxUJE+4emQGIKyFvgNGVI5aV4wnrhQXJidQSC38U87KQGIPoLQuYi3P
 A42km/2cRCAG7Cb26Jk+sSNkPnFAFZhCFt/0NJgDoP3mLLfUDZn0XJushNDBeIxPwzSg
 DwVw==
X-Gm-Message-State: AFuF++mG3YrFQlxrQPq224ij0I4O8RomoVzIWdivknYthucQHszkgtwj
 nXXNlpm063GfVtZNR/VVCYci1tWref9mVAqoTtSLmtRQkal1yTkqABEKWsOKVosdZE9F0vmVhy5
 j23INhZlHHQ3yyKbK53s5hdwGz9ZTxHvWqv5WFeF27GdINRx274vF90mcCHY79jw8ltN3
X-Gm-Gg: AYBFou1LfJWYMCzmNAQNocb0EKijtlAtpozUQ/ZwJKo1xBz2EO6POuzpLbGLSgyeUdr
 nLV1e7ddzrjlcDVrmg+L7aqHPE3O4Q6HNecCNGeZSUtJF7SxM6Fg8ueaZxskcpPo2x+ms5m5X5D
 DYzuRLBdjs/85+4V/GNsAosI4D7pfznabzFH3GsMiUCYD5KiDtyJjrHRoHYCmBqY146yVkWFV89
 iiFarsMt883QzAzpDh9sTC50VdSzqWPJDR/fKjS0fVrAN5ibEiqNX/KtybGiYsFpXpzMEtYX3+7
 hQ6B4xbp8NtPCxqx9EFixWaiRRgf+7VsSfS0OkxLxBCS/xTAi6yWmQZJtpPqzcvjQEDhwa/fcuL
 JcGa7cnKWbat5jceVybew
X-Received: by 2002:a05:6512:3345:b0:5b4:ac27:6bb0 with SMTP id
 2adb3069b0e04-5b8c1833167mr4016909e87.25.1790055278605; 
 Mon, 21 Sep 2026 22:34:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3345:b0:5b4:ac27:6bb0 with SMTP id
 2adb3069b0e04-5b8c1833167mr4016894e87.25.1790055278113; 
 Mon, 21 Sep 2026 22:34:38 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d46e0966sm191742e87.55.2026.09.21.22.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 22:34:37 -0700 (PDT)
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
Subject: [PATCH 00/12] [PATCH v14 00/12] migrate on fault for device pages
Date: Tue, 22 Sep 2026 08:34:09 +0300
Message-ID: <20260922053421.4092027-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2jkTc-xiLzoVyeoM48sooXz10FMHWBR2ujVDU8d0ebI_1790055279
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
For the migrate_vma_setup() call paths, new flags, MIGRATE_VMA_FAULT,
and MIGRATE_VMA_WRITE are added to tell to add fault handling to migrate.

An extra benefit of migrating with hmm_range_fault() path
is the migrate_vma.vma gets populated, so no need to
retrieve that separataly.

Tested in X86-64 VM with HMM test device, passing the selftests.
For performance, the migrate throughput tests from the selftests
show similar numbers (within error margin) as unmodified kernel.
Tested also rebased on the
"Remove device private pages from physical address space" series:
https://lore.kernel.org/linux-mm/20260130111050.53670-1-jniethe@nvidia.com/
plus a small patch to adjust with no problems.

Changes since v13:
  - rebased on v7.3-rc
  - fix compile error in !CONFIG_MMU_NOTIFIER kernel configs
  - added patch 12/12 for Documentation/mm/hmm updates
  - document the semantics of new flags for migrate_vma_setup()
  - fix error handling after migrate_vma_split_folio() failure
  - comment and style fixes

Link to v13: https://lore.kernel.org/linux-mm/20260804042631.2175585-1-mpenttil@redhat.com/

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

Mika Penttilä (12):
  mm/Kconfig: changes for migrate on fault for device pages
  mm: add helper to convert HMM pfn to migrate pfn
  mm/hmm: preparations for HMM to participate in migration
  mm/hmm: do the plumbing for HMM to participate in migration
  mm/hmm: implement folio split for migrate needs in HMM pagewalk
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
 lib/test_hmm.c                         | 132 +++-
 lib/test_hmm_uapi.h                    |  21 +-
 mm/Kconfig                             |   1 +
 mm/hmm.c                               | 977 +++++++++++++++++++++++--
 mm/migrate_device.c                    | 617 +++-------------
 tools/testing/selftests/mm/hmm-tests.c |  54 ++
 9 files changed, 1341 insertions(+), 609 deletions(-)

drm-tip
base-commit: dfe5a8188de9aaddd4e46b0f2410d0bccd5c1c04
-- 
2.55.0

