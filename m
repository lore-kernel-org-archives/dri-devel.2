Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6304CCA5FFD
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD1BE10EB62;
	Mon,  5 Oct 2026 06:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BMujyVTt";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C41210E845
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 06:41:44 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso13447165e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 23:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791182502; x=1791787302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1AVlpPfw5UZbso5/hscvA6TJLBv2kCVbh4MVGQA/j1o=;
 b=BMujyVTtjBec0zCFRMKpOhOkDqP5I/pQ1IQ7DP8MJTIHAuwR4lLMxro770Ddm7cBSj
 WiU+fhSI0VbGysnuZ+ZpMVh14ZpkTvw+OVfT9up7zOFbulCAAMhDYpEusmXIq+yLqsZE
 usYleqap7BqqHsGtDaq2Xqzmu5HUXRVr9kbJerBlkH3O4BgSCueiyvGvZXARRomqTFUf
 ETJqVUBJDYeQNv6HPGG3Dg/zoiwsAwYQnoFLu5yo0tqxOsGLliwCZl2C4aFh7txOxMcE
 oRFtnxL6fyhAguGgemFQqTlromXruJNzgLZtwCqgaIBQT+HdWDJgE/FZXktgcPIo/vW2
 C0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791182502; x=1791787302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1AVlpPfw5UZbso5/hscvA6TJLBv2kCVbh4MVGQA/j1o=;
 b=1scoVh2JW7aeN5PkNBSt015KKCvWS/Dz7RJEiJ1V5ZfFW/tTpF1L/6acxMdyfznqI6
 xRpks83SDBviBWZx05Hz/FjGyigVbdjPxCeqLwDYRLEwbU9Kz/HSJfB8+aUL9BReSz9h
 9hpO12DBV8df8aLo66tMHnhlkpzUS855cVsZ0UhMlA1ZOctOtnwDGBhr/jLaZnDU/85s
 BuFcM19llvk0pA+2QeGjH1gPOhrmJliYeNnJubBsI20s7u9Ll9i3Lz7G+8cCMjsrIw+h
 qW6qQFiJRo5L1MhJ30j7F60DdlDiy0uofmUc+9QVsbf5i1yxvN7d7gVmU1O5KrLclTZ4
 WNzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwreN0MFt3nx3Suagn3jyLKV/hENDKqc0BC5aElD5MENcWdytjz3mhLm50/F8NOwF6EW2Mw7PwvyUE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kRRQ3tKszluIXdI8P4kuOIYJKUe6yu2PC1D8C68JExi9PC+E4O
 6/mBkZOiIgvechy0ubiou9X/cCag3JyFy+ZOIu59FPuGyV1z501eDxIp
X-Gm-Gg: AYBFou21g5hsHwBt9+jhBAq23tKkiwmICszLGc3mmOykyCe0vl9ZlKHAlgQLMWqVriy
 HjwUKPeL1hmSZgGo6x7ivwFE7VsFOCadi+9lw0bY1sq+apec5X88DSFhaMP/g7BnzOREdqbF0O/
 dmWuqe1U7rBUgfqB888Yb2ZD8bNwTHmX0UmlUB4J9bbQd4n5QlNj49ib4wVaQbzLlcXFfmSzwRy
 jBUTWngknz/CThhpJ+9tGCxTApnYLcOPpHp20tFkiZDqtcjvieujfdWEMbC/gCBVQLUhig0eChz
 aSG01rxK/FlOWRLta4S0Msk8ElDYxBG13CISSfWSFaNTPJh4p305e9Lmwbty4BqEFbdRPLaIpBN
 4lARfeTJVNJ/Vz9XydOCz9q6rQm6jPenetRQvzosKLQh3W4DFcIRXRgulBpo+VLW6Bp6J0dUfJU
 uaEp0scMfVFUHgfTv/M3eZ6eglHO8TSRGxMTQW1ds+CED59cgKHH8aXKC2CPqLqWe3INVDWWwN+
 En7746hTe0TsdFQg48wmkxpq6/zWrrG99cypZr2uCCaPvc+s9/T0Db5ZzeFdps3OW6nkqv7axxj
 DsXkJyxjuRS+egea2i5eCzXn+8GmJ1LBPkuI/3BKPBck0Eg4qi8ufY2IEGU4CIhAs2jPRULfvxI
 Ury1t6ocK/UsP
