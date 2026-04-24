Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CB3FE51F1
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831D110F460;
	Fri, 24 Apr 2026 09:20:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SqWOmURp";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D3410F45B
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:20:20 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso103980665e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777022419; x=1777627219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnJ8rz3SAZgwpHSNeGvtwmXY+Huwbmu0iTnb9Qm9g2E=;
 b=SqWOmURpTTyo1T7bzfQWbUVx7EOo3BX9HvQ4jdRCVvmzXfieJgtg0Ts8+nDO4FC5DW
 O/BJTyXYb17fhLbnuio3aynO1IUWakyFJeFoztSNfrR4cRAjfUOt147G4CuOucODkBQ2
 4eQlkbwd4DLcUpblONEGk5zW0nKh3D0r949pKDb3W1VPz6AtyVZXgiRjH5HK0LYTTGKb
 EGxvUA4dCclQ8WkYVGWTD6XII2Kni9T7O4JgQUBbCk2o0pS+q5FyA1EyyMFEQDFK3h7F
 JHtlioEcR4Bqvy9D/Aqtl+55PH5s889IPili/iZhgoSlSZP7niQSsIXedUy8Ww1/AtlM
 sE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777022419; x=1777627219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RnJ8rz3SAZgwpHSNeGvtwmXY+Huwbmu0iTnb9Qm9g2E=;
 b=VjmHMsul31kSqhnJDQLMy6L8TgVIn95a07s1wYhyAyAYyoCXy6olTcveU77XPGg5/Y
 ntntTa2DCE1jWUVTEoAOeVUKBe10qZ7rIN6/44jAnmzN75iljxNQeUvydEawIYGNAOUZ
 QD5AC5rVDCxk39deqVCILCXg+J83sU6Ef4RPRycPsbejatgGj+ydrqGKh/75KeFTv5v6
 JeCf6pw1nVJKuxP6F2mP5d9sHbOawZgeRzi0x96kBpVWeMbLilEdXZQ15bnXlcp1Fm2q
 BtPs/Ylzx1mmmrA1534SlNBXhZYfET31dbiFkTXJyteH4+DwCk4Fge2jyy/zuP39sEs1
 omxw==
X-Gm-Message-State: AOJu0Yzte8pQXy1aHUI8HVokWhov5Fw++HLp/Nlz6uTVDFUNmG4qyQsA
 v2vy9UXSVR8JdjpnIgBOjN9rjtrJC0UiiXJvsI8/o3OSOxngB7VNkiXUgBcOd+NV
X-Gm-Gg: AeBDieuHh+oqiz5oK6jJcxHChgS4DkgyEGHiLmJ0/5hAldKCXtTayAhqHeZDbl1Ubqt
 xFt5FJB3U+aXO3SS3oE6rotJ4YkKwr7RFd5q0Led3tZpOhU8EiwmFHVyLhDFWuG58JGZ2lZyjGK
 fxAN15Y+cNHj97x7jfHUqiDhZCTk1zQMxiXYLj+unKN+PWtSTgvPOClQdKgab3eoDZgc3uzViSE
 e1QPr1po+GuYWK71SglBXxWQ6A1W9L6eyzdXi0sAmvpNTgKkoGCI9sxABfIgRzFaAIv60VwE7Sd
 cvwpfAZU6bq4vjZ8H16tCRD73c1aOqTsBM17QH+xmvoWUpnzT7jabnN/IndJiBFtjF6TtvxNRWD
 9ViFIWYxKY2akZDjun5RwaO0rMK1EUse5Z3r/4p00Lo0+aRhthDmVHQ9ekpb2Y8o0HttbmPiOql
 kXsiz+Q0wpxk7Ivz7zLKhdDfx97p0hopydoc3yB3o09HnuAl8=
X-Received: by 2002:a05:600c:1f83:b0:488:8840:e5ae with SMTP id
 5b1f17b1804b1-488fb787afemr432405435e9.24.1777022418633; 
 Fri, 24 Apr 2026 02:20:18 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f2:7300:95ce:4290:489c:f518])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm660955235e9.1.2026.04.24.02.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:20:18 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH 4/4] drm/ttm: remove ttm_execbuf_util
Date: Fri, 24 Apr 2026 11:15:12 +0200
Message-ID: <20260424092012.5694-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424092012.5694-1-christian.koenig@amd.com>
References: <20260424092012.5694-1-christian.koenig@amd.com>
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

Replaced by drm_exec and not used any more.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/Makefile           |   4 +-
 drivers/gpu/drm/ttm/ttm_execbuf_util.c | 163 -------------------------
 include/drm/ttm/ttm_execbuf_util.h     | 119 ------------------
 3 files changed, 2 insertions(+), 284 deletions(-)
 delete mode 100644 drivers/gpu/drm/ttm/ttm_execbuf_util.c
 delete mode 100644 include/drm/ttm/ttm_execbuf_util.h

