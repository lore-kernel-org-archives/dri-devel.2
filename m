Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67957CD4F25
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 519E210E1A9;
	Sat, 16 May 2026 11:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sBxrgHId";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F46F10E492
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:07:00 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so9714975e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929619; x=1779534419; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dVfs+wqDh2APf8gPwREvGpcVhgxv7KkNQvxDWgzbhy8=;
 b=sBxrgHIdLf2BFEeSxe7zJkVzaKJhvZ5JjbqtBK3IkHQGqDpjF1NnQwwlu9YGYjtyN0
 UkfotjNXCYPQxbHJI6Ty89i/YNJnCvwirmQo5n9SuuJ0OBwSDpgOpsyUdbBk8MAeAdjR
 vAmrZB8+kjnlvb2xApojV9RUlf95ho+kpuZbCkhb1SiWe0haal3RpPkXnmkcLNe40Ido
 HR25rvSUu4rOzHUrKa5kUjIJcCb71cOIunPMlkwPx0CaCWQECewBUm94r5TpsMqrMZM1
 2BLHBySoJyb+xfvPNCrpcswGZamowx5sNU3ObLmSo258mGfRCQWwuRu8WqGjEH+jtbyb
 oO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929619; x=1779534419;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dVfs+wqDh2APf8gPwREvGpcVhgxv7KkNQvxDWgzbhy8=;
 b=d+ndabUJo5f1ZcbFN3SsfbGQewMl286u3DB4e5+hH6sR4DXts7/4gSGxCIiKQsdg5c
 yoxVa5Qjy78z+o+razW0fKjcIQ+HffY5zKqUSMzvN1CeIyzZXh0AYrg+MXO54WDn0sCY
 FAJRBgv34moRQTpZxMZFCNF4f6fna0eb3dFKivE/ieiMywDJE86bMBiqLB6wdc0Hsb45
 +PEI5R2EKPZxIOZsjbGI4xJQrvUZezgBqakV35O2k9iRoDaLCXHIdtZeiwQJBMv0lE0r
 Bb8cHZYoXjU3hqPUhv7D5rzsYwktG81iP2s5JVNTDHoKEF3q98Ilb1e0p/+mXO1+XTKV
 yoYw==
X-Gm-Message-State: AOJu0YzRi8mwDfL6mINUZ57ypqJV8oOXSVBSWqC9T0SdjCdOPYbZzXNB
 M4MxUjtTEb/YUnU4zsiKS4TFmKSq7zGtoHcPyOjZGKHyQLXVV02O76RM
X-Gm-Gg: Acq92OFQPHTSGROB+4mj/UkSo88Q3+FeTiE4gyPG/BZUXAaFvMNkeOMA02QQ6NWUyti
 YoOAwXTonJPWGFAX2pozLM1y3Waye+Rc5c540ix2t6wg8lVIETfc4SNZcuSfP6ynQgPMrU7uj6u
 P8znlANxhg3j9jwhtI6L/6UEqxI/f8beJZEYwcA4oLYJQnylkIEwhQODNztj/24lZZcA+r4hQXu
 aJxF6ISV1twOUH3kGS2cRWAXUvWPI2iTio3N1nmNLPwbYIW4tRRHdyoQnXcUlQ/vDgJzHj1ghBC
 ehD4Jx4lFR9WkvXFuPNnY6EwK2uvaWpg2wsS+We47WkbAsJvyIZECL0i07+wyw4OOZIS9raR6fy
 XWIvKu4RulxaL4YYAtKgMMER4B5iGFXRzD+GeX/HoPNelhhz9uxLVlvUyNXrbl+bRHjAscXRvj6
 rC6odDJEqTsCDnkLzhH4oNC3q5uHHiB7JDVwl4pqnW8JeSUKCmZKPEhpIUtLWyB08W/RyetCr27
 G5QTVQ=
X-Received: by 2002:a05:600c:c4a1:b0:48a:5363:8cac with SMTP id
 5b1f17b1804b1-48fe63268eemr108045305e9.22.1778929618884; 
 Sat, 16 May 2026 04:06:58 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:58 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 13:06:14 +0200
