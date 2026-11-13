Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E90606A335
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R319Fwef
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A67A310EE01;
	Sat, 14 Nov 2026 16:24:48 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C7510E110
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:27:13 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3b1c2c31a6fso49551a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794587233; x=1795192033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nH+4fuf6JFUHnT4EFq7h99rEDt8N7Ykz0lHqkyH7S6o=;
 b=R319FwefEDfx3ZYs+xaEBGfaH5PZWHyNZu3VRmZA8LQIW1mUcUCr2Dp5UQBWayFuH4
 E44xe7P38SpBNWLK55uCfERCdGESegBZPVUUoDYksDjyQ6FuXAiWF7fxlpdWTTfBdneo
 MEn4Jkp84Pv410TFkxPin3M9Hc5i2uij8QYrehbNzQ1kPvf32sfprjlBOyovBBOVFT+A
 f4SN6jqev17FeAnTeCpyjZ8IZZX5iMN2GRFMnS4Y13/gjP0/OjhRu2hbnavRsNHZVfmw
 trVduVsF/9+14D9OsSrQoc+HRsgiYf2pJikZCazHXCQj0ph/ssOMfZud+C1MvvMCoAYa
 zT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794587233; x=1795192033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nH+4fuf6JFUHnT4EFq7h99rEDt8N7Ykz0lHqkyH7S6o=;
 b=K7xhwHaQ3pxlQIApsJgAJaawV7Y1jH+2dqlI2gQfXLKIiKynFaM6sEfQVUdXEti/o5
 VQlWuIIzvyJJn2/35qrDB8N+44MTD0xd6ecgNUwyj9c6tLiB5kSISQ95RmZ8PPVMHgLd
 DNXXzlR5FAp80zHqb7AkqYF7vTHTz2gRRZwNl0/vX7COjTkb7JiezBmhjyZ7KClJSFwb
 Qcel/023uRWTaSrVMD+DuXPLSVnoBA5Xkz3w1K9CWMlqFd9gLQt2myD7RFiFfmxC2dTp
 aKdljtUrPSpO8q02Y0WKJfEtZSd28+sqUHY25V31100WXMFtl+jVmXJ6ApdjqGgyVixM
 nwKw==
X-Forwarded-Encrypted: i=1;
 AL+hErGmU4zLXdvJxl+p+bQoQLoYy3bH4XC+bDcazwu+UGNKYP5av2WqSpzq8B0ITEmeW9+gvIRCEbQSHoo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z91o7nNs/9q5bjYpKzMGy2KikIvy0cn5HuiyfuORm3sb1qfVdZq
 Wsec1fk3tg3Cwxnltf8ORcgfJ+diSiVLcWdOGIvoA852IuExuYTw06gQ
X-Gm-Gg: AYBFou37UbhEaqAktNF1aJhq30EpHKUWd4YzqOu8UJqOfiBVTiU0hAX5uB6qOapzDgF
 beOKesxn+3UyTYVN3e/pYjUD7Sy35/DgUCEW5Ih8WXTEGmEB6uTBTBfCbTDYy9Yto/X1IyvZdcy
 Nl3OpTe7wFAAv5Z4Zop7iKaSmdOCaAJMVkeIu0KBRanPHk471/lNmujIfA5setvo+f+55b26fit
 9/RdRBGM+84nBahpEy0toe06LtfegYSYld0mJAKTxPk17NgA0QdbDTosZVP19lPV/9jrX5mLbCn
 6QNHZTB33wuFwrC+7Rhnm2dzl0gjICsQX6xLuF6OXDqG3hesqi/gb+8LhPxTt7RS+6UkthFua9e
 2buZvpQ6A/kQcjDQBqreB/wsDvlrVVomi7KFjncLfbki7MntJh1EGQHRWPH1zFlnw7AHAVNZd3L
 4JPQYb17vSz6p87snZ57ZG27akzO8mx8Q7KVsHUSEFIpP9xOI+c2+u/lqIjwCrBZEswEwdbdzfJ
 Ez/hXVmOxKgHle4xM6pBw+fQKU9H5i9RGOfvccLvFZ8L9q+3kXw6SIs6TzFPD2V9W/NaGR/iUly
 AK4X5ULqz4xoXlbtYhbPdsV0YikRdfc8+r03gkRU4ilJ43tjk3ndH2ZDxFrD2hlkxlvlyIQQU09
 fItA=
