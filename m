Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D8ECD4F47
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 147EF10E18C;
	Sat, 16 May 2026 11:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UbX/IywC";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BFF610E18C
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:06:48 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so4171935e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929607; x=1779534407; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DZXH6WE6NwIFHcNfcXNqTsh8pXC1vp/igAOE1DEZDoU=;
 b=UbX/IywCVWiJh4Sr+7kVEKWXWio3N77Gu0Q0XVyGSiA5uT2OvEFZqb1Kee1Hi7BXbN
 PzrlQy8167q78AEACVL30yFRER54P2/J7lti+VragvV0MoMFxHWBHuMXUyTRcfW4KKq1
 Kt68em1sLzPlJNXUu9tXkfNBjr2TT8jUxkZ8Xgilu5dNaG6tC6yeCApuEH/9WXBOu/77
 jcyBuMd0lp1ie7mRUanwXdUTLFuj9E+2h9cR9aC8PrR2O7/+M34REDJH+0O0XX+yQzMe
 52CPNpKE56+8j0DCVxRDBgo/kmnvjg8Rx1JfdYNhh1ea/PBM9DucfcHtAm9iY4MaGG+e
 hQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929607; x=1779534407;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DZXH6WE6NwIFHcNfcXNqTsh8pXC1vp/igAOE1DEZDoU=;
 b=OJWte9GeSTouTHurQJAZwuxmR93OSDMuRTnsq00i8SFvEBuPih4R058RItKTnmymOX
 m97I0q/sZ2mtyFzgdn2uIKqgQNx7N3V/hveUEqqSjTFn4NtqD2xXym5DXSVqv8i0QUY6
 RqsSRnYnq1Aq5sg0K+0CMwLmjSKMAwCjxz5HHpbNGXeAxXrLG7hzxGANvo3TkhwmjolX
 sB3rE10PsDQGuBnoVeiniBkMjhPxO7jcBd4P0o4IBKhvfdW0bKTUIyluo0B0c6Q1hFfw
 eQagIu54gegaDo5Dgtbdfn3OsqhWCAkuJWLzZRyGN1TtRzQJXyWcVQn3rPqrm7Smyb5s
 aH4A==
X-Gm-Message-State: AOJu0YzePoE2lDJwb24jc/JVm3+HNjitnZV1uP0ikp3JIUkMypAOOl+Q
 w5t8C3B0PIDxyqj/OJzSRVutxVx6df/wlopdnpIf5ii296z9tRegPhnK
X-Gm-Gg: Acq92OFqxXKGMHb04/Rka1YVFInRBSeVlCKq2gPEBUYh9inMw0CkJ6kFYHRiUXraQ99
 mnxYqaF9WrMCEfHNelN5vo4NqeJQCy9uOl9+jfuqJjoIMRn+9Ohpzi/qbhwnULC6X7QOrO0JVKT
 +izO0c4CihWy1xe2GlvLC22soa4+KLDsujbRoYxzavFTyaeUiknsj3t/+k6rwJewFAGAGHTS2C7
 KkL0eGVw0NKEMByzC4WI2NyEpMZT5vhCdM+2Rh6wesIfZnKHIgOYw8sgXZrwRYRZipu977kB3HF
 GKcTfuDMJZ01a9cepe95Ghp+2N55uOty7U9conbfeUwD8owkN0n7vm4FbVKh/xHjoyIjn+WKL0y
 /0bNuJmm8cPBi0wYsjXM4QPvS4cxkDaCuyMRopD1+307UXl1LNE074R5YzQGwfXk8w45SRqV87k
 BovbBYbNuustWE6EF7AVi4A0eIHraLyZg/2WyrC/gpwV5b6hDIlNbNH4tkfc3nNRlwVy1STet6m
 r5IH7wZnqOawoyptg==
X-Received: by 2002:a05:600c:4692:b0:48f:d835:e104 with SMTP id
 5b1f17b1804b1-48fe6325391mr108240075e9.16.1778929606890; 
 Sat, 16 May 2026 04:06:46 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:46 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 13:06:05 +0200
