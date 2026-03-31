Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315FAFF60FF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B7610EA23;
	Tue, 31 Mar 2026 10:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CJvLYjTs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D26F010EA09
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:00:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B62F44459E;
 Tue, 31 Mar 2026 10:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311CFC2BCB2;
 Tue, 31 Mar 2026 10:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774951233;
 bh=WYlzG+ukMJv0uKE6bBondQfqi9l4oA5FGcpDNGm8BfQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=CJvLYjTsGVFPfmwcssIBPuYWjEXZyeslFXYMGjWslUxnkyWJMRkYWx/l4rHOl4MhJ
 Cs86r/iSby2dp1Cy3j1p0YGLO8/seT+yM9iTE785mhUngsXG5HrJINhMDZAvJ8kXUa
 9MteSpTOUqG7xcXMh7lSM12m7OWM2y7/jGQ7ij9uIsRnSyoAWJP5cdy3YmbmeIUWtl
 3skZX52saIkv3R0r8Zc79v2VEXqEJ5d8ohc75fVF98npAw3lC5eBO+pQYuqJ8skGNz
 orDcMmp0BajvP9QI2x0X2qP6MS0813wJiAU0+2RjN5K9t2VKQWmbyqxaXS9dG18Kth
 0N4mtm7SpjM/w==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 31 Mar 2026 12:00:13 +0200
Subject: [PATCH v4 4/8] dma: contiguous: Export dev_get_cma_area()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-dma-buf-heaps-as-modules-v4-4-e18fda504419@kernel.org>
References: <20260331-dma-buf-heaps-as-modules-v4-0-e18fda504419@kernel.org>
In-Reply-To: <20260331-dma-buf-heaps-as-modules-v4-0-e18fda504419@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: Albert Esteve <aesteve@redhat.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=mripard@kernel.org;
 h=from:subject:message-id; bh=WYlzG+ukMJv0uKE6bBondQfqi9l4oA5FGcpDNGm8BfQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJmnZxv81fradDYnN/8Gl+LUDRekPcP7X+5e8vtpaNLbZ
 K2t8qwHOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEJvky1hcs2svx6NgZ4yLT
 IJXHbfnV+8vfCTVuNBNRuXuBr/aQjfAp4RlrxZYV5B417zYNOlOXythwwin1TskDzm27Z2rb8pt
 OVlje0m/zePGpgNv7l8Yd/GkY9ICfXSqnI+m2pstGTfO58fwA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The CMA dma-buf heap uses the dev_get_cma_area() function to retrieve
the default contiguous area.

Now that this function is no longer inlined, and since we want to turn
the CMA heap into a module, let's export it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 kernel/dma/contiguous.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index fd8d3518a2323f0a631fb185ef92a24c35f8d25d..83a5bd9488e1448cc72e92ed204ce804164cc6b8 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -136,10 +136,11 @@ struct cma *dev_get_cma_area(struct device *dev)
 	if (dev && dev->cma_area)
 		return dev->cma_area;
 
 	return dma_contiguous_default_area;
 }
+EXPORT_SYMBOL_GPL(dev_get_cma_area);
 
 #ifdef CONFIG_DMA_NUMA_CMA
 
 static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
 static phys_addr_t numa_cma_size[MAX_NUMNODES] __initdata;

-- 
2.53.0

