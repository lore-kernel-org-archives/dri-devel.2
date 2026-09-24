Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73867C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C96210F908;
	Fri, 25 Sep 2026 07:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baidu.com header.i=@baidu.com header.b="PCijraKn";
	dkim-atps=neutral
X-Greylist: delayed 362 seconds by postgrey-1.36 at gabe;
 Thu, 24 Sep 2026 07:03:32 UTC
Received: from outbound.baidu.com (mx16.baidu.com [111.202.115.101])
 by gabe.freedesktop.org (Postfix) with SMTP id 5441D10F33A
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:03:32 +0000 (UTC)
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: Ankit Agrawal <ankita@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>, Yili Zhang
 <zhangyili01@baidu.com>, <stable@vger.kernel.org>
Subject: [PATCH] dma-buf: Fix IOVA offset when linking phys vecs to sgt
Date: Thu, 24 Sep 2026 14:55:08 +0800
Message-ID: <20260924065508.27245-1-zhangyili01@baidu.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1790232919;
 bh=DB4sZkh5fDZtNwjNkl/1Uhukpv9zgpTbwOF9bC8zHew=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=PCijraKn7y9QfquXxpjPou81QLILLYp5oAH13B/LlgktqVMhYRfNPef7PGjcb84Av
 ceAgiop+KSTZtMqnBPj/6ZvVQCRnuaQYqCP6R7vEg5rg4v1Cj+GFkQKIklgRmBVRpq
 5y94keVVKtm5X0vYJ/kLECg4nm/zgbXzcv8DzP49nZom23bUp+UFrnY7aW9zISkgO6
 TKzzB7nRvHP4cFmRJDnLrHoSZNVmumrbZOovISDLP7Vyt9COQg20qrrM+NFWWFgLOB
 LtHrPPReGOvWEyt3gmV4GrCJYPXOPgEVudQlkOtqeQRguBdEx+QHh96yjl7CH5cg3z
 ezqHKKPWc0BYw==
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

The dma_buf_phys_vec_to_sgt() routine links every physical range into
the allocated IOVA space at offset zero instead of advancing the offset
by the already mapped length. This breaks the THRU_HOST_BRIDGE flow
whenever phys_vec contains more than one entry: the second and
subsequent dma_iova_link() calls try to install mappings on top of
PTEs that already exist, which fails and makes the whole conversion
return an error.

Fix it by passing the accumulated mapped_len as the IOVA offset. This
matches the pattern used by all other dma_iova_link() callers and is
consistent with the rest of the function: dma_iova_sync() and the
error path in dma_iova_destroy() both operate on the [0, mapped_len)
prefix of the IOVA space, which assumes that the ranges were linked
contiguously starting at offset 0.

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
---
 drivers/dma-buf/dma-buf-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 833be519e1e6..ef0f22854d01 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -156,7 +156,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 						       phys_vec[i].paddr);
 		} else if (dma_use_iova(dma->state)) {
 			ret = dma_iova_link(attach->dev, dma->state,
-					    phys_vec[i].paddr, 0,
+					    phys_vec[i].paddr, mapped_len,
 					    phys_vec[i].len, dir,
 					    DMA_ATTR_MMIO);
 			if (ret)
-- 
2.27.0

