Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C086CD4F47
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F0F10E4A2;
	Sat, 16 May 2026 11:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UVxKgg3J";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E6AF10E356
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:06:52 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso4884285e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929611; x=1779534411; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W2kX0D85vKgrMTrfAaShnpioKYHS8IrhnFr9X3CmECA=;
 b=UVxKgg3JXV2UcHWvJ3NXFZFXOZUbWnZKc+MX8g+Msr6IPpRT5dNeFN0lPohIsumtOw
 M9N30vu7RKTS/GBcdCJNoq03gYWMnz32SUsvEllRrSImjlxVus0uTEr5yPfDLV2Wo/r3
 Lu9brDV891rl4l6amCcSiKeDQEDi5JYA3Fy2K1ccTVRGCtYOkM3eUnyCn07Vv3nyj7NZ
 1YZ3SVZJvNQyxei+4tEAbf714miJjgJZXE6bxlcW+unZUFn2/QOLcmCI6kyJFcgo5s9d
 17FvTNHVrrQ0erNDj6/dq+kqGIEAQX3zkILi2P9edh+dqGnF+PZD4KlPa4NAtQ3LWru+
 9bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929611; x=1779534411;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W2kX0D85vKgrMTrfAaShnpioKYHS8IrhnFr9X3CmECA=;
 b=JDgxTFAl2rxNxp+PQcf42iD9YXLnr5mSd++ktglKvVi9oaJfxoWu/wOcMBdjhnVV1H
 HF8xJeTwZiJ6XOJSzovazCHKJICYHrY2UrTS6TZPc/e0bbGs3qzxdY38Cu5rj7YIbIqV
 l8JB1Z7rUI+4ml9/ebuZ4UFbRwEvjh13FWROgmMOt7OIGx+sbbzLWu9aVqMJLZDSeokC
 Y1W4pRslb1ceSI4JnzA4YcoNBGx2hZhxXV/c+cA3QJ0zGDiI1gYwO70sC1aB3kGnU+WX
 yQzLS0/+aNv7R0XPm3U0H0XbghF3kYFBOh6hf31MueAuk25nLQMU3n7uojWthF8Ni8Yu
 RmSg==
X-Gm-Message-State: AOJu0Yyd1kF0xG87bSL9Ihzn9PwteKEgxg+8yuyS/Fd0bNptXYhwhOW8
 217T9rHvEgCx1UbuXelMqFSmF6wr51wiibz9g1Obv46XPp2tbCtiW16s
X-Gm-Gg: Acq92OHluZW3e3/KqcxRiQzq2Zx4lFW9T3b+PLVv9GJXTjQ8i2ODZTu+Xd+nbvCZHLN
 lGREJNKHaEuIteSJd3+1jocyiMSf6fIbYXaaFmicDCPHFqDmbmyUBfoA1FkMmVcDUna5HCtG/Jm
 ESvDC1srEqqlmsPn4KyEhBuvFhtOAhfYpmVJsCDIa6Bkgud7ccUzLuSkE4fsRJKotsWvszxb+T1
 z/Nw3ECOPvQwIMHoRLT/6fTfKMHu/1WS80SpVqG0ocQqtSIBvucrpfYt78ZQPCw/3wkoBHLam2N
 pTcvT/7umdE/nPRGix7p+7trl6ycxskyHifUCK+ZBvL3ZOU2xm3EAI3B6jbcFGp7jADKsl03kES
 NnN/MBv0banxRqLbmCwOsVePGMTJAsN5i9BEW7iz1tu1oEh5J1G9QMZBVFW1YTwVqiUlD6cQbVM
 u70x7ibXWakK/r0RYW+sfqOjCpyKKfdwiY2Lbz4NBvhH2lhlu5OOPP2TuObZm0HWahxl78TAnfs
 wf0ez6opirFsjevig==
X-Received: by 2002:a05:600c:1512:b0:48f:e26a:1744 with SMTP id
 5b1f17b1804b1-48fe60ecd67mr61949075e9.9.1778929610832; 
 Sat, 16 May 2026 04:06:50 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:50 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 13:06:08 +0200
Subject: [PATCH 05/12] drm/syncobj: have transfer functions accept
 drm_syncobj directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-jorth-syncobj-v1-5-88ede9d98a81@gmail.com>
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
In-Reply-To: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org, 
 ju.orth@gmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=3982;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=Mb8lX2KhvsBJbZLZbGjpbAUq1f7hQxcuF5oQ0+pOVFk=;
 b=BeGkMWuyeX/aZRp2H0hfoW2AxnZOC2lzk8MPd8PsvJlWTvAKosg1c1JQKJEBD/6j1xtsYYLN2
 hnZSkrLB1TOAJz2SwH4GedXgfD0gdUZ4ygDmsn2lzPUAFQlwflz007b
