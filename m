Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF78C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F13010E17B;
	Mon, 20 Jul 2026 11:13:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="E8xUJmVM";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6AA10E897
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=Lp7nt8x6Hr8SRPNlysKZQlJkRjPsnZbf7xODCnCrq24=; b=E8xUJmVMz4YDQhdPOAoAom0NRp
 QElunSc9WNvLgFYYjrsN5G+60LHjVu6ABc0H4+x8JxRbruMUfSxnASlL/IwaAVofkWjLP8TPiRbAU
 ueehEzsEqKoLuXpP0Rj8Fz7S+nStCdfYRKHqgn89YJt0Rea+tPj9baLvUHn7j8fL9S2jvmuu4XmcJ
 LY1MESkl3j9OPaz4wIbNq9yDwXthw7MKl57U+s+Cz1PtmoYUtz0qt7IT0e8pi1GFWHd8fho1KeVD5
 CkmbpXdL9VMPjJwug6Nj5KHftlG+geWP6fK2W4KMWrpvxI8GCUGZKF3Ssh4GidZ+x8LNJPYRwdYFD
 Zr6QwJNw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wllvg-0000000Akyn-3Cty; Mon, 20 Jul 2026 11:13:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red
 Hat Linux)) id 1wllvg-00000000W0M-1hoL;
 Mon, 20 Jul 2026 12:13:00 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>,
 Kees Cook <kees@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>,
 Connor Williamson <connordw@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhou Yuhang <zhouyuhang@kylinos.cn>, Zi Li <zi.li@linux.dev>,
 Dan Williams <djbw@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Colin Ian King <colin.i.king@gmail.com>, connordw@amazon.co.uk,
 graf@amazon.de, fgriffo@amazon.co.uk
Subject: [RFC PATCH v2 00/11] KVM: Allow alternative providers of guest_memfd
 backed by PFNMAP memory
Date: Mon, 20 Jul 2026 12:03:01 +0100
Message-ID: <20260720111259.122911-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

For dedicated hosting environments, there are a few reasons to prefer
using external PFNMAP memory for guests, rather than kernel-managed
memory:

 • No struct page overheads

 • Easily managed in 1GiB pages (or larger chunks); no fragmentation/THP

 • Faster kexec/KHO live update (every millisecond spent faffing around
   with memory management is an extra millisecond of steal time taken
   from guests)

Today, there is only one implementation of guest_memfd: the internal
shmem-based page cache in virt/kvm/guest_memfd.c. This series allows
for other code to provide "a guest_memfd". This is an early path-
finding proof of concept tested with AMD SEV-SNP as well as non-CoCo
guests on x86 and arm64. I'm planning to build a memory-based file
system which gives files for both guest_memfd as well as memory-based
storage to allow things like userspace VM and orchestrator state
to be passed over KHO/kexec.

This series lifts guest_memfd's operations into a small ops struct and
converts KVM's own gmem to use it, so it becomes one implementation
among peers rather than the only game in town.  It also adapts the
SEV-SNP fast paths to page-less operation, plumbs iommufd to map a
guest_memfd-backing dma-buf as CPU RAM (not MMIO), and adds the
provider->KVM revocation primitive that makes overcommit-style reclaim
possible.

It's largely AI-built at the moment. My main design concerns are around
how we tell that a given file is "a guest_memfd", and how we plug into
IOMMUFD. Presenting a dma-buf was the less intrusive choice because that
path already has support for taking pages away, but I'm less convinced
that it's the cleaner choice in the long term.

I'll continue to bikeshed it myself, but this is at least functional
enough to show the direction and solicit further opinions...

https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=gmem-provider-v2

