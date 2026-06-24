Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07941CDB471
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C6210EEFA;
	Wed, 24 Jun 2026 12:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UCpwQk/l";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C6510EEEA
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:29:27 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4602e2a0372so773404f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782304165; x=1782908965; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=e+wf2elqBE83cLAMddkXjWEzB4Lp80uvCyXariA02m8=;
 b=UCpwQk/lDACpXVN96+ebeYg4cOF8dx+PxN70NEM0MlBZHvFfHUqfK2E12weHyJDnaS
 ZnVMZJW4IEEsXBQC2uV8ekxwlhU0G18ZGEgsQMaQyhZC7kK9Wf1yte1SMGSfJ5srptef
 3wHUA9ubrmiFWWv8lngpToGElHFwwEdx2N33WyBi53M5ub1NOHjSYu2e3D/qmLKvlGYx
 IXxDsAQPXUnGofZHp4B3VaDtCQkZgP+Xk8bjIEouC7Qgbn08KIibo80LhwI/u4Aen4ZZ
 +gD9qs3IZsXxaafO2EUp0jEB6+ykOIo/OIO8ZcExAmbed/FZ/Uax/oAnouPFS/M/DlJr
 HTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782304165; x=1782908965;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+wf2elqBE83cLAMddkXjWEzB4Lp80uvCyXariA02m8=;
 b=Ju/VuLshg6nfJqxh/Zuucvks/s8LJrxRgyyL1l7FaACEvU8IG1onlV0CrbwaiN9MKs
 GVEvFCR8zQLbH0KaQKxim0ZAGo9uNgKLb++1JKlAbuEDCK6dufn3Ths6B/Etiz9pW36P
 zk+Y1pNwCaKf/UvCjxJ80tS6pz0jsCqBo3NQhCB1WvpQQjnV7+6Mq6o3Btdx/61pUhdD
 iRwUwJfX+NZmWSaeuE4cAy4LOAPslGzLw6k6+N8sAi+SI/ktf/6QHAMkYMWuPw1JqYtn
 tksiPIkbO7QEP2t7jnlpnwfo0XX/LfASRTyFHfUWOv4xcxHGtkWWrUN3fGRjWwM1RTtr
 NLEQ==
X-Gm-Message-State: AOJu0Yzb9eDmdjMX1+pwD1czwa89i15yLhHS2gfXoEGMKRvLmKxZ1ncU
 KxmwTjD/98KSzdDa91PWWkdMPZJ0+MNI/C/gmpS3L3iU/LfBDZEa4Jka
X-Gm-Gg: AfdE7clf94AbAIUDtWWsr5xl+fRoYUsqJB8wcL+o/52oPpQsKbVws3GLeQTEF6qUEAu
 Nn92p8HyeXINM1INWBWS8ugO1R6zge6UiH73qwx770BYT3ybHwZoPjB5Lxb5SxUyt69EtG5ify2
 vbwaPOzjBl13WNA8sv2/KCyGboyfxb7KAmFUgFFHJpkTEiiTUzTXbeXIay708dEWm+LhzwOLjY7
 4XIpe86nqrDEoS2CERxX5CjK1VOKNCJRsoi6IQ7lDZ6oBl3dVHFG6JQ5Kta3IKPVJdfIXRK4MPf
 CYoCqBKmQK6SxilB8QYJDoQjJRoH5QTIoX9WV8EY4EsjPvBktfn7G2M0EOciSP0wdUaNzgepCSN
 A77c2O+9KA8YDMfx6Pv3atKVlhPn+Zm9bADgbf4rP5yPsOzI3gFnTy9PfEgATCr6btNVzuO688E
 dkirt6ykaffYxpLSR01vfFCJGgMtnLp/rIvYgz
X-Received: by 2002:a05:6000:46cc:b0:460:1957:1b33 with SMTP id
 ffacd0b85a97d-46ad8c2448dmr7855512f8f.3.1782304165478; 
 Wed, 24 Jun 2026 05:29:25 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:157e:3500:2be7:1a89:41c5:9239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9787dddbsm3896530f8f.3.2026.06.24.05.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:29:25 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@kernel.org, simona@ffwll.ch, sumit.semwal@linaro.org,
 tvrtko.ursulin@igalia.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH 06/10] drm/xe: stop using dma_fence_is_signaled_locked