X-Received: by 2002:a05:600c:a013:b0:4a1:69fd:f90a with SMTP id
 5b1f17b1804b1-4a169fdfac5mr81732785e9.26.1791182502096; 
 Sun, 04 Oct 2026 23:41:42 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de.
 [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c62289b62sm1666871f8f.20.2026.10.04.23.41.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 04 Oct 2026 23:41:41 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Rob Clark <rob.clark@oss.qualcomm.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] dma-buf: add a warn-only mode to DMABUF_DEBUG
Date: Mon,  5 Oct 2026 08:41:32 +0200
Message-Id: <20261005064133.7305-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261005064133.7305-1-kmehltretter@gmail.com>
References: <20261005064133.7305-1-kmehltretter@gmail.com>
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

DMABUF_DEBUG hands importers a copy of the exporter's sg_table without
the struct pages. An importer that uses them then fails, often far from
the cause and without a message that points at it. Where sg_dma_len()
is sg->length, the copy cannot hide the length either.

Add DMABUF_DEBUG_WARN. With it the copy keeps the CPU side of the
exporter's table: page, offset and length of all orig_nents entries,
and the exporter's nents and orig_nents. A table without a CPU side
(orig_nents == 0) stays that way. Every entry of the copy is marked
with a new dma_flags bit, SG_DMA_DMABUF_DEBUG.

sg_page(), sg_nents_for_len() and sg_split() test the bit and print a
rate limited message with a stack trace. sg_page() is mostly reached
through DMA and scatterlist helpers, so the trace is what names the
importer. These CPU-side accesses can continue after the report instead
of failing because the fields were cleared.

The report is not a WARN(). It does not taint the kernel and does not
trigger panic_on_warn.

Reads of sg->offset and sg->length that do not go through these
helpers are not seen. The option adds a test to every sg_page() and
selects NEED_SG_DMA_FLAGS.

