Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF293606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cQbN4ShB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9114D10ECC3;
	Sat, 14 Nov 2026 16:24:48 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D0910E128
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:12:27 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-36ecc11bd26so160686eec.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794589947; x=1795194747; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xv91mbpY6CHl9oZ10SuH7nK8AHihJpvpXeevDfWrpHA=;
 b=cQbN4ShB1jz2O9X7X7EJkdn4c0nO5KxB9AtMhpxJflMDFpVp2DmAsALx2AjKB5lbbP
 bj7F/wcVzwSnT9cMbLEs77OqHJ6IJY6u0Mmp2cXo9xVcTM+uDRqYdwhAtPgqEGsySQEV
 WF938rmwHm1p/Fa1SrMZbC9QYq60+kN7RM+HaTrP0HvCRlcFGdVVzORO4xXgQOqozW80
 w4jhDbjsvmkj4LM3o9ShgNhRURCNeg3sRbHwJp7H+BX7s2oTJ5G7O6g/TBqwRvw+vAFK
 rIMINiW+1UnaOwsRod6IGxy45yxABb4AxloRK7hU1mBe2wAzL9SEZPDUiF1BfpwYpV6o
 AgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794589947; x=1795194747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xv91mbpY6CHl9oZ10SuH7nK8AHihJpvpXeevDfWrpHA=;
 b=YnxBNgFmVitQ1LhjpPf5muCX+J1aZOCOj5SNESjLE6qrKVkl5/DNQhPuMfBgurxlFD
 YHGYkiucqTHXShvSDDnq1X4NMp+AJI6N6nafTcStb0ZgDqxCkc9ZX2STqqKFf0P5ep5m
 Y5phjDRZAst4OkBnsYKUe1I6dRLqG5vXCGekTa6bf1v2lBGhLMuGP3pZV/DoG9nfe/a6
 IvRn7AaiSDRIQMJ6lM2k3NuC3cL4QhXq/gvMVCxrJQGG8/8iNqCaDzQ2B84uYoAJvLUT
 ZP3zL2UB1G7T1yqoApMACHkjHefHu1HlhUkkVaZZ2UDf/Dwu0OvFV+J4kpUiBE8F7bbE
 gKSg==
X-Forwarded-Encrypted: i=1;
 AL+hErFeeZCfJQXPuu33iUfDUs2R63ti/Fo916VzOR7/1FjhbBCy6Td+Mt+eSz3CLwY3lJtipd2okZzNZ+A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ooWFVZ7UL9wkCq36W5sHb+x4c19Ow/wjuOb1WYP6DRh3omKUi
 KuUFZseoY0xkSx20RnUoVfTw1OjnJ8DNpXp02JPXbCMbW3UimEbcmxsP
X-Gm-Gg: AYBFou3O6q8o1pSyko0tJRaenTBoi0D2nlIKMHGkWJ/pqJpHj8mLlXUMtOG+2UnXrEp
 fT5F0KW2gT6r+aN6BrQ83+N2BMCeOJlA7MPlfM03cE9Pb/tySqLdJXtCJeWspDyoYQc/NyMcQIb
 0khTYsJopobJlNHUpjztbuURSjw0H7/5u9emXt7V1dmwwTRnb9eYW1Od8aV/YqVmck98jYiymzQ
 lgKIbdHoZH16bipiPONF0HcHdmZlX8jSx7dyC+mp7uUHEUHmnUurdRvixYwsuWzU7GJ1vBzYHyj
 a4IrSQPsQhDqX5eLGiPcuIFmFSbx6bFliPDIozH97RkQ/vv1PXZSjjBg8pbTmb4QSa+lUMN2ume
 RTe2ZS+klLdCNAJgdMXeU65vw8K3cLAV32Ri31CKKwr1iXERg53KxFXMIYmoIkJpmvl74Bpi8tZ
 6iEVwGRARyTPqza4r34SImokaQZe6aJuoAqpXWT9J2ByTzZjz0eSX3Ezz7QrAz8g7Gz1aQ2C25Y
 cZoRHv6r1a0aqyXiCO7u9BUU+HrfQXr2NaEYdZDyE7SMvBTD6hFrRaGqzXzsGeurtt5s6YQHHwq
 NAwxvOwNI77AaSU3lU/tFxQi8x8ez7JXTUfBFfa/E+ol1iLVvsMrkSUPvCoAHFAziHmXOCsUcvJ
 3cz0=
X-Received: by 2002:a05:7022:7f04:b0:1a1:9106:cfff with SMTP id
 a92af1059eb24-1b503097baamr4481535c88.2.1794589946743; 
 Fri, 13 Nov 2026 09:12:26 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b505b5bf76sm5975999c88.10.2026.11.13.09.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:12:26 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jiwoo Kim <arpe1618@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/panthor: Fix unlocked pool->vm access in
 panthor_heap_create()
