Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76656CD4F49
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B713010E4DB;
	Sat, 16 May 2026 11:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DRzRcIZs";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FCC110E4C0
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:06:59 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso3619725e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929618; x=1779534418; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mZxaw3u6g9gSQgxhivb/aQTd6ZH6WM8J0IbrlUd06os=;
 b=DRzRcIZsDDd/pGk/P061gW2BE2do9kKnR10KXK5f+RChN4Qo6d7S480afTk/MC9Ior
 OyvpYeXI34E72hoqcMhzDpPqdgVe1kMlkUYopG6kOM2YjvHDGZRM7OaIjg876C2rsBWk
 cF0cXb8h1xAjPiRVvxca+lHpI8YKhkWk7V+LN769CzQ0iTp+kiCX+SxY2Tkm/Xkxotx8
 dex3oNQP7f4jUxscIqHsWAP1H/T4Vnm5w+1bj6HDDlLjNhUfEoPHG7Bxy74MHo54Y8hi
 7UrNyJaw1yXmoytWqzU47jONFKZ+zK1xhVQH3BcHX2yg/Jyyg+dywtOIp8FpcktQRZ5W
 n37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929618; x=1779534418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mZxaw3u6g9gSQgxhivb/aQTd6ZH6WM8J0IbrlUd06os=;
 b=pzyIy4vPj+/3rjpuxJxS+IZ0e3G34KxIqIhYEhhQ7hRhPheEnYszibcll1Vt6JNPxh
 JgElijLppknFHbZ0CDz5ZEsaAXgVYRcNCsO0ugawUdLaGyW5VxrnGGhlx4NTGB6fh1/b
 2y3+J3bhl4LDrGEe7Uy//kMOtYhBRkZPFmTKz2OAG452HWPd9L6Kx74QTUaxGUNZhABv
 DjlXukb3vW+BGCHlxUni8JctfPb6OQaK8WVw09+iPJxz+xS/0Bxaq5bWL3rieyc8ZwKt
 T/bPg06Nyz5l4fal8VSq/uRdVPBusaK/sGlaOll07zSzgTv1kQj1DW+nRcW9+CnqyULA
 EnPQ==
X-Gm-Message-State: AOJu0YxD3aPJxBOw4IAjDypxGVSxx5D73O9TyoLlQwemG7Z862i9K9Rk
 RksLOskDw750fe6Ecrm9mmgC+RIAzz/qbrzrRKlRZ47LNVfMThvogJeD
X-Gm-Gg: Acq92OEwd7kJRxMuqaUDBjNuHt19qiw2jiymQk5nq2GxH580OXqOJKSdid3H0r5+b1m
 /eYZdTqrWkCS2hq34dvJg88UTEBjFT9wwHknTHA7mobY4GF37Bt6s+R57pM6/EBah8LHJ1v/CIh
 uFLpUFgOTe1CPhrTTSNcz4D0grADNnkVUGQ3prjHxH7qA9CHLE7Az32U8MQ/TwbDMDMj3t8ALfP
 H8qomagLHx8cjww5s/9HTRgV9stDYeUmI3gH1ECXAeaGvo0NcBWCJVNU/awPGnw9qHXBkZl/7zO
 +UC69tDrUWvHdwuP8axC1zUbbdNf3BUyRHsAbSmCt0nIT8aP2xIeaPMIcclccFPtUODkGH4ycEk
 1xPXFt4q71PBY+uBpmrfy2JQ5tRLGXCgV30kDYvLixsc+dJzdAyexjll9EffwKh57lVkta+jM3I
 eisGX8YDysfXDDC+BZGm4PRW3M4BIssIvv6TY10CcBa6Z42FVazmNBtUiEBYmYoTfGTa6vZf2Lz
 NIfXaE54f1zeuzR+g==
X-Received: by 2002:a05:600c:2d09:b0:48f:e1ac:c96d with SMTP id
 5b1f17b1804b1-48fe61f2bcemr60030905e9.20.1778929617614; 
 Sat, 16 May 2026 04:06:57 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:57 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 13:06:13 +0200
Subject: [PATCH 10/12] drm/syncobj: add drm_syncobj_import_sync_file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-jorth-syncobj-v1-10-88ede9d98a81@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=2792;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=gccEkxb9Fgxq3kICRGFzS2yuH2T+EBoB3hEcASoUfk4=;
 b=LfciDdq+01NiK3gXOUbCymlEM3K+nuuGo3VhuhjLND4T9QDwYUXe2UHMMsjDrtokyTzc+edKE
 S+PE8qGatMuDQ8hyiPBhAhZK6ObHL0ljbFX8Do8xYlPgTokSZvXJnCB
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

This makes the logic from drm_syncobj_import_sync_file_fence available
to callers that have a drm_syncobj instead of a drm_file/handle pair.

Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 35 ++++++++++++++++++++++++++---------
 include/drm/drm_syncobj.h     |  2 ++
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 1da96e23dfc0..4c1667c67cb7 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -765,19 +765,37 @@ static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
 static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
 					      int fd, int handle, u64 point)
 {
-	struct dma_fence *fence = sync_file_get_fence(fd);
 	struct drm_syncobj *syncobj;
 	int ret = 0;
 
+	syncobj = drm_syncobj_find(file_private, handle);
+	if (!syncobj)
+		return -ENOENT;
+
+	ret = drm_syncobj_import_sync_file(syncobj, fd, point);
+
+	drm_syncobj_put(syncobj);
+
+	return ret;
+}
+
+/**
+ * drm_syncobj_import_sync_file - import a sync_file fd into a syncobj
+ * @syncobj: syncobj to import into
+ * @fd: sync_file file descriptor
+ * @point: timeline point or 0
+ *
+ * Returns 0 on success or a negative error value on failure.
+ */
+int drm_syncobj_import_sync_file(struct drm_syncobj *syncobj,
+				 int fd, u64 point)
+{
+	struct dma_fence *fence = sync_file_get_fence(fd);
+	int ret = 0;
+
 	if (!fence)
 		return -EINVAL;
 
-	syncobj = drm_syncobj_find(file_private, handle);
-	if (!syncobj) {
-		ret = -ENOENT;
-		goto err_syncobj;
-	}
-
 	if (point) {
 		struct dma_fence_chain *chain = dma_fence_chain_alloc();
 
@@ -792,11 +810,10 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
 	}
 
 err:
-	drm_syncobj_put(syncobj);
-err_syncobj:
 	dma_fence_put(fence);
 	return ret;
 }
+EXPORT_SYMBOL(drm_syncobj_import_sync_file);
 
 static int drm_syncobj_export_sync_file(struct drm_file *file_private,
 					int handle, u64 point, int *p_fd)
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index da237ca3e61f..1571ffa12a5c 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -143,6 +143,8 @@ int drm_syncobj_timeline_signal(struct drm_syncobj **syncobjs,
 				u64 user_points, u32 count);
 int drm_syncobj_query(struct drm_syncobj **syncobjs, u64 user_points,
 		      u32 count, u32 flags);
+int drm_syncobj_import_sync_file(struct drm_syncobj *syncobj,
+				 int sync_file_fd, u64 point);
 void drm_syncobj_free(struct kref *kref);
 int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
 		       struct dma_fence *fence);

-- 
2.54.0

