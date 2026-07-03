Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3330EC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8550D10E609;
	Fri,  3 Jul 2026 14:28:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vifwQz+5";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D19EE10E2E7
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 14:28:04 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493bab44440so4039295e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783088883; x=1783693683; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vfzjlva7uTRp2nrRC1IpEggKvDc4norG+B7c1mS+L3Q=;
 b=vifwQz+52BmsIFhtbyNIMBNw3EcCIjvqh5CfWqQzUFASe48JlltzmMtJT+e7FHFzAf
 HQQr9NeHoTWfpA40aDPDmRXyWJ59Vo54m7/5oM+lJr4Q4NEfACw7OGLWs+ANMFF75gTV
 i2JjxG+q7Fp8SmxhthiCfVB+nElb5OdYUjWrYges0TRrMPpL7Wm8g6aaXfL/H0LeMZvn
 eU96a/qeDSh1SPzE49uKsE/erW2vqYZqGgLqiqbRl/xun1lMGxYefh8uv1xHDIu8tXVC
 RH34/CvM1uOE1FN4qYooAe6FoQSFQszSOyPBlGMKKhJFfMdzCm/5pndilSVCPiQGiafg
 xxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783088883; x=1783693683;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfzjlva7uTRp2nrRC1IpEggKvDc4norG+B7c1mS+L3Q=;
 b=qh159UNzPyBzWH+Ea6p95EbEpIxQQhHKWfMA/IwKtao/WBsB75tNZ9wkmQz0jKLHeu
 mx3p5Z+ev2PS2N/x2W2Yc7C6JCJlx8tlJvuLLQ0O8rnVRFXwDKuSG5YO9Yp1obO3bLzm
 yS9tdwZn+muRuLwBu5EX/mFWTq0pjhcM5VvPFfSKKC5QMnWeiyLd6/LVrUQWWwYwWR8a
 JSjdlh/aNIybejI0+Hu06JWZmx75V1v2Z0NdcnXuDUwedxcFsgPTP/LSk+i83JyTI34K
 /fZnnDzKHOwJpJZXtfJWjPXXxVeYYYYQbDnfMLZWOj/jEr7d9BqDcl/8i6NnpWDWxv0E
 8Xbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qTS3Kqdgey/4VOQCwSzxquEKk7pxbWrkrkeNnXGQ7oMZ5BfV8z4sG0JNPBET5pgmvfX3xS3uYIEY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxmxx4vacgARxIGBJYRtw9kucTJRKX2VenA4Yb85hyKcb3cX4Uv
 V9izxsawYr8b6ASsI6k7NBbL+dflt37iEFrH8k5tAfUfXKSd2UTe0duTgzDvXhiq3RQ=
X-Gm-Gg: AfdE7cmP8brZqmUZxNx4djX4P7AmOd3z56oNjV0JEaJjy5afP60db485iLzegzmvp9L
 wVhOOiOY16FTIRcBze5eOBi52iFGn8DtXNeFqsG7stI6XHsRlbvSvkXuUJufIgvGZelVYuWRnIq
 LrAr/K+ud/p7OVXXOILRb+5gDTRq3hf5kX4XNLXLkgH4Z9nr2ziCQLxBJCZJ1SUBDVlkryMo1eW
 mB6XRwqvV5xpaSbdhEmj+5bB93fMHhs7EZVvRbODSB3Go6dDpEKiWiCjjJHJ4QfidZgHjkiCkQE
 m1tOc9efyw0pG3IeE99KmHYpI8ZcTzKHfkSRs5JXhu+U3aZouhMDCBlBImi+mUpxBCm/8D5MfvO
 +OKN9FmRIpX+TmnPxKwdCqjPq5ooFtTnjvXUplC/wO+PVTUOTxuJyCcARGJj9StMqWxF6K2qpxL
 L8WmLehr4S+xzIOJRAXsPHRHRpfpVgbTFHse7s+R/DYfPq16WxXwnZfP8ro+Mn6wk=
X-Received: by 2002:a05:600c:8718:b0:492:7025:13fd with SMTP id
 5b1f17b1804b1-493d0b2fe36mr4072985e9.0.1783088883062; 
 Fri, 03 Jul 2026 07:28:03 -0700 (PDT)
Received: from ta2.c.googlers.com (214.8.78.34.bc.googleusercontent.com.
 [34.78.8.214]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccd9d607sm73048945e9.2.2026.07.03.07.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 07:28:02 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 03 Jul 2026 14:28:01 +0000
Subject: [PATCH v2] dma-buf: remove unused dma-fence-unwrap.c
 (stable/linux-5.15.y only)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260703-5-15-dma-fence-unwrap-v2-1-43d58ee68c6b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPDGR2oC/4WNSw7CMAwFr1J5jZGTfpBYcQ/URUid1hIkyIECq
 np3Qi/AckZ68xbIrMIZjtUCyrNkSbGA3VXgJxdHRhkKgyXb0YFqbNG0ONwcBo6e8Rlf6u5IoXG
 dp3pwwULZ3pWDvLfuuS88SX4k/Ww3s/nZf8XZoEHyoWuai2/JhNNVotO0TzpCv67rFyJEdd27A
 AAA
X-Change-ID: 20260703-5-15-dma-fence-unwrap-0f4a6c03daf2
To: stable@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, 
 Gustavo Padovan <gustavo@padovan.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sasha Levin <sashal@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Yunxiang Li <Yunxiang.Li@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 peter.griffin@linaro.org, andre.draszik@linaro.org, jyescas@google.com, 
 kernel-team@android.com, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783088882; l=6389;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=0I76ZwMoPjiSrdzlVPbCXsgffgqRX/g8PDFQj/MqraI=;
 b=MUC/mZrIiaFHeZ3I4K94wWDobfdb8G1nLQh5/QGPiyaNX/jdcVM7J7Id9ZpF/FWyi0B5qXo/3
 6/uHcV8aGcQC06CtW95kCzjuXQTe1hwcRsJQAUBgmsuaYfkYWLuKFE3
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
Changes in v2:
- add To: stable@vger.kernel.org
- Link to v1: https://lore.kernel.org/r/20260703-5-15-dma-fence-unwrap-v1-1-0cf644bc501f@linaro.org
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

