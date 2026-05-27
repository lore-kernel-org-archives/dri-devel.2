Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73893CD5BC9
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 10:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF7E810E1D9;
	Wed, 27 May 2026 10:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baidu.com header.i=@baidu.com header.b="TaYc9YRm";
	dkim-atps=neutral
X-Greylist: delayed 484 seconds by postgrey-1.36 at gabe;
 Wed, 27 May 2026 10:53:05 UTC
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
 by gabe.freedesktop.org (Postfix) with SMTP id DF8DD10E1D9
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 10:53:05 +0000 (UTC)
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] dma-buf: Move dma_resv_assert_held() after input validation
Date: Wed, 27 May 2026 06:44:49 -0400
Message-ID: <20260527104449.2350-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1779878699;
 bh=8wxiXP655DLDne+j37kjUbGvhP71Q5D+Jw5Sn2qPwtM=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=TaYc9YRm50UTB3PERjLWE9PFLf2rUKjf6YsOz++tHMhErOOBfr8yKMCvsuMDlcgHh
 WjQ92PnYmoK6my3wLAUVW2vdj35v3uNbpjxV6UQOc008dKZCTkTUWTNi6HbaomhtK2
 9Ksis3y3oHGNoDd3pThW2Q4R8+V5NtnNAlq9w6N3wBGa2Rnq4yHklSwlC5nOtAOfTy
 1o5XRmiIusLKuqcu7oMJsy3UpqpupBhjwj4l8EZypZKKKWR+OuBJ2BSKUnyFbPg95r
 Pav5xlHwVP2j+FoVhJLHJLdmV9PyPXKVY6zT+ujJf5G0FkMmUNDZu/2XRvw0P2U5m9
 EgDhAmGcs5iww==
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

From: Li RongQing <lirongqing@baidu.com>

Move dma_resv_assert_held() after the validation of 'attach' and
'attach->dmabuf' to avoid a potential null pointer dereference if
the function is ever called with invalid arguments.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/dma-buf/dma-buf-mapping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff..e6ecd6c 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -102,12 +102,12 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	size_t i;
 	int ret;
 
-	dma_resv_assert_held(attach->dmabuf->resv);
-
 	if (WARN_ON(!attach || !attach->dmabuf || !provider))
 		/* This function is supposed to work on MMIO memory only */
 		return ERR_PTR(-EINVAL);
 
+	dma_resv_assert_held(attach->dmabuf->resv);
+
 	dma = kzalloc_obj(*dma);
 	if (!dma)
 		return ERR_PTR(-ENOMEM);
-- 
2.9.4

