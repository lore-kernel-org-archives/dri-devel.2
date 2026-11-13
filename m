Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4881606A337
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LCld0mtC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A36D10EC9B;
	Fri, 13 Nov 2026 20:47:36 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA4310EC9B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:47:30 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so21513755e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794602848; x=1795207648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CeJdUlTarSzl0zOxcgqdgSz/hfHd0m5LVHMetEyWCNA=;
 b=LCld0mtCDELKZZH3gPBvzocAVhx7swT9N7jU7wwpQClCoyrGNmPNVftJMzxIJRvyK9
 sIiCTfccrMQ+zji3LVc8gEsXDMFwRUBkXZFIf4C2xdXkgRGloA4GFVeoUwzYvhlQvbtQ
 j2Whq0EEMyqsmK1FI2WuvYr7+NMjsre84IFuORTGLraW1NtGgaumIiCZXwRMymhHWUXb
 gjmuyx0D+i6Z3vaF6EvKALOP9ZYu/ssit4GmXGZ1crF0uNQ4iFZeZMcABADOix0cHCBz
 jlCcFfZJ2AvmqdpUNNiOI5sGSVubrxmh34/GsEqHRvb23pNLkysqpvPOalAVZIIij9rS
 NjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794602848; x=1795207648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CeJdUlTarSzl0zOxcgqdgSz/hfHd0m5LVHMetEyWCNA=;
 b=td2gekTYNDntqTUZB+B520ZYilo6JhkUBG1dNVbm1NpgcCW27zmoA+UAzk0rTyFvSb
 C1ye04gPO4O+2N7KRNmfjtAd+WqJXawJMSIb/AcQhgYf9BXCxya6lbiWYSm/M1pbm+KG
 8A6lB++hlu97UpIFRp3ODAL96eRK3ukygkkDG/Dix2Vb1lQfWe4HGiP8wxJJD2Ervs9W
 rVfjwONTiH9xM+EEBegeRHrgXLBhDoQiUB9kXqZuChCxf26WIxPnzQTxRcSyfMGLQK71
 oEbTcbXIrMkDFBoZD9r0mnHkmLDIaW8I3GqdLJbWme821BePT6WNRwfYQXr+ZUziD634
 QuQA==
X-Forwarded-Encrypted: i=1;
 AL+hErFxb9sQ+4iJkhbp5Xr7wx0/3mtxQpzh8AmNmLkskhcUdJWKdlCm+g5RQFn0LZwuwnfi16zk+Wdmv7s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9X5PlzVVRiZ/qoo71QXEsIDlrz9H/rRJQYtE59fguKHAPooQ5v
 TMEr21wxs8frxetHQ4MzmMYVr6yg+Ine/KtJ5QlrU4CwuB41/2acQErz
X-Gm-Gg: AYBFou0T7+vYZ4uoylqE8dA2qsn86AlAAkx10vepW0yXPSPUsgrs9G72ZLvzpkxkTbE
 KQ7uUpPwUi0R4ecLsh6TRNaJujEpoimhAAIJj8ym/OOxHWjosUaNcDYcibJyeVK+dz0vdes/Gf3
 nHX3Nvt4wPV2ga5x6AzEOfjgHMDqAKyH+6AzSAYdzhcidlZGcKVKt2zxXiGmOlqHaTzklJvTfZQ
 gnvzCnvkV3mAuJHOQb+i4iQf4hdphTwE1op9y3q6c72QB15E0SppxKUDNRYyMtkZF2C60wpy7qT
 aSqt+9q/m/VzyJi7V2q4VWzOO0Lj1lUouumIBHsQ7TTFTj0vqGXfua4fdgS4ElpSQ4QmB4r+/M6
 ZQ+WHVCVZZj3l2WD0ro2dZ01rXoDdLAhCi1yvkSu6sF1hzXrI36Ng8qiRgQzHABFafKqwH1AQH6
 LmPafk0aYMQe9Sw7eAQq+NydE4myXg5Oooaf8+7adpwsd9dW3rVz3M+Q4IXASVWWsDOaTJnavZK
 M2wTZMSlgMBD8ueqB2uo0uQQs4k5dj5PmQmvcQDt5UYEtdaaNQYUmPNMGRoMtXlR3PQr0JidFfv
 sSG85BpEjpwP9+HCsw+s1AUv3JrFFlsRg8ShKwekIoJl/IOQDNnPGA/Kzo+v4yXQqELM0Mi8S70
 YVThaEbsO
X-Received: by 2002:a05:600c:3b9d:b0:4bb:5dbf:af06 with SMTP id
 5b1f17b1804b1-4bb5dbfb103mr44986715e9.9.1794602848265; 
 Fri, 13 Nov 2026 12:47:28 -0800 (PST)