X-Received: by 2002:a17:90b:568f:b0:3ae:629:ca12 with SMTP id
 98e67ed59e1d1-3b1b0b506dbmr4305114a91.3.1794587233028; 
 Fri, 13 Nov 2026 08:27:13 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1bfb607e7sm712916a91.3.2026.11.13.08.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:27:09 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jiwoo Kim <arpe1618@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/panthor: Don't access gpu_contexts of a destroyed heap
 pool
Date: Sat, 14 Nov 2026 01:26:51 +0900
Message-ID: <20261113162648.110226253-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

panthor_heap_grow() and panthor_heap_return_chunk() compute the heap
context offset from pool->gpu_contexts before taking pool->lock.

The tiler OOM work holds references on the group, its VM and the heap
pool when it calls these functions, but nothing stops
panthor_vm_destroy() from destroying the pool in the meantime.
panthor_heap_pool_destroy() frees the gpu_contexts BO under pool->lock
and marks the pool as destroyed by clearing pool->vm, but leaves
pool->gpu_contexts pointing to the freed BO. VM destruction doesn't
wait for the work either: panthor_sched_prepare_for_vm_destruction()
only flushes the scheduler tick work, and only when the VM is active,
and evicting the group doesn't help, as group_unbind_locked() uses
cancel_work(), which doesn't wait for a tiler OOM work that is already
running. Such a work can then read the freed BO.

Take pool->lock before dereferencing pool->gpu_contexts, and return
-EINVAL if the pool has been destroyed, as panthor_heap_create()
already does.

The problem was found through AI-assisted source code review. The fix
is compile-tested only and there is no reproducer, as I don't have
Mali CSF hardware.

Fixes: 9cca48fa4f89 ("drm/panthor: Add the heap logical block")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---

Notes:
    This conflicts trivially with Osama Abdelkader's pending "drm/panthor:
    Fix race when retrieving the new chunk in panthor_heap_grow()", as both
    change the local variables at the top of panthor_heap_grow(). I can
    rebase on top of it if it lands first.
    
    While looking at this, I also noticed that panthor_heap_create() reads
    pool->vm without pool->lock when allocating the initial chunks, in
    panthor_alloc_heap_chunk(), so a concurrent VM destroy can make
    panthor_kernel_bo_create() hit its drm_WARN_ON(!vm). That doesn't touch
    freed memory and is left for a separate patch.

 drivers/gpu/drm/panthor/panthor_heap.c | 44 +++++++++++++++++++-------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 99311abdf1..e55f7e648d 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -90,7 +90,7 @@ struct panthor_heap_pool {
 	/** @vm: VM this pool is bound to. */
 	struct panthor_vm *vm;
 
-	/** @lock: Lock protecting access to @xa. */
+	/** @lock: Lock protecting access to @xa, @vm and @gpu_contexts. */
 	struct rw_semaphore lock;
 
 	/** @xa: Array storing panthor_heap objects. */
@@ -371,16 +371,27 @@ int panthor_heap_return_chunk(struct panthor_heap_pool *pool,
 			      u64 heap_gpu_va,
 			      u64 chunk_gpu_va)
 {
-	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
-	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
 	struct panthor_heap_chunk *chunk, *tmp, *removed = NULL;
 	struct panthor_heap *heap;
+	u32 heap_id;
+	u64 offset;
 	int ret;
 
-	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
-		return -EINVAL;
-
 	down_read(&pool->lock);
+
+	/* The heap contexts are gone if the pool has been destroyed. */
+	if (!pool->vm) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
+	heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
+	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	heap = xa_load(&pool->xa, heap_id);
 	if (!heap) {
 		ret = -EINVAL;
@@ -435,16 +446,27 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
 		      u32 pending_frag_count,
 		      u64 *new_chunk_gpu_va)
 {
-	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
-	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
 	struct panthor_heap_chunk *chunk;
 	struct panthor_heap *heap;
+	u32 heap_id;
+	u64 offset;
 	int ret;
 
-	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
-		return -EINVAL;
-
 	down_read(&pool->lock);
+
+	/* The heap contexts are gone if the pool has been destroyed. */
+	if (!pool->vm) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
+	heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
+	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	heap = xa_load(&pool->xa, heap_id);
 	if (!heap) {
 		ret = -EINVAL;

base-commit: bafda823590ddf7031ecb765d673572fae7ab44a
-- 
2.43.0