X-Developer-Key: i=ju.orth@gmail.com; a=ed25519;
 pk=uM2SS4lelkuIoYHc7v9N9bgBZ3hS632zJS2xjRJLPLI=
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

This removes the implicit flags check from drm_syncobj_find_fence. The
check is moved to the only caller drm_syncobj_transfer_ioctl.

Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 62 ++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 3e8fb7e0cace..a746e787882d 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -955,29 +955,23 @@ drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev, void *data,
 					&args->handle);
 }
 
-static int drm_syncobj_transfer_to_timeline(struct drm_file *file_private,
-					    struct drm_syncobj_transfer *args)
+static int drm_syncobj_transfer_to_timeline(struct drm_syncobj *src, u64 src_point,
+					    struct drm_syncobj *dst, u64 dst_point,
+					    u32 flags)
 {
-	struct drm_syncobj *timeline_syncobj = NULL;
 	struct dma_fence *fence, *tmp;
 	struct dma_fence_chain *chain;
 	int ret;
 
-	timeline_syncobj = drm_syncobj_find(file_private, args->dst_handle);
-	if (!timeline_syncobj) {
-		return -ENOENT;
-	}
-	ret = drm_syncobj_find_fence(file_private, args->src_handle,
-				     args->src_point, args->flags,
-				     &tmp);
+	ret = drm_syncobj_fence_lookup(src, src_point, flags, &tmp);
 	if (ret)
-		goto err_put_timeline;
+		goto out;
 
 	fence = dma_fence_unwrap_merge(tmp);
 	dma_fence_put(tmp);
 	if (!fence) {
 		ret = -ENOMEM;
-		goto err_put_timeline;
+		goto out;
 	}
 
 	chain = dma_fence_chain_alloc();
@@ -986,34 +980,27 @@ static int drm_syncobj_transfer_to_timeline(struct drm_file *file_private,
 		goto err_free_fence;
 	}
 
-	drm_syncobj_add_point(timeline_syncobj, chain, fence, args->dst_point);
+	drm_syncobj_add_point(dst, chain, fence, dst_point);
 err_free_fence:
 	dma_fence_put(fence);
-err_put_timeline:
-	drm_syncobj_put(timeline_syncobj);
+out:
 
 	return ret;
 }
 
 static int
-drm_syncobj_transfer_to_binary(struct drm_file *file_private,
-			       struct drm_syncobj_transfer *args)
+drm_syncobj_transfer_to_binary(struct drm_syncobj *src, u64 src_point,
+			       struct drm_syncobj *dst, u32 flags)
 {
-	struct drm_syncobj *binary_syncobj = NULL;
 	struct dma_fence *fence;
 	int ret;
 
-	binary_syncobj = drm_syncobj_find(file_private, args->dst_handle);
-	if (!binary_syncobj)
-		return -ENOENT;
-	ret = drm_syncobj_find_fence(file_private, args->src_handle,
-				     args->src_point, args->flags, &fence);
+	ret = drm_syncobj_fence_lookup(src, src_point, flags, &fence);
 	if (ret)
 		goto err;
-	drm_syncobj_replace_fence(binary_syncobj, fence);
+	drm_syncobj_replace_fence(dst, fence);
 	dma_fence_put(fence);
 err:
-	drm_syncobj_put(binary_syncobj);
 
 	return ret;
 }
@@ -1022,18 +1009,39 @@ drm_syncobj_transfer_ioctl(struct drm_device *dev, void *data,
 			   struct drm_file *file_private)
 {
 	struct drm_syncobj_transfer *args = data;
+	struct drm_syncobj *src, *dst;
 	int ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
 		return -EOPNOTSUPP;
 
+	if (args->flags & ~DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
+		return -EINVAL;
+
 	if (args->pad)
 		return -EINVAL;
 
+	src = drm_syncobj_find(file_private, args->src_handle);
+	if (!src)
+		return -ENOENT;
+
+	dst = drm_syncobj_find(file_private, args->dst_handle);
+	if (!dst) {
+		ret = -ENOENT;
+		goto err_dst;
+	}
+
 	if (args->dst_point)
-		ret = drm_syncobj_transfer_to_timeline(file_private, args);
+		ret = drm_syncobj_transfer_to_timeline(src, args->src_point,
+						       dst, args->dst_point,
+						       args->flags);
 	else
-		ret = drm_syncobj_transfer_to_binary(file_private, args);
+		ret = drm_syncobj_transfer_to_binary(src, args->src_point,
+						     dst, args->flags);
+
+	drm_syncobj_put(dst);
+err_dst:
+	drm_syncobj_put(src);
 
 	return ret;
 }

-- 
2.54.0

