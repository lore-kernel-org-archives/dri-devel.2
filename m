Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922F6C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 08:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56FE010E2A1;
	Thu,  6 Aug 2026 08:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="WTYUcXH5";
	dkim-atps=neutral
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [91.218.175.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 255EE10E2A1
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 08:52:24 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1786006342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VFLbWVUfMcTF/uRRMOzyFcp+4eS6agFQIGUD7x9RHd8=;
 b=WTYUcXH5ZSQu5tK8oM9H9x0dmak31UtEVNl3M5o5SgozgjlT6/EZl2Kai2KDQlMuaWmkE7
 CBxOuoqGXqgFuXWEhrD+Lu/E6Czfhl4CjjyddCVYrGAtwwnpjHvZldYj0OMvVNWUVkupEY
 NpnPz66MCeH8sBSWtAqqOyMGrePPsLs=
From: Hongfu Li <hongfu.li@linux.dev>
To: christian.koenig@amd.com, ray.huang@amd.com, matthew.auld@intel.com,
 matthew.brost@intel.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, syeh@vmware.com, alexander.deucher@amd.com,
 Hongbo.He@amd.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 hongfu.li@linux.dev, Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH v2] drm/ttm: Fix hardcoded LRU index in ttm_device_fini()
Date: Thu,  6 Aug 2026 16:52:03 +0800
Message-ID: <20260806085203.5268-1-hongfu.li@linux.dev>
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

When iterating all TTM_MAX_BO_PRIORITY LRU lists using loop variable i,
the list_empty() check references man->lru[0] instead of man->lru[i].
The loop therefore relies entirely on the state of priority 0 LRU
rather than checking each priority list individually.

Change hardcoded index man->lru[0] to man->lru[i] to correctly
inspect every per-priority LRU list.

Fixes: cf6c467d67d3 ("drm/ttm: add BO priorities for the LRUs")
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
v2:
- Only the commit message was updated, including the Fixes: tag; no code
  changes.
- Link to v1: https://lore.kernel.org/all/20260715085823.25671-1-hongfu.li@linux.dev/
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

