Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE58C98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E2010F413;
	Thu, 24 Sep 2026 10:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MBbTPQiM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7971810F413
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:06:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE7746022F;
 Thu, 24 Sep 2026 10:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDE41F000FF;
 Thu, 24 Sep 2026 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790244417;
 bh=waix5vjh+pKFV3Wslxy857438fq/HyMRB7bQ/yb+Wag=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MBbTPQiMrIlhFnAQgodW4mh3L6x9pAnVoy9CpXDiD5kwwKVpSU3cW85m6YO3TllUe
 +8u1KpU1qq8ya8T0dvH9jh9swr5NkeWtJ0Jd25sXVXkLI4kJPPUC12YjRJqZRefRui
 Dr8TzQTF2X7fdYDA28ugxZlsWVSwiyDXVbEOHF18q78gXVUmWvnjBgJTLq7m5529Ex
 8vXjEnYwjiugyhtg4AKJmlx9fPxgE3qm1L6Pf7xfudwJrSN6SlBAc1JbgB/SJzlNwz
 dtHD71eWILpn/kglR9wjXyVr+pY2jUtdefsLu9FHGEk86hCjUr/+mEpozltE+1KBYE
 +LiKQH7VzRRKA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
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
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org
Subject: [RFC PATCH v8 04/14] irqchip/gic-v3-its: Allocate shared tables using
 CoCo shared memory allocator
Date: Thu, 24 Sep 2026 15:35:19 +0530
Message-ID: <20260924100529.1398790-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924100529.1398790-1-aneesh.kumar@kernel.org>
References: <20260924100529.1398790-1-aneesh.kumar@kernel.org>
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
index ac5507acb1a0..4814161df02e 100644
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
@@ -214,25 +213,13 @@ static gfp_t gfp_flags_quirk;
 static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 					 unsigned int order)
 {
-	struct page *page;
-	int ret = 0;
-
-	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
-
-	if (!page)
-		return NULL;
+	struct cc_shared_pages mem;
 
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
@@ -242,13 +229,15 @@ static struct page *its_alloc_pages(gfp_t gfp, unsigned int order)
 
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
@@ -273,7 +262,8 @@ static void *itt_alloc_pool(int node, int size)
 		if (!page)
 			break;
 
-		gen_pool_add(itt_pool, (unsigned long)page_address(page), PAGE_SIZE, node);
+		gen_pool_add(itt_pool, (unsigned long)page_address(page),
+			     cc_shared_granule_size(), node);
 	} while (!addr);
 
 	return (void *)addr;
-- 
2.43.0

