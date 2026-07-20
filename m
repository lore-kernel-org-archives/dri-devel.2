Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8A0C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A9B10E890;
	Mon, 20 Jul 2026 11:13:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="vHy1vLjW";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D54410E893
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=RL/v5SvC2VxJ6+oyZc8TOkOrhRSfWhkJXoWNNru7NU8=; b=vHy1vLjWnEzcwKp2MY02G+rjTR
 XbvtIw0REZvX43EiX248S/BrLsHfMfy3LKnjCXs2CAGydoPlgLuUdOEwcWiWA9Smr/5bjDfn8BSBq
 2Cm9ra8hQVtl+ZmNhDj9O4/51kJnUvTwJqhvvMJZOzaBLWy7Vs3i5gpT8a4ZYnLvOyx1rXTQM1v+c
 G5gXNV8HKMTG9yowBmNbSJ0hXq+KijgBj4zQnMyKwro849UU5tow7Y9k7mkQClMpCmq62k5ETjLg5
 ohnxkQbzLOapXuDiy7o3jAbotvPxq2Ajl3ocx9EbLNHxW77nAmoUCUr/W+ez/xv69suPxQPbmAVMg
 aSES1NaA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wllvh-0000000Akyy-2QyW; Mon, 20 Jul 2026 11:13:01 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red
 Hat Linux)) id 1wllvh-00000000W14-1DbF;
 Mon, 20 Jul 2026 12:13:01 +0100
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
 graf@amazon.de, fgriffo@amazon.co.uk, David Woodhouse <dwmw@amazon.co.uk>
Subject: [RFC PATCH v2 11/11] samples/kvm,
 selftests/kvm: Allow the gmem_provider NVMe DMA test on arm64
Date: Mon, 20 Jul 2026 12:03:12 +0100
Message-ID: <ac6174df98ec277aa6758859bcf7307865718bbf.1784545391.git.dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2b5e7a83d277134294199a455469bb436196b902.1784545391.git.dwmw@amazon.co.uk>
References: <2b5e7a83d277134294199a455469bb436196b902.1784545391.git.dwmw@amazon.co.uk>
MIME-Version: 1.0
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

From: David Woodhouse <dwmw@amazon.co.uk>

The sample provider and the NVMe DMA selftest have no x86 specifics.
Drop the X86_64 gate on the sample's Kconfig (arm64 also has
KVM_GUEST_MEMFD; the SEV RMP reset is already guarded by
CONFIG_AMD_MEM_ENCRYPT) and move the NVMe DMA selftest from
TEST_GEN_PROGS_x86 to TEST_GEN_PROGS_COMMON so it also builds on
architectures with an IOMMU (arm64 SMMU-v3, ...).

The test itself does not need to change: it uses KVM_CREATE_VM(0) as
a client for the sample provider's SETUP ioctl and then exercises
the iommufd + dma-buf + provider revoke path with direct NVMe MMIO,
none of which is x86-specific.  On arm64 it validates the same flow
through the ARM SMMU.

Signed-off-by: David Woodhouse (Kiro) <dwmw@amazon.co.uk>
---
 samples/Kconfig                                                 | 2 +-
 tools/testing/selftests/kvm/Makefile.kvm                        | 2 +-
 .../selftests/kvm/{x86 => }/gmem_provider_nvme_dma_test.c       | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename tools/testing/selftests/kvm/{x86 => }/gmem_provider_nvme_dma_test.c (100%)

diff --git a/samples/Kconfig b/samples/Kconfig
index 3482659638b5..d26a03dea072 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -328,7 +328,7 @@ source "samples/damon/Kconfig"
 
 config SAMPLE_KVM_GMEM_PROVIDER
 	tristate "Build sample guest_memfd provider -- loadable module only"
-	depends on KVM_GUEST_MEMFD && X86_64 && m
+	depends on KVM_GUEST_MEMFD && (X86_64 || ARM64) && m
 	help
 	  This builds a sample external guest_memfd provider module with two
 	  backing modes.  Loaded with addr=/len= it backs guest memory with a
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 7f46843e7428..12004a487c32 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -58,6 +58,7 @@ TEST_PROGS_x86 += x86/nx_huge_pages_test.sh
 # Compiled test targets valid on all architectures with libkvm support
 TEST_GEN_PROGS_COMMON = demand_paging_test
 TEST_GEN_PROGS_COMMON += dirty_log_test
+TEST_GEN_PROGS_COMMON += gmem_provider_nvme_dma_test
 TEST_GEN_PROGS_COMMON += guest_print_test
 TEST_GEN_PROGS_COMMON += irqfd_test
 TEST_GEN_PROGS_COMMON += kvm_binary_stats_test
@@ -82,7 +83,6 @@ TEST_GEN_PROGS_x86 += x86/gmem_provider_hugepage_test
 TEST_GEN_PROGS_x86 += x86/gmem_provider_revoke_test
 TEST_GEN_PROGS_x86 += x86/gmem_provider_iommufd_test
 TEST_GEN_PROGS_x86 += x86/gmem_provider_vfio_test
-TEST_GEN_PROGS_x86 += x86/gmem_provider_nvme_dma_test
 TEST_GEN_PROGS_x86 += x86/hwcr_msr_test
 TEST_GEN_PROGS_x86 += x86/hyperv_clock
 TEST_GEN_PROGS_x86 += x86/hyperv_cpuid
diff --git a/tools/testing/selftests/kvm/x86/gmem_provider_nvme_dma_test.c b/tools/testing/selftests/kvm/gmem_provider_nvme_dma_test.c
similarity index 100%
rename from tools/testing/selftests/kvm/x86/gmem_provider_nvme_dma_test.c
rename to tools/testing/selftests/kvm/gmem_provider_nvme_dma_test.c
-- 
2.55.0