Subject: [PATCH 11/12] drm/syncobj: add drm_syncobj_export_sync_file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-jorth-syncobj-v1-11-88ede9d98a81@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=3389;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=9xL4k8P4OzDmeuDyBCak9cYfAMz/kFZpIBcu/tKVYxQ=;
 b=IyP6KTEg/nnToCAtPFKyKdeoh+C+VT61maR9YZkQriDB2BckEZMqDGD+hg82OZFoyq8W/t5dM
 UcduM0gEp0VDuV8slfvoJd+B0QiHGRqTA8TF5AMzoWTfDIVoRvYYEyG
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

This makes the logic from drm_syncobj_export_sync_file_by_handle
available to callers that have a drm_syncobj instead of a
drm_file/handle pair.

Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 39 ++++++++++++++++++++++++++++++++++-----
 include/drm/drm_syncobj.h     |  2 ++
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 4c1667c67cb7..d5e633738730 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -815,8 +815,34 @@ int drm_syncobj_import_sync_file(struct drm_syncobj *syncobj,
 }
 EXPORT_SYMBOL(drm_syncobj_import_sync_file);
 
-static int drm_syncobj_export_sync_file(struct drm_file *file_private,
-					int handle, u64 point, int *p_fd)
+static int drm_syncobj_export_sync_file_by_handle(struct drm_file *file_private,
+						   int handle, u64 point,
+						   int *p_fd)
+{
+	struct drm_syncobj *syncobj;
+	int ret;
+
+	syncobj = drm_syncobj_find(file_private, handle);
+	if (!syncobj)
+		return -ENOENT;
+
+	ret = drm_syncobj_export_sync_file(syncobj, point, p_fd);
+
+	drm_syncobj_put(syncobj);
+
+	return ret;
+}
+
+/**
+ * drm_syncobj_export_sync_file - export a syncobj fence as a sync_file fd
+ * @syncobj: syncobj to export from
+ * @point: timeline point or 0
+ * @p_fd: out parameter for the new file descriptor
+ *
+ * Returns 0 on success or a negative error value on failure.
+ */
+int drm_syncobj_export_sync_file(struct drm_syncobj *syncobj,
+				 u64 point, int *p_fd)
 {
 	int ret;
 	struct dma_fence *fence;
@@ -826,7 +852,7 @@ static int drm_syncobj_export_sync_file(struct drm_file *file_private,
 	if (fd < 0)
 		return fd;
 
-	ret = drm_syncobj_find_fence(file_private, handle, point, 0, &fence);
+	ret = drm_syncobj_fence_lookup(syncobj, point, 0, &fence);
 	if (ret)
 		goto err_put_fd;
 
@@ -847,6 +873,8 @@ static int drm_syncobj_export_sync_file(struct drm_file *file_private,
 	put_unused_fd(fd);
 	return ret;
 }
+EXPORT_SYMBOL(drm_syncobj_export_sync_file);
+
 /**
  * drm_syncobj_open - initializes syncobj file-private structures at devnode open time
  * @file_private: drm file-private structure to set up
@@ -933,8 +961,9 @@ drm_syncobj_handle_to_fd_ioctl(struct drm_device *dev, void *data,
 		point = args->point;
 
 	if (args->flags & DRM_SYNCOBJ_HANDLE_TO_FD_FLAGS_EXPORT_SYNC_FILE)
-		return drm_syncobj_export_sync_file(file_private, args->handle,
-						    point, &args->fd);
+		return drm_syncobj_export_sync_file_by_handle(file_private,
+							      args->handle,
+							      point, &args->fd);
 
 	if (args->point)
 		return -EINVAL;
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index 1571ffa12a5c..48476c570595 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -145,6 +145,8 @@ int drm_syncobj_query(struct drm_syncobj **syncobjs, u64 user_points,
 		      u32 count, u32 flags);
 int drm_syncobj_import_sync_file(struct drm_syncobj *syncobj,
 				 int sync_file_fd, u64 point);
+int drm_syncobj_export_sync_file(struct drm_syncobj *syncobj,
+				 u64 point, int *p_fd);
 void drm_syncobj_free(struct kref *kref);
 int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
 		       struct dma_fence *fence);

-- 
2.54.0