diff --git a/drivers/gpu/drm/ttm/Makefile b/drivers/gpu/drm/ttm/Makefile
index 40d07a35293a..e35724b02528 100644
--- a/drivers/gpu/drm/ttm/Makefile
+++ b/drivers/gpu/drm/ttm/Makefile
@@ -3,8 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 
 ttm-y := ttm_tt.o ttm_bo.o ttm_bo_util.o ttm_bo_vm.o ttm_module.o \
-	ttm_execbuf_util.o ttm_range_manager.o ttm_resource.o ttm_pool.o \
-	ttm_device.o ttm_sys_manager.o ttm_backup.o
+	ttm_range_manager.o ttm_resource.o ttm_pool.o ttm_device.o \
+	ttm_sys_manager.o ttm_backup.o
 ttm-$(CONFIG_AGP) += ttm_agp_backend.o
 
 obj-$(CONFIG_DRM_TTM) += ttm.o
diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
deleted file mode 100644
index bc7a83a9fe44..000000000000
--- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
+++ /dev/null
@@ -1,163 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR MIT */
-/**************************************************************************
- *
- * Copyright (c) 2006-2009 VMware, Inc., Palo Alto, CA., USA
- * All Rights Reserved.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the
- * "Software"), to deal in the Software without restriction, including
- * without limitation the rights to use, copy, modify, merge, publish,
- * distribute, sub license, and/or sell copies of the Software, and to
- * permit persons to whom the Software is furnished to do so, subject to
- * the following conditions:
- *
- * The above copyright notice and this permission notice (including the
- * next paragraph) shall be included in all copies or substantial portions
- * of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
- * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
- * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
- * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
- * USE OR OTHER DEALINGS IN THE SOFTWARE.
- *
- **************************************************************************/
-
-#include <linux/export.h>
-
-#include <drm/ttm/ttm_execbuf_util.h>
-#include <drm/ttm/ttm_bo.h>
-
-static void ttm_eu_backoff_reservation_reverse(struct list_head *list,
-					      struct ttm_validate_buffer *entry)
-{
-	list_for_each_entry_continue_reverse(entry, list, head) {
-		struct ttm_buffer_object *bo = entry->bo;
-
-		dma_resv_unlock(bo->base.resv);
-	}
-}
-
-void ttm_eu_backoff_reservation(struct ww_acquire_ctx *ticket,
-				struct list_head *list)
-{
-	struct ttm_validate_buffer *entry;
-
-	if (list_empty(list))
-		return;
-
-	list_for_each_entry(entry, list, head) {
-		struct ttm_buffer_object *bo = entry->bo;
-
-		ttm_bo_move_to_lru_tail_unlocked(bo);
-		dma_resv_unlock(bo->base.resv);
-	}
-
-	if (ticket)
-		ww_acquire_fini(ticket);
-}
-EXPORT_SYMBOL(ttm_eu_backoff_reservation);
-
-/*
- * Reserve buffers for validation.
- *
- * If a buffer in the list is marked for CPU access, we back off and
- * wait for that buffer to become free for GPU access.
- *
- * If a buffer is reserved for another validation, the validator with
- * the highest validation sequence backs off and waits for that buffer
- * to become unreserved. This prevents deadlocks when validating multiple
- * buffers in different orders.
- */
-
-int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
-			   struct list_head *list, bool intr,
-			   struct list_head *dups)
-{
-	struct ttm_validate_buffer *entry;
-	int ret;
-
-	if (list_empty(list))
-		return 0;
-
-	if (ticket)
-		ww_acquire_init(ticket, &reservation_ww_class);
-
-	list_for_each_entry(entry, list, head) {
-		struct ttm_buffer_object *bo = entry->bo;
-		unsigned int num_fences;
-
-		ret = ttm_bo_reserve(bo, intr, (ticket == NULL), ticket);
-		if (ret == -EALREADY && dups) {
-			struct ttm_validate_buffer *safe = entry;
-			entry = list_prev_entry(entry, head);
-			list_del(&safe->head);
-			list_add(&safe->head, dups);
-			continue;
-		}
-
-		num_fences = max(entry->num_shared, 1u);
-		if (!ret) {
-			ret = dma_resv_reserve_fences(bo->base.resv,
-						      num_fences);
-			if (!ret)
-				continue;
-		}
-
-		/* uh oh, we lost out, drop every reservation and try
-		 * to only reserve this buffer, then start over if
-		 * this succeeds.
-		 */
-		ttm_eu_backoff_reservation_reverse(list, entry);
-
-		if (ret == -EDEADLK) {
-			ret = ttm_bo_reserve_slowpath(bo, intr, ticket);
-		}
-
-		if (!ret)
-			ret = dma_resv_reserve_fences(bo->base.resv,
-						      num_fences);
-
-		if (unlikely(ret != 0)) {
-			if (ticket) {
-				ww_acquire_done(ticket);
-				ww_acquire_fini(ticket);
-			}
-			return ret;
-		}
-
-		/* move this item to the front of the list,
-		 * forces correct iteration of the loop without keeping track
-		 */
-		list_del(&entry->head);
-		list_add(&entry->head, list);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(ttm_eu_reserve_buffers);
-
-void ttm_eu_fence_buffer_objects(struct ww_acquire_ctx *ticket,
-				 struct list_head *list,
-				 struct dma_fence *fence)
-{
-	struct ttm_validate_buffer *entry;
-
-	if (list_empty(list))
-		return;
-
-	list_for_each_entry(entry, list, head) {
-		struct ttm_buffer_object *bo = entry->bo;
-
-		dma_resv_add_fence(bo->base.resv, fence, entry->num_shared ?
-				   DMA_RESV_USAGE_READ : DMA_RESV_USAGE_WRITE);
-		ttm_bo_move_to_lru_tail_unlocked(bo);
-		dma_resv_unlock(bo->base.resv);
-	}
-	if (ticket)
-		ww_acquire_fini(ticket);
-}
-EXPORT_SYMBOL(ttm_eu_fence_buffer_objects);
diff --git a/include/drm/ttm/ttm_execbuf_util.h b/include/drm/ttm/ttm_execbuf_util.h
deleted file mode 100644
index fac1e3e57ebd..000000000000
--- a/include/drm/ttm/ttm_execbuf_util.h
+++ /dev/null
@@ -1,119 +0,0 @@
-/**************************************************************************
- *
- * Copyright (c) 2006-2009 VMware, Inc., Palo Alto, CA., USA
- * All Rights Reserved.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the
- * "Software"), to deal in the Software without restriction, including
- * without limitation the rights to use, copy, modify, merge, publish,
- * distribute, sub license, and/or sell copies of the Software, and to
- * permit persons to whom the Software is furnished to do so, subject to
- * the following conditions:
- *
- * The above copyright notice and this permission notice (including the
- * next paragraph) shall be included in all copies or substantial portions
- * of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
- * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
- * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
- * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
- * USE OR OTHER DEALINGS IN THE SOFTWARE.
- *
- **************************************************************************/
-/*
- * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
- */
-
-#ifndef _TTM_EXECBUF_UTIL_H_
-#define _TTM_EXECBUF_UTIL_H_
-
-#include <linux/list.h>
-
-struct ww_acquire_ctx;
-struct dma_fence;
-struct ttm_buffer_object;
-
-/**
- * struct ttm_validate_buffer
- *
- * @head:           list head for thread-private list.
- * @bo:             refcounted buffer object pointer.
- * @num_shared:     How many shared fences we want to add.
- */
-
-struct ttm_validate_buffer {
-	struct list_head head;
-	struct ttm_buffer_object *bo;
-	unsigned int num_shared;
-};
-
-/**
- * ttm_eu_backoff_reservation
- *
- * @ticket:   ww_acquire_ctx from reserve call
- * @list:     thread private list of ttm_validate_buffer structs.
- *
- * Undoes all buffer validation reservations for bos pointed to by
- * the list entries.
- */
-void ttm_eu_backoff_reservation(struct ww_acquire_ctx *ticket,
-				struct list_head *list);
-
-/**
- * ttm_eu_reserve_buffers
- *
- * @ticket:  [out] ww_acquire_ctx filled in by call, or NULL if only
- *           non-blocking reserves should be tried.
- * @list:    thread private list of ttm_validate_buffer structs.
- * @intr:    should the wait be interruptible
- * @dups:    [out] optional list of duplicates.
- *
- * Tries to reserve bos pointed to by the list entries for validation.
- * If the function returns 0, all buffers are marked as "unfenced",
- * taken off the lru lists and are not synced for write CPU usage.
- *
- * If the function detects a deadlock due to multiple threads trying to
- * reserve the same buffers in reverse order, all threads except one will
- * back off and retry. This function may sleep while waiting for
- * CPU write reservations to be cleared, and for other threads to
- * unreserve their buffers.
- *
- * If intr is set to true, this function may return -ERESTARTSYS if the
- * calling process receives a signal while waiting. In that case, no
- * buffers on the list will be reserved upon return.
- *
- * If dups is non NULL all buffers already reserved by the current thread
- * (e.g. duplicates) are added to this list, otherwise -EALREADY is returned
- * on the first already reserved buffer and all buffers from the list are
- * unreserved again.
- *
- * Buffers reserved by this function should be unreserved by
- * a call to either ttm_eu_backoff_reservation() or
- * ttm_eu_fence_buffer_objects() when command submission is complete or
- * has failed.
- */
-int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
-			   struct list_head *list, bool intr,
-			   struct list_head *dups);
-
-/**
- * ttm_eu_fence_buffer_objects
- *
- * @ticket:      ww_acquire_ctx from reserve call
- * @list:        thread private list of ttm_validate_buffer structs.
- * @fence:       The new exclusive fence for the buffers.
- *
- * This function should be called when command submission is complete, and
- * it will add a new sync object to bos pointed to by entries on @list.
- * It also unreserves all buffers, putting them on lru lists.
- *
- */
-void ttm_eu_fence_buffer_objects(struct ww_acquire_ctx *ticket,
-				 struct list_head *list,
-				 struct dma_fence *fence);
-
-#endif
-- 
2.43.0