Changes since v1 (mostly Sashiko feedback):

 Core (KVM / SEV):
  - populate: drop the transient page reference after ->post_populate()
    rather than before, so the callback still sees the ref it relies on
  - kvm_gmem_invalidate_range(): walk every address space and all
    memslots in the range, not just address space 0 / a single slot
  - SEV: the guest_memfd cache flush hit a WARN_ON_ONCE on a failed
    temporary mapping; that path is reachable from userspace (hole-punch),
    so downgrade to pr_warn_ratelimited to avoid a panic_on_warn DoS
  - Export file_is_kvm() (EXPORT_SYMBOL_GPL) so an external provider can
    confirm the fd handed to it at setup really is a KVM instance

 Sample provider (samples/kvm/gmem_provider.c):
  - Serialize per-fd state (info->kvm, bound_slot, present bitmap) under a
    new info->lock; v1 accessed info->kvm without locking, racing
    bind/unbind against release
  - Validate setup.kvm_fd via file_is_kvm() before using it
  - Fix bitmap_zalloc(unsigned int) truncation -> kvzalloc with
    BITS_TO_LONGS
  - Fix integer underflow in SET_PRESENT when start_index < pgoff
  - gmem_release: zap active guest mappings + clear slot->gmem.file before
    freeing the backing
  - Pin THIS_MODULE while a provider fd is open
  - gmem_mmap: refuse if the fd was not created mmap-capable
  - gmem_max_order: clamp by the absent bitmap
  - Bind/unbind: symmetric psmash + rmp_make_shared with proper 2MiB
    alignment

 Selftests:
  - Revoke test: assert the revoked access faults unconditionally
  - iommufd test: mark the range KVM_MEMORY_ATTRIBUTE_PRIVATE so the guest
    actually exercises the provider path rather than the shared HVA mmap
  - NVMe DMA test: read the vendor ID from PCI config and add compiler
    barriers before the doorbell writes

Connor Williamson (1):
      KVM: SEV: Remove struct page dependency from SNP gmem paths

David Woodhouse (10):
      KVM: selftests: sev_smoke_test: Only run VM types the host offers
      KVM: selftests: sev_init2_tests: Derive SEV availability from KVM
      KVM: guest_memfd: Introduce guest memory ops and route native gmem through them
      iommufd: Look up private-interconnect phys via exporter symbols
      iommufd: Plumb dma-buf memory-type (RAM vs MMIO) through the phys map
      KVM: guest_memfd: Add ops-driven page revocation
      samples/kvm: Add guest_memfd backing sample
      selftests/kvm: gmem_provider KVM-only tests
      selftests/kvm: gmem_provider iommufd tests
      samples/kvm, selftests/kvm: Allow the gmem_provider NVMe DMA test on arm64

 arch/x86/kvm/Makefile                              |   5 +-
 arch/x86/kvm/svm/sev.c                             |  93 ++-
 arch/x86/virt/svm/sev.c                            |  27 +-
 drivers/iommu/iommufd/io_pagetable.h               |   7 +
 drivers/iommu/iommufd/pages.c                      |  49 +-
 include/linux/kvm_host.h                           |  91 +++
 samples/Kconfig                                    |  18 +
 samples/Makefile                                   |   1 +
 samples/kvm/Makefile                               |   2 +
 samples/kvm/gmem_provider.c                        | 772 +++++++++++++++++++++
 samples/kvm/gmem_provider.h                        |  53 ++
 tools/testing/selftests/kvm/Makefile.kvm           |   6 +
 .../selftests/kvm/gmem_provider_nvme_dma_test.c    | 376 ++++++++++
 .../kvm/x86/gmem_provider_hugepage_test.c          | 130 ++++
 .../selftests/kvm/x86/gmem_provider_iommufd_test.c | 158 +++++
 .../selftests/kvm/x86/gmem_provider_revoke_test.c  | 135 ++++
 .../testing/selftests/kvm/x86/gmem_provider_test.c | 195 ++++++
 .../selftests/kvm/x86/gmem_provider_vfio_test.c    | 134 ++++
 tools/testing/selftests/kvm/x86/sev_init2_tests.c  |  16 +-
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |   9 +-
 virt/kvm/guest_memfd.c                             | 391 +++++++++--
 virt/kvm/kvm_main.c                                |   8 +-
 virt/kvm/kvm_mm.h                                  |   4 +-
 23 files changed, 2577 insertions(+), 103 deletions(-)

