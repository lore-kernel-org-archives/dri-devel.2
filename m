Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FADF9B607
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6CE10E9A3;
	Wed, 22 Apr 2026 10:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bDTFW2sY";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D3610E9A3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 10:30:16 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so3624818f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776853814; x=1777458614; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u5EkC/29S44h/d7Ni2SqoG2DCC3TxCGRvqnl3YG/8w8=;
 b=bDTFW2sYfSSFu6Vs8Ttf+4BIVuY1d4LMD5VZnROGvuNTrU6ia+xJoirX/iNTkiH8Ao
 7St1djCLQR2zvJFFyd/Vkq1AGR4Ke/kCjenY3yQb1emFWVilH1JPEu3LLuxx5b8T/hcT
 bycInElFykmEyXM501qDCatB8X+rw9ghMC1h4PI2YjToMMRC3oyY4UVsv2gO+i5l38J4
 ir9U7t0TMelReSruBSBSLuyra0AZM2D6TnHqkx9OMJw6h+S2uI/U+vOfi7cfTHxDRYJU
 xlpYj3f6L1riH5NqBEaI1NDDeewF5c4J8FJuaW9wY+1zllP+oyKbUU/lQTvFEi8XevV8
 L0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853814; x=1777458614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5EkC/29S44h/d7Ni2SqoG2DCC3TxCGRvqnl3YG/8w8=;
 b=WquoKog3Jmbh7mIt7Ogmt8FSlYeGOhTPUnXS43FIs0D26193Od+9S2HRWR7Y7/p+Wl
 9O1IoPRsG+XGfEU+2oscyuInR7vc7UIcavKC6hdtMHLD7Bs9D33rraZ5qy+e6jahww1U
 8QeGjTpCDR6dNJ5xzva/razDL6b99QjGeeoIfiiFUZB3dXH1DCkT6pZU8JJkIn712I+W
 0i9bOZIx+9tOAZSKwuyMyZ4rAZgLDmXzSPIpPaZu16Lv7/oNmOkCF6/fzAAWEriDRVlJ
 2FmTmVIe/wc58Iigr0V3+oLgsrom0xYcIaoSaMHMjZeTCxGdu+toR3nuPZF+z6qpb/xJ
 1BaQ==
X-Gm-Message-State: AOJu0YzKmZOu9zvA2L62mItPAiovQ6N6kbPXcw+SNaCKPScmokcPWBgR
 6aXwWdn49gXeKMH/v94fT2oTk63ZZH2vGx6vHUxm5aiTHVrj63naPzkv
X-Gm-Gg: AeBDievvkn6bfLjFeVnmu18ARt+MZjYRvi38RlzWB6DEmd5d38BlJOnMRXUlZ00QvCV
 NUdQr7oCjcYZY4LS7QMBFWOm/plvVyJyhIqUw+g/PClP5PkWATaVDKDJH5DwlCzMGlK89G2QtzS
 6xEPayuLvCmpIqZ9YZmgmYGyAYzSMCipgg3+qI6MW6o/tlhQOImg7/IDRSf1RrP/b4Mwbd6SBwN
 GyIV2cn5EdeQayf2upVaeXorvyXoopDwydMw1Wg6D9k4CmUOzwKuEcer/K3yO5AS6gwZcle7Ecj
 NOFzoFXwaQlaffBX4lhNGCh94CUVBKiFErH234KQyMwtgxaAINi61ogd98tyfdor3OCyMVIsVPw
 Ne7FU1EiwpbMXlLcgZwj9uhveFHONoBr2NWhVEh/hSFvEyyWmunIwa+b8VbsK3ego0lxycQAEQT
 IOHwvX485YfUJIdcKtES5YcI31XUgiFK2v6aOhR3z55ShS/Q==
