Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28259CD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31DEF10E19D;
	Sat, 16 May 2026 11:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="egODXPEq";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07E7B10E19D
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:06:51 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48e56c1bf5dso2685165e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929609; x=1779534409; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3zYhR3PGwQ+MjR6b0xjhfz0ypo71/qwlvJbXPw+XJwc=;
 b=egODXPEqReh2z1gduhbYrVYOwOllD7Po1R0iY1mvppSPMR1lWET2glunkBjF0mYnRJ
 PSxqbnPOvopinNgVhMytOpVirLt74TlZcAepFD15zawReOSUbadjiJ/FTQxvGmjo7aJB
 v9UwCXVtOF5n6CHZhFPWuRTbckrXLK0xHYmCcgFE+VkwtYLPnxNV22FLbRUdT65+B4Ev
 44OD1gga6TDnq4JkTeGHeNhPupZCPZdOpmG3bXzj019HaXf04gozYCOnQaNucR+/Ng4T
 4cBtn0FqytHG6uNBU6yUHmHj2DWJuVzcyKMw8pHgRj9tc4bo0U3LODMkaUYQBIkTTViT
 JVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929609; x=1779534409;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3zYhR3PGwQ+MjR6b0xjhfz0ypo71/qwlvJbXPw+XJwc=;
 b=mpIQMxhevbrgJJ7MFsn9kr4OK9tZ4dqcbomd37tLql0CxLSwDoEiAZTwimKIGHeTDE
 yorMHEsjL9JYTr+zlcJap8U5h4J0SMvzMRZDv1g/aGdFO/zcOnXSusWwWxEM6WUdd/wU
 ow2973oQTRKiiCJC4VpPziht1OZnwr8/PM2UQW63/4pH/6i4ThQoYKRgRBBJms5x3YRC
 EDuVE+Q6d6D3ZmsXiDhjWcf7P7HQSZdGkIh8sSjhyvH7gl0Q3bwtwdln/pJBDBPSz9il
 jlnYXtVnOnuQ5rCoNKQz1NaLJruNPmtbNiL4PXcNsdfJvhTbzi4EwHaG+587bsoB95/v
 4mjQ==
X-Gm-Message-State: AOJu0YxFKb/e+QofFrFOAmjYjoYu2X/hNZ9CR8CxVl6OEeAgG+tepV1B
 hfPAmEjRi4M03GqqtDYpJR3tBYRp+mm56cb1IC4T4G3ileEZQIt/hpfp
X-Gm-Gg: Acq92OEQF1MNBC9dlUiSrtkr9ROVrrPvtXzIWPRvXLP2K0Y4VCw8w16E4UUIiXFOc0N
 /KN8ioyWQ453TVlv2wh9GLRyCR5fOtW9BT/EjofNQsI/p4l45gEXpckfzY7qWSCW/Q+EWRBjT6h
 JjH33Ufchy37rpSXkkXKbohCCfl/CbITlPUWaKP6aG73rkEVXTXuFQJTftkdbQfcrzqTD0IVocU
 kT41EEiRWEuxlhAg+QYNrJG7ltZ3qN+PyEnOTmVJinixeD3ZW0lqFSvF5ATtjG5Z81srcnYtJET
 m10kqOqmRleYh+LQWlj5Uw7mKszmWpElWdbeygcSrn7qtUAYywj9L5wkjQXtV5jcha6tbP20NX6
 8T3Tb7VxPXouArVGLwOvTzSjB4pHuXoyijCPMRhIfi1yPmT/tGQ2FmjcuE/5lbojEi6rpal+DYR
 2MfiZPUZXcrbXmfzZn4y8Oejm+LjmgwBaDYPB+QkSNS1lYfUSJMOdDIniCd/3As6F4e+0WOgHpg
 bI3wf4=
X-Received: by 2002:a05:600c:4e47:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-48fe61ed3b3mr113720245e9.16.1778929609523; 
 Sat, 16 May 2026 04:06:49 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:49 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 13:06:07 +0200
Subject: [PATCH 04/12] drm/syncobj: add drm_syncobj_register_eventfd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-jorth-syncobj-v1-4-88ede9d98a81@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=3158;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=E8KFRmAvFwSHl3US+f+37kFcs+Zh1TZlm/HDUacqWIY=;
 b=bWpzKA+XEX3J2UNOYwj8QCncPGUIt1EclXXwvNyI/mmaQH21mYNpvhjIrkkFE7rAGXoJvJuvr
 uSj76PriSooBBU33M65Bq/uYq41w4a4tjHiYN/O/IE29Xyc6bLuV1Yr
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

This makes the logic from drm_syncobj_eventfd_ioctl available to callers
that already have a drm_syncobj.

Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 37 ++++++++++++++++++++++++++++++-------
 include/drm/drm_syncobj.h     |  2 ++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 648afd1f4fdd..3e8fb7e0cace 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1502,8 +1502,6 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 {
 	struct drm_syncobj_eventfd *args = data;
 	struct drm_syncobj *syncobj;
-	struct eventfd_ctx *ev_fd_ctx;
-	struct syncobj_eventfd_entry *entry;
 	int ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
@@ -1519,7 +1517,33 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 	if (!syncobj)
 		return -ENOENT;
 
-	ev_fd_ctx = eventfd_ctx_fdget(args->fd);
+	ret = drm_syncobj_register_eventfd(syncobj, args->fd, args->point, args->flags);
+
+	drm_syncobj_put(syncobj);
+
+	return ret;
+}
+
+/**
+ * drm_syncobj_register_eventfd - register an eventfd for a syncobj
+ * @syncobj: sync object to add the eventfd to
+ * @ev_fd: eventfd file descriptor to signal
+ * @point: timeline point to wait for
+ * @flags: DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE or 0
+ *
+ * Registers an eventfd that will be signaled when the point is
+ * signaled or available.
+ *
+ * Returns 0 on success or a negative error value on failure.
+ */
+int drm_syncobj_register_eventfd(struct drm_syncobj *syncobj,
+				 int ev_fd, u64 point, u32 flags)
+{
+	struct eventfd_ctx *ev_fd_ctx;
+	struct syncobj_eventfd_entry *entry;
+	int ret;
+
+	ev_fd_ctx = eventfd_ctx_fdget(ev_fd);
 	if (IS_ERR(ev_fd_ctx)) {
 		ret = PTR_ERR(ev_fd_ctx);
 		goto err_fdget;
@@ -1532,20 +1556,19 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 	}
 	entry->syncobj = syncobj;
 	entry->ev_fd_ctx = ev_fd_ctx;
-	entry->point = args->point;
-	entry->flags = args->flags;
+	entry->point = point;
+	entry->flags = flags;
 
 	drm_syncobj_add_eventfd(syncobj, entry);
-	drm_syncobj_put(syncobj);
 
 	return 0;
 
 err_kzalloc:
 	eventfd_ctx_put(ev_fd_ctx);
 err_fdget:
-	drm_syncobj_put(syncobj);
 	return ret;
 }
+EXPORT_SYMBOL(drm_syncobj_register_eventfd);
 
 int
 drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index 7677fd995be0..85e7ca7f7896 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -134,6 +134,8 @@ signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 					   uint32_t count, uint32_t flags,
 					   signed long timeout, uint32_t *idx,
 					   ktime_t *deadline);
+int drm_syncobj_register_eventfd(struct drm_syncobj *syncobj,
+				 int ev_fd, u64 point, u32 flags);
 void drm_syncobj_free(struct kref *kref);
 int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
 		       struct dma_fence *fence);

-- 
2.54.0

