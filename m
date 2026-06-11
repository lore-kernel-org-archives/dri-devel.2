Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B59CD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C7210F2D2;
	Fri, 12 Jun 2026 07:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="drqIksIR";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A1E10E827
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:17:19 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2bf22d29dabso71775ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781194639; x=1781799439; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jAxTBIOEmfhpqt503+PoPJMs1ii7LUEnvcbZDbUBB0A=;
 b=drqIksIRtQwuXhoWnT/mtLg2VQTF41iuKXecuBcwI8/sSSnslh8lm6fsx6M8yyDdvX
 5wYdfZ4g/lwXUe7IZ49BWf9L6K+9glIAJI2Okp3ikGDrsQo458P8L17Nl+edTkM6bHyf
 59bh+JgRBcvqJWysVG/7pJTcmkp/Ec1db+9amZk48Wc9iVNrE2+v+hT0IbMmp+JRLpf+
 EDJCtyBdG+3NVrvtLUihH9739oECkKt8+TsDX+Geto6jkMYthmIvv54wC6jUXIUpoxMd
 XJhawB/dVrHeEPYMZJJV459s3FL0RU8z8Nxi4WM1YY1s2deP+xOv5ujx437IQ+BavhRy
 AcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781194639; x=1781799439;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jAxTBIOEmfhpqt503+PoPJMs1ii7LUEnvcbZDbUBB0A=;
 b=M/8kFN+3VWk8cUD2CKpokc9om+8LMLI6vd69ccVzyrV7SOG6CsD/zLj4HCnhFhAzcf
 kCyn6jjMaNMOfMUbxYPcjNPb7TgZwfC6/ysKGiMRwZQFQz2dZkEVWC50fxk08aKHXXYJ
 mUcYpQwHoc7GikwuoYPHaZTSNRHhpBuY9vVYiuTZJYsC5jT9Hs5g0rvXpxNWVxna+s8h
 ZG3Bac13DrOd7D9UM95muCIhj48Dgn6uLeskqHbAzLpxlv2YI9dNLg6bkj1XMz9K6S0H
 NGovlZk6JZsKYznMEydkP/E1ZyY5WGlhgOiUhpW57YKjl9dYVVn8FVAm+5Hq3/RnEYzy
 vJbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9H8p9zqMXZUdQiuSQ2GOkqzbiCDk4DBSwZso25vdWPpKRWVDNpxUWCrAn4zEOBJoVuDmjqnCdRhq0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDWMEHzFkIR4feXU1fIhgNfFN3JwmV3lTv7vVMEOr5ck7FZc7V
 B8TEtsFjvbk2xyLCays+0NKI9X0IdbSS2fTJtuMnuHmkOap2SaLoF+2q
X-Gm-Gg: Acq92OFIsCMANrgq7Nu+hdvJi6p/7pJWXyiA4+X+Ftap+RStGNJzP9oJclG3t6vcLxX
 JbGMjZbNJHKLRPahCP0ZxqtQ5goLgOwkFrWxymsfuDFe8NJsEGgakmATUdDOQha/XwbHUuruvRc
 MGrukDK9rJNgf4U/Facpp0RXwhhyZiM8K986h6SexXrAOahsmPsjmuGcIU1z1xddN0rbIM8j495
 WUFul0uTQzwWDVOmfAvYudrlIApazt2f3EYQRo9TN/EUGLJVv6I5mmwACAck4J3qq7hXjZAuvCv
 Be30ZT99mUU+XdDChkVqnc6Pr0Uv5kv4H6LNXwGUafPBrgf1e0pVQKEMMoZTqyEFPlVtuyYheYy
 34B8v1SLzH2/9AIFXc4yLXt/3T265mB0CR1tExdoHvYL72twLU6VVPVVusrKSFX5mwKzwa4j7ua
 4eZBkmpIc/SZ44582KOyg=
X-Received: by 2002:a17:902:c404:b0:2bf:128d:f7ff with SMTP id
 d9443c01a7336-2c2f0932d65mr42009805ad.16.1781194638490; 
 Thu, 11 Jun 2026 09:17:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609e627sm288573265ad.52.2026.06.11.09.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 09:17:18 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 11 Jun 2026 08:28:43 -0700
Subject: [PATCH net-next v2 2/4] udmabuf: emit one sg entry per pinned
 folio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-tcpdm-large-niovs-v2-2-ee2bf15e7523@meta.com>
References: <20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com>
In-Reply-To: <20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com>
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
X-Mailman-Approved-At: Fri, 12 Jun 2026 07:45:54 +0000
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

