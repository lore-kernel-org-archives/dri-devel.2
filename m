Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D457ACD98DC
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7487A10E0C7;
	Sun, 14 Jun 2026 15:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jeY54yEv";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA0510EAA1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:28:14 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2bf18c30bb2so9961555ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781281694; x=1781886494; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jAxTBIOEmfhpqt503+PoPJMs1ii7LUEnvcbZDbUBB0A=;
 b=jeY54yEv89rzjy4Xcrhsp79TSEZ0+Um/vx+pg6O2W6tN9ZZaWzCYycxydyUyU3uZ1k
 pOvBLPk+MmXBJPpF/YVWebcKcz+jWQtWjUzWMgbzlVFUOHAQIc69UKD0nse8hlaQ9HVF
 6qAopHxDnfvWuPoEzWllKpnTSCdisqGjdjlduuZviRu6Vlzr0k0xzpsoaAbt7kzD0uvq
 vTPr79Ij4dyAxJiYtnREwGzGWilXhLxuE6oQoW5UTJORBk0JT7vn9b7zvtS2kZhXOHVY
 N9DfKyqRH37Z2MgF4tZkcFoihEbKv5dvmphkvCVbHHQVcg9ep2owTFp3tLvRi++uNxg2
 ldaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781281694; x=1781886494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jAxTBIOEmfhpqt503+PoPJMs1ii7LUEnvcbZDbUBB0A=;
 b=mXIg13nZAYROFK8hMCaPTT5xgSmBwcfqXWkHWduqJ24Kv0fbo9A7buBpRQ6ZNh/8gV
 VfLUsvrCje8O+YKNueW8Je53eXnyS+vZGYh2QXixn4brLpnQZftzDSzkS6JOUbhLUzP1
 A65fR7Gq9JWQUZ1itCe96Yxx3MqGYFuS6VaIkudP+n0IkbCUkDLzRviBIJ6wFE92hUlN
 EXD0vM99sVhM+vJuw3jLrmeEMxmxcGGO3GMqlrFrim5kP7GyHzFZxL4OnzGyAin+y8kV
 XW/MhIWYrp41Z4SwJbQy6iAXUCgcCJbwg6kOVoNTLt7FW1BRwqqg1pq9fBxXJ3KhpJdj
 hCvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8y7SbzLY5fU7wyfG5tQ9hxvJFdlwOZEH65Gh2H1y9ZEMQK3h3g20B3wSDQ84Zinl3xHlsY9UW7lAw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfU2GE2DxBR6P/w7fslOShtuJlhyjiYTL6WV+X2uBCE4CkBzWZ
 ACngjDrMp4hOhdtCePQZxCGTSLN5hQGD9gsz1OPpBqsFDAquye95l/Bb
X-Gm-Gg: Acq92OGNzrEMKXfbodfAO9mpplNuD2a1FVo2qyzg2F3Yz5WIHrvQFzFOd5RKl4EJyye
 LBCO1Ho8PfPSrWSNP56GseZBr1t1h0NwEA0Wi9gehaw6TNitJiExV0GUOLkwLoe0JIkyINE6gtO
 1SxNiJvnFCpTwv+sCuBlyaznJlGMVyNr8ltmQ3GMlIKvVFpzECgUJmQtPIb+ygktpsTteaAFkdz
 Ba0p/HB3l2jhoi4VTVeUtE4C9MAwuuLfZM9vqrxe86AjIMFCCmU7lG1+oBTEhMI+HphOxiJyOqj
 D9tzSGdSXVW87HiwQis3Y/nXha1WeI+tAeJH5rjpfUSWGSRoUKVRd7JVWdFhhN7E09Mb+y5P6X3
 A4ccYzu9i5NFTjoOxdCuIIOZDRJTseF2u4G7UcOlOjXj+OzHjQ75Z30xpA0NRWRoTS05H57WKsT
 I4Go5CHNY3K1JkCbvRt2lpdYHmYzIYFQ==
X-Received: by 2002:a17:903:1acb:b0:2c2:7e17:39f6 with SMTP id
 d9443c01a7336-2c6642c3dd5mr3387595ad.36.1781281693627; 
 Fri, 12 Jun 2026 09:28:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e586bsm26830975ad.12.2026.06.12.09.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:28:13 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 12 Jun 2026 09:25:58 -0700