Strict mode remains the default and continues to remove the CPU-side
fields.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    Tested on v7.3-rc4-70-gfe2ec83746e5 with GCC 15.2.0.
    
    Builds, without warnings:
    
    - x86_64 with DMABUF_DEBUG_WARN=y, full build
    - arm64 defconfig with DMABUF_DEBUG_WARN=y: Image, and the msm and
      rockchip DRM drivers
    - ARM926 (SAM9X75) with DMABUF_DEBUG_WARN=y and without
      NEED_SG_DMA_LENGTH, full build
    - ARM926 with DMABUF_DEBUG=n and without NEED_SG_DMA_FLAGS, full build.
      dma-buf.o and lib/scatterlist.o disassemble as on the base commit,
      except for __LINE__ constants.
    - x86_64 with SG_SPLIT, W=1, the objects touched here: with
      DMABUF_DEBUG_WARN=y, with DMABUF_DEBUG=y alone, and with
      DMABUF_DEBUG=n
    
    Runtime, both in QEMU with local device models, not on hardware.
    
    Zynq with an AXI ADC, IIO DMABUF capture into udmabuf buffers,
    NEED_SG_DMA_LENGTH=y. The IIO dmaengine buffer calls sg_nents_for_len()
    on the attachment's table. With DMABUF_DEBUG=y alone the capture fails:
    
      DMABUF_ENQUEUE failed: Device or resource busy
    
    With DMABUF_DEBUG_WARN=y all 16 blocks arrive with the right data, the
    kernel is not tainted, and the log has one report:
    
      DMA-BUF: importer used the CPU side of an exporter's sg_table
      CPU: 0 UID: 0 PID: 48 Comm: iio-dmabuf Not tainted 7.3.0-rc4+ #2 VOLUNTARY
      Hardware name: Xilinx Zynq Platform
      Call trace:
       unwind_backtrace from show_stack+0x10/0x14
       show_stack from dump_stack_lvl+0x54/0x68
       dump_stack_lvl from sg_nents_for_len+0xd8/0xe4
       sg_nents_for_len from iio_dmaengine_buffer_submit_block+0x4c/0x33c
       iio_dmaengine_buffer_submit_block from iio_dma_buffer_submit_block.part.0+0x5c/0x104
       iio_dma_buffer_submit_block.part.0 from iio_dma_buffer_enqueue_dmabuf+0x68/0xa0
       iio_dma_buffer_enqueue_dmabuf from iio_buffer_chrdev_ioctl+0x520/0x9a4
       iio_buffer_chrdev_ioctl from sys_ioctl+0x460/0x914
       sys_ioctl from ret_fast_syscall+0x0/0x4c
    
    x86_64 with intel-iommu, xHCI and a SUR40, capture into udmabuf
    buffers. This kernel had a one-line test-only change in sur40 that
    makes the vb2 queue use the USB controller's DMA device. There was no
    report during boot. The capture gives one, from sg_page() in
    iommu_dma_map_sg():
    
      DMA-BUF: importer used the CPU side of an exporter's sg_table
      CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 7.3.0-rc4+ #5 PREEMPT(lazy)
      Workqueue: events_freezable input_dev_poller_work
      Call Trace:
       <TASK>
       dump_stack_lvl+0x4d/0x70
       iommu_dma_map_sg+0x4c0/0x1010
       __dma_map_sg_attrs+0x254/0x3b0
       dma_map_sg_attrs+0xe/0x20
       usb_hcd_map_urb_for_dma+0x7e0/0x1620
       usb_hcd_submit_urb+0x162/0x1af0
       usb_sg_wait+0x17c/0x550
       sur40_poll+0xb3e/0xff0
       input_dev_poller_work+0x54/0x90
       process_one_work+0x692/0xf90
       [...]
    
    The capture did not finish in this setup. The guest stalled in
    xhci_queue_bulk_tx() after the report, so this run only shows the
    report.
    
    The SG_DMA_* defines move up in scatterlist.h because sg_page() needs
    the new one.

 drivers/dma-buf/Kconfig     | 23 +++++++++++++++++++
 drivers/dma-buf/dma-buf.c   | 44 ++++++++++++++++++++++++++++++++++++-
 include/linux/scatterlist.h | 26 +++++++++++++++++++---
 lib/scatterlist.c           | 22 +++++++++++++++++++
 lib/sg_split.c              |  2 ++
 5 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index e4f078a326a4..06177465091a 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -49,6 +49,29 @@ config DMABUF_DEBUG
 	  exporters. Specifically it validates that importers do not peek at the
 	  underlying struct page when they import a buffer.
 
+config DMABUF_DEBUG_WARN
+	bool "Warn instead of hiding the pages from DMA-BUF importers"
+	depends on DMABUF_DEBUG
+	select NEED_SG_DMA_FLAGS
+	help
+	  DMABUF_DEBUG normally hands importers a copy of the exporter's
+	  sg_table without the struct page pointers, so that an importer which
+	  uses them fails early.
+
+	  With this option the copy keeps the pages, offsets and lengths and is
+	  only marked. sg_page() and the helpers built on it, sg_nents_for_len()
+	  and sg_split() then print a rate limited message with a stack trace
+	  when they are used on such a table. The access itself continues
+	  instead of failing because the fields were cleared. The message is
+	  not a WARN(): it does not taint the kernel or trigger panic_on_warn.
+
+	  Importers that read sg->offset or sg->length directly are not
+	  noticed. The option adds a test to every sg_page() call. It selects
+	  NEED_SG_DMA_FLAGS, which adds dma_flags and may increase the size of
+	  struct scatterlist.
+
+	  If unsure, say N.
+
 config DMABUF_KUNIT_TEST
 	tristate "KUnit tests for DMA-BUF" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index b3d311acb883..bd82b6b7f5ff 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -57,6 +57,7 @@
 struct dma_buf_sg_table_wrapper {
 	struct sg_table *original;
 	struct sg_table wrapper;
+	unsigned int alloc_nents;
 };
 
 static inline int is_dma_buf_file(struct file *);
