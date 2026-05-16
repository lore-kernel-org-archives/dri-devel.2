Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B430ACD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D4C10E1A0;
	Sat, 16 May 2026 11:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iWNSKY//";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2683F10E18C
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:06:47 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so3182365e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929606; x=1779534406; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lYlLPOH4yVQW/c+VIhwYHIXyYVIQiO3ciiQAaKF6Jpo=;
 b=iWNSKY//Ws99DgXYEgXPPX44dvTI8wg7bwAqSeTnIDoXtwK9bg03UqxHDG6lAd513E
 1aBM8a4sSwAFec+LkfgvixoKkINTysOkdst3mUfnU0PTVtxj83vc6bFUy6hHBovltR7X
 PogzEyl1P6V1xzvtFs/tP/wF6QD1SuJtNu8qMvhW/gnpl6nAll9P3Tt/uRkjYAMVcaaX
 9NrdJ5sw//zGB2SLmx250m1eFCUP/BOWG2UiZ2OojLT/Mzzk81KQmHl7JvZdEcVFjMY7
 5jQlT959iPWCqeSWZtBLApuUbPdFyIGayIpKA8sBGY5WlQ8koKSRt3Wk+qAtGv3sZPWD
 d9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929606; x=1779534406;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lYlLPOH4yVQW/c+VIhwYHIXyYVIQiO3ciiQAaKF6Jpo=;
 b=OemwKfpKYOgdX8NJoudJmUp6IKcaeDs7uoHRjAPgYgGWhbwwSa7p+4I+jkhAW/evuX
 Ev92RSL30VlVY3timbhNIz1bSgAIjBnpFASDnZ/6kRW4lT3sf7LBiHyX112935I6ETfu
 twGqh7hvLzHq4v46AwiS0gF8NvnaI7OzLynMJBLmkmaJ3LzI5bISDvB/2J0GK8zvvsjq
 cRtaW3zO8CBrtJ4rC2+fLDrTliCmYi8LmnTFfxxA8EO4TJduyMMr1gFvCkU5op1do6lf
 +Y7wVBSX44OOGzeBECzaGbqHMG3ZjFkQNJDx+VoNLeoXmoUifwiPEpGLv1rXzxD0ANU2
 MxMg==
X-Gm-Message-State: AOJu0YwV3IQZlFBLFbzwkYlVcNIEVvei65R3Zuf/SjVrfuuo1r8dcVgl
 DWL56GgELWvNIQ3qLucGT1llEfnuJLvmykU/5b2KxBZ9zr6WXLesXj7R
X-Gm-Gg: Acq92OFdVFJyQWqS3SjWOtv6suGrPIewQUZkySp0ewJqS+s7Bws9NgAscgvRSlTNAip
 aKJAvlEcWVxPeOSNp85gDKznWY4xX5GydWuJQDRYqHf30XX8cwJHlFpD1dhaUa/zrCoFJKQsd0Q
 OvKMb1w2brrldFYGEKM38Qe22rQvDkBqyobMkH3SW+r44Cu0iagh9Zmt3x8WrTg7dA79Oh9zwn9
 qO2nRILam3y8DnpbKkKZfrm/SRg4xMabNEVGiuP4kidvrvldASfto5GPgL7kLmXqaC06rfeba28
 lpLfFHOM9Gct3R1DyXhln7Cv16olqvsROu/WuqAwL0saKk6rTJ+zA4GHPNw+oLZWOIz6y0w/t1F
 p35lm06ZIa/C0GZ8gZZ+c+9dMEkfKkI7waQrYgIxU9Gw+eLh+LAR9QYHEXhzNqs/DTX1HxGzc4u
 Fdg7A1QFUraYjyEfBNh/2kIXggAwJjD8PfgOpFE2VsTj359sN/nluIMBCzQ1xcP5Yw/Yq/D6GEU
 krdEEE=
X-Received: by 2002:a05:600c:4e43:b0:48f:e230:8cad with SMTP id
 5b1f17b1804b1-48fe6632135mr98825375e9.33.1778929605528; 
 Sat, 16 May 2026 04:06:45 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:45 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 13:06:04 +0200
Subject: [PATCH 01/12] drm/syncobj: add drm_syncobj_from_fd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-jorth-syncobj-v1-1-88ede9d98a81@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=2530;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=Xxs8inG7yNnVnqsTeDmsro1fFz3EEPayoUW9RCB58oE=;
 b=+8Ntp4CeTenAuSVPrMlJyQQ3aZauaK6+QLTjIL8uRDHdQOin3LlpX/RlNsbP4/cmzUNFxQZTX
 jdMvakZq1vTDS+YTjld0PyK5yiRyPU+nmJ9Cooj8Tm+KOPLpLdSvCEH
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

Given a syncobj FD, returns the underlying drm_syncobj.

Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 37 +++++++++++++++++++++++++++----------
 include/drm/drm_syncobj.h     |  1 +
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 8d9fd1917c6e..d992aa082ace 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -684,6 +684,31 @@ int drm_syncobj_get_fd(struct drm_syncobj *syncobj, int *p_fd)
 }
 EXPORT_SYMBOL(drm_syncobj_get_fd);
 
+/**
+ * drm_syncobj_from_fd - lookup and reference a syncobj.
+ * @fd: syncobj file descriptor
+ *
+ * Returns a reference to the syncobj pointed to by @fd or NULL. The
+ * reference must be released by calling drm_syncobj_put().
+ */
+struct drm_syncobj *drm_syncobj_from_fd(int fd)
+{
+	struct drm_syncobj *syncobj;
+
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return NULL;
+
+	if (fd_file(f)->f_op != &drm_syncobj_file_fops)
+		return NULL;
+
+	syncobj = fd_file(f)->private_data;
+	drm_syncobj_get(syncobj);
+	return syncobj;
+}
+EXPORT_SYMBOL(drm_syncobj_from_fd);
+
 static int drm_syncobj_handle_to_fd(struct drm_file *file_private,
 				    u32 handle, int *p_fd)
 {
@@ -701,20 +726,12 @@ static int drm_syncobj_handle_to_fd(struct drm_file *file_private,
 static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
 				    int fd, u32 *handle)
 {
-	struct drm_syncobj *syncobj;
-	CLASS(fd, f)(fd);
+	struct drm_syncobj *syncobj = drm_syncobj_from_fd(fd);
 	int ret;
 
-	if (fd_empty(f))
-		return -EINVAL;
-
-	if (fd_file(f)->f_op != &drm_syncobj_file_fops)
+	if (!syncobj)
 		return -EINVAL;
 
-	/* take a reference to put in the xarray */
-	syncobj = fd_file(f)->private_data;
-	drm_syncobj_get(syncobj);
-
 	ret = xa_alloc(&file_private->syncobj_xa, handle, syncobj, xa_limit_32b,
 		       GFP_KERNEL);
 	if (ret)
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index b40052132e52..5da9988834b5 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -117,6 +117,7 @@ drm_syncobj_fence_get(struct drm_syncobj *syncobj)
 
 struct drm_syncobj *drm_syncobj_find(struct drm_file *file_private,
 				     u32 handle);
+struct drm_syncobj *drm_syncobj_from_fd(int fd);
 void drm_syncobj_add_point(struct drm_syncobj *syncobj,
 			   struct dma_fence_chain *chain,
 			   struct dma_fence *fence,

-- 
2.54.0