Subject: [PATCH net-next v3 2/4] udmabuf: emit one sg entry per pinned
 folio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-tcpdm-large-niovs-v3-2-a3b693e76fcb@meta.com>
References: <20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com>
In-Reply-To: <20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, 
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net, 
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com, 
 dw@davidwei.uk, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 14 Jun 2026 15:44:15 +0000
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

From: Bobby Eshleman <bobbyeshleman@meta.com>

get_sg_table() emitted one PAGE_SIZE sg entry per page even when the
underlying folio was larger.

Instead, walk folios[] and emit one sg entry per folio. When folios
represent large pages (as is for MFD_HUGETLB), each sg entry is a large
page. Normal PAGE_SIZE sg tables are unchanged.

This is helpful for importers like net/core/devmem that expect dmabuf sg
entries to be size and length aligned. Prior to this patch udmabuf
handed over one PAGE_SIZE sg entry per page, so devmem only saw
PAGE_SIZE chunks regardless of the underlying folio size.

dma_map_sgtable() does not always merge contiguous pages for us, so we
do this internally before exporting.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/dma-buf/udmabuf.c | 52 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 94b8ecb892bb..9b751dd98b12 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -141,26 +141,68 @@ static void vunmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
 	vm_unmap_ram(map->vaddr, ubuf->pagecount);
 }
 
+/* Return the number of contiguous pages backed by the folio at @i.
+ * A udmabuf may map only part of a folio, or reference the same folio
+ * in multiple non-contiguous runs, so folio_nr_pages() can't be used.
+ */
+static pgoff_t udmabuf_folio_nr_pages(struct udmabuf *ubuf, pgoff_t i)
+{
+	struct folio *f = ubuf->folios[i];
+	pgoff_t j;
+
+	for (j = 1; i + j < ubuf->pagecount; j++) {
+		if (ubuf->folios[i + j] != f)
+			break;
+		/* Same folio, but not a sequential offset within it. */
+		if (ubuf->offsets[i + j] != ubuf->offsets[i] + j * PAGE_SIZE)
+			break;
+	}
+	return j;
+}
+
+/* Count the contiguous folio runs in @ubuf, one sg entry per run.
+ *
+ * Coalescing folios into a single sg entry up front lets importers actually
+ * see large chunks. We can't rely on dma_map_sgtable() to do this for us as
+ * the dma_map_direct() path preserves the input scatterlist lengths verbatim.
+ */
+static unsigned int udmabuf_sg_nents(struct udmabuf *ubuf)
+{
+	unsigned int nents = 0;
+	pgoff_t i;
+
+	for (i = 0; i < ubuf->pagecount; i += udmabuf_folio_nr_pages(ubuf, i))
+		nents++;
+	return nents;
+}
+
 static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 				     enum dma_data_direction direction)
 {
 	struct udmabuf *ubuf = buf->priv;
-	struct sg_table *sg;
 	struct scatterlist *sgl;
-	unsigned int i = 0;
+	struct sg_table *sg;
+	pgoff_t i, run;
+	unsigned int nents;
 	int ret;
 
+	nents = udmabuf_sg_nents(ubuf);
+
 	sg = kzalloc_obj(*sg);
 	if (!sg)
 		return ERR_PTR(-ENOMEM);
 
-	ret = sg_alloc_table(sg, ubuf->pagecount, GFP_KERNEL);
+	ret = sg_alloc_table(sg, nents, GFP_KERNEL);
 	if (ret < 0)
 		goto err_alloc;
 
-	for_each_sg(sg->sgl, sgl, ubuf->pagecount, i)
-		sg_set_folio(sgl, ubuf->folios[i], PAGE_SIZE,
+	sgl = sg->sgl;
+	for (i = 0; i < ubuf->pagecount; i += run) {
+		run = udmabuf_folio_nr_pages(ubuf, i);
+		sg_set_folio(sgl, ubuf->folios[i], run << PAGE_SHIFT,
 			     ubuf->offsets[i]);
+		sgl = sg_next(sgl);
+	}
 
 	ret = dma_map_sgtable(dev, sg, direction, 0);
 	if (ret < 0)

-- 
2.53.0-Meta

