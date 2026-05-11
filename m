Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C2DCD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 21:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0222010E8FC;
	Mon, 11 May 2026 21:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="GIaVs4ZQ";
	dkim-atps=neutral
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA3B410E8FC
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 21:42:46 +0000 (UTC)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8ae752c5273so102435756d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778535765; x=1779140565;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yA1gek3HR3At3Q9DFaDVVLNqwF2oJxAWcK0srTpOdyw=;
 b=GIaVs4ZQ7hp1l2I7rI3PmcRPzCZC5EFQ8MyrF5lHw4gBfPRJPaRD390DWVVi1IiR9i
 0fLQFb/c/uqBFsaH4oOdsEiQb8oPKMS7vLODiLC4w8bv019jtr9xkwHs33/sVXc8S93Q
 fu5nH8RM1ShLpVnssM4YU1RWNXLiItYGLGjRmNc91ykRWaazwD67kaIv6yN0ZpOOS0U4
 M/gTDVPjc7EcRfeRfe9ZEFWEudT11BRx/qBlBGDSGRoEQNKGJrpCxiCbV/k3MO6bb+4Y
 jJ0IjP2UMvjfGqa13hIVcgAwGxlyb2n1/oi+/ZVeBZdp4YqyyDw0mWsjP5nVyCIiRhhg
 oRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778535766; x=1779140566;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yA1gek3HR3At3Q9DFaDVVLNqwF2oJxAWcK0srTpOdyw=;
 b=pNz6qjBs19l4CZ3QIqM5/63jAPHBedV87hIIy6TzUhYKZAYeCsU2VTZdm+ntuk5dKH
 4jWquK2MbSBrXhrj60ZBF3v764Q/vvKmSqL9KYeJ+XZUyJX6RIDzroYZ+3uwsK/mNyTR
 vPpA2zfk/eDlcmPRVn4wmGWTzgx0D0euFwVH40TM+ZXp7PurQEfbr1qP2eOdDHVmuM7A
 xQcq0O2Y65LlbQCbxd3F6PINAD/nqHyH0XgVhw0NM+s90rhn+KCxzC4IwK4IAC/CoInz
 0I/V4A+kmPNoCyQ9Zbc8GyN64rvg8g2DtmvXiGsnP9bqZd5nQFEIjuw3dVrUR+5DGhNA
 sjvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NRBWh9VVGYoMrBx6sOiUR2rnlFX6V0ZclobVQLRCBsV2sjvYHKgFK75xZt4sCm1SpJ/6tpzu4zoE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxd/JZAcrEQjX863Gk6zNAmatXF8Z7ZzPrcWlesUqNC7G8mWaCf
 c4cMtpmG+yWNR+cwQ4RmpsVZhYpDKSD1BdUz3/uxMB4Lqnv0rNYec2Ih8NdrxG51myxtJfA0Dgg
 yXMt4Kjr6gEd5
X-Received: from qvbkd27.prod.google.com
 ([2002:a05:6214:401b:b0:8a2:c383:22e2])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3f81:b0:89f:4a69:44b9 with SMTP id
 6a1803df08f44-8c663f6deb2mr7250256d6.40.1778535765277; 
 Mon, 11 May 2026 14:42:45 -0700 (PDT)
Date: Mon, 11 May 2026 21:42:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511214243.349487-1-xuehaohu@google.com>
Subject: [PATCH] dma-buf: Fix silent overflow for phys vec to sgt
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, jmoroni@google.com, 
 David Hu <xuehaohu@google.com>
Content-Type: text/plain; charset="UTF-8"
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

In case MMIO size is bigger than 4G, and peer2peer
dma goes through host bridge, we trigger the code
path to assign total linked IVOA, greater than 4G
to mapped_len, and leading to a silent overflow

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Signed-off-by: David Hu <xuehaohu@google.com>
---
 drivers/dma-buf/dma-buf-mapping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..658064140357 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -95,7 +95,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 					 size_t nr_ranges, size_t size,
 					 enum dma_data_direction dir)
 {
-	unsigned int nents, mapped_len = 0;
+	unsigned int nents = 0;
+	size_t mapped_len = 0;
 	struct dma_buf_dma *dma;
 	struct scatterlist *sgl;
 	dma_addr_t addr;
-- 
2.54.0.563.g4f69b47b94-goog

