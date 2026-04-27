Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6EEFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ADD110E861;
	Mon, 27 Apr 2026 17:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="syeXzU9Q";
	dkim-atps=neutral
X-Greylist: delayed 349 seconds by postgrey-1.36 at gabe;
 Mon, 27 Apr 2026 17:31:47 UTC
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [91.218.175.186])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA3110E861
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 17:31:47 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777310756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0Wd0ztt1cxde3+fGD/1IJw2pKKT81J5P1qKg+eBGc9A=;
 b=syeXzU9QyDJ8aW3SRcVjkxpVJYsA5gTo25Xq/O/czeK8DZT91hKz+8/wwADDGUF+FaoVZ5
 rznbhciY+O99TZZfU0XZbwlCRBk966EhookPYX1LR+XsXvA8IhxG1OiAOV8NN0BXKNB/d0
 GBsNCLrIOR0Ev4NGkkiuGwJBU5OilNw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] dma-buf: heaps: use max3() in dma_heap_ioctl
Date: Mon, 27 Apr 2026 19:25:21 +0200
Message-ID: <20260427172519.417333-3-thorsten.blum@linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=755; i=thorsten.blum@linux.dev;
 h=from:subject; bh=JG8mxS9i7QQZ6A/BJBB1M9zNmRM6umvWte7BVTi3Gos=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnvZ///y9p5yaFJ4GPc2SNFdnkX35UtEbH1sdt8sLGhL
 0KQf0ZaRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEykvIaRoUFa4TD3y46q+Llz
 vjOeXFa80Kq9Z0HER8XzbfMfu4vUSDP8T/mpcPZx0cdCWea9s8uCDGrX8sYunnL80NbUvV0CVoG
 9/AA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Replace two nested max() calls with a single max3() in dma_heap_ioctl().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/dma-buf/dma-heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index ac5f8685a649..52eec2ebb2e8 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -153,7 +153,7 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
 		in_size = 0;
 	if ((ucmd & kcmd & IOC_OUT) == 0)
 		out_size = 0;
-	ksize = max(max(in_size, out_size), drv_size);
+	ksize = max3(in_size, out_size, drv_size);
 
 	/* If necessary, allocate buffer for ioctl argument */
 	if (ksize > sizeof(stack_kdata)) {
