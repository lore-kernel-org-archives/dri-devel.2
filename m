Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76285C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD65210F81E;
	Fri,  3 Jul 2026 14:16:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xb1w3IKZ";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70DE610F81E
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 14:16:42 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493b1710405so3485635e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783088201; x=1783693001; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lskiCzL04/SeK1/iyp8dzWHm0r0N5RaxkUMlmtlc8uk=;
 b=Xb1w3IKZunCNCK21TRr+P5sDRVxgbTDhsMZart2bRu8lED3vGIeE5veC1wwb4v+BD0
 1a731aRPTl+lv/bkoAdQ6TxsQhreHU2q27fo2tpPPLAeLVcBYNo3KITgpOvBsUGSfUnt
 mlaP8NPo6CKT5EtLP/SBxbFylSFC8cwvUppCwvmstsmD1dpN9VjwIm01yeZ0bay2GdZI
 lAhHdOyN7UVer0XWOhxZqZ3frRjcXSVfVOCCZhzqaQjb7q82pOoZP1CH6847SsE5GQ4G
 EPJkaryL9GKrV6I67GC8mLEspZv3GoP1Fbhpuk7uxxoW4WAk+AR25YGiWMJJi544nE8f
 jrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783088201; x=1783693001;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lskiCzL04/SeK1/iyp8dzWHm0r0N5RaxkUMlmtlc8uk=;
 b=AUdMv6afMZdXYUgQ4Bw2zg3lBjLT/SEBUpZCYCHkNAIhW+9vBBEoqLq9P3KBtE0qdi
 iUR1DtkAlucz0x8JU56Zy2dPNLHHjSc/XxNN4kWsXfzHsUkcdq6eqF4Qr3z3jXxwb12v
 4hVV0fDlT55ua9BeZmGw0RZQ5rDbGQs7OImIbMS+/Dum9xYjB1jAfNiziicDgUhJFT5B
 Ul9s+JAynSFjsAS3CfOWwSFIBRy1imW6K2vtPAYZCha46d5OU6gTkfILNtiJcJJE2HVX
 b2VnL6PuOdiEoZT20ANwQxZo41iGeC+SA+PKtMZ88gacGACJPyvijhd2v1pfaozT7pek
 OxjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QGX+oFHC9MNkrPlM8o8IbPVN00U9mk/A+KDOpPxaFLcm4isA/2JjO9n5TJzBldUyBovUbMNu1Rug=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8h5sOsKRevsgUaHGFPqtA5AnF9YiAO2u/dEqjc+gjxjq9QpIJ
 5fPCToF6vjfJejr6EEYbwFiw5MmNC1PzGy4D4v4N9yHMzhOXfg0hsYz3QgghBPF9zmM=
X-Gm-Gg: AfdE7ckULMnsxzMMgNXO2tpqdoTCY6AYFD95nfE002hCO3UxP2BMrPz+aXZcoS8shpt
 arpcmp/e+N81AKBJR2/RtPcH1oDDkL8JrSn0sTOfsURLbFJ0YujleJeoWr5FWjFSF5XGxDtU175
 CtFo2v5juwJkaytR/KxTzr64+CXZDI5RSQtAJNLBn9HNOlYZ2CNbx7ZGjl4yalEaSPpgQVYBwFr
 2De6oSsiGnAxFBzzzJ4nt+s2nNWeWOpM5MRkBiPMD/Nx04nZJwzwOavqWmjdr3oYBCcyeAxnPtm
 dsEtbtEANtuG8L67DlTTzkumBQfI97rV5humaQKJB3jq6x73c/bjTrshlD4E8IA+eHXON+SuPZd
 FquIimQSSrPYzRnTE7SxG+PPIlXtiFvKVzScOMniBBKZjrFhyB8Z2XKwP5xnZ7OPxvY60q8zv/w
 O2ncwWLTLuHGnZsmDUiAw8v3d6P3W/Vdo+kDQE3j3TauL/BYn+r0VQoneuZjJOECA=
X-Received: by 2002:a05:600c:4194:b0:493:b764:ff98 with SMTP id
 5b1f17b1804b1-493d0f100c3mr517275e9.11.1783088200711; 
 Fri, 03 Jul 2026 07:16:40 -0700 (PDT)
