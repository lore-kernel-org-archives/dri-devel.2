Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A484DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCCD610E098;
	Mon, 29 Jun 2026 12:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VXIgWtDv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B5610E098;
 Mon, 29 Jun 2026 12:23:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2C174172B;
 Mon, 29 Jun 2026 12:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D2D1F000E9;
 Mon, 29 Jun 2026 12:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782735835;
 bh=KhbirzDiqdXz8L9jjlZYmqe2i6OHEV90p3aTdG2piLY=;
 h=From:To:Cc:Subject:Date;
 b=VXIgWtDvSyFcIJVJpcYBkbjDgAVyydc/iME59+R6XRw8bXvm1BkNScIESWGDKzwG8
 AhB5OWOUACxuGpUzXK9CREXTc7QbzenbF+f/m6fiWZ0ZOCz579Z+6psilDULlUv4KS
 t1hK4vxpshyeCdzB6jjoAR0ouWSDv6aa2AfmFzAVxeVUQ8libN4amrv2h5IP6iXnkJ
 vw5hlBz64z8tNrLEbQWPi3qxat89f66kKwijiuXDogs+GZh0c9W1lQTLDBkLRzgknf
 wM2jN6figSLSgDjYHDAuCpQ6/CJax3wvd/hhdrpFl4QAONOJEwet916X7QRVjLhdGy
 V41g50mCmMcMA==
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>,
 Kees Cook <kees@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-sgx@vger.kernel.org,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, kvm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>
Subject: [PATCH 00/30] mm: make VMA page offset handling more consistent
Date: Mon, 29 Jun 2026 13:23:11 +0100
Message-ID: <cover.1782735110.git.ljs@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
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

This series performs a series of cleanups and improvements around how the
vma->vm_pgoff field is used.

Folios belonging to file-backed mappings are simply indexed by the page
offset within the file they map.

However, anonymous folios belonging to pure anonymous mappings are indexed
by their "virtual" page offset, which is equal to addr >> PAGE_SHIFT at the
time at which the VMA was first faulted in.

The page offset of a VMA is stored in vma->vm_pgoff and indicates the page
offset of the start of the VMA range, whether it be file-backed or
anonymous.

The work here both cleans up how we reference this field, as well as laying
the foundations for a future series which addresses the inconsistency of
CoW'd folios in MAP_PRIVATE-file backed mappings, which are indexed as if
they were file-backed but behave as if they were anonymous.

This future series will make it such that all anonymous folios are indexed
by virtual page offset whether belonging to VMAs who satisfy
vma_is_anonymous() or MAP_PRIVATE-mapped file-backed mappings.

This series:

* Exposes vma_start_pgoff() and updates the kernel to use it consistently.
* Adds and uses the useful vma_end_pgoff() helper.
* Parameterises the file-backed mapping helpers vma_interval_tree_*()
  by adress_space rather than rb_root_cached.
* Renames the misleadingly-named vma_interval_tree_*() helpers to
  mapping_interval_tree_*() to be consistent with
  anon_vma_interval_tree_*().
* Parameterises anon_vma_interval_tree_*() by anon_vma.
* Moves mm/interval_tree.c to the rmap section.
* Adds vmg_*() helpers for page offset.
* Clarifies the confusing vmg_adjust_set_range() function.
* Introduces linear_page_delta() to provide relative pgoff within a VMA.
* Replaces open-coded versions of linear_page_delta() and
  linear_page_index() with invocations of these functions.
* Introduces and uses vma_assert_can_modify() to account for whether a VMA
  can be modified (detached or write locked).
* Adds and uses vma_[add,sub]_pgoff() to adjust VMA page offset.
* Moves __install_special_mapping() to vma.c.
* Makes vma_set_range() static and internal to vma.c.
* Introduces and makes use of vma_set_pgoff().
* Fixes incorrect vma.h header inclusion.
* Defaults VMA userland tests to 64-bit vma flags size.
* Updates VMA userland tests to give better output on failure.
* Various smaller cleanups.

