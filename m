Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC65C88E69
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2402010E9FD;
	Sun, 13 Sep 2026 20:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UC5N1Mas";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD04410E44F
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 06:33:02 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so1660955e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789194781; x=1789799581; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DPg+7nE162dH93wuY+DrMzygOgGDBhIqEJk9vb3GqbA=;
 b=UC5N1MashPQ+ihc/Dw15O0Ei9Vp7kfhw3N/JTnuihjK6XnEDOg+YqC99Cfv4mgjpng
 EoI7K5ms+gph0mkft5aL4Ya1Qu0RhzMz6C2E0SJLGvmPraSZuOqncANU65B857ua88iQ
 9B0jLK/fJQLVjjClJvUGXF+GUq2YqyNnVMfi9nFfxzLrr+UqCusB4MpRGxXWO/xNG64o
 bdgW6Ao7YMvrDS9KAjo4ciO0rqEsx6paGFKj5js1pijrPvWO046BjJyNJoIwuWGvHlFn
 TvAFH+LX18wFFOeyLsbG8X3ZOJOfLY/tHkP5LcWyB2GiCTPW/PkUa8ADQ6iOa3MQOMcl
 2mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789194781; x=1789799581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DPg+7nE162dH93wuY+DrMzygOgGDBhIqEJk9vb3GqbA=;
 b=AdglJAzKOnQwgrELratiVePdXfolXnOAAwb7M9FlGB6uVni5y8SUJ++3ZzV0wJnoSX
 o4bAfuUJ0YkZ13ZsZ6SMMfD5tf75ulS/YdYOHqI4BYd5SueEs12Kwh9YIDDA9MjlXj6t
 Q6urA/8S2EiQCWkMWljoy4V+dtynXaLf9UIW0B3P7jZtPfNsV2jb3Qtffh2O1ARCCQwu
 Ep/NLSkxxYMnT45xztn+glTgPgnAVSF536WDxM6uanxm5SdQxop3pKKHljV4z32aerL5
 Lb8xUnmmD8jLCZku74LY7ZGDGMmvIkiIDx8COrKCMFlHI5Q4R81Yed7WxHxqmdxbqaOQ
 ddyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6DnAVTdTWhiT2npBvVGuE+g30VNuPqVshN6LZqaI20qAzLoXmPaetqgxF0O6qkDoJbIil0u2vj/w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kJWkVAZ+t8Zb/00a93FGrhMJ8BbHoWDy4z1BOYknNtzPnkCB7D
 NDx2/GHM4sTN0O9HMK4vqzqzP3b8fBmlD3Z3m2B8OWEyk/V3ylhr8xOs
X-Gm-Gg: AYBFou0jBLh9mbqvOj7apqPReqIwA2blGIh4BJ0CJ8+u/xnNPeI3iLrNd7fftdrwpW9
 6qr/hGTUvOJv/zbebnNp7SQRh13nxayMWbu7/j4pyDactufd4jqSk3Q8ISGM0mQAn4RghMyB4ND
 N8oktbOHINUOkHSJI+1r608gsmZdqFMm7lDCjskeMZSqLgWgZP7ZQYgIuNoaClZUG94Pwg6iMfM
 pCB96/2NaUPJkNIccAo7kEzZDgQsygWJVG4MRTk+OrIhJDnvjL6psNA2E8/0LCwfIGFPCTrn2Dt
 lTeuy7EW9ujAt2Cb6NvJcDG+RCjAhHBX4jqWCOJBQJQNzAuVnVm0LwnzW0j5VoptVoaWkztEh/1
 2aiL9G7Hm5v5PGd6njvmfIhfDhgScZk0d92GjuOf3OP4Vhwa6eNft71DDRm//jl+dW40oYJ6S2T
 PfdYn6jm77HAsgz92PNd6aGCheY9gc1hcgC0depxTc6e6QBmklxwycH4yxDkKKOsOtCjp8CSgUR
 LRDw0r5tQ1P9qSa26PcWYvzEx2YzdbJLmH1ioPiv5Va0n40t13diwToKTB7R/0ERKZYRoinvL8i
 6teFVFEmor8/G79XeAY4n/8gaTIbNi4o7BXnYaWVekWFb7wF2KGMr6Dh748jj/2GyQL0imfGzuW
 eOcY=
X-Received: by 2002:a05:600d:8654:20b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-49e619995e3mr63686975e9.12.1789194780974; 
 Fri, 11 Sep 2026 23:33:00 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de.
 [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6fe9d3e3sm11553925e9.0.2026.09.11.23.32.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Sep 2026 23:33:00 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Danilo Krummrich <dakr@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gem-dma: Correct GEM object wrapper documentation
Date: Sat, 12 Sep 2026 08:32:58 +0200
Message-Id: <20260912063258.43169-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

The drm_gem_dma_object_free() wrapper calls drm_gem_dma_free(), but its
description still names the former drm_gem_dma_free_object() helper.
Update the reference to match the wrapped function.

Also correct drm_gem_dma_object_get_sg_table() to document an error
pointer on failure. It forwards the result of
drm_gem_dma_get_sg_table(), which returns ERR_PTR() rather than NULL on
failure.

Fixes: e580ea25c08d ("drm/cma-helper: Pass GEM CMA object in public interfaces")
Fixes: 05b1de51df07 ("drm/cma-helper: Export dedicated wrappers for GEM object functions")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/drm/drm_gem_dma_helper.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_gem_dma_helper.h b/include/drm/drm_gem_dma_helper.h
index f2678e7ecb9847917e9c6c0287af9815d54bae79..5defd47d7de425515c76391d1825f0ed28077eaa 100644
--- a/include/drm/drm_gem_dma_helper.h
+++ b/include/drm/drm_gem_dma_helper.h
@@ -52,7 +52,7 @@ extern const struct vm_operations_struct drm_gem_dma_vm_ops;
  * drm_gem_dma_object_free - GEM object function for drm_gem_dma_free()
  * @obj: GEM object to free
  *
- * This function wraps drm_gem_dma_free_object(). Drivers that employ the DMA helpers
+ * This function wraps drm_gem_dma_free(). Drivers that employ the DMA helpers
  * should use it as their &drm_gem_object_funcs.free handler.
  */
 static inline void drm_gem_dma_object_free(struct drm_gem_object *obj)
@@ -87,7 +87,8 @@ static inline void drm_gem_dma_object_print_info(struct drm_printer *p, unsigned
  * use it as their &drm_gem_object_funcs.get_sg_table handler.
  *
  * Returns:
- * A pointer to the scatter/gather table of pinned pages or NULL on failure.
+ * A pointer to the scatter/gather table of pinned pages on success, or
+ * an ERR_PTR() on failure.
  */
 static inline struct sg_table *drm_gem_dma_object_get_sg_table(struct drm_gem_object *obj)
 {
-- 
2.39.5 (Apple Git-154)

