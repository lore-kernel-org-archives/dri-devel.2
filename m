Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF79C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE2110EA09;
	Sun, 13 Sep 2026 20:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L9/uwUy/";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BE3110E404
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 17:26:51 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so863584a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789234010; x=1789838810; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7izVhFPU5f2Mxv3Dnub39YzR+1KtOurbwyZEjfxW9ME=;
 b=L9/uwUy/yenucfezIrYxo39q3q/2f2eF1rS1bFY9VNHgEVs7LD9ScC6GmCtlj+3/sw
 7Ug8iuf4R/OomXhIh8tfubHsalEwjGgEF3lvldBb6H0CHKP9UzFkzBs0bZhG4LTmuH+J
 9cis2JeWotawzKF1sbgbmEgqKakZaB8U+esT9wa/C9JoIv7+D41hvTlyFSqKRoxCcXJl
 996BQZpGEPrjGcs/5lZA8jfYkJT/jD0LTXZBJXQE8Up8ri3uk9TZlXvWdN7+iDLQItFF
 uKzua2WGQ3vvwvxwaZPY0LhKIXZcHHYvwdXfOWEiLt96171g46NMU1nWO+J7L/L9aAi4
 DjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789234010; x=1789838810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7izVhFPU5f2Mxv3Dnub39YzR+1KtOurbwyZEjfxW9ME=;
 b=QaF2SSuhMwVPxXpVH3N9WYCPG9uR6dHhRk96Cy8OVYQN28xiOenriNnRZcfICsFcOb
 qKrEfskoeUFWOZwKMbkHMWPRBTplliomX7Z/iKMzjMbLhzEp9Y4zWaJWBBx0Oe8TS8/8
 LtwcLxbayE85f2z9Wkl+QxawtOWFOLSiD7vQPkjgJSCFGV6JN6A7Dx7xO/LmHW6frPVT
 xb0kJhXFpazr5Xwhj9wmXw2ObdDa8wjIJU94nVlVDalD6EVssvAVvO8+JNQds1wJ5Aka
 1JP3qpcYSFHlfLcIv/mqY3zqNK3JtA5auoLKTBebPrJRe5VJTuiZF5ZITp7iRAQz4QDZ
 mJGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/qTL7Ts5uf8Z5V2O4TEa5LP9x2BB/YFt0+idO7V7LLbrGRyZVbedbNe0PoagLLex9qO0e32VJmhM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mXzYuipIYE1FWp1NSFrThRGYnDKf9qEVETUL6bflW/bHtRBEBx
 3i07+xh5CqZWCjhI6TqtPXw/zzob2M3Nw43QW0ZWpHPEmw+Iv1I/6jK2
X-Gm-Gg: AYBFou1ovWORwAKBMU7czMT/0cHF9RCuj+qiJYoYex7fhCv4Zc/vdr9+LUOBQqNYzY3
 zbU/7tmQ96iozYsdNUtLY4Nz/6QyvVh8EzqgSNqGj6J86oEhaVXrQprWcpdN+zIvOLVspsjmlt7
 Vymc4ka15HgsGF1FmOxl0tp8I4vUxJKfuBYhq/P3l64+YPVOmmgLWHNHFNhKQia4DBOirdqS88j
 WBRc9xspq/6AamirhbWG9Hylm0o7YLJ9Dzbieoq0MB6/DnNnSL5W+tjIqURcvXOzvWZ04PIqKBW
 xCaRqT9CC/zBkssLc8vGMnTqx1s60pXoD+ZJOuXgDhCv+Cgzh5BRcwMW7hBq4cvRK/XMW1o5p8o
 t768u0Bnv4wHP6K8j1N3nkzaRJW9mQiBbLlyJtM8G/GdOkp3sPhY2bvPRUAo7767L7PjHeyfxHb
 yuj3QWb7wyHvtqROm71qXz6Nri5U1xY571y/JQrxqqGofZppGotpSw9uSrAudY9i9nCxfYsyWqx
 H5bKQa4ku4=
X-Received: by 2002:a17:90b:2741:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-39d9bdbb0e4mr16432141a91.6.1789234010571; 
 Sat, 12 Sep 2026 10:26:50 -0700 (PDT)
Received: from G15-5520 ([103.206.144.35]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-143659a9a06sm14279263c88.0.2026.09.12.10.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:26:50 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] drm/amdgpu: replace kmalloc_array with kmalloc_objs
Date: Sat, 12 Sep 2026 17:25:52 +0000
Message-ID: <20260912172552.70502-1-lalitshankarch@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Replace the remaining kmalloc_array instances with kmalloc_objs.

No functional changes.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c         | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 9 +++------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 132d054900b5..f2427bf07905 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -986,7 +986,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
-	config = kmalloc_array(256, sizeof(*config), GFP_KERNEL);
+	config = kmalloc_objs(*config, 256);
 	if (!config)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 242c48e85912..f67caa255327 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -900,8 +900,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (info->read_mmr_reg.count > 128)
 			return -EINVAL;
 
-		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs),
-				     GFP_KERNEL);
+		regs = kmalloc_objs(*regs, info->read_mmr_reg.count);
 		if (!regs)
 			return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 743b41db5b7c..cbdbd8196eb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -486,8 +486,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	if (IS_ERR(syncobj_handles))
 		return PTR_ERR(syncobj_handles);
 
-	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj),
-				GFP_KERNEL);
+	syncobj = kmalloc_objs(*syncobj, num_syncobj_handles);
 	if (!syncobj) {
 		r = -ENOMEM;
 		goto free_syncobj_handles;
@@ -726,13 +725,11 @@ amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *fil
 	struct drm_exec exec;
 	int i, cnt, r;
 
-	fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info),
-				   GFP_KERNEL);
+	fence_info = kmalloc_objs(*fence_info, wait_info->num_fences);
 	if (!fence_info)
 		return -ENOMEM;
 
-	fences = kmalloc_array(wait_info->num_fences, sizeof(*fences),
-			       GFP_KERNEL);
+	fences = kmalloc_objs(*fences, wait_info->num_fences);
 	if (!fences) {
 		r = -ENOMEM;
 		goto free_fence_info;
-- 
2.53.0

