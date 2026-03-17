Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49226F3029B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 05:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B440B10E184;
	Tue, 17 Mar 2026 05:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E6eDNSQb";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C0510E184
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 05:37:03 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-59e5aa4ca41so4894284e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 22:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773725822; x=1774330622; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2NiRAQv05vxst//6uLfp/yYFASGq0d9XovqJe++xcxQ=;
 b=E6eDNSQbBqHkF1eEMeRYeimz4vHpdNYhoAZS72KfXtYFsyYuoETA/YAWWPZnD3k05J
 eaXZuwk6MsVpOLF0stc2XXXKxaMP+9DohvaW3CSpWiAzVpUwdqZl1H9ngZe+sBBVNtJR
 230eHtXPKA65uuP4U0helqIF9mtNfuIDzwpCQf9VKGomjLzumScY6JDuXrtlFMbEGflI
 CYtFLzrO3HSu+s2LEKj6WCRw9Q43uLLKbB9VUWk0/M8UKPws8EwP6b1HtHUxchbjrjIX
 hgCxx+7NZhjQdcSOa0CuvM6miNuBdSlSp76nda19bxZBuPYzpN57nqNzNa3cHBXbUJvV
 h99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773725822; x=1774330622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NiRAQv05vxst//6uLfp/yYFASGq0d9XovqJe++xcxQ=;
 b=gz9x5o3ValNp7ZmAHxKwuK6cNbRJSp3iHG2Yk86VOGBSnDa4BKBCfwzXcXpikPsMqu
 OW0KoxuQ6xgQO7AsWxt7LDXg96ghuisabW0TSFpVefoqfq1205Wu9ZzHp5t04n4IT4sl
 5O+wyJ9v35SuKSk/57zwqaAt3isFMzq2wYdPE1cUbcT17OUytuvZ4d/UqWMt0gSebJhj
 WF9emiFtXU/E1smp/K/1/6nVdVUCpWLl/sw2DVNTFD/e3LqB7pgkcxMnC9x9jNz+6zHb
 8ikgpl9TilmBz01Miy6/mT7qytt0tk/dpghMd70gWC/ojkLr0zQi3hcDkB2oiYpVUsI4
 ZYIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgerH3lQUTHnlRVVpI2NtiqJTNC7pY2ZqsmN6N3jpVb2dhlbEMXmk+Au/2FPUzLk6mhjpG8pXOTok=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHqtuTWA9hWVMQk5X5dYF5x4giSfkna5Y5h845/UCavHCj5p6W
 mjXQrg81Fegb3SRUp+ptogCANK+U85nKFQ2/tlT2VPtRSpVUFFN9Qzc7
X-Gm-Gg: ATEYQzyNs8BnldYZOmthCs9Bv8IWxJPux7ezuOvw/jKDy799cxJU8lroqbn9+NlmVcH
 YqbHAQ5zRQygMgtRa2gZFhKdiOo1KWeQXcuNi29tVvnIe9bH6RnT2WVnbmwPls6/iF9ZjRkO3Hu
 RFMpICke65tnd7/0harWzgClYovW9tOhOetVzTeMw2rcSDSx5BBbMBwjoq13Z7FCtWglo/5m9IY
 HtZxoCNn1UBDGCCKSesIvTmxxu8z3ouHNQMZ+QS7Y8vwXU3EZUd2TFBVlK2UhaWyesRTsllbW1G
 IG/nPxRi7aJxs+IFAwgs19Hl/wGksSzwuBWjP9r7D2+HGowdFu7jWOELvFvqHmbZ+xHXzGf6OHo
 eSX/GLwqp0rvL5b+IH1pTaeHeBaw0/wjGh/FGuI2E5W7Fzpe981LrW64LQUCd/trkbHEblx7vrc
 qNK7A7uv71RIoXq5hnkJugzVB8YpSAWE+p8kMiQvMMKpev
X-Received: by 2002:a05:6512:2350:b0:5a1:c03b:7980 with SMTP id
 2adb3069b0e04-5a1c03b7a7dmr186889e87.28.1773725821391; 
 Mon, 16 Mar 2026 22:37:01 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366606sm3958338e87.73.2026.03.16.22.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 22:36:59 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: kraxel@redhat.com,
	vivek.kasireddy@intel.com
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] dma-buf/udmabuf: skip redundant cpu sync to fix cacheline
 EEXIST warning
Date: Tue, 17 Mar 2026 10:36:53 +0500
Message-ID: <20260317053653.28888-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When CONFIG_DMA_API_DEBUG_SG is enabled, importing a udmabuf into a DRM
driver (e.g. amdgpu for video playback in GNOME Videos / Showtime)
triggers a spurious warning:

  DMA-API: amdgpu 0000:03:00.0: cacheline tracking EEXIST, \
      overlapping mappings aren't supported
  WARNING: kernel/dma/debug.c:619 at add_dma_entry+0x473/0x5f0

The call chain is:

  amdgpu_cs_ioctl
   -> amdgpu_ttm_backend_bind
    -> dma_buf_map_attachment
     -> [udmabuf] map_udmabuf -> get_sg_table
      -> dma_map_sgtable(dev, sg, direction, 0)  // attrs=0
       -> debug_dma_map_sg -> add_dma_entry -> EEXIST

This happens because udmabuf builds a per-page scatter-gather list via
sg_set_folio().  When begin_cpu_udmabuf() has already created an sg
table mapped for the misc device, and an importer such as amdgpu maps
the same pages for its own device via map_udmabuf(), the DMA debug
infrastructure sees two active mappings whose physical addresses share
cacheline boundaries and warns about the overlap.

The DMA_ATTR_SKIP_CPU_SYNC flag suppresses this check in
add_dma_entry() because it signals that no CPU cache maintenance is
performed at map/unmap time, making the cacheline overlap harmless.

All other major dma-buf exporters already pass this flag:
  - drm_gem_map_dma_buf() passes DMA_ATTR_SKIP_CPU_SYNC
  - amdgpu_dma_buf_map() passes DMA_ATTR_SKIP_CPU_SYNC

The CPU sync at map/unmap time is also redundant for udmabuf:
begin_cpu_udmabuf() and end_cpu_udmabuf() already perform explicit
cache synchronization via dma_sync_sgtable_for_cpu/device() when CPU
access is requested through the dma-buf interface.

Pass DMA_ATTR_SKIP_CPU_SYNC to dma_map_sgtable() and
dma_unmap_sgtable() in udmabuf to suppress the spurious warning and
skip the redundant sync.

Fixes: 284562e1f348 ("udmabuf: implement begin_cpu_access/end_cpu_access hooks")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/dma-buf/udmabuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 94b8ecb892bb..9c6f8785a28a 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -162,7 +162,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 		sg_set_folio(sgl, ubuf->folios[i], PAGE_SIZE,
 			     ubuf->offsets[i]);
 
-	ret = dma_map_sgtable(dev, sg, direction, 0);
+	ret = dma_map_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	if (ret < 0)
 		goto err_map;
 	return sg;
@@ -177,7 +177,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 static void put_sg_table(struct device *dev, struct sg_table *sg,
 			 enum dma_data_direction direction)
 {
-	dma_unmap_sgtable(dev, sg, direction, 0);
+	dma_unmap_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sg);
 	kfree(sg);
 }
-- 
2.53.0

