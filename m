Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661B5CDB481
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF70910EEE7;
	Wed, 24 Jun 2026 12:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rCdG8dnk";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9480710EEE7
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:29:24 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490b8ac62baso19907335e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 05:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782304163; x=1782908963; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rK7BBYKp4olcSlX/FhhqJF/M5dPppXiXimriQNw/H+8=;
 b=rCdG8dnkDWk5C6vtYVpLa3DqbmWsxYLdrwt3MmHEJftv4Ib3lIj54AjBpheM9hNnPV
 jwvP0snJ46m3htUmbKmFth9E5vMWKY3KTmjFBthTXjqTqyrztrPEAGSSXLYdpqy/xnnc
 AzG+4LgLgy1OzbsiX9Q0oymkjn0+wEpn+FwVJtKzI+3QcmjBXWX/rIQuQKDIslpcqOg7
 GaRJGhu8m9dKAevCaqTtQvCjn6Nott1UqOixTbcjENXeEiexhSCCbXadS8Yg5SPleekX
 2XeSltJpYQdnJgR75GOoQeOe1nxUz3/QmcNArjwkEaA1GcG6u6p/h4nRZbpqJDBM5wNs
 406Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782304163; x=1782908963;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rK7BBYKp4olcSlX/FhhqJF/M5dPppXiXimriQNw/H+8=;
 b=H0Lx6GBTltJtvoC456fOtOZhbegKhgA7Q1z288pwTqFSuk79n1LbVEUfd18AU3+8aM
 RUM9P5nQG9hgstdTUUA4E+aj0IveXZIhp9EfGlxzLsUBbnwwLmPb0IXVEyxPdrDWK4dQ
 Cxlw8RGcRWMNE558HKbCasuFJFYhprppMfBHFepaFSqPHqJeFLPJ8WDZUkOGT0fkVP34
 l6K0RM0vokDDcbY2Qx2+P+NKW5Tp28g98wC+FglpOKewfjXXufXMywKbLE0DEenjuB/p
 chZQKHVdkRTnrXynasgJ7PR6JbC4UxbUFrkWjhBiaxDETKcZSCWwHk2i1Oqw9kKetqUQ
 staw==
X-Gm-Message-State: AOJu0YxWNty7kqo46xBfDimnP/bPrW7868YLOKW3sGG9igx+7ZAGMVW6
 K1OJaGkchOlF7mqxspjJLSdXqU+6sBOJ1EuUnCUHXPaJKxVkBGVnfHJO
X-Gm-Gg: AfdE7cnBpvtXhP/e3Gy3WK1xN5YLpJxEI+lGmMXPVlA4RMcmzFkUbIOeJflpuQyHfyO
 59Lr6VHYqBZAVG0e7CfLVb2/7fe5Q/Df2QWk1TGn0/+qpCcJcobcIQECyz3I9WJTWxtUSKKIcNW
 0oScWWFbByBWJdZ9DMIV7kWsgkFWO0rtqF/hL0IIDkIbU9Zr1d8Z2gRL5e1OU6GI2nSAqk6lzyD
 ZD+uPC2/WDrBwxBShFbovskgJ+gPytvRNAeCatJU5vk0Q0sfbjWtt99lPEAeuUD5vRvtFHeRtRW
 DpRcrrynfD1/qNqi7zTjDQZ4j39Z5SmjZTFyzB1apCY65czBJtFCdUWV9a8ACMvfVyq0RFlhs9U
 ZUNa2NfS6z7rd20I6jJNZJApsObC9IfPLh3PongMONcbWr8+RTgIK0Z669kGlvkPhiIh7ZFynSj
 nuD6IDnETAn02khH/Cpl23vNVDNkwulq7qhg/i
X-Received: by 2002:a05:600c:c171:b0:490:e180:2e0 with SMTP id
 5b1f17b1804b1-4926329a875mr3823145e9.3.1782304162768; 
 Wed, 24 Jun 2026 05:29:22 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:157e:3500:2be7:1a89:41c5:9239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9787dddbsm3896530f8f.3.2026.06.24.05.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:29:22 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@kernel.org, simona@ffwll.ch, sumit.semwal@linaro.org,
 tvrtko.ursulin@igalia.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH 03/10] drm/amdgpu: use dma_fence_test_signaled_flag()
Date: Wed, 24 Jun 2026 13:13:27 +0200
Message-ID: <20260624122917.2483-4-christian.koenig@amd.com>
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

Instead of dma_fence_is_signaled_locked() use
dma_fence_test_signaled_flag().

The extra polling check seems unecessary for those use cases.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c       | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index ea69b1bac7c6..1192b9800ff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -652,7 +652,7 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
 
 		fence = rcu_dereference_protected(drv->fences[i],
 						  lockdep_is_held(&drv->lock));
-		if (fence && !dma_fence_is_signaled_locked(fence))
+		if (fence && !dma_fence_test_signaled_flag(fence))
 			dma_fence_set_error(fence, error);
 	}
 	spin_unlock_irqrestore(&drv->lock, flags);
@@ -677,7 +677,7 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
 
 		fence = rcu_dereference_protected(drv->fences[i],
 						  lockdep_is_held(&drv->lock));
-		if (fence && !dma_fence_is_signaled_locked(fence)) {
+		if (fence && !dma_fence_test_signaled_flag(fence)) {
 			if (fence == timedout_fence)
 				dma_fence_set_error(fence, -ETIME);
 			else
@@ -738,7 +738,7 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 		rcu_read_lock();
 		unprocessed = rcu_dereference(*ptr);
 
-		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
+		if (unprocessed && !dma_fence_test_signaled_flag(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 			is_guilty_fence = fence == guilty_fence;
 			is_guilty_context = fence->context == guilty_fence->context;
@@ -802,7 +802,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 		rcu_read_lock();
 		unprocessed = rcu_dereference(*ptr);
 
-		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
+		if (unprocessed && !dma_fence_test_signaled_flag(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
 			amdgpu_ring_backup_unprocessed_command(ring, fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index d6bee5c30073..ae9d6a2eefab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -460,7 +460,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 		return false;
 
 	dma_fence_lock_irqsave(fence, flags);
-	if (!dma_fence_is_signaled_locked(fence))
+	if (!dma_fence_test_signaled_flag(fence))
 		dma_fence_set_error(fence, -ENODATA);
 	dma_fence_unlock_irqrestore(fence, flags);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a41fb72dba94..2cc6552a6399 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -426,7 +426,7 @@ amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
 
 	f = rcu_dereference_protected(&fence->base,
 				      lockdep_is_held(&fence_drv->fence_list_lock));
-	if (f && !dma_fence_is_signaled_locked(f))
+	if (f && !dma_fence_test_signaled_flag(f))
 		dma_fence_set_error(f, error);
 	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 }
-- 
2.43.0