X-Received: by 2002:a05:6000:40da:b0:43d:1df7:e3af with SMTP id
 ffacd0b85a97d-43fe4088b01mr33049560f8f.22.1776853813543; 
 Wed, 22 Apr 2026 03:30:13 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15c7:5100:eecf:fda8:2b8:432b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4daf2sm43439037f8f.33.2026.04.22.03.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:30:12 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net,
	sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH 1/2] dma-buf/dma_fence_array: remove unused functionality v3
Date: Wed, 22 Apr 2026 12:30:10 +0200
Message-ID: <20260422103012.1647-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Amdgpu was the only user of the signal on any feature and we dropped
that use case recently, so we can remove that functionality.

v2: update num_pending only after the fence is signaled
v3: separate out simplifying dma_fence_array implementation

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence-array.c              | 13 ++++---------
 drivers/dma-buf/dma-fence-unwrap.c             |  3 +--
 drivers/dma-buf/dma-resv.c                     |  3 +--
 drivers/dma-buf/st-dma-fence-unwrap.c          |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c |  3 +--
 drivers/gpu/drm/xe/xe_sync.c                   |  2 +-
 drivers/gpu/drm/xe/xe_vm.c                     |  4 ++--
 include/linux/dma-fence-array.h                |  6 ++----
 8 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
index 089f69469524..5e10e8df372f 100644
--- a/drivers/dma-buf/dma-fence-array.c
+++ b/drivers/dma-buf/dma-fence-array.c
@@ -190,15 +190,13 @@ EXPORT_SYMBOL(dma_fence_array_alloc);
  * @fences:		[in]	array containing the fences
  * @context:		[in]	fence context to use
  * @seqno:		[in]	sequence number to use
