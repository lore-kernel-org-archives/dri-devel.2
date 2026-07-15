Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B419C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 08:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D511810E169;
	Wed, 15 Jul 2026 08:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="pjTdX+aw";
	dkim-atps=neutral
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com
 [91.218.175.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7817110E169
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 08:58:42 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784105920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qiuSSy8ybFGsTU3Etu0fZcXat/PQY5377yksTpGdaF0=;
 b=pjTdX+awk1ZahQAXSx3Fwo94YGzH+l8mfAt+65QvjIMp86HRBVoLX9dhxjgonE51mM5Agc
 LBA3OipNAWbNOkc5vqM+yMTzDkoTJzhe1nRiCQfklVUAZrFSV0kw5JZL8m5vqFQVOlG0iG
 p8PPAQH9alwFEhalEuEpK+qfvgZejlc=
From: Hongfu Li <hongfu.li@linux.dev>
To: christian.koenig@amd.com, ray.huang@amd.com, matthew.auld@intel.com,
 matthew.brost@intel.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 hongfu.li@linux.dev, Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH] drm/ttm: Fix hardcoded LRU index in ttm_device_fini()
Date: Wed, 15 Jul 2026 16:58:23 +0800
Message-ID: <20260715085823.25671-1-hongfu.li@linux.dev>
MIME-Version: 1.0
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

From: Hongfu Li <lihongfu@kylinos.cn>

ttm_device_fini() iterates over all TTM_MAX_BO_PRIORITY LRU lists
using loop variable i, but list_empty() always checks man->lru[0]
instead of man->lru[i]. This means the debug message only checks
priority 0 and prints the same result four times.

Fixes: 8af8a109b34f ("drm/ttm: device naming cleanup")
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 drivers/gpu/drm/ttm/ttm_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index d3bfb9a696a7..e22c77f4228e 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -266,7 +266,7 @@ void ttm_device_fini(struct ttm_device *bdev)
 
 	spin_lock(&bdev->lru_lock);
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i)
-		if (list_empty(&man->lru[0]))
+		if (list_empty(&man->lru[i]))
 			pr_debug("Swap list %d was clean\n", i);
 	spin_unlock(&bdev->lru_lock);
 
-- 
2.54.0

