Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9844AFF8870
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073D110E07E;
	Mon, 27 Apr 2026 21:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="ig/N7rOx";
	dkim-atps=neutral
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E57010E07E
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:27:47 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777325265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hueLhtL3zsdmdXnMtuPrauJ8fkjBDESO/03aEH4/H2E=;
 b=ig/N7rOxAjR6yFr0Jkkz+z60oppTfibLQOzEKI/nc4RCoJvJZ5ASDIIR5H8umv+wM5kMCn
 LBqhZcPbIsgZfg5y2Q+zwXzqwRjcKAjI7v9HZI2TzUziDgej15Ve5xV+cw0AG2gxVco0TN
 LTb/eiIzYFH3p5rCtq6nlhlbzImvnIM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] dma-buf: heaps: use max3() in dma_heap_ioctl
Date: Mon, 27 Apr 2026 23:24:56 +0200
Message-ID: <20260427212454.420004-3-thorsten.blum@linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175; i=thorsten.blum@linux.dev;
 h=from:subject; bh=2Qy1bhZE4ZUxVczuVFGuB6tJXixNg2z/25mUfsiG6bg=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnvr6ht3b0sQqfy14Ly09nCLzf+1VQtz7oVwrXO/n8X3
 /bfb6/0dpSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBElk9k+CvQvddeYz6vfuWJ
 +ft+GhcWbjd3TekvymXw/Xf30FJHkz0M/xS1BD5HyN83PscmILv89kN9g8wHHxjfZ5j17PQ6rBH
 WxgoA
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

Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Include minmax.h as suggested by T.J. Mercier
- v1: https://lore.kernel.org/lkml/20260427172519.417333-3-thorsten.blum@linux.dev/
---
 drivers/dma-buf/dma-heap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index ac5f8685a649..d49188893608 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/list.h>
+#include <linux/minmax.h>
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
@@ -153,7 +154,7 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
 		in_size = 0;
 	if ((ucmd & kcmd & IOC_OUT) == 0)
 		out_size = 0;
-	ksize = max(max(in_size, out_size), drv_size);
+	ksize = max3(in_size, out_size, drv_size);
 
 	/* If necessary, allocate buffer for ioctl argument */
 	if (ksize > sizeof(stack_kdata)) {
