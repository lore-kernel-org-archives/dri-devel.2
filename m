Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F43ECD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3863C10E265;
	Fri, 22 May 2026 14:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="XAAerBj4";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Fri, 22 May 2026 03:38:03 UTC
Received: from mail-m128126.netease.com (mail-m128126.netease.com
 [103.209.128.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D0F10E05F;
 Fri, 22 May 2026 03:38:03 +0000 (UTC)
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3f63bb888;
 Fri, 22 May 2026 11:32:57 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 Dawei Feng <dawei.feng@seu.edu.cn>, stable@vger.kernel.org,
 Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] drm/radeon: Use kvfree instead of kfree in radeon_gpu_reset
Date: Fri, 22 May 2026 11:32:54 +0800
Message-Id: <20260522033254.3602281-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e4dbe4a6e03a2kunma43dd79261302
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBlJVhpIHh8ZS0pPH0hKHVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
 5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
 b=XAAerBj4UO150YsFWbPnbkZhMrbQTXJwizec3Wkq69Ho74iOHFV0p5Xd291/8vm5XadLKLeclBN3AsIgvGralV4mf6hFPuRPjFNkVxbLfdNy5+HNEMfGgL2+qsfJiJ4eL8kg7X6vxQu7ts+RscOBqJ4kJGuOdxaNxWnCyIb5ez8=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=t85wgIYDJDkRWKpC2Gn2UjV3gwyPjPlbrb7Fn29A06U=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:04 +0000
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

radeon_ring_backup() internally allocates ring_data buffers using
kvmalloc_array(), which may use vmalloc() for large allocations. Using
kfree() to release vmalloc-backed ring_data buffers in
radeon_gpu_reset() will lead to memory corruption.

Use kvfree() to safely handle both kmalloc and vmalloc allocations.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc3.

Runtime validation was not attempted because a targeted reproducer for
this GPU reset error path was not available. Compile-tested only.

Fixes: 2098105ec65c ("drm: drop drm_[cm]alloc* helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/gpu/drm/radeon/radeon_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 705c012fcf9e..1f0f0d0eb673 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1800,7 +1800,7 @@ int radeon_gpu_reset(struct radeon_device *rdev)
 					    ring_sizes[i], ring_data[i]);
 		} else {
 			radeon_fence_driver_force_completion(rdev, i);
-			kfree(ring_data[i]);
+			kvfree(ring_data[i]);
 		}
 	}
 
-- 
2.34.1

