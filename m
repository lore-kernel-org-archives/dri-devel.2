Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A60C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F8110E390;
	Thu, 16 Jul 2026 15:17:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="XsXsYOZ/";
	dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9106D10F337
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=H5JZBL4uxCbxe0SE5uQe2ASNO8RCuyJLMxN8Jb1Qq/4=; b=XsXsYOZ/Ct32ecd0lk/FZbxGbv
 TIQrrOLYBa7MgiU56uoUOrFzihJC/YPUvUxRSht2CpUS/WX/zb3RZffmNmCbWhprGw7Ksom/8fpmi
 GqXx8FLQ3VaRl6VdV2U9hNfDpBmAOfzJAKP2/mDua4QaFq5q+YsfeymwiSus3dMdzqLjhCdkPQybh
 LoZey4Bu0xpTZAFSJKeiVnmZeD8rTcyU0x8kg/HkKhEWh+eT21Ffm7w4eJnEtfEV70/Rw9Jz0c+vK
 n6rld3BPFeuSNBwzxx6vqDK+E4qx6Fyz7edutiVLmBUvsgaNYFYp1Hh1HMh9ISqjwdGVKD+kYacbF
 eZw2rVbw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
 id 1wkNpl-0000000E9ND-49SG; Thu, 16 Jul 2026 15:17:10 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red
 Hat Linux)) id 1wkNpi-000000012sn-3yZ3;
 Thu, 16 Jul 2026 16:17:06 +0100
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
Subject: [RFC PATCH 00/11] KVM: Allow alternative providers of guest_memfd
 backed by PFNMAP memory
Date: Thu, 16 Jul 2026 10:31:20 +0100
Message-ID: <20260716151706.244987-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
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

 • Faster kexec/KHO live update (every millisecond spend faffing around
   with memory management is an extra millisecond of steal time taken
   from guests)

Today, there is only one implementation of guest_memfd: the internal
shmem-based page cache in virt/kvm/guest_memfd.c. This series allows
for other code to provide "a guest_memfd". This is an early path-
finding proof of concept tested with AMD SEV-SNP as well as non-CoCo
guests on x86 and arm64. I'm planning to build a memory-based file
system which gives files for both guest_memfd as well as memory-based
storage to allow things like userspace VM and orchestrator stateallows
to be passed over KHO/kexec.

This series lifts guest_memfd's operations into a small ops struct and
converts KVM's own gmem to use it, so it becomes one implementation
among peers rather than the only game in town.  It also adapts the
SEV-SNP fast paths to page-less operation, plumbs iommufd to map a
guest_memfd-backing dma-buf as CPU RAM (not MMIO), and adds the
provider->KVM revocation primitive that makes overcommit-style reclaim
possible.

It's largely AI-built at the moment. My main design concerns are around
that we tell that a given file is "a guest_memfd", and how we plug into
IOMMUFD. Presenting a dma-buf was the less intrusive choice because that
path already has support for taking pages away, but I'm less convinced
that it's the cleaner choice in the long term.

I'll continue to bikeshed it myself, but this is at least functional
enough to show the direction and solicit further opinions...

https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=gmem-provider

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


 arch/x86/kvm/Makefile                              |   4 +-
 arch/x86/kvm/svm/sev.c                             |  83 ++-
 arch/x86/virt/svm/sev.c                            |  27 +-
 drivers/iommu/iommufd/io_pagetable.h               |   7 +
 drivers/iommu/iommufd/pages.c                      |  49 +-
 include/linux/kvm_host.h                           |  91 +++
 samples/Kconfig                                    |  18 +
 samples/Makefile                                   |   1 +
 samples/kvm/Makefile                               |   2 +
 samples/kvm/gmem_provider.c                        | 651 +++++++++++++++++++++
 samples/kvm/gmem_provider.h                        |  53 ++
 tools/testing/selftests/kvm/Makefile.kvm           |   6 +
 .../selftests/kvm/gmem_provider_nvme_dma_test.c    | 365 ++++++++++++
 .../kvm/x86/gmem_provider_hugepage_test.c          | 130 ++++
 .../selftests/kvm/x86/gmem_provider_iommufd_test.c | 150 +++++
 .../selftests/kvm/x86/gmem_provider_revoke_test.c  | 134 +++++
 .../testing/selftests/kvm/x86/gmem_provider_test.c | 195 ++++++
 .../selftests/kvm/x86/gmem_provider_vfio_test.c    | 134 +++++
 tools/testing/selftests/kvm/x86/sev_init2_tests.c  |  16 +-
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |   9 +-
 virt/kvm/guest_memfd.c                             | 377 +++++++++---
 virt/kvm/kvm_main.c                                |   6 +-
 virt/kvm/kvm_mm.h                                  |   4 +-
 23 files changed, 2410 insertions(+), 102 deletions(-)