Lorenzo Stoakes (30):
  mm: move vma_start_pgoff() into mm.h and clean up
  mm: add kdoc comments for vma_start/last_pgoff()
  tools/testing/vma: use vma_start_pgoff() in merge tests
  mm: introduce and use vma_end_pgoff()
  mm/rmap: update mm/interval_tree.c comments
  mm/rmap: parameterise vma_interval_tree_*() by address_space
  mm/rmap: elide unnecessary static inline's in interval_tree.c
  mm/rmap: rename vma_interval_tree_*() to mapping_interval_tree_*()
  mm/rmap: parameterise anon_vma_interval_tree_*() by anon_vma
  MAINTAINERS: Move mm/interval_tree.c to rmap section
  mm/vma: introduce and use vmg_pages(), vmg_[start, end]_pgoff()
  mm/vma: clean up anon_vma_compatible()
  mm/vma: refactor vmg_adjust_set_range() for clarity
  mm/vma: minor cleanup of expand_[upwards, downwards]()
  mm: introduce and use linear_page_delta()
  mm/vma: use vma_start_pgoff(), linear_page_index() in mm code
  mm: prefer vma_[start,end]_pgoff() to vma->vm_pgoff in kernel/
  mm/vma: remove duplicative vma_pgoff_offset() helper
  mm: use linear_page_[index, delta]() consistently
  mm/vma: introduce vma_assert_can_modify()
  mm/vma: add and use vma_[add/sub]_pgoff()
  mm/vma: move __install_special_mapping() to vma.c
  mm/vma: make vma_set_range() static, drop insert_vm_struct() decl
  mm/vma: update vma_shrink() to not pass unnecessary pgoff parameter
  mm/vma: update vmg_adjust_set_range() to offset pgoff instead
  mm/vma: introduce and use vma_set_pgoff()
  mm/vma: correct incorrect vma.h inclusion
  mm/vma: use guard clauses in can_vma_merge_[before, after]()
  tools/testing/vma: default VMA flag bits to 64-bit
  tools/testing/vma: output compared expression on ASSERT_[EQ, NE]()

 MAINTAINERS                           |   2 +-
 arch/arm/mm/fault-armv.c              |   4 +-
 arch/arm/mm/flush.c                   |   2 +-
 arch/nios2/mm/cacheflush.c            |   2 +-
 arch/parisc/kernel/cache.c            |   2 +-
 arch/x86/kernel/cpu/sgx/virt.c        |   3 +-
 drivers/comedi/comedi_fops.c          |   3 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c |   3 +-
 drivers/gpu/drm/gma500/gem.c          |   2 +-
 drivers/gpu/drm/msm/msm_gem.c         |   3 +-
 drivers/gpu/drm/omapdrm/omap_gem.c    |   5 +-
 drivers/gpu/drm/tegra/gem.c           |   3 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c       |   7 +-
 drivers/vfio/pci/nvgrace-gpu/main.c   |   3 +-
 drivers/vfio/pci/vfio_pci_core.c      |   3 +-
 fs/dax.c                              |   2 +-
 fs/hugetlbfs/inode.c                  |  15 +-
 include/linux/huge_mm.h               |   1 +
 include/linux/hugetlb.h               |   3 +-
 include/linux/mm.h                    | 118 +++++++++----
 include/linux/mmap_lock.h             |   8 +
 include/linux/pagemap.h               |  39 ++++-
 kernel/dma/coherent.c                 |   7 +-
 kernel/dma/direct.c                   |   6 +-
 kernel/dma/mapping.c                  |   8 +-
 kernel/dma/ops_helpers.c              |   4 +-
 kernel/events/core.c                  |  20 ++-
 kernel/events/uprobes.c               |  13 +-
 kernel/kcov.c                         |   2 +-
 kernel/trace/ring_buffer.c            |   3 +-
 mm/damon/vaddr.c                      |   5 +-
 mm/debug.c                            |   2 +-
 mm/filemap.c                          |   7 +-
 mm/huge_memory.c                      |   2 +-
 mm/hugetlb.c                          |  15 +-
 mm/internal.h                         |  33 ++--
 mm/interval_tree.c                    | 113 +++++++-----
 mm/khugepaged.c                       |   7 +-
 mm/ksm.c                              |   7 +-
 mm/madvise.c                          |   6 +-
 mm/mapping_dirty_helpers.c            |   2 +-
 mm/memory-failure.c                   |  10 +-
 mm/memory.c                           |  33 ++--
 mm/mempolicy.c                        |  13 +-
 mm/mmap.c                             |  41 +----
 mm/mmu_notifier.c                     |   2 +-
 mm/mremap.c                           |  12 +-
 mm/msync.c                            |   4 +-
 mm/nommu.c                            |  22 +--
 mm/pagewalk.c                         |   6 +-
 mm/rmap.c                             |  14 +-
 mm/shmem.c                            |   9 +-
 mm/userfaultfd.c                      |   4 +-
 mm/util.c                             |   4 +-
 mm/vma.c                              | 239 ++++++++++++++++++--------
 mm/vma.h                              |  59 ++++++-
 mm/vma_exec.c                         |  12 +-
 mm/vma_init.c                         |   6 +-
 mm/vma_internal.h                     |   4 +-
 tools/testing/vma/Makefile            |   2 +-
 tools/testing/vma/include/dup.h       |  41 ++++-
 tools/testing/vma/include/stubs.h     |  12 +-
 tools/testing/vma/shared.c            |   9 -
 tools/testing/vma/shared.h            |  36 ++--
 tools/testing/vma/tests/merge.c       |  40 ++---
 virt/kvm/guest_memfd.c                |   2 +-
 66 files changed, 699 insertions(+), 432 deletions(-)

--
2.54.0