Received: from osama ([2a02:908:186:df80:be86:db23:a9d4:f15e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm7282165f8f.49.2026.11.13.12.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:47:27 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/panthor: Fix race when retrieving the new chunk in
 panthor_heap_grow()
Date: Fri, 13 Nov 2026 21:47:16 +0100
Message-ID: <20261113204717.35195-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113110217.6c1513be@fedora1.home>
References: <20261113110217.6c1513be@fedora1.home>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

panthor_heap_grow() allocates a new chunk with panthor_alloc_heap_chunk(),
which adds the chunk at the head of heap->chunks under heap->lock, and
then drops the lock. panthor_heap_grow() then assumes the head of the
list is the chunk it just added, and reads its GPU VA through
list_first_entry() without holding heap->lock.

panthor_heap_grow() and panthor_heap_return_chunk() only take pool->lock
in read mode, and tiler OOM events of different groups are processed in
parallel on the unbound heap_alloc_wq. If two groups use the same heap
context, they can modify the chunk list concurrently:

  group A OOM work                     group B OOM work
  alloc C_A, list_add()
                                       alloc C_B, list_add()
  list_first_entry() -> C_B
                                       group scheduled out:
                                       panthor_heap_return_chunk(C_B)
                                         list_del(), destroy BO, kfree()
  C_B->bo                              <- use-after-free

Even without the free, both groups end up being handed the same chunk,
and the chunk allocated by group A is never linked to the heap context.

Fix this by having panthor_alloc_heap_chunk() return the GPU VA of the
chunk it allocated, retrieved before the chunk is published in the list,
instead of looking it up afterwards. Do the same for the initial chunks
allocated by panthor_heap_create(), so the first chunk GPU VA is
returned by panthor_alloc_heap_chunks() rather than retrieved from the
list.

Fixes: 9cca48fa4f89 ("drm/panthor: Add the heap logical block")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- Always write chunk_gpu_va in panthor_alloc_heap_chunk().
- Have panthor_alloc_heap_chunks() return the first chunk GPU VA, and drop
  the list_first_entry() lookup in panthor_heap_create().

 drivers/gpu/drm/panthor/panthor_heap.c | 39 +++++++++++++++-----------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 99311abdf1e9..febc18b43af8 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -139,7 +139,8 @@ static void panthor_free_heap_chunk(struct panthor_heap_pool *pool,
 
 static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
 				    struct panthor_heap *heap,
-				    bool initial_chunk)
+				    bool initial_chunk,
+				    u64 *chunk_gpu_va)
 {
 	struct panthor_heap_chunk *chunk;
 	struct panthor_heap_chunk_header *hdr;
@@ -181,6 +182,14 @@ static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
 
 	panthor_kernel_bo_vunmap(chunk->bo);
 
+	/*
+	 * Retrieve the GPU VA before the chunk becomes visible in the heap
+	 * chunk list: once heap->lock is released, a concurrent grow or
+	 * return_chunk on the same heap can modify the list, and the chunk
+	 * can be freed.
+	 */
+	*chunk_gpu_va = panthor_kernel_bo_gpuva(chunk->bo);
+
 	mutex_lock(&heap->lock);
 	list_add(&chunk->node, &heap->chunks);
 	heap->chunk_count++;
@@ -210,13 +219,19 @@ static void panthor_free_heap_chunks(struct panthor_heap_pool *pool,
 
 static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,
 				     struct panthor_heap *heap,
-				     u32 chunk_count)
+				     u32 chunk_count,
+				     u64 *first_chunk_gpu_va)
 {
 	int ret;
 	u32 i;
 
+	/*
+	 * Chunks are inserted at the head of the list, so the last chunk
+	 * allocated is the first chunk of the heap.
+	 */
 	for (i = 0; i < chunk_count; i++) {
-		ret = panthor_alloc_heap_chunk(pool, heap, true);
+		ret = panthor_alloc_heap_chunk(pool, heap, true,
+					       first_chunk_gpu_va);
 		if (ret)
 			return ret;
 	}
@@ -280,7 +295,6 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
 			u64 *first_chunk_gpu_va)
 {
 	struct panthor_heap *heap;
-	struct panthor_heap_chunk *first_chunk;
 	struct panthor_vm *vm;
 	int ret = 0;
 	u32 id;
@@ -315,15 +329,11 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
 	heap->max_chunks = max_chunks;
 	heap->target_in_flight = target_in_flight;
 
-	ret = panthor_alloc_heap_chunks(pool, heap, initial_chunk_count);
+	ret = panthor_alloc_heap_chunks(pool, heap, initial_chunk_count,
+					first_chunk_gpu_va);
 	if (ret)
 		goto err_free_heap;
 
-	first_chunk = list_first_entry(&heap->chunks,
-				       struct panthor_heap_chunk,
-				       node);
-	*first_chunk_gpu_va = panthor_kernel_bo_gpuva(first_chunk->bo);
-
 	down_write(&pool->lock);
 	/* The pool has been destroyed, we can't create a new heap. */
 	if (!pool->vm) {
@@ -437,8 +447,8 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
 {
 	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
 	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
-	struct panthor_heap_chunk *chunk;
 	struct panthor_heap *heap;
+	u64 chunk_gpu_va;
 	int ret;
 
 	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
@@ -473,14 +483,11 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
 	 * further jobs in this queue fail immediately instead of having to
 	 * wait for the job timeout.
 	 */
-	ret = panthor_alloc_heap_chunk(pool, heap, false);
+	ret = panthor_alloc_heap_chunk(pool, heap, false, &chunk_gpu_va);
 	if (ret)
 		goto out_unlock;
 
-	chunk = list_first_entry(&heap->chunks,
-				 struct panthor_heap_chunk,
-				 node);
-	*new_chunk_gpu_va = (panthor_kernel_bo_gpuva(chunk->bo) & GENMASK_ULL(63, 12)) |
+	*new_chunk_gpu_va = (chunk_gpu_va & GENMASK_ULL(63, 12)) |
 			    (heap->chunk_size >> 12);
 	ret = 0;
 
-- 
2.53.0