@@ -874,11 +875,42 @@ void dma_buf_put(struct dma_buf *dmabuf)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
 
+#ifdef CONFIG_DMABUF_DEBUG_WARN
+/*
+ * Warn mode: the importer also gets the CPU side of the exporter's table,
+ * marked so that sg_page() and friends can report who uses it.
+ */
+static void dma_buf_wrap_cpu_side(struct sg_table *to, struct sg_table *from)
+{
+	struct scatterlist *to_sg, *from_sg;
+	int i;
+
+	for_each_sgtable_sg(to, to_sg, i)
+		to_sg->dma_flags |= SG_DMA_DMABUF_DEBUG;
+
+	to_sg = to->sgl;
+	for_each_sgtable_sg(from, from_sg, i) {
+		sg_assign_page(to_sg, sg_page(from_sg));
+		to_sg->offset = from_sg->offset;
+		to_sg->length = from_sg->length;
+		to_sg = sg_next(to_sg);
+	}
+
+	to->nents = from->nents;
+	to->orig_nents = from->orig_nents;
+}
+#else
+static void dma_buf_wrap_cpu_side(struct sg_table *to, struct sg_table *from)
+{
+}
+#endif
+
 static int dma_buf_wrap_sg_table(struct sg_table **sg_table)
 {
 	struct scatterlist *to_sg, *from_sg;
 	struct sg_table *from = *sg_table;
 	struct dma_buf_sg_table_wrapper *to;
+	unsigned int nents = from->nents;
 	int i, ret;
 
 	if (!IS_ENABLED(CONFIG_DMABUF_DEBUG))
@@ -888,14 +920,21 @@ static int dma_buf_wrap_sg_table(struct sg_table **sg_table)
 	 * To catch abuse of the underlying struct page by importers copy the
 	 * sg_table without copying the page_link and give only the copy back to
 	 * the importer.
+	 *
+	 * With DMABUF_DEBUG_WARN the copy keeps the CPU side, which can have
+	 * more entries than the DMA side.
 	 */
 	to = kzalloc_obj(*to);
 	if (!to)
 		return -ENOMEM;
 
-	ret = sg_alloc_table(&to->wrapper, from->nents, GFP_KERNEL);
+	if (IS_ENABLED(CONFIG_DMABUF_DEBUG_WARN))
+		nents = max(nents, from->orig_nents);
+
+	ret = sg_alloc_table(&to->wrapper, nents, GFP_KERNEL);
 	if (ret)
 		goto free_to;
+	to->alloc_nents = nents;
 
 	to_sg = to->wrapper.sgl;
 	for_each_sgtable_dma_sg(from, from_sg, i) {
@@ -910,6 +949,7 @@ static int dma_buf_wrap_sg_table(struct sg_table **sg_table)
 #endif
 		to_sg = sg_next(to_sg);
 	}
+	dma_buf_wrap_cpu_side(&to->wrapper, from);
 
 	to->original = from;
 	*sg_table = &to->wrapper;
@@ -929,6 +969,8 @@ static void dma_buf_unwrap_sg_table(struct sg_table **sg_table)
 
 	copy = container_of(*sg_table, typeof(*copy), wrapper);
 	*sg_table = copy->original;
+	/* sg_free_table() needs the number of allocated entries */
+	copy->wrapper.orig_nents = copy->alloc_nents;
 	sg_free_table(&copy->wrapper);
 	kfree(copy);
 }
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 6de1a2434299..5dc8c134ca4c 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -21,6 +21,13 @@ struct scatterlist {
 #endif
 };
 
