Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAE2CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 07:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E2211270F;
	Thu,  4 Jun 2026 07:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N6Mj06Zk";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A611124F6
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 00:43:08 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8424b6792efso33880b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 17:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780533788; x=1781138588; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vsTKuujCl0cTIDmjasTaeO7+rGb2Yh+GT+02Pw0KJmo=;
 b=N6Mj06Zk5uXMAyhTxx7bV7k/pDSLJHJJDwe69Nmz21hwmjHRwom/sVRqyKCWU2N6Wg
 lI+iOaQFwCwXXQrEjgG6NdPUv9cTJ+AnT1AxjD3BlZHYVw1tj29HbvdlYds4m739AOVT
 BL02KnQ/IGsosJ8Mn41UbAJNwgGETqa+7fyH8xRvM6+tV3pQ/VfESK2TiNGDY93GkqYK
 oYKGZ1f4cJqxLIOvFyC0KDV7/YCUF62bWNmFmCCY0SMeeTXPl0VHsz9rahWyXPo9W9WT
 PCzAMcQqfep9pmprciqkJLYjsjMmQD8hS5FBujH7y8ZDxOgHW1gs/KoD54m0oDTOqS3w
 W+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780533788; x=1781138588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vsTKuujCl0cTIDmjasTaeO7+rGb2Yh+GT+02Pw0KJmo=;
 b=Ze/9074C4YjHSwLJD1ffpNB6ijekJ1BTXAt991Qr7VuJy1iihYzwOKZK6tMUfAv3c3
 WccFwHINEWPRysPOZUpzcpt5WD+hObSOpEgq5R8vnErQC1Rj6Vp0kRPvCFBjFXO71HzD
 7KBpA/KaChc4O5909bBpnRM0zuonoCrC+cAzvumdVEe8wCmdVADLhQwKR22J58XUYdNd
 ePfYtGsx6VTNUOkx1Dmr5JFzX//kHnv4A2Kbw9rmowP1ka7SGlqKL5etNUvQqcFcJmJ8
 BE6UKctL5i0ZdJ/42WtquIq+YU2EJu7tiZS9nTLCCPEpxbjmfwqXLRysfno+2kvKQAv8
 dcHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ85R+3Kwnh/XNU9B2UBiMfdPqFOzCD5JmAchX3hDyIX1va1sY6rdMXwgbaZeI8tOftIGTUlxGCiNP8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJFQMG6lzNcYsDlDKHhnlD7j3sKeL/1AxWghsflAXiLdnygZTk
 0giYruW5iUi39UT+bNbvlzF+C8a8lQD7Ekw8tzg0Ftl9tjsMN6cHkotj
X-Gm-Gg: Acq92OFtSBDWbcosUdvZOrhdwosbs+cGUur8rbuGPrk2LXJwugmOpq2rV5KGOM0p4zx
 z/e2iW7fNTjstvWG1kmaa3FiY30ApO/LleTB+HBVFLmgpgdROkLJiDnDcG9Nn7Fyxgl63UHGKKA
 /l4w82BIcR5IWuvbPeb/y4dBgAu62pLbVZwCsgoKKgr8hz1ZVPEOR2v7xxkL5e/8+gPKORP8AVX
 XYyFXqdMljcXWpLY/d8e1TcDwk1mf8T7BGCp2D6BMpT3GvazAZn9wD/45StUZOcjenHHSiAWnHH
 ynV9NlcZ5nLzIMHckLD5aS5Fyx+ScotFcy/Qvqm6Z2wIMDk1v7LxrrWBD9GDS4AGgAD/4WI4BDD
 thMNK5+9dvc7OLsy06ws1e07iUZiWhwFAa7rRXnize+R0rgsHpZXc7CB7oqYc5neIXq8vfRhU/x
 TfqBbFtI1k/kVLYa7VvsHtldKiAv/yLQ==
X-Received: by 2002:a05:6a00:139e:b0:842:77ab:35c8 with SMTP id
 d2e1a72fcca58-84284fe7c61mr5429878b3a.44.1780533788133; 
 Wed, 03 Jun 2026 17:43:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:52::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282372502sm4584728b3a.16.2026.06.03.17.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 17:43:07 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 03 Jun 2026 17:42:59 -0700
Subject: [PATCH net-next 2/4] udmabuf: emit one sg entry per pinned folio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-tcpdm-large-niovs-v1-2-f37a4ac6726c@meta.com>
References: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
In-Reply-To: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
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
X-Mailman-Approved-At: Thu, 04 Jun 2026 07:03:30 +0000
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

Required by net/core/devmem to support rx-buf-size > PAGE_SIZE with
udmabuf.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/dma-buf/udmabuf.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 94b8ecb892bb..f28dd3788ada 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -141,26 +141,63 @@ static void vunmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
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
+/* Count the contiguous folio runs in @ubuf, one sg entry per run. */
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

