Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1170CCD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6651810E9C6;
	Wed, 10 Jun 2026 14:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cpFXm4lE";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9134F10E9C6
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:23:48 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2bf18c30bb2so50105615ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781101428; x=1781706228; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RIgrfTieRwmLlw1dLE2AIE0y0j3JlRfXfzK5v3rBlwE=;
 b=cpFXm4lEEnVxUxXbc/N6RWYj2Y4Shwvp6th/oYyABVtWOe671WlTMfKKByPcST833w
 Wy2mheq4Md7WGx6JeV9rHFo8l4dQ/mlYORrOAbHwyVHXaO6PMmQvhkeh3w+xGvPyy1js
 BP7FZ1fMs8CjDrOX2sJXTKCGny4+9xZE20nvw8ZpmAid2IYeN9Be+LaExYWf+Xx0d4Q5
 V3kDSyqx4QLMhqMoEHBqUCl53fLOGQSd6Kx9M+cW5e9SWlqgGkGcJUO5qmxyGqMlhiDz
 B1mi2uZaCYUQq+4Zzvum3HyJvIUzytqKSfiRQ9uZXuxPqAf0RzWCBctNMKUdmrCX6PZG
 mDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781101428; x=1781706228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIgrfTieRwmLlw1dLE2AIE0y0j3JlRfXfzK5v3rBlwE=;
 b=g+8nyAb2VopPUEDG9YIjTtK02Gjqt3MWwr43NUZAF2aOMdKK5z9n1E2z04fIsQUm++
 4JGMKKZl2gWXWipHkEn05hR8/dnN0+7emhHoQWt1wl73qSR4It7quCesT4/CMwyQaQnZ
 vLiif/ZKbBUhg6KGEbpXqth5Teq8+Wi4Ilsjugu1xceAWP9w6yG36a3F9PD86j1q09G5
 DAe+8pbd0MwwN2MqbDdTII0fQpC6LoGlKcOlrc8RIyKIZt8uGH9fcD94JWJUUPJQSV8e
 LKi/FtZDY3M8OD5q1Nd1P0RjiUhShLidQC+ALY7ppJeI9ssmpYZuvY/SZBkJSXo/K24B
 sNxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iLjNCWI8xinzyiOIXyqeCwgahMnxnJwULztuz7e0JN0NM86CvbbL3SCh2Dhcau3rezXDRwJnzh3s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsgxIBMm7ivuUuaCVLlNR/Hoi7/0rXDAOtmxdCzfU6TOmSTbAy
 udgkWVyLW8CWH6IwQVTIV+KjAOhTCwEkS9A2iODAsJ+LtcXUd/TXh0VtDpe97KgWHQU=
X-Gm-Gg: Acq92OFY9nHiKvcHlqhTePdxztlxl2ugbb9wddlV2f1Tvx/oIo+SLG8VaE9/a0Aw0k0
 4GnzoPOohmpgMVTTp6zU44bVpUn2a268GGWAnNvx+SApICM2r2nI3FRGWAWywlK+TJ5q76mAhjA
 RftUre1yddPSg9rqotzjaWUUy3VHvFjTRiw/TQhVVrcYnNtFX+rm8k4V5nzbVUqB9P8BRzacaJs
 YOcQrlt3LC6hP+EVcHBxspgt+u9VSULFJI/uTCBDIN8dXn1z624DopX/mXy2UYaFtmyl5jIQqW0
 ocBb15M7AqnG9gmjzhvow0cbjDZU1jb9TnWP8P/OyfmLatYrPznXjHk3Vf5crPJMGmexqLXh6TA
 mUbG3fkENdW4JFfnXe5jv/3icMonJKeVcwRudqDdy6XaGVFTN0BOX1gw09JIn+tH7NUcF3jr4El
 XnOMblLVR8FBEOcmMR3RuRkwGD0aP+U5kcKv/AxtwjsEKoDqvbSZUzHA==
X-Received: by 2002:a17:902:e752:b0:2b2:5515:661c with SMTP id
 d9443c01a7336-2c1e893d62dmr281727295ad.31.1781101427890; 
 Wed, 10 Jun 2026 07:23:47 -0700 (PDT)
