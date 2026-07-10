Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39A7C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7249E10F964;
	Fri, 10 Jul 2026 19:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hw40dCLe";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C54E10F94A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:08:02 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso10886905e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783710481; x=1784315281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yfqzx7NPmSYUt62vyH3N9Lvh263fPR148WybLR6D9i4=;
 b=hw40dCLeRp+8GmrUp+cFJHGxkWrluIlCp8g9BFkr8FnBvpAQ4+DXpqV8YCUBd08BqG
 CPjztruNGoVgOplUlZsdwRZi9p0WKVtdBQtc5lXDVFMRGRJqRRtlrAjhgZ+FtKDd9HNj
 lFTi2dhPF/A/0Wgdr6F2NdOonDeWQcpZyK32OtR1FS7h2I8fSTmtgJpgihVBFBjsMv4m
 Np5qyhIvWsI75t/g23W5zA7W2gfoH3npVe9IFVtHWyTtzoL4SEGbd7tXzNE3wGaBDyY+
 M73eCFzGVBY8DApI2Lh5u/rheKOZ/bU99ZJ+H2yCyt5XvOdkfAIto5NETdPzB7299unu
 g/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710481; x=1784315281;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yfqzx7NPmSYUt62vyH3N9Lvh263fPR148WybLR6D9i4=;
 b=ByOGjqbed2/mkp85KxAeF5UCHBuOOt67a1Ohffz3obNaOLprLJixn5V+wLZBPXf7o8
 5DAGdOSpYsANBQ6Fc6bVAxImRcj9yBf2Gm/w7PycQZM5RvZYNYPhE26yzbpJSEfVw1m3
 zd26OjJvas2w9uLN/4wIB8NXBFABHuU7m2qJN3hNqzdcXTnSN+TcQK4NXRjxPI2VqkLQ
 lkSDZMSalf7CEaHP70kcJJp1dHj+ktTl9nBemRmOrxviijJwf+Uy2hd1g1NUFRnT596+
 7hWMz9q3dz9u5DePGR9y4gYsgQ2En6x1J4yWz5DpAgAWTXFE2Ww/n1DJmkOwAiUkSo7v
 Qj4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoantZAOpN8D808i7RDFgjwh4KKIL+JcnbhmbhOeWz6oa0QAkO2CpoySMj5t9FIhBsyNqYkHMvGbxI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyB0Qz6i+9W6MHVk3tTzW/5gnes0p/Iv96u+E/qgrG1UK1mpwji
 uyhU8xayDzOhcm5yjDNJSkFxuFPyAi20Z/xGd976U8VLOzr9yFsQsxAa
X-Gm-Gg: AfdE7cl4eVaUk5zO+Z+7IiXPqwV2RT6sdCS8UYAdydLd9Gy77pxBMlbUnSXZkGEHzwj
 oJzmoYMHeNxkKKti5mXmt6wxFsujbT/cbsmrZdeSi7vwf+kNJmC3veu+ICLe3kNs1+cc4IzUWYb
 2Xg6H6Oao2UTAqf+LlJz2V0ovm+wJhjcsfu6KIRz3dA94lTX5nOXiFJVT0p3Nm3C5GV8K1azvNI
 wjaxXmEfNVFr4UnlMbcbj7KDVqfAnS3FtH/H5kqG2J8EOrdgePkw6+4/+eHkzideHMarvo1ogNp
 GA/psseUx4h++Vc0QZqvtyOK7WJOWy9O74tIVIg2SShU/jdpbKoAluiOAWmvgJYE2tMPUrSrCKH
 191GbQ+MNvpvELP15TZmi0Cq4bJQSJGXKjGWtX+/r0daxH7t36kGgHIF2ZHbzf2rhwlqbaa26cj
 EMJNAgix5XSoB1/6xAY9e9fbmLhg==
X-Received: by 2002:a05:600c:3b07:b0:493:f807:1a79 with SMTP id
 5b1f17b1804b1-493f882b042mr996745e9.27.1783710480841; 
 Fri, 10 Jul 2026 12:08:00 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154f:ec00:aa08:de24:db33:4496])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f567eadfsm55000755e9.6.2026.07.10.12.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:08:00 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 simona@ffwll.ch, matthew.brost@intel.com, nat@pixelcluster.dev,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/12] drm/ttm: move delete handling into ttm_bo_evict
Date: Fri, 10 Jul 2026 20:52:46 +0200
Message-ID: <20260710190752.2355-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710190752.2355-1-christian.koenig@amd.com>
References: <20260710190752.2355-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Both callers do the same thing, so we can trivially unify that.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index db72fb2fde9ff..e28e11c06ef48 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -363,6 +363,13 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
 	struct ttm_place hop;
 	int ret = 0;
 
+	if (bo->deleted) {
+		ret = ttm_bo_wait_ctx(bo, ctx);
+		if (!ret)
+			ttm_bo_cleanup_memtype_use(bo);
+		return ret;
+	}
+
 	memset(&hop, 0, sizeof(hop));
 
 	dma_resv_assert_held(bo->base.resv);
@@ -470,13 +477,7 @@ int ttm_bo_evict_first(struct ttm_device *bdev, struct ttm_resource_manager *man
 	if (!bo->resource || bo->resource->mem_type != mem_type)
 		goto out_bo_moved;
 
-	if (bo->deleted) {
-		ret = ttm_bo_wait_ctx(bo, ctx);
-		if (!ret)
-			ttm_bo_cleanup_memtype_use(bo);
-	} else {
-		ret = ttm_bo_evict(bo, ctx);
-	}
+	ret = ttm_bo_evict(bo, ctx);
 out_bo_moved:
 	dma_resv_unlock(bo->base.resv);
 out_no_lock:
@@ -524,14 +525,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
 	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk->place))
 		return 0;
 
-	if (bo->deleted) {
-		lret = ttm_bo_wait_ctx(bo, walk->arg.ctx);
-		if (!lret)
-			ttm_bo_cleanup_memtype_use(bo);
-	} else {
-		lret = ttm_bo_evict(bo, walk->arg.ctx);
-	}
-
+	lret = ttm_bo_evict(bo, walk->arg.ctx);
 	if (lret)
 		goto out;
 
-- 
2.43.0

