Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E362606A334
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YO6y8M70
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AAD110ED96;
	Mon, 16 Nov 2026 09:13:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8130810EE0A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:13:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62164418FF;
 Mon, 16 Nov 2026 09:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E156D1F000C5;
 Mon, 16 Nov 2026 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794820391;
 bh=BkbaFHk2u10jsgJXIyugQue+lmp79DE9DfOGev5Fa6w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YO6y8M70miqIftiolCtjqWxT1cPdwgt4HbMjzAAzHYOjE/n/ayOyiVqewfVGDGe63
 RIBGo2geYnm+TXLh0O/WQAMlt4om/0bcCWBjnwvmTmBwFY5gHQBzyfl0CA0Go9fiLt
 KN0gBXtYX+YKW+HQ2GHhjbPTLHtm11ifwkcRlFC0h2WNgJK7QCgd48ZzriZWBcnGaA
 nnzVMKvNXczopAnQlTiVyV+tl8dt0CeN0rHhMh4usWPNKtZjnBuaxCfz0vWuuwhWVv
 XKgZdnevaDCGvLOxMZdL12dmAPvqsOr58Y8BGjJJaVeYHyK1IStYYGF0zdDSVc5Ixu
 b/Tq/isddt0VA==
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
Subject: [PATCH v10 04/13] irqchip/gic-v3-its: Allocate shared tables using
 CoCo shared memory allocator
Date: Mon, 16 Nov 2026 14:41:27 +0530
Message-ID: <20261116091137.94252-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116091137.94252-1-aneesh.kumar@kernel.org>
References: <20261116091137.94252-1-aneesh.kumar@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ITS command queues and tables are shared with the host in a
confidential-computing guest. The ITS allocator currently assumes that
the guest PAGE_SIZE is sufficient for both allocation alignment and
private/shared state changes.

Route ITS page allocations through alloc_cc_shared_pages_node(). Keep
the tracked table size based on the ITS-requested order. On release,
reconstruct the common allocation metadata from the original ITS order
and the architecture granule size so the same transitioned range and
buddy order are used.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Radu Rendec <radu@rendec.net>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 40 ++++++++++++--------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ada5c30af41e..a67e98cecde5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -8,6 +8,7 @@
 #include <linux/acpi_iort.h>
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
+#include <linux/cc_shared.h>
 #include <linux/cpu.h>
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
@@ -19,7 +20,6 @@
 #include <linux/irqdomain.h>
 #include <linux/list.h>
 #include <linux/log2.h>
-#include <linux/mem_encrypt.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/msi.h>
@@ -29,7 +29,6 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/percpu.h>
-#include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
 #include <linux/topology.h>
@@ -216,28 +215,16 @@ static gfp_t gfp_flags_quirk;
 static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 					 unsigned int order)
 {
-	struct page *page;
-	int ret = 0;
+	struct cc_shared_pages mem;
 
 	if (node == NUMA_NO_NODE)
 		node = numa_mem_id();
 
-	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
-
-	if (!page)
-		return NULL;
-
-	ret = set_memory_decrypted((unsigned long)page_address(page),
-				   1 << order);
-	/*
-	 * If set_memory_decrypted() fails then we don't know what state the
-	 * page is in, so we can't free it. Instead we leak it.
-	 * set_memory_decrypted() will already have WARNed.
-	 */
-	if (ret)
+	if (alloc_cc_shared_pages_node(node, gfp | gfp_flags_quirk,
+				       PAGE_SIZE << order, &mem))
 		return NULL;
 
-	return page;
+	return mem.page;
 }
 
 static struct page *its_alloc_pages(gfp_t gfp, unsigned int order)
@@ -247,13 +234,15 @@ static struct page *its_alloc_pages(gfp_t gfp, unsigned int order)
 
 static void its_free_pages(void *addr, unsigned int order)
 {
-	/*
-	 * If the memory cannot be encrypted again then we must leak the pages.
-	 * set_memory_encrypted() will already have WARNed.
-	 */
-	if (set_memory_encrypted((unsigned long)addr, 1 << order))
+	struct cc_shared_layout layout;
+	struct cc_shared_pages mem;
+
+	if (WARN_ON(cc_shared_calc_layout(PAGE_SIZE << order, &layout)))
 		return;
-	free_pages((unsigned long)addr, order);
+
+	mem.page = virt_to_page(addr);
+	mem.shared_size = layout.shared_size;
+	free_cc_shared_pages(&mem);
 }
 
 static struct gen_pool *itt_pool;
@@ -278,7 +267,8 @@ static void *itt_alloc_pool(int node, int size)
 		if (!page)
 			break;
 
-		gen_pool_add(itt_pool, (unsigned long)page_address(page), PAGE_SIZE, node);
+		gen_pool_add(itt_pool, (unsigned long)page_address(page),
+			     cc_shared_granule_size(), node);
 	} while (!addr);
 
 	return (void *)addr;
-- 
2.43.0

