Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98150CD4F48
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A61A10E4DA;
	Sat, 16 May 2026 11:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kYXX4ZED";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD7D10E491
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:06:56 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso3976635e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929615; x=1779534415; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=30Q99PLuQeVhsFXIYdjo6aYJwvFzoWXm4HGv+NrFQtM=;
 b=kYXX4ZEDg4szSp1hfdgc0jXIBgWyd4JUrFftn9xRuORkYcI1ioxwLo7mKS9H85kvL6
 Jwncnj1A8RZN1058AwiPqoU5wUckp9qVHbPsU7WfuhvzWmOtJY4ixSOLzt0r6+V6eWua
 TxqMD8KjiC4DvxLglVmjU6XCTjdF/PEp2ojHgwis8QidK4YWmCpgwwAjvaVtfZDH5VOz
 +xQgdlN5PtiDJVnZ4zNZXgte8MIeqnTin6Pl5kFNxy/DH1yqW+1h85YNME0DbwLpdegx
 Zk3ge8GzkthM/WH2dvIDH3PMM40WhtQVEKzxorFiZ6Ku75VUZVauoa7lVHc3v8Ew0mPf
 VTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929615; x=1779534415;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=30Q99PLuQeVhsFXIYdjo6aYJwvFzoWXm4HGv+NrFQtM=;
 b=JLClZZLopjYBOH6+qKM2yKXyDrKMwmHsFIszmftuuovvj6ZuKxjIUmzuQXYb9ACq0c
 +mnbAJiBKjfyzQDTbX9cDg3vkxGMhaFvySrcp8joXrvCk3YHZ9SSXF6VLY3Jc8yi5/C0
 7NwfvRJnOzRoviPa4h6qlOa5HF3WaMoXCtkXAw/7vUg+mVW6TJ2r+MWNM/0+o/CD/gJG
 oGT67pxAs/pKIG6lK/85Yfo/IvmI+DJOhb5hN2ExupA7KJsCIzAYnfw5+9xxkqW78nZf
 MCSqNPKPavMB73bWbFiwLudEdu7k42RClCDz3oCYrcM4Qo4HdB8LGjBsUeeV4rSScTZ4
 PQow==
X-Gm-Message-State: AOJu0YwE+P8WuBXlgZsmEtJM8dA65SMUZH9UP7P/Rs9Tk22Fh+Gj3dhf
 gtKBrROzHffPTxdvoXxvmTQwGCDoZ2uD8+eS4jDwLcZIHy8rNsubFuk4
X-Gm-Gg: Acq92OGk2w99ZrgcvaP/pweIvZjLh9kYHcmQ2LPTYRadzly3veTmWMUlE1RjGKBc0us
 gKgk6jw9MNWg2mdNQe8OCmR5+DvFv58I1/8Aufsnrlc7XSmWid9oS6bxMBI8DdKVRU4Ra+pxTBK
 HV5Rknan3H0Ey+dNG/U1RrFoxZOEHK5yGKbx8eFu+CwwfBMkXgE1mb9b3Keeq07Z1y2pEhW87Ez
 2IWAD1yg9JuqPYHguZXCIklEY582c82IJyBHTlV8poYft+e4cnUE2eopE2Xue+bmsQ5LxTeRYAP
 fP/FWnXsxih754Tx9vZS71l2/FWPnp1MEoK/euseeme8I2+Ojicj/Cg1FordRz0mhxMA5m2Y1Jm
 RoyxfGnfZz5Sory6JbCezKiO245F1cWnHcXCRIoSwGDaB/Ibz15IN9MKfKxOTHVe085uvYmQ0Dd
 dx0l/a5jsFLAnaiWGB7imYPCXlOfQHIY7RU7ZFlcBTO6Rh3X4SnGTlFVjpN1Z3KRROEGWUWaXpc
 fK86+k=
X-Received: by 2002:a05:600c:8189:b0:48e:89f9:9408 with SMTP id
 5b1f17b1804b1-48fe632374fmr115018775e9.20.1778929614964; 
 Sat, 16 May 2026 04:06:54 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:54 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 13:06:11 +0200
Subject: [PATCH 08/12] drm/syncobj: add drm_syncobj_query
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-jorth-syncobj-v1-8-88ede9d98a81@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=3038;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=u/7AwpljxtH4IVP0O+P5dyfoAPoN+qqc7x1nJCbL2qA=;
 b=Z99DZxu195EeP3vO6X1kysFQ8YqTJJCA0BtkhBQFSClYANqqlJRzUiJ2Mte4dsbxSoaJ7uZfc
 SeQCmRzeltDByjvV1yhoKMIXpDXzFzH7PGzJ6lguaIs7JV/fN5LYMoH
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

This makes the logic from drm_syncobj_query_ioctl available to callers
that already have an array of drm_syncobj.

Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 32 +++++++++++++++++++++++++++-----
 include/drm/drm_syncobj.h     |  2 ++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 948084f56c32..9b7ecc2978f5 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1773,8 +1773,6 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 {
 	struct drm_syncobj_timeline_array *args = data;
 	struct drm_syncobj **syncobjs;
-	uint64_t __user *points = u64_to_user_ptr(args->points);
-	uint32_t i;
 	int ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
@@ -1793,7 +1791,31 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < args->count_handles; i++) {
+	ret = drm_syncobj_query(syncobjs, args->points,
+				args->count_handles, args->flags);
+
+	drm_syncobj_array_free(syncobjs, args->count_handles);
+
+	return ret;
+}
+
+/**
+ * drm_syncobj_query - query timeline points of syncobjs
+ * @syncobjs: array of syncobjs
+ * @user_points: user pointer to array of timeline points
+ * @count: number of syncobjs
+ * @flags: DRM_SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED or 0
+ *
+ * Queries the timeline point of each syncobj and writes it to @points.
+ */
+int drm_syncobj_query(struct drm_syncobj **syncobjs, u64 user_points,
+		      u32 count, u32 flags)
+{
+	uint64_t __user *points = u64_to_user_ptr(user_points);
+	uint32_t i;
+	int ret = 0;
+
+	for (i = 0; i < count; i++) {
 		struct dma_fence_chain *chain;
 		struct dma_fence *fence;
 		uint64_t point;
@@ -1804,7 +1826,7 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 			struct dma_fence *iter, *last_signaled =
 				dma_fence_get(fence);
 
-			if (args->flags &
+			if (flags &
 			    DRM_SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED) {
 				point = fence->seqno;
 			} else {
@@ -1832,7 +1854,7 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 		if (ret)
 			break;
 	}
-	drm_syncobj_array_free(syncobjs, args->count_handles);
 
 	return ret;
 }
+EXPORT_SYMBOL(drm_syncobj_query);
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index a9216ea07946..da237ca3e61f 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -141,6 +141,8 @@ int drm_syncobj_transfer(struct drm_syncobj *src, u64 src_point,
 			 u32 flags);
 int drm_syncobj_timeline_signal(struct drm_syncobj **syncobjs,
 				u64 user_points, u32 count);
+int drm_syncobj_query(struct drm_syncobj **syncobjs, u64 user_points,
+		      u32 count, u32 flags);
 void drm_syncobj_free(struct kref *kref);
 int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
 		       struct dma_fence *fence);

-- 
2.54.0

