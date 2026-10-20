Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A816960A3810
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qOEMvf2J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120EC10F280;
	Tue, 20 Oct 2026 06:38:34 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9272C10F278
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:38:27 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so1808476f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792478306; x=1793083106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=54nP+hVnBR38qJFAJ37FPqemtxXLBnXTchrtQmC7INs=;
 b=qOEMvf2JiecqQwcZEWirXzw9wfEFJwDpOBVwvQMILm4NT4XOTl1CVfgbrb2VYqwufL
 MeGW53ylFAJz1GfH+5fcyyxSWYQaj+NIYqDPTsGPh9mXagcEXzJPk5073070YYyxdrJk
 iMpBeO7JbsjXOXEQzF98BIv7e+6OTbqxwpjmgw29XW0KLlK76cFORG0L6QJ+mtMj0eAi
 DWlJFplLtjeswvFVZ4i9BK4Xw9ETMHhRvj+pj/IIGBBytN1U4YfqPOtmSsSw0Qvnnko5
 BXIjdkB8OdsY+730y/xD/9H4lAVX3XlL7zaQPJ5QHvMaJ9m4zZv+tf0aokvCMcoFhjZy
 VHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792478306; x=1793083106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=54nP+hVnBR38qJFAJ37FPqemtxXLBnXTchrtQmC7INs=;
 b=L5bYHBy2qtCpWm7e6ilMZd/HmtsjSVfdCV4D/0Sn+mXHBEaEa5jpXVohLHtq6Tpkcw
 E06iE4m5g4JJQ46LNlzElKxQhyrjsgOkDqEInZFfYMxeDSOqDjRsHg8mPsajg4vGlcqp
 8h+bnYTOyZzAoqgvp7Xlr+P+dehVxl5ZBm1n7KqqHsrWUAGUAxYmrMe3QAlJvIiLrh/v
 IBlWjARncqbeuoHX65VDpVrMBUVWkEtf2hNzNd3PsVvo+acqsF9jMxUC+mNNUoagljXu
 8ALBE4DTNGrraMY/jl+1osiz3fWIgObR0pKyPL1dHuxSmrBqZQw+4DEHeVI48Y/pRKPB
 0IuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxf2IFhG3LZMOTC7aoOCX9ZR7B6iGmv2zM0eNNhnV35S9Z+ijbDijMK+yKtcwyL6konQMdzGFEFoiM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKpDR2TE4UcRED077gPJ+zv0Zh15CEkn/octG44s6lYMc+gpTFA
 p30Ft7jotJtGN4qFa6jqssBp7Q9QMhL3WEnv9Pnoi89JRiL1W7v2YrRi
X-Gm-Gg: AYBFou3r5SWJ50clZSV5QnXgAel4RPiLm9FeBykA+7Lxp/SkRzvTlOnTXOPBG1AJuWi
 fHiIJs2otiErK2yVdGwfUWAvcXx7gR2Pa2khU0sZn7Zth4zNzO3BrAP6dc6ob0JE4bVpYmh4Bl/
 zS++pzU4oSTyTw/JQ9GJWhP9E1Kfj1fgrxWCfyBqsnLjbYop3spzL5ps/VYxqqrK3k7bMTF5myt
 6AptkbpxSNMEv4wAkSP2v4KrZX4TO6BwU17NkXqpGDPHY6uxu5ktZSOaIj/31Av2xPKS9tXZ1d9
 JplrfS8RkLiqL/amIYZUO5Gbg9mWu6JwgRUxqZ55jXCzLguJJmGiy1HBgDQkmgB6q80smm3Hvxv
 qoNRXqinsT9OThyXySGq/9dxRdX6y0VqhGwBU7vIJFOgciKQ28w75ra6PfOVFPadE3ucayyaLjQ
 nFtmvouvZYmUsWw0DqAix6TUlSm/w1xZ9yJcv5tMvq9/fqcobThBPXaSNOzNl02QvcztcLGoJRS
 uA2YQCW4ZLPy4GruLNPq0KJv8G2EZfaXXTTwyTIXfbLUZRClAn3uVuODl0opO36L8Dg6S+aFBPe
 u7cUZzejgUT8KANRRVSdYkITTUVZAZu8z+A1ElAoqhuV2RZow1ryMtw8bwSwd+uixFWNHTkJCxu
 /7glzWGh6tNaN
X-Received: by 2002:a05:6000:1e4f:b0:48e:412:3829 with SMTP id
 ffacd0b85a97d-48e07fb2b18mr14486670f8f.15.1792478305848; 
 Mon, 19 Oct 2026 23:38:25 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de.
 [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Oct 2026 23:38:25 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH 2/6] iommufd: Publish successful PAL mappings under resv
Date: Tue, 20 Oct 2026 08:37:41 +0200
Message-Id: <10fbbfdbf3a19fff48e504bcf5ec3a74f11bfd7c.1792477872.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1792477872.git.kmehltretter@gmail.com>
References: <cover.1792477872.git.kmehltretter@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

iopt_map_dmabuf() stores the PAL map result in exp_phys before checking
for errors and publishes the attachment after dropping resv. The
attachment is already linked to the DMA-buf. An invalidation after the
unlock can therefore pass a NULL attachment to dma_buf_pal_unmap_phys().
On map failure, the non-NULL error pointer also looks like a live mapping
to iopt_dmabuf_revoked().

Keep the map result local until it succeeds. Publish the attachment and
physical list together before dropping resv, leaving exp_phys NULL on
failure.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 0b32c65af..9e9bc6a1c 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1491,6 +1491,7 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
 {
 	struct dma_buf_mapping_match pal_match[] = { DMA_BUF_IMAPPING_PAL() };
 	struct dma_buf_attachment *attach;
+	struct dma_buf_phys_list *phys;
 	int rc;
 
 	attach = dma_buf_mapping_attach(dmabuf, pal_match,
@@ -1513,16 +1514,16 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
 	if (rc)
 		goto err_detach;
 
-	pages->dmabuf.exp_phys = dma_buf_pal_map_phys(attach);
-	if (IS_ERR(pages->dmabuf.exp_phys)) {
-		rc = PTR_ERR(pages->dmabuf.exp_phys);
+	phys = dma_buf_pal_map_phys(attach);
+	if (IS_ERR(phys)) {
+		rc = PTR_ERR(phys);
 		goto err_unpin;
 	}
 
-	dma_resv_unlock(dmabuf->resv);
-
 	/* On success iopt_release_pages() will detach and put the dmabuf. */
 	pages->dmabuf.attach = attach;
+	pages->dmabuf.exp_phys = phys;
+	dma_resv_unlock(dmabuf->resv);
 	return 0;
 
 err_unpin:
-- 
2.39.5 (Apple Git-154)

