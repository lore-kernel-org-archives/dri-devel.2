Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAACCA5FE2
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84D7010EB78;
	Mon,  5 Oct 2026 06:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wbc+5GEC";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2445B10EB78
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 06:46:55 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso13490485e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 23:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791182813; x=1791787613; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G3p/ksaVF9bUxZ/l44uSSprnNI0BM8HQrDHB2YvnRV0=;
 b=Wbc+5GECfiykFz7vpwV6loATocKEwTkvcVdjjeqv2kJYZnModb9W0qt/kE4+N2cUGS
 FBHimMBLRCpMFN/2nzKngjlk1/H55clUdCSXVh8/Qf9SnD52lbKPn35EZMJZN0h6I6Oo
 vlMk/FHlucG6wogcnmDh+/J7OGIBNBOQ7JUSabQVgYBviedub7N6GhJuuha3h0oTJjcC
 6bJc/vF207ntJuagh1gMZOdodRFxboHbwrHfNutyLXHiAh7yb5sIo+jhAiVFerV9VUPb
 pnW7r7SApYJbqtSaH1oeCG9tsk2R5Hh4V/aptW3S8lQ8gPXWAlKzLk/uvXDDHMTPkC5y
 SDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791182813; x=1791787613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G3p/ksaVF9bUxZ/l44uSSprnNI0BM8HQrDHB2YvnRV0=;
 b=AP3eeLm8Gt67Z19cE9grq4l4C6Ipmi2ZGM1NdEhTmRJZ1xbBchigPKnpMY4J66IjPL
 akIO74lar/L0cGmS2d2vgzWPZy7pkGrp28Kio91q28qepOKD+hG/+hNbb34gbGBa6BCW
 YiMJd6D87otuXNPHRF8oirmA7CACFLLfnBgikRYORf5qNhfQrI6AA5LDi+bIrxpDs5Su
 9R8eCW3qah+muIgOXHxVq+PeNTZXiL+9eowpWla197Jced1WAZcLbsbHJmzAR1c92g8c
 23c5xOeGw7V7DEvXgDNf1+fmI/Po9XpqsyeBTe6wbmmI9SQGVXjOQRZI2wm+wBP3EgSz
 EpAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmuO0fSooEAgUKQNiEZeQGBaJcnR0udY1P3Hx1Fc6eu5LnBiw1Mz1pyJDCyZ3g4vYDSgEDPsrwueE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mrCVy4YirQY07dCcgdPPTBK7aOW8I71uUDXisRpezjPxMBAGrD
 iLUyQyN+YamuILuf0yG0ZJTPIuiEMJiBIlrTxTBi3CqqkXD53s67cXl5
X-Gm-Gg: AYBFou1IbvC+gf5W55SF+aKU7S6eoovW8uYl2GZIrucu+zBNwVnMchrbFQ7Vdj10DOk
 o9H0KfM1uJjhNkteNBAGVM5UlOUsjOZmnXan0ZjOQ2+B7Ev2mDUoCBIdA533qzV0BBQjHKH9gKk
 Lnhw9WHFrHqXZ+OPPxanHCzPZqcAsJRl/sXueq1ZPTkqlL6DSU4VpSizXfC7cd4UK2XkaSbWNwS
 pk53kXkiuKUTFpT5bU7vFNGcqe2F3XgGGddo5lekfA2yRBVeSrttzbvh+bLrk2G8ys/CtT+1ZdX
 SjLDh5Zq3TIad7Y5tYlpEYKA8Ydw6FeZC4YfrgY9Pd0PSYGtGlUQQ9ecGOy2ijFAvdtQk4M7Ydy
 8c6hqVZiGvJrrvDo2dtZ9x4EM4szetf5pu2TwleDMjVabmM50xwO0SWUpdSPEAV7FmeaM/j5Z+l
 oN6KyVO9SzgSyJFCP6pdJr/kpf1SLjMBpwHNAZYGCfTaMLMPsSNhj5IIIfU3mc2oBl9K8gYFknG
 Chceju3ntsUYdMRjCjrwAXQ5MZg1DvhjpjxSG9AMk2V5r8MjBxCE+8qFzMzVEUojtD8L4I0rLTi
 0m+QwH7YJcYXjp2WP/N4moW4aZ/QZaiF6laPkiDuDsz25ko+Lt5vpJVi/ZxtYCObRBGgcYbPYLZ
 8lg==
