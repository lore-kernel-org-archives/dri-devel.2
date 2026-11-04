Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F176082BC5
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaU4mJTK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F38DF10FD60;
	Wed,  4 Nov 2026 16:49:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE6A710FD60
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:49:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D0A20419DB;
 Wed,  4 Nov 2026 16:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93C01F000C1;
 Wed,  4 Nov 2026 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793810962;
 bh=E/8vjYvtupLf5v8TU9CZJ1WziBquBZCxwcYljZ5lOwY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZaU4mJTK07JhJXoOkHugFNOLKSBOtcBwxVlKLdiuNzvBXN3LpTwlbBjFzVqSVbTH5
 LuzRV8aOWucDBQ1u9vOK0c+4vhcf/3rYEbeq8jcehdhHJ6lF3LgdylELGHFOcisJ7t
 Fy+EAPnct469u07A8EYfuj2ozRASkB7gtHRUuDSp5vUkpujtSRh3FPhlAjA7Dw+UgF
 YacoSPx62c9Q2O6xn7F9aYhQ6JDOUxRkw28L8HkO5uZtIP4e4Ox78fAStd0D5p6eth
 mxnUf4FsSSf4xVn8adZv6TbiNv124uPo6C1aJORBOTSNnHWHbDc7S4c3yUtm0rdH2F
 Ahf4K0XkiJutQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Marc Zyngier <maz@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Mark Rutland <mark.rutland@arm.com>, Radu Rendec <radu@rendec.net>,
 "T.J. Mercier" <tjmercier@google.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, kvmarm@lists.linux.dev, patches@lists.linux.dev
Subject: [PATCH v9 09/14] swiotlb: Reject misaligned restricted DMA pools for
 CoCo guests
Date: Wed,  4 Nov 2026 22:15:50 +0530
Message-ID: <20261104164555.3555725-10-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104164555.3555725-1-aneesh.kumar@kernel.org>
References: <20261104164555.3555725-1-aneesh.kumar@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A restricted DMA pool is a firmware-described ownership boundary. Unlike
a pool allocated by SWIOTLB itself, its base cannot be moved and its
size cannot be rounded without claiming memory outside the reserved
region.

Confidential-computing guests may require private/shared state changes
to cover units larger than PAGE_SIZE. Passing a misaligned restricted
region to set_memory_decrypted() can therefore fail.

Validate both the physical base and the complete reserved size with the
common CoCo shared-range helper before allocating SWIOTLB metadata or
performing a state transition. Perform the transition through
cc_make_shared().

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/swiotlb.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 36fbec2241e4..a3fc33c54cec 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -2011,6 +2011,14 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 		return -EINVAL;
 	}
 
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
+	    !cc_shared_range_valid(rmem->base, rmem->size)) {
+		dev_err(dev,
+			"Restricted DMA pool must be aligned to %#zx bytes for memory encryption\n",
+			cc_shared_granule_size());
+		return -EINVAL;
+	}
+
 	/*
 	 * Since multiple devices can share the same pool, the private data,
 	 * io_tlb_mem struct, will be initialized by the first device attached
@@ -2044,8 +2052,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			int ret;
 
 			mem->cc_shared = true;
-			ret = set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
-						   rmem->size >> PAGE_SHIFT);
+			ret = cc_make_shared(phys_to_virt(rmem->base),
+					     rmem->size);
 			if (ret) {
 				dev_err(dev, "Failed to decrypt restricted DMA pool\n");
 				kfree(pool->areas);
-- 
2.43.0

