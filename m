Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFB9C982F8
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D967910E161;
	Mon, 21 Sep 2026 14:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kc8P2140";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D327810E161
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 14:49:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA2FB410B9;
 Mon, 21 Sep 2026 14:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CA71F00893;
 Mon, 21 Sep 2026 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790002184;
 bh=HSe1gOHGix6Y2SkfM68PVLIwg5C/r0qNlcWeNP5Fwxs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Kc8P2140ujn+VDpWuuA0syxxlPiR5Dl/sChZvXp0DKgAkTCax/cLTbAp8LB0IWXAB
 R4hVFA8/L+PQBfe/eKPRAHKK3vjVTVdKREnLY52b3114xvDk3GOmnJLuphnn5R+2sm
 uOTWUiy5I/4uo1Ehng06km71pPSO/H3d3vc7lO+Gx1bVyxhyybF3v6MrEd5Hy3uB/W
 f1R2+b/CTIVMQSZLAmFcf1ixeWZgNZEF7GsQ3UxDkz+aw0go90MnrLv0EykJ1GFlpI
 enwffS8MUCShd5hX7jN0XvuJEjTM/ibsrm8B2tGuAGjBx+1oFq7lO33iYzkp/Ypz4I
 NeRaMoJfvCMAw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, christian.koenig@amd.com,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Marc Zyngier <maz@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH v7 05/13] irqchip/gic-v3-its: Allocate shared tables using
 CoCo shared memory allocator
Date: Mon, 21 Sep 2026 20:18:39 +0530
Message-ID: <20260921144847.501151-6-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921144847.501151-1-aneesh.kumar@kernel.org>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
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