X-Received: by 2002:a05:600c:4e13:b0:4a1:7367:5395 with SMTP id
 5b1f17b1804b1-4a173675558mr17104845e9.2.1791182813344; 
 Sun, 04 Oct 2026 23:46:53 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de.
 [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027741586sm315273615e9.14.2026.10.04.23.46.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 04 Oct 2026 23:46:52 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Dmitry Osipenko <digetx@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Russell King <linux@armlinux.org.uk>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dma-buf: heaps: cma: respect the device's maximum segment
 size
Date: Mon,  5 Oct 2026 08:46:40 +0200
Message-Id: <20261005064640.7776-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261005064640.7776-1-kmehltretter@gmail.com>
References: <20261005064640.7776-1-kmehltretter@gmail.com>
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

cma_heap_attach() merges the physically contiguous buffer into one
scatterlist entry without considering the importing device's maximum
segment size. With DMA_API_DEBUG, importing a buffer larger than that
limit reports, here with atmel-hlcdc:

  DMA-API: atmel-hlcdc-display-controller atmel-hlcdc-dc: mapping sg
  segment longer than device claims to support [len=307200] [max=65536]

Build each attachment table using the importing device's segment limit.
Return -EINVAL if the limit is smaller than PAGE_SIZE because the
page-based allocator cannot honor it.

An importer that needs the whole buffer as one entry has to declare a
segment size that covers it. tegra-vde without an IOMMU domain and
armada did not. Their limits must be raised before this change is
applied.

Reproduced with a custom QEMU model of the SAM9X75 Curiosity. Not
tested on real hardware.

Fixes: b61614ec318a ("dma-buf: heaps: Add CMA heap to dmabuf heaps")
Cc: stable+noautosel@kernel.org # needs the tegra-vde and armada segment size changes first
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    Tested on v7.3-rc4-70-gfe2ec83746e5 with DMA_API_DEBUG and
    DMABUF_DEBUG, on a custom QEMU model of the SAM9X75 Curiosity
    (ARM926EJ-S, TCG) with an XLCDC model.
    
    vivid captures into three 307200-byte CMA heap buffers, which
    atmel-hlcdc imports and scans out. All 8 frames are shown before and
    after the patch, with 3 DMA-API reports before and none after.
    
    A test importer maps a 256 KiB CMA heap buffer with different
    maximum segment sizes (4 KiB pages):
    
      max segment (bytes)   before         after
      2048                  1 x 256 KiB    attach returns -EINVAL
      4096                  1 x 256 KiB    64 x 4 KiB
      65536                 1 x 256 KiB    4 x 64 KiB
      UINT_MAX              1 x 256 KiB    1 x 256 KiB
    
    The first three cases gave a DMA-API report before the patch and
    none after it.

 drivers/dma-buf/heaps/cma_heap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 3fb4b946c91a..9d61d14688b8 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -58,16 +58,22 @@ static int cma_heap_attach(struct dma_buf *dmabuf,
 {
 	struct cma_heap_buffer *buffer = dmabuf->priv;
 	struct dma_heap_attachment *a;
+	unsigned int max_segment;
 	int ret;
 
+	max_segment = dma_get_max_seg_size(attachment->dev);
+	/* The SG allocator requires a segment limit of at least PAGE_SIZE. */
+	if (max_segment < PAGE_SIZE)
+		return -EINVAL;
+
 	a = kzalloc_obj(*a);
 	if (!a)
 		return -ENOMEM;
 
-	ret = sg_alloc_table_from_pages(&a->table, buffer->pages,
-					buffer->pagecount, 0,
-					buffer->pagecount << PAGE_SHIFT,
-					GFP_KERNEL);
+	ret = sg_alloc_table_from_pages_segment(&a->table, buffer->pages,
+						buffer->pagecount, 0,
+						buffer->pagecount << PAGE_SHIFT,
+						max_segment, GFP_KERNEL);
 	if (ret) {
 		kfree(a);
 		return ret;
-- 
2.53.0

