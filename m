Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B3606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uTvvi/cY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F43C10E13D;
	Tue, 24 Nov 2026 02:45:45 +0000 (UTC)
Received: from mta1.migadu.com (out-70.mta1.migadu.com [95.215.58.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFCE10E13D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 02:45:38 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=tjBVgiSeQ42i6F1VR+QY5djrJY00Dtaohe2UFEdUDDs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795488335; v=1; x=1796093135;
 b=uTvvi/cYojLAdnl7mt+KQ7xm3g+Dj7Ca5nk1TlQwG4xccQNJKiV0QHzWZWN3xUM1Wg0A2j5o
 YqlrQzpH2NofK5BZAnh4OmO7xbCMSilWKf6apExjYhQbx/pbJMEExJmEfyHrTtWNFwNlC+k4/E+
 8vbpVEnD69Nc/3vi6m4kw+eM=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 0d1d44d1ee1858c3;
 Tue, 24 Nov 2026 02:45:35 +0000
X-Mizu-Trace-ID: 0d1d44d1ee1858c3
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Mon, 23 Nov 2026 21:45:01 -0500
Subject: [PATCH v2 2/3] udmabuf: map huge page backed ranges with PMDs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-feat-udmabuf-huge-pfnmap-v2-2-3254f801fc36@linux.dev>
References: <20261123-feat-udmabuf-huge-pfnmap-v2-0-3254f801fc36@linux.dev>
In-Reply-To: <20261123-feat-udmabuf-huge-pfnmap-v2-0-3254f801fc36@linux.dev>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Shuah Khan <shuah@kernel.org>
Cc: =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 "T.J. Mercier" <tjmercier@google.com>, Philip Yang <Philip.Yang@amd.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <qiliang.yuan@linux.dev>, 
 Natalie Vock <nat@pixelcluster.dev>
X-Mailer: b4 0.13.0
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QEMU and crosvm hand guest memory to the host renderer and display as
udmabufs for virtio-gpu blob resources. The guest memory is a memfd that
is often backed by 2 MiB huge pages, and the host process mmap()s the
dma-buf to access it with the CPU.

udmabuf maps every page with its own PTE: the first fault inserts a PFN
for each 4 KiB page of the whole VMA. Mapping and touching 4 GiB this way
takes over 200 ms and a million PTEs, although the memory behind it is
2048 huge pages.

Add a ->huge_fault() handler that maps a PMD-sized range with one PMD
when it is backed by an aligned run of contiguous PFNs, and falls back to
PTEs otherwise. Have the pre-mapping on the first fault skip the ranges
the handler will map, so that their PTEs don't take the place of the
PMDs. Once THP is disabled for the VMA, the ranges already mapped with a
PMD keep it, so pre-map only the PMD-sized range of the fault then.

Mapping a udmabuf over a memfd filled with data and reading a byte of
each 4 KiB page through the mapping, base and patched kernels alternating
over 3 rounds of 5 runs (7 for shmem 4K), median of the per-round medians
and range in parentheses:

  backing    size        before (ms)         after (ms)   change
  hugetlb    256M   13.3 (13.3-13.7)      1.7 (1.7-1.8)     -87%
  hugetlb      1G   53.6 (53.0-53.7)      6.5 (4.2-6.6)     -88%
  hugetlb      4G      211 (211-212)   23.6 (17.6-25.2)     -89%
  hugetlb      8G      423 (422-424)   45.8 (45.8-47.2)     -89%
  shmem THP    1G   52.8 (52.5-53.1)      6.3 (5.8-6.8)     -88%
  shmem THP    4G      210 (207-214)   20.7 (19.5-21.1)     -90%
  shmem 4K     1G   52.0 (51.6-52.7)   51.8 (51.5-52.9)       0%
  shmem 4K     4G      209 (209-211)      208 (208-209)       0%

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 drivers/dma-buf/udmabuf.c | 85 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 018937435356e..9f53d33fbdd9a 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -44,12 +44,63 @@ struct udmabuf {
 	struct miscdevice *device;
 };
 
+/*
+ * Return whether the PMD-sized range of @vma at @addr is backed by one aligned
+ * run of contiguous PFNs, which can then be mapped with a single PMD.
+ */
+static bool udmabuf_pmd_mappable(struct vm_area_struct *vma, unsigned long addr,
+				 unsigned long *pfn)
+{
+	struct udmabuf *ubuf = vma->vm_private_data;
+	const pgoff_t nr = PMD_SIZE >> PAGE_SHIFT;
+	unsigned long first;
+	pgoff_t pgoff, i;
+
+	if (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP))
+		return false;
+
+	if (!IS_ALIGNED(addr, PMD_SIZE) || addr < vma->vm_start ||
+	    vma->vm_end - addr < PMD_SIZE)
+		return false;
+
+	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+	if (pgoff >= ubuf->pagecount || ubuf->pagecount - pgoff < nr)
+		return false;
+
+	first = page_to_pfn(ubuf->pages[pgoff]);
+	if (!IS_ALIGNED(first, nr))
+		return false;
+
+	for (i = 1; i < nr; i++) {
+		if (page_to_pfn(ubuf->pages[pgoff + i]) != first + i)
+			return false;
+	}
+
+	*pfn = first;
+	return true;
+}
+
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+static vm_fault_t udmabuf_vm_huge_fault(struct vm_fault *vmf,
+					unsigned int order)
+{
+	unsigned long pfn;
+
+	if (order != PMD_ORDER ||
+	    !udmabuf_pmd_mappable(vmf->vma, vmf->address & PMD_MASK, &pfn))
+		return VM_FAULT_FALLBACK;
+
+	return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+}
+#endif
+
 static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct udmabuf *ubuf = vma->vm_private_data;
 	pgoff_t pgoff = vmf->pgoff;
-	unsigned long addr, pfn;
+	unsigned long addr, end, pfn;
+	bool pmd_ok;
 	vm_fault_t ret;
 
 	if (pgoff >= ubuf->pagecount)
@@ -61,14 +112,37 @@ static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
 	if (ret & VM_FAULT_ERROR)
 		return ret;
 
-	/* pre fault */
-	pgoff = vma->vm_pgoff;
+	/*
+	 * Pre-fault the rest of the VMA, except for the ranges that
+	 * udmabuf_vm_huge_fault() maps with a PMD once they are accessed.
+	 */
+	pmd_ok = thp_vma_allowable_order(vma, vma->vm_flags, TVA_PAGEFAULT,
+					 PMD_ORDER);
 	addr = vma->vm_start;
+	end = vma->vm_end;
 
-	for (; addr < vma->vm_end; pgoff++, addr += PAGE_SIZE) {
+	/*
+	 * Ranges mapped with a PMD before THP was disabled for the VMA keep
+	 * their PMD, so pre-fault only the PMD-sized range of the fault.
+	 */
+	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) && !pmd_ok) {
+		addr = max(addr, vmf->address & PMD_MASK);
+		end = min(end, (vmf->address & PMD_MASK) + PMD_SIZE);
+	}
+	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+
+	for (; addr < end; pgoff++, addr += PAGE_SIZE) {
 		if (addr == vmf->address)
 			continue;
 
+		if (pmd_ok && IS_ALIGNED(addr, PMD_SIZE) &&
+		    (vmf->address & PMD_MASK) != addr &&
+		    udmabuf_pmd_mappable(vma, addr, &pfn)) {
+			pgoff += (PMD_SIZE >> PAGE_SHIFT) - 1;
+			addr += PMD_SIZE - PAGE_SIZE;
+			continue;
+		}
+
 		if (WARN_ON(pgoff >= ubuf->pagecount))
 			break;
 
@@ -89,6 +163,9 @@ static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
 
 static const struct vm_operations_struct udmabuf_vm_ops = {
 	.fault = udmabuf_vm_fault,
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+	.huge_fault = udmabuf_vm_huge_fault,
+#endif
 };
 
 static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)

-- 
2.43.0