+/* Bits in dma_flags, see below. sg_page() needs SG_DMA_DMABUF_DEBUG. */
+#ifdef CONFIG_NEED_SG_DMA_FLAGS
+#define SG_DMA_BUS_ADDRESS	(1 << 0)
+#define SG_DMA_SWIOTLB		(1 << 1)
+#define SG_DMA_DMABUF_DEBUG	(1 << 2)
+#endif
+
 /*
  * These macros should be used after a dma_map_sg call has been done
  * to get bus addresses of each of the SG entries and their lengths.
@@ -188,11 +195,27 @@ static inline void sg_set_folio(struct scatterlist *sg, struct folio *folio,
 	sg->length = len;
 }
 
+#ifdef CONFIG_DMABUF_DEBUG_WARN
+void sg_dmabuf_cpu_access_warn(void);
+
+/* Report use of the CPU side of a table that a DMA-BUF importer was given */
+static inline void sg_dmabuf_cpu_access_check(struct scatterlist *sg)
+{
+	if (unlikely(sg->dma_flags & SG_DMA_DMABUF_DEBUG))
+		sg_dmabuf_cpu_access_warn();
+}
+#else
+static inline void sg_dmabuf_cpu_access_check(struct scatterlist *sg)
+{
+}
+#endif
+
 static inline struct page *sg_page(struct scatterlist *sg)
 {
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg_is_chain(sg));
 #endif
+	sg_dmabuf_cpu_access_check(sg);
 	return (struct page *)((sg)->page_link & ~SG_PAGE_LINK_MASK);
 }
 
@@ -303,9 +326,6 @@ static inline void sg_unmark_end(struct scatterlist *sg)
  */
 #ifdef CONFIG_NEED_SG_DMA_FLAGS
 
-#define SG_DMA_BUS_ADDRESS	(1 << 0)
-#define SG_DMA_SWIOTLB		(1 << 1)
-
 /**
  * sg_dma_is_bus_address - Return whether a given segment was marked
  *			   as a bus address
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 6ea40d2e6247..55a3697df881 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -12,6 +12,27 @@
 #include <linux/bvec.h>
 #include <linux/uio.h>
 #include <linux/folio_queue.h>
+#include <linux/printk.h>
+#include <linux/ratelimit.h>
+
+#ifdef CONFIG_DMABUF_DEBUG_WARN
+/*
+ * Not a WARN(): a wrong importer must not taint the kernel or trigger
+ * panic_on_warn. sg_page() is mostly reached through DMA or scatterlist
+ * helpers, so the stack trace is what identifies the importer.
+ */
+void sg_dmabuf_cpu_access_warn(void)
+{
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL, 1);
+
+	if (!__ratelimit(&rs))
+		return;
+
+	pr_warn("DMA-BUF: importer used the CPU side of an exporter's sg_table\n");
+	dump_stack_lvl(KERN_WARNING);
+}
+EXPORT_SYMBOL(sg_dmabuf_cpu_access_warn);
+#endif
 
 /**
  * sg_nents - return total count of entries in scatterlist
@@ -54,6 +75,7 @@ int sg_nents_for_len(struct scatterlist *sg, u64 len)
 		return 0;
 
 	for (nents = 0, total = 0; sg; sg = sg_next(sg)) {
+		sg_dmabuf_cpu_access_check(sg);
 		nents++;
 		total += sg->length;
 		if (total >= len)
diff --git a/lib/sg_split.c b/lib/sg_split.c
index 24e8f5e48e63..cbbc7f9a206d 100644
--- a/lib/sg_split.c
+++ b/lib/sg_split.c
@@ -33,6 +33,8 @@ static int sg_calculate_split(struct scatterlist *in, int nents, int nb_splits,
 	}
 
 	for_each_sg(in, sg, nents, i) {
+		if (!mapped)
+			sg_dmabuf_cpu_access_check(sg);
 		sglen = mapped ? sg_dma_len(sg) : sg->length;
 		if (skip > sglen) {
 			skip -= sglen;
-- 
2.53.0

