Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0ACC44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE28210E199;
	Thu, 16 Jul 2026 15:17:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="S2CfLZpb";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC3310E390
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=SAZ8/BhCMnGmySiPyEgDtcYdmMNZhlXkPyz2Lr2GfpU=; b=S2CfLZpbUOxQcVH235CtAPFqKy
 +/KX3Ho76hCmOE45SOVu0AuEYQDT10HVStFLpeUPbGCNJUdYl5V9eBN2Lnpw8OEZrQlUmXz3XVI/l
 xRHhrZ7UFrAiw38lCpD6Hj7HJWLWwHsgm9mG3/teoDKAj0LlnddfvjJ2dcP28i5myDOarinnZYO9P
 INlGCXdTg6GfJOW8ncN3Dvyd0+M7Icz1Ld5Bteiz+y4jqR/b0leVgrbPTn3fNzOVHJ5laEvZsgE9G
 kMjdMVQbpKEn6lYvG+3XDmufWJoSkSXlQxrtaeNsT04AzDsVHtSmDtaZ4phTRm9/sAP7LVWOI1bqC
 Xks20TLg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wkNpj-00000002l0J-2rOR; Thu, 16 Jul 2026 15:17:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red
 Hat Linux)) id 1wkNpj-000000012tA-1k9i;
 Thu, 16 Jul 2026 16:17:07 +0100
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
Subject: [RFC PATCH 06/11] iommufd: Plumb dma-buf memory-type (RAM vs MMIO)
 through the phys map
Date: Thu, 16 Jul 2026 10:31:26 +0100
Message-ID: <a716d496ec095e1f71bb5fc8be3e2559bbe914cc.1784194290.git.dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
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

iommufd's dma-buf import path programmed the IOMMU unconditionally with
BATCH_MMIO (IOMMU_MMIO set, IOMMU_CACHE cleared).  This is correct for
the VFIO PCI dma-buf exporter -- its phys is PCI BAR (MMIO) memory --
but it is the wrong prot for a dma-buf whose phys is RAM: on AMD-Vi the
device DMA silently misroutes (Identify Controller against a
gmem-provider-backed target completes with status=0 but the target
region is not written).

Carry the exporter's memory type through to the fill routine:

  - Add is_cpu_ram to iopt_pages_dmabuf and pfn_reader_dmabuf.
  - Make sym_vfio_pci_dma_buf_iommufd_map() also fill *is_cpu_ram.
    VFIO PCI's exporter is MMIO (false); the sample gmem provider's
    exporter is CPU RAM (true).
  - pfn_reader_fill_dmabuf() picks BATCH_CPU_MEMORY vs BATCH_MMIO based
    on the captured kind.

The eventual formal negotiated exporter op should return phys and
memory type together in one call, replacing both symbol_get() lookups.