Subject: [PATCH 02/12] drm/syncobj: add drm_syncobj_fence_lookup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-jorth-syncobj-v1-2-88ede9d98a81@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=3464;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=a9lG2nbpvJpNBTclhiNFI8DwaJzMN3KTgSfTJHOAb6U=;
 b=07+mwlPAmGj35N8dMENXh6PCoPSv2aMD6VxpSxRkS+KDubuwjlGqM09oILAMtWVMbSAEmf3Bp
 UZUi9wH3NLuA1L+LQNH3MdycdnESgn7NfT46epz4KcBbp+qwZvxkBy9
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

This makes the logic from drm_syncobj_find_fence available to callers
that have a drm_syncobj instead of a drm_file/handle pair.

Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 34 ++++++++++++++++++++++++++++------
 include/drm/drm_syncobj.h     |  2 ++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index d992aa082ace..8df438fe0807 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -427,7 +427,7 @@ static int drm_syncobj_assign_null_handle(struct drm_syncobj *syncobj)
  * @fence: out parameter for the fence
  *
  * This is just a convenience function that combines drm_syncobj_find() and
- * drm_syncobj_fence_get().
+ * drm_syncobj_fence_lookup().
  *
  * Returns 0 on success or a negative error value on failure. On success @fence
  * contains a reference to the fence, which must be released by calling
@@ -438,8 +438,6 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
 			   struct dma_fence **fence)
 {
 	struct drm_syncobj *syncobj = drm_syncobj_find(file_private, handle);
-	struct syncobj_wait_entry wait;
-	u64 timeout = nsecs_to_jiffies64(DRM_SYNCOBJ_WAIT_FOR_SUBMIT_TIMEOUT);
 	int ret;
 
 	if (flags & ~DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
@@ -448,6 +446,32 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
 	if (!syncobj)
 		return -ENOENT;
 
+	ret = drm_syncobj_fence_lookup(syncobj, point, flags, fence);
+
+	drm_syncobj_put(syncobj);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_syncobj_find_fence);
+
+/**
+ * drm_syncobj_fence_lookup - lookup and reference the fence in a sync object
+ * @syncobj: sync object to lookup.
+ * @point: timeline point
+ * @flags: DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT or not
+ * @fence: out parameter for the fence
+ *
+ * Returns 0 on success or a negative error value on failure. On success @fence
+ * contains a reference to the fence, which must be released by calling
+ * dma_fence_put().
+ */
+int drm_syncobj_fence_lookup(struct drm_syncobj *syncobj, u64 point,
+			     u64 flags, struct dma_fence **fence)
+{
+	struct syncobj_wait_entry wait;
+	u64 timeout = nsecs_to_jiffies64(DRM_SYNCOBJ_WAIT_FOR_SUBMIT_TIMEOUT);
+	int ret;
+
 	/* Waiting for userspace with locks help is illegal cause that can
 	 * trivial deadlock with page faults for example. Make lockdep complain
 	 * about it early on.
@@ -511,11 +535,9 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
 		drm_syncobj_remove_wait(syncobj, &wait);
 
 out:
-	drm_syncobj_put(syncobj);
-
 	return ret;
 }
-EXPORT_SYMBOL(drm_syncobj_find_fence);
+EXPORT_SYMBOL(drm_syncobj_fence_lookup);
 
 /**
  * drm_syncobj_free - free a sync object.
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index 5da9988834b5..580a967ae364 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -124,6 +124,8 @@ void drm_syncobj_add_point(struct drm_syncobj *syncobj,
 			   uint64_t point);
 void drm_syncobj_replace_fence(struct drm_syncobj *syncobj,
 			       struct dma_fence *fence);
+int drm_syncobj_fence_lookup(struct drm_syncobj *syncobj, u64 point,
+			     u64 flags, struct dma_fence **fence);
 int drm_syncobj_find_fence(struct drm_file *file_private,
 			   u32 handle, u64 point, u64 flags,
 			   struct dma_fence **fence);

-- 
2.54.0