Received: from ta2.c.googlers.com (214.8.78.34.bc.googleusercontent.com.
 [34.78.8.214]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce11497sm56004595e9.12.2026.07.03.07.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 07:16:40 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 03 Jul 2026 14:16:36 +0000
Subject: [PATCH] dma-buf: remove unused dma-fence-unwrap.c
 (stable/linux-5.15.y only)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260703-5-15-dma-fence-unwrap-v1-1-0cf644bc501f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAETER2oC/x3MSQqAMAxA0atI1gZincCriIvQppqFVVocQLy7x
 eVb/P9AkqiSYCgeiHJq0i1kVGUBduEwC6rLBkOmo55qbLFq0a2MXoIVPMIVeUfyDXeWasfeQG7
 3KF7v/ztO7/sB/HMeWmcAAAA=
X-Change-ID: 20260703-5-15-dma-fence-unwrap-0f4a6c03daf2
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Gustavo Padovan <gustavo@padovan.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sasha Levin <sashal@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Yunxiang Li <Yunxiang.Li@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 peter.griffin@linaro.org, andre.draszik@linaro.org, jyescas@google.com, 
 kernel-team@android.com, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783088200; l=6233;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=IoBDA9RGNCrEvq0FVmsK4Z45OhW+Q/oVyDeW5CmzsEk=;
 b=bXpjW/Wws+hGcp56bVJAO0VTeqV6NGPVaFHSi0ulYSZHMsW6kJiBJ8BRP6pFh3jm63Qunv+yE
 F57tc7/d0YOA6VZ/8RTBQP80J9o3N22CnarbId+FauxgboFRvWFStiO
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
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

The file drivers/dma-buf/dma-fence-unwrap.c was incorrectly added to
the 5.15.y stable branch in commit 4e82b9c11d3c ("dma-buf: add
dma_fence_timestamp helper") as a new file, but it was never enabled in
the Makefile, and its header include/linux/dma-fence-unwrap.h was not
present, making it uncompilable.

A full revert of commit 4e82b9c11d3c ("dma-buf: add dma_fence_timestamp
helper") is not desirable because that commit also introduced the valid
dma_fence_timestamp() helper and fixed legitimate timestamp race
windows in drivers/dma-buf/sync_file.c and
drivers/gpu/drm/scheduler/sched_main.c.

Since there are no users of dma-fence-unwrap in the 5.15.y branch,
remove the unused file to clean up the tree and avoid confusion.

Fixes: 4e82b9c11d3c ("dma-buf: add dma_fence_timestamp helper")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/dma-buf/dma-fence-unwrap.c | 176 -------------------------------------
 1 file changed, 176 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
deleted file mode 100644
index 628af51c81af..000000000000
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ /dev/null
@@ -1,176 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * dma-fence-util: misc functions for dma_fence objects
- *
- * Copyright (C) 2022 Advanced Micro Devices, Inc.
- * Authors:
- *	Christian König <christian.koenig@amd.com>
- */
-
-#include <linux/dma-fence.h>
-#include <linux/dma-fence-array.h>
-#include <linux/dma-fence-chain.h>
-#include <linux/dma-fence-unwrap.h>
-#include <linux/slab.h>
-
-/* Internal helper to start new array iteration, don't use directly */
-static struct dma_fence *
-__dma_fence_unwrap_array(struct dma_fence_unwrap *cursor)
-{
-	cursor->array = dma_fence_chain_contained(cursor->chain);
-	cursor->index = 0;
-	return dma_fence_array_first(cursor->array);
-}
-
-/**
- * dma_fence_unwrap_first - return the first fence from fence containers
- * @head: the entrypoint into the containers
- * @cursor: current position inside the containers
- *
- * Unwraps potential dma_fence_chain/dma_fence_array containers and return the
- * first fence.
- */
-struct dma_fence *dma_fence_unwrap_first(struct dma_fence *head,
-					 struct dma_fence_unwrap *cursor)
-{
-	cursor->chain = dma_fence_get(head);
-	return __dma_fence_unwrap_array(cursor);
-}
-EXPORT_SYMBOL_GPL(dma_fence_unwrap_first);
-
-/**
- * dma_fence_unwrap_next - return the next fence from a fence containers
- * @cursor: current position inside the containers
- *
- * Continue unwrapping the dma_fence_chain/dma_fence_array containers and return
- * the next fence from them.
- */
-struct dma_fence *dma_fence_unwrap_next(struct dma_fence_unwrap *cursor)
-{
-	struct dma_fence *tmp;
-
-	++cursor->index;
-	tmp = dma_fence_array_next(cursor->array, cursor->index);
-	if (tmp)
-		return tmp;
-
-	cursor->chain = dma_fence_chain_walk(cursor->chain);
-	return __dma_fence_unwrap_array(cursor);
-}
-EXPORT_SYMBOL_GPL(dma_fence_unwrap_next);
-
-/* Implementation for the dma_fence_merge() marco, don't use directly */
-struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
-					   struct dma_fence **fences,
-					   struct dma_fence_unwrap *iter)
-{
-	struct dma_fence_array *result;
-	struct dma_fence *tmp, **array;
-	ktime_t timestamp;
-	unsigned int i;
-	size_t count;
-
-	count = 0;
-	timestamp = ns_to_ktime(0);
-	for (i = 0; i < num_fences; ++i) {
-		dma_fence_unwrap_for_each(tmp, &iter[i], fences[i]) {
-			if (!dma_fence_is_signaled(tmp)) {
-				++count;
-			} else {
-				ktime_t t = dma_fence_timestamp(tmp);
-
-				if (ktime_after(t, timestamp))
-					timestamp = t;
-			}
-		}
-	}
-
-	/*
-	 * If we couldn't find a pending fence just return a private signaled
-	 * fence with the timestamp of the last signaled one.
-	 */
-	if (count == 0)
-		return dma_fence_allocate_private_stub(timestamp);
-
-	array = kmalloc_array(count, sizeof(*array), GFP_KERNEL);
-	if (!array)
-		return NULL;
-
-	/*
-	 * This trashes the input fence array and uses it as position for the
-	 * following merge loop. This works because the dma_fence_merge()
-	 * wrapper macro is creating this temporary array on the stack together
-	 * with the iterators.
-	 */
-	for (i = 0; i < num_fences; ++i)
-		fences[i] = dma_fence_unwrap_first(fences[i], &iter[i]);
-
-	count = 0;
-	do {
-		unsigned int sel;
-
-restart:
-		tmp = NULL;
-		for (i = 0; i < num_fences; ++i) {
-			struct dma_fence *next;
-
-			while (fences[i] && dma_fence_is_signaled(fences[i]))
-				fences[i] = dma_fence_unwrap_next(&iter[i]);
-
-			next = fences[i];
-			if (!next)
-				continue;
-
-			/*
-			 * We can't guarantee that inpute fences are ordered by
-			 * context, but it is still quite likely when this
-			 * function is used multiple times. So attempt to order
-			 * the fences by context as we pass over them and merge
-			 * fences with the same context.
-			 */
-			if (!tmp || tmp->context > next->context) {
-				tmp = next;
-				sel = i;
-
-			} else if (tmp->context < next->context) {
-				continue;
-
-			} else if (dma_fence_is_later(tmp, next)) {
-				fences[i] = dma_fence_unwrap_next(&iter[i]);
-				goto restart;
-			} else {
-				fences[sel] = dma_fence_unwrap_next(&iter[sel]);
-				goto restart;
-			}
-		}
-
-		if (tmp) {
-			array[count++] = dma_fence_get(tmp);
-			fences[sel] = dma_fence_unwrap_next(&iter[sel]);
-		}
-	} while (tmp);
-
-	if (count == 0) {
-		tmp = dma_fence_allocate_private_stub(ktime_get());
-		goto return_tmp;
-	}
-
-	if (count == 1) {
-		tmp = array[0];
-		goto return_tmp;
-	}
-
-	result = dma_fence_array_create(count, array,
-					dma_fence_context_alloc(1),
-					1, false);
-	if (!result) {
-		tmp = NULL;
-		goto return_tmp;
-	}
-	return &result->base;
-
-return_tmp:
-	kfree(array);
-	return tmp;
-}
-EXPORT_SYMBOL_GPL(__dma_fence_unwrap_merge);

---
base-commit: eceeec79dbc646d6dace49ed1ba2f656683d5537
change-id: 20260703-5-15-dma-fence-unwrap-0f4a6c03daf2

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