Signed-off-by: David Woodhouse (Kiro) <dwmw@amazon.co.uk>
---
 drivers/iommu/iommufd/io_pagetable.h |  7 ++++++
 drivers/iommu/iommufd/pages.c        | 33 +++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 27e3e311d395..887ed94474c7 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -206,6 +206,13 @@ struct iopt_pages_dmabuf {
 	/* Always PAGE_SIZE aligned */
 	unsigned long start;
 	struct list_head tracker;
+	/*
+	 * true if the exporter's phys is CPU RAM (map with IOMMU_CACHE, no
+	 * IOMMU_MMIO); false for MMIO/BAR memory (map with IOMMU_MMIO).  Set
+	 * by the exporter dispatch at map time; consulted by
+	 * pfn_reader_fill_dmabuf() to pick BATCH_CPU_MEMORY vs BATCH_MMIO.
+	 */
+	bool is_cpu_ram;
 };
 
 /*
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 2d4ea41460fd..f9b2ae6d7e96 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1080,6 +1080,7 @@ static int pfn_reader_user_update_pinned(struct pfn_reader_user *user,
 struct pfn_reader_dmabuf {
 	struct phys_vec phys;
 	unsigned long start_offset;
+	bool is_cpu_ram;
 };
 
 static int pfn_reader_dmabuf_init(struct pfn_reader_dmabuf *dmabuf,
@@ -1091,6 +1092,7 @@ static int pfn_reader_dmabuf_init(struct pfn_reader_dmabuf *dmabuf,
 
 	dmabuf->phys = pages->dmabuf.phys;
 	dmabuf->start_offset = pages->dmabuf.start;
+	dmabuf->is_cpu_ram = pages->dmabuf.is_cpu_ram;
 	return 0;
 }
 
@@ -1106,9 +1108,15 @@ static int pfn_reader_fill_dmabuf(struct pfn_reader_dmabuf *dmabuf,
 	 * always filled using page size aligned PFNs just like the other types.
 	 * If the dmabuf has been sliced on a sub page offset then the common
 	 * batch to domain code will adjust it before mapping to the domain.
+	 *
+	 * The exporter's memory type (CPU RAM vs MMIO/BAR) selects the batch
+	 * kind so downstream iommu_map sets IOMMU_CACHE for cache-coherent RAM
+	 * or IOMMU_MMIO for BAR memory.  The kind was captured at map time by
+	 * the exporter dispatch.
 	 */
 	batch_add_pfn_num(batch, PHYS_PFN(dmabuf->phys.paddr + start),
-			  last_index - start_index + 1, BATCH_MMIO);
+			  last_index - start_index + 1,
+			  dmabuf->is_cpu_ram ? BATCH_CPU_MEMORY : BATCH_MMIO);
 	return 0;
 }
 
@@ -1459,22 +1467,31 @@ static const struct dma_buf_attach_ops iopt_dmabuf_attach_revoke_ops = {
  * iommufd and vfio have a circular dependency. Future work for a phys
  * based private interconnect will remove this.
  */
+/*
+ * Look up the exporter's phys accessor for iommufd's private-interconnect
+ * path.  Also fills *is_cpu_ram: true if the exporter's memory is normal
+ * cache-coherent RAM (needs BATCH_CPU_MEMORY / IOMMU_CACHE), false for MMIO
+ * (needs BATCH_MMIO / IOMMU_MMIO).  This will be replaced by a formal
+ * exporter op that returns phys + memory type together.
+ */
 static int
 sym_vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
-				 struct phys_vec *phys)
+				 struct phys_vec *phys, bool *is_cpu_ram)
 {
 	typeof(&vfio_pci_dma_buf_iommufd_map) fn;
 	int rc;
 
 	rc = iommufd_test_dma_buf_iommufd_map(attachment, phys);
-	if (rc != -EOPNOTSUPP)
+	if (rc != -EOPNOTSUPP) {
+		*is_cpu_ram = false;	/* test hook mimics VFIO MMIO */
 		return rc;
+	}
 
 	/*
 	 * Prototype: try the sample gmem provider's dma-buf exporter.  This
 	 * mirrors the vfio-pci private-interconnect hook, and (like it) is
 	 * meant to be replaced by a formal negotiated exporter op returning
-	 * phys for iommufd.
+	 * phys + memory type.  The provider serves RAM, so mark it CPU_RAM.
 	 */
 	{
 		extern int gmem_provider_dma_buf_iommufd_map(
@@ -1485,8 +1502,10 @@ sym_vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 		if (gfn) {
 			rc = gfn(attachment, phys);
 			symbol_put(gmem_provider_dma_buf_iommufd_map);
-			if (rc != -EOPNOTSUPP)
+			if (rc != -EOPNOTSUPP) {
+				*is_cpu_ram = true;
 				return rc;
+			}
 		}
 	}
 
@@ -1498,6 +1517,7 @@ sym_vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 		return -EOPNOTSUPP;
 	rc = fn(attachment, phys);
 	symbol_put(vfio_pci_dma_buf_iommufd_map);
+	*is_cpu_ram = false;	/* VFIO PCI dma-buf carries BAR (MMIO) memory */
 	return rc;
 }
 
@@ -1526,7 +1546,8 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
 	if (rc)
 		goto err_detach;
 
-	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
+	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys,
+					      &pages->dmabuf.is_cpu_ram);
 	if (rc)
 		goto err_unpin;
 
-- 
2.54.0