Received: from nagraj.tail8a2ac.ts.net ([2406:7400:98:3ab:da47:17e2:32f7:c4d3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6d318sm265761935ad.15.2026.06.10.07.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 07:23:47 -0700 (PDT)
From: Sumit Semwal <sumit.semwal@linaro.org>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: jgg@ziepe.ca, jiri@resnulli.us, hch@infradead.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 linuxppc-dev@lists.ozlabs.org, lkp@intel.com, agordeev@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, djbw@kernel.org,
 thomas.lendacky@amd.com, x86@kernel.org, arnd@linaro.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 tjmercier@google.com, mripard@kernel.org, afd@ti.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] dma-buf: move system_cc_shared heap under separate Kconfig
Date: Wed, 10 Jun 2026 19:53:29 +0530
Message-ID: <20260610142329.3836808-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.51.1
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

From: Arnd Bergmann <arnd@arndb.de>

While system heap and system_cc_shared heap share a lot of code
and hence the same source file, their users have different needs.

system heap users need it to be a loadable module, while
system_cc_shared heap users don't.

Building as a loadable module breaks system_cc_shared heap on
powerpc and s390 due to un-exported set_memory_encrypted /
set_memory_decrypted functions.

Fix these by reorganising code to put the system_cc_shared heap
under a new Kconfig symbol, which allows either building both
into the kernel, or leave encryption up to the consumers of the
system heap.

Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 drivers/dma-buf/heaps/Kconfig       |  8 ++++++++
 drivers/dma-buf/heaps/system_heap.c | 16 ++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index e273fb18feca..a39decdcf067 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -5,6 +5,14 @@ config DMABUF_HEAPS_SYSTEM
 	  Choose this option to enable the system dmabuf heap. The system heap
 	  is backed by pages from the buddy allocator. If in doubt, say Y.
 
+config DMABUF_HEAPS_CC_SYSTEM
+	bool "DMA-BUF System Heap for decrypted CoCo VMs"
+	depends on DMABUF_HEAPS && ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=y
+	help
+	  Choose this option to enable the system_cc_shared dmabuf heap. This
+	  allows allocating shared (decrypted) memory for confidential computing
+	  (CoCo) VMs.
+
 config DMABUF_HEAPS_CMA
 	tristate "DMA-BUF CMA Heap"
 	depends on DMABUF_HEAPS && DMA_CMA
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index c92bdec356fc..71d9028cc3df 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -48,6 +48,9 @@ struct dma_heap_attachment {
 	bool cc_shared;
 };
 
+#define cc_shared_buffer(b) (IS_ENABLED(CONFIG_DMABUF_HEAPS_CC_SYSTEM) && \
+				(b)->cc_shared)
+
 #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO)
 #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
 				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
@@ -161,7 +164,7 @@ static struct sg_table *system_heap_map_dma_buf(struct dma_buf_attachment *attac
 	unsigned long attrs;
 	int ret;
 
-	attrs = a->cc_shared ? DMA_ATTR_CC_SHARED : 0;
+	attrs = cc_shared_buffer(a) ? DMA_ATTR_CC_SHARED : 0;
 	ret = dma_map_sgtable(attachment->dev, table, direction, attrs);
 	if (ret)
 		return ERR_PTR(ret);
@@ -233,7 +236,7 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	int i, ret;
 
 	prot = vma->vm_page_prot;
-	if (buffer->cc_shared)
+	if (cc_shared_buffer(buffer))
 		prot = pgprot_decrypted(prot);
 
 	for_each_sgtable_sg(table, sg, i) {
@@ -282,7 +285,7 @@ static void *system_heap_do_vmap(struct system_heap_buffer *buffer)
 	}
 
 	prot = PAGE_KERNEL;
-	if (buffer->cc_shared)
+	if (cc_shared_buffer(buffer))
 		prot = pgprot_decrypted(prot);
 	vaddr = vmap(pages, npages, VM_MAP, prot);
 	vfree(pages);
@@ -349,7 +352,7 @@ static void system_heap_dma_buf_release(struct dma_buf *dmabuf)
 		 * Intentionally leak pages that cannot be re-encrypted
 		 * to prevent shared memory from being reused.
 		 */
-		if (buffer->cc_shared &&
+		if (cc_shared_buffer(buffer) &&
 		    system_heap_set_page_encrypted(page))
 			continue;
 
@@ -456,7 +459,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 		list_del(&page->lru);
 	}
 
-	if (cc_shared) {
+	if (cc_shared_buffer(buffer)) {
 		for_each_sgtable_sg(table, sg, i) {
 			ret = system_heap_set_page_decrypted(sg_page(sg));
 			if (ret)
@@ -485,7 +488,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 		 * Intentionally leak pages that cannot be re-encrypted
 		 * to prevent shared memory from being reused.
 		 */
-		if (buffer->cc_shared &&
+		if (cc_shared_buffer(buffer) &&
 		    system_heap_set_page_encrypted(p))
 			continue;
 		__free_pages(p, compound_order(p));
@@ -525,6 +528,7 @@ static int __init system_heap_create(void)
 		return PTR_ERR(sys_heap);
 
 	if (IS_ENABLED(CONFIG_HIGHMEM) ||
+	    !IS_ENABLED(CONFIG_DMABUF_HEAPS_CC_SYSTEM) ||
 	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return 0;
 
-- 
2.43.0