Date: Wed, 24 Jun 2026 13:13:30 +0200
Message-ID: <20260624122917.2483-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624122917.2483-1-christian.koenig@amd.com>
References: <20260624122917.2483-1-christian.koenig@amd.com>
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

This use case is a bit more complicated since the irq worker is
actually the one signaling the fence.

The patch should not indroduce any functional change, but the code can
probably be cleaned up quite a bit after the full patch set lands.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/xe/xe_hw_fence.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_fence.c b/drivers/gpu/drm/xe/xe_hw_fence.c
index 14720623ad00..a4e0278559b8 100644
--- a/drivers/gpu/drm/xe/xe_hw_fence.c
+++ b/drivers/gpu/drm/xe/xe_hw_fence.c
@@ -16,6 +16,8 @@
 
 static struct kmem_cache *xe_hw_fence_slab;
 
+static struct xe_hw_fence *to_xe_hw_fence(struct dma_fence *fence);
+
 int __init xe_hw_fence_module_init(void)
 {
 	xe_hw_fence_slab = kmem_cache_create("xe_hw_fence",
@@ -47,6 +49,16 @@ static void fence_free(struct rcu_head *rcu)
 		kmem_cache_free(xe_hw_fence_slab, fence);
 }
 
+static bool xe_hw_fence_signaled(struct dma_fence *dma_fence)
+{
+	struct xe_hw_fence *fence = to_xe_hw_fence(dma_fence);
+	struct xe_device *xe = fence->xe;
+	u32 seqno = xe_map_rd(xe, &fence->seqno_map, 0, u32);
+
+	return dma_fence->error ||
+		!__dma_fence_is_later(dma_fence, dma_fence->seqno, seqno);
+}
+
 static void hw_fence_irq_run_cb(struct irq_work *work)
 {
 	struct xe_hw_fence_irq *irq = container_of(work, typeof(*irq), work);
@@ -60,7 +72,9 @@ static void hw_fence_irq_run_cb(struct irq_work *work)
 			struct dma_fence *dma_fence = &fence->dma;
 
 			trace_xe_hw_fence_try_signal(fence);
-			if (dma_fence_is_signaled_locked(dma_fence)) {
+			if (dma_fence_test_signaled_flag(dma_fence) ||
+			    xe_hw_fence_signaled(dma_fence)) {
+				dma_fence_signal_locked(dma_fence);
 				trace_xe_hw_fence_signal(fence);
 				list_del_init(&fence->irq_link);
 				dma_fence_put(dma_fence);
@@ -120,8 +134,6 @@ void xe_hw_fence_ctx_finish(struct xe_hw_fence_ctx *ctx)
 {
 }
 
-static struct xe_hw_fence *to_xe_hw_fence(struct dma_fence *fence);
-
 static struct xe_hw_fence_irq *xe_hw_fence_irq(struct xe_hw_fence *fence)
 {
 	return container_of(fence->dma.extern_lock, struct xe_hw_fence_irq,
@@ -142,16 +154,6 @@ static const char *xe_hw_fence_get_timeline_name(struct dma_fence *dma_fence)
 	return fence->name;
 }
 
-static bool xe_hw_fence_signaled(struct dma_fence *dma_fence)
-{
-	struct xe_hw_fence *fence = to_xe_hw_fence(dma_fence);
-	struct xe_device *xe = fence->xe;
-	u32 seqno = xe_map_rd(xe, &fence->seqno_map, 0, u32);
-
-	return dma_fence->error ||
-		!__dma_fence_is_later(dma_fence, dma_fence->seqno, seqno);
-}
-
 static bool xe_hw_fence_enable_signaling(struct dma_fence *dma_fence)
 {
 	struct xe_hw_fence *fence = to_xe_hw_fence(dma_fence);
-- 
2.43.0