- * @signal_on_any:	[in]	signal on any fence in the array
  *
  * Implementation of @dma_fence_array_create without allocation. Useful to init
  * a preallocated dma fence array in the path of reclaim or dma fence signaling.
  */
 void dma_fence_array_init(struct dma_fence_array *array,
 			  int num_fences, struct dma_fence **fences,
-			  u64 context, unsigned seqno,
-			  bool signal_on_any)
+			  u64 context, unsigned seqno)
 {
 	static struct lock_class_key dma_fence_array_lock_key;
 
@@ -222,7 +220,7 @@ void dma_fence_array_init(struct dma_fence_array *array,
 	 */
 	lockdep_set_class(&array->base.inline_lock, &dma_fence_array_lock_key);
 
-	atomic_set(&array->num_pending, signal_on_any ? 1 : num_fences);
+	atomic_set(&array->num_pending, num_fences);
 	array->fences = fences;
 
 	array->base.error = PENDING_ERROR;
@@ -249,7 +247,6 @@ EXPORT_SYMBOL(dma_fence_array_init);
  * @fences:		[in]	array containing the fences
  * @context:		[in]	fence context to use
  * @seqno:		[in]	sequence number to use
- * @signal_on_any:	[in]	signal on any fence in the array
  *
  * Allocate a dma_fence_array object and initialize the base fence with
  * dma_fence_init().
@@ -264,8 +261,7 @@ EXPORT_SYMBOL(dma_fence_array_init);
  */
 struct dma_fence_array *dma_fence_array_create(int num_fences,
 					       struct dma_fence **fences,
-					       u64 context, unsigned seqno,
-					       bool signal_on_any)
+					       u64 context, unsigned seqno)
 {
 	struct dma_fence_array *array;
 
@@ -273,8 +269,7 @@ struct dma_fence_array *dma_fence_array_create(int num_fences,
 	if (!array)
 		return NULL;
 
-	dma_fence_array_init(array, num_fences, fences,
-			     context, seqno, signal_on_any);
+	dma_fence_array_init(array, num_fences, fences, context, seqno);
 
 	return array;
 }
diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index 07fe9bf45aea..53bb40e70b27 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -180,8 +180,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 
 	if (count > 1) {
 		result = dma_fence_array_create(count, array,
-						dma_fence_context_alloc(1),
-						1, false);
+						dma_fence_context_alloc(1), 1);
 		if (!result) {
 			for (i = 0; i < count; i++)
 				dma_fence_put(array[i]);
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index ce9e6c04897f..39a92d9f2413 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -648,8 +648,7 @@ int dma_resv_get_singleton(struct dma_resv *obj, enum dma_resv_usage usage,
 	}
 
 	array = dma_fence_array_create(count, fences,
-				       dma_fence_context_alloc(1),
-				       1, false);
+				       dma_fence_context_alloc(1), 1);
 	if (!array) {
 		while (count--)
 			dma_fence_put(fences[count]);
diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
index 51c87869b7b8..4e7ee25372ba 100644
--- a/drivers/dma-buf/st-dma-fence-unwrap.c
+++ b/drivers/dma-buf/st-dma-fence-unwrap.c
@@ -64,7 +64,7 @@ static struct dma_fence *mock_array(unsigned int num_fences, ...)
 
 	array = dma_fence_array_create(num_fences, fences,
 				       dma_fence_context_alloc(1),
-				       1, false);
+				       1);
 	if (!array)
 		goto error_free;
 	return &array->base;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 942f4eed817f..4a1a9031f9db 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -3205,8 +3205,7 @@ eb_composite_fence_create(struct i915_execbuffer *eb, int out_fence_fd)
 	fence_array = dma_fence_array_create(eb->num_batches,
 					     fences,
 					     eb->context->parallel.fence_context,
-					     eb->context->parallel.seqno++,
-					     false);
+					     eb->context->parallel.seqno++);
 	if (!fence_array) {
 		kfree(fences);
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index 24d6d9af20d6..37866768d64c 100644
--- a/drivers/gpu/drm/xe/xe_sync.c
+++ b/drivers/gpu/drm/xe/xe_sync.c
@@ -376,7 +376,7 @@ xe_sync_in_fence_get(struct xe_sync_entry *sync, int num_sync,
 		xe_assert(vm->xe, current_fence == num_fence);
 		cf = dma_fence_array_create(num_fence, fences,
 					    dma_fence_context_alloc(1),
-					    1, false);
+					    1);
 		if (!cf)
 			goto err_out;
 
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 56e2db50bb36..8f472911469d 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3370,7 +3370,7 @@ static struct dma_fence *ops_execute(struct xe_vm *vm,
 		goto err_trace;
 	}
 
-	cf = dma_fence_array_alloc(n_fence);
+	cf = dma_fence_array_alloc();
 	if (!cf) {
 		fence = ERR_PTR(-ENOMEM);
 		goto err_out;
@@ -3414,7 +3414,7 @@ static struct dma_fence *ops_execute(struct xe_vm *vm,
 
 	xe_assert(vm->xe, current_fence == n_fence);
 	dma_fence_array_init(cf, n_fence, fences, dma_fence_context_alloc(1),
-			     1, false);
+			     1);
 	fence = &cf->base;
 
 	for_each_tile(tile, vm->xe, id) {
diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
index 370b3d2bba37..1b1d87579c38 100644
--- a/include/linux/dma-fence-array.h
+++ b/include/linux/dma-fence-array.h
@@ -81,13 +81,11 @@ to_dma_fence_array(struct dma_fence *fence)
 struct dma_fence_array *dma_fence_array_alloc(int num_fences);
 void dma_fence_array_init(struct dma_fence_array *array,
 			  int num_fences, struct dma_fence **fences,
-			  u64 context, unsigned seqno,
-			  bool signal_on_any);
+			  u64 context, unsigned seqno);
 
 struct dma_fence_array *dma_fence_array_create(int num_fences,
 					       struct dma_fence **fences,
-					       u64 context, unsigned seqno,
-					       bool signal_on_any);
+					       u64 context, unsigned seqno);
 
 bool dma_fence_match_context(struct dma_fence *fence, u64 context);
 
-- 
2.43.0

