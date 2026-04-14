Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FC1F9D0EC
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BEE410E651;
	Tue, 14 Apr 2026 18:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b8d98yjb";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D0B10E34F
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 10:55:45 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5a2c7427ad9so5076134e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776164143; x=1776768943; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W12ofF4X1Wo2C6qvMXRei9SFctcqIrL5xbkSvEXmBW4=;
 b=b8d98yjbbNehRRFcy6c6NTELVQrH5ruke322mtYhhsVv50BX42NOqakUHEI8JpIFE+
 j5J4RVFm1k5JzloAQpftT7gep1kSwiHjhTC4jnbUAFrk53bPBQQFJdjU2a0r29H+PVor
 GBigCD3Q1O8YH3PXYkaNRUkenNzyQPFWHytxrlV7C+O0SqdjOF4MRshIfFyOfNoRvvIM
 FCobVauVJnTYdv2dQBdU3pblVTNtHK+9aZF4IbTM9Q6T6WerJbQ+2+iBxyKQeHHDXX8Q
 hWEy1KoaIKsXpZSLJBXCbdxRjoNHxVt+GooGpZlEsVq7Le8xzAYYzH5rZCW2KV6eXzKQ
 liWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776164143; x=1776768943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W12ofF4X1Wo2C6qvMXRei9SFctcqIrL5xbkSvEXmBW4=;
 b=KARy4RcruVVkYfZuZ3xcLngAHHLsSbabcoag77BTp78TRK2paO5ReZdLONgB6fIZ2K
 v+G+iLhzzivlGOgND1r0sT+bPAoAMRybmT+GMBBIe5ISf6E5TkGWUUJJYb018P7F6lMr
 FmFshPvIpyftZ9rYZv606G3aIUk2BeuJLDx/NDXeBAauQFH+w+Tlw9cVHK6tKVqr6hqO
 nlEzdC+ACp4q6pBopVkpaP90FsaUc2agEWH0aLuTRL+kbKYSNXtHXI+RhsyhA+/WYT+k
 HGXerdGebQJpK0KPBTKJsAsjTNbH+FPzKDRaCdnzmMT6uHFQhXcwUIf+lXLgSokAYImv
 6l/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0HCxFuhPvQOhSZz7mhu9zpZoe21rWyoOAEcJC7yofVz/yXTi97KBK3zTzI2p35gqO2CAKfp/q6v8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzdc6WQSZWqdkaoqjkgqb350GGi+EhprFfmfwoWXDJqplpWWY3t
 mTFPrETFhcE5H0w/0FUkS7u09CeVzzqSfDZVW459w8sqBLrn+LR9b2NI
X-Gm-Gg: AeBDieupmszi2DlfsAzsB06FAd1SCJXn2XGFPx6y2Nc8u9gFYWsi69P7zjjazBhOAjb
 TwhKWYvMpmXdzHhPZZxFlJCabyRkNXCaqi4q1cP6AMISxeAg0ljBlt3n64+Zvc4bOK7YeLoS/TA
 +YrGqF/ITX3iRgbteXhKWE153YC0eewbDJfJOBMuRK9mjBVxc1lHfd7+rOMQyDlGS2mHODF21DP
 ZjhzxzbLVlvc9gGTLMdhuWgarAsoHZDQXnRxFpurr3FtUDqiaMBXv959sLw1hNSd5iFdabgmhA1
 tB4nG1zRIxItqPW5mJRSxJ4wOyCcRnKpP0RlNs2KaID/MQkQUJ4k7zERgtY0XexKczn5rrKR9Js
 FfH/mdYxwJ5Y+h04aaTx1PnFN+EMmJC3/gjV/bFLnN3KFVHvl9UaSMwFtCCXC12mMlND3v/0KE+
 PPdUVehgRAmBI+Ea/ZHiNSVu2rX8GJ+8T2GThGGQPe2KNlvP1KNJt9wXW+DQ==
X-Received: by 2002:a05:6512:a94:b0:5a2:bf05:be77 with SMTP id
 2adb3069b0e04-5a3efb283fbmr5981911e87.23.1776164142993; 
 Tue, 14 Apr 2026 03:55:42 -0700 (PDT)
Received: from ghost-mint-vmk.cs.msu.ru (wifi.cs.msu.ru. [188.44.42.48])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeee12fesm3177645e87.40.2026.04.14.03.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 03:55:42 -0700 (PDT)
From: popov.nkv@gmail.com
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Vladimir Popov <popov.nkv@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Deepak Rawat <drawat@vmware.com>, Sinclair Yeh <syeh@vmware.com>,
 Thomas Hellstrom <thellstrom@vmware.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
Subject: [PATCH 15901/15901] drm/vmwgfx: fix NULL pointer dereference in
 vmw_validation_bo_fence()
Date: Tue, 14 Apr 2026 13:55:27 +0300
Message-ID: <20260414105529.9883-1-popov.nkv@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Apr 2026 18:48:22 +0000
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

From: Vladimir Popov <popov.nkv@gmail.com>

If vmw_execbuf_fence_commands() call fails in
vmw_kms_helper_validation_finish(), it sets *p_fence = NULL. If 
ctx->bo_list is not empty, the caller, vmw_kms_helper_validation_finish(),
passes the fence through a chain of functions to dma_fence_is_array(),
which causes a NULL pointer dereference in dma_fence_is_array():

vmw_kms_helper_validation_finish() // pass NULL fence
  vmw_validation_done()
    vmw_validation_bo_fence()
      ttm_eu_fence_buffer_objects() // pass NULL fence
        dma_resv_add_fence()
          dma_fence_is_container()
            dma_fence_is_array() // NULL deref

Fix this by adding a NULL check in vmw_validation_bo_fence(): if the fence
is NULL, fall back to ttm_eu_backoff_reservation()to safely release
the buffer object reservations without attempting to add a NULL fence to
dma_resv. This is safe because when fence is NULL, vmw_fallback_wait()
has already been called inside vmw_execbuf_fence_commands() to synchronize
the GPU.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 038ecc503236 ("drm/vmwgfx: Add a validation module v2")
Cc: stable@vger.kernel.org
Signed-off-by: Vladimir Popov <popov.nkv@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
index 353d837907d8..fc04555ca505 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
@@ -127,16 +127,23 @@ vmw_validation_bo_reserve(struct vmw_validation_context *ctx,
  * vmw_validation_bo_fence - Unreserve and fence buffer objects registered
  * with a validation context
  * @ctx: The validation context
+ * @fence: Fence with which to fence all buffer objects taking part in the
+ * command submission.
  *
  * This function unreserves the buffer objects previously reserved using
- * vmw_validation_bo_reserve, and fences them with a fence object.
+ * vmw_validation_bo_reserve, and fences them with a fence object if the
+ * given fence object is not NULL.
  */
 static inline void
 vmw_validation_bo_fence(struct vmw_validation_context *ctx,
 			struct vmw_fence_obj *fence)
 {
-	ttm_eu_fence_buffer_objects(&ctx->ticket, &ctx->bo_list,
-				    (void *) fence);
+	/* fence is able to be NULL if vmw_execbuf_fence_commands() fails */
+	if (fence)
+		ttm_eu_fence_buffer_objects(&ctx->ticket, &ctx->bo_list,
+					    (void *)fence);
+	else
+		ttm_eu_backoff_reservation(&ctx->ticket, &ctx->bo_list);
 }
 
 /**
-- 
2.43.0