Date: Sat, 14 Nov 2026 02:12:14 +0900
Message-ID: <20261113171211.836427578-1-arpe1618@gmail.com>
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

panthor_heap_create() takes a reference on pool->vm under pool->lock,
because the pool can be destroyed concurrently, and the initial heap
chunks used to be allocated in that VM. Since commit c63c3bfdde26
("drm/panthor: Avoid sleep locking in the internal BO size path"),
panthor_alloc_heap_chunk() takes the pool instead and reads pool->vm
itself. panthor_heap_grow() calls it with pool->lock held, but
panthor_heap_create() does not, so pool->vm is read without the lock
for every initial chunk.

If TILER_HEAP_CREATE races with VM_DESTROY on the same VM,
panthor_vm_destroy() calls panthor_heap_pool_destroy(), which sets
pool->vm to NULL, and panthor_kernel_bo_create() can then be called
with a NULL VM, which hits its drm_WARN_ON(!vm) and fails with
-EINVAL.

Pass the VM to panthor_alloc_heap_chunk() and
panthor_alloc_heap_chunks() again: panthor_heap_create() passes the VM
it holds a reference on, and panthor_heap_grow() passes pool->vm, which
it reads under pool->lock. In the race above, the initial chunks are
then created in the destroyed but still referenced VM, and
panthor_heap_create() frees them and fails with -EINVAL when it finds
the pool destroyed under pool->lock, as it did before that commit.

The problem was found through AI-assisted source code review. The fix
is compile-tested only and there is no reproducer, as I don't have
Mali CSF hardware.

Fixes: c63c3bfdde26 ("drm/panthor: Avoid sleep locking in the internal BO size path")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---

Notes:
    This is the follow-up mentioned in "[PATCH] drm/panthor: Don't access
    gpu_contexts of a destroyed heap pool":
    https://lore.kernel.org/all/20261113162648.110226253-1-arpe1618@gmail.com/
    The two patches are independent and apply in either order.
    
    It conflicts with Osama Abdelkader's pending "drm/panthor: Fix race
    when retrieving the new chunk in panthor_heap_grow()", which also
    changes the panthor_alloc_heap_chunk() arguments. I can rebase on top
    of it if it lands first.

 drivers/gpu/drm/panthor/panthor_heap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 99311abdf1..46f53699a2 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -137,7 +137,12 @@ static void panthor_free_heap_chunk(struct panthor_heap_pool *pool,
 	kfree(chunk);
 }
 
+/*
+ * @vm must be pool->vm read under pool->lock, or a reference taken from it
+ * under that lock: panthor_heap_pool_destroy() clears pool->vm.
+ */
 static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
+				    struct panthor_vm *vm,
 				    struct panthor_heap *heap,
 				    bool initial_chunk)
 {
@@ -149,7 +154,7 @@ static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
 	if (!chunk)
 		return -ENOMEM;
 
-	chunk->bo = panthor_kernel_bo_create(pool->ptdev, pool->vm, heap->chunk_size,
+	chunk->bo = panthor_kernel_bo_create(pool->ptdev, vm, heap->chunk_size,
 					     DRM_PANTHOR_BO_NO_MMAP,
 					     DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
 					     PANTHOR_VM_KERNEL_AUTO_VA,
@@ -209,6 +214,7 @@ static void panthor_free_heap_chunks(struct panthor_heap_pool *pool,
 }
 
 static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,
+				     struct panthor_vm *vm,
 				     struct panthor_heap *heap,
 				     u32 chunk_count)
 {
@@ -216,7 +222,7 @@ static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,
 	u32 i;
 
 	for (i = 0; i < chunk_count; i++) {
-		ret = panthor_alloc_heap_chunk(pool, heap, true);
+		ret = panthor_alloc_heap_chunk(pool, vm, heap, true);
 		if (ret)
 			return ret;
 	}
@@ -315,7 +321,7 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
 	heap->max_chunks = max_chunks;
 	heap->target_in_flight = target_in_flight;
 
-	ret = panthor_alloc_heap_chunks(pool, heap, initial_chunk_count);
+	ret = panthor_alloc_heap_chunks(pool, vm, heap, initial_chunk_count);
 	if (ret)
 		goto err_free_heap;
 
@@ -473,7 +479,7 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
 	 * further jobs in this queue fail immediately instead of having to
 	 * wait for the job timeout.
 	 */
-	ret = panthor_alloc_heap_chunk(pool, heap, false);
+	ret = panthor_alloc_heap_chunk(pool, pool->vm, heap, false);
 	if (ret)
 		goto out_unlock;
 

base-commit: bafda823590ddf7031ecb765d673572fae7ab44a
-- 
2.43.0

