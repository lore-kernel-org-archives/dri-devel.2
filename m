Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5686606A328
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=to+rtgy7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A3A5112C4B;
	Fri,  6 Nov 2026 09:18:49 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F6610E8CE
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 07:17:32 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso576954eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 23:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793949452; x=1794554252; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=23tdgrbhdEj0Ew1yGHRUaEBBGufmw96pkWF7xHJ9Y+w=;
 b=to+rtgy75NKeo0RJqsR4psLSn0T0G44FK+ok06dgbxWoAatyzr47lTOlAQbTk7YNDD
 s0s8e+ZtybJDJPpqtHR98WeCmAyiVmKD80hQTPyzR33SVt6mm9B+bSQryPu6LfDRHfCA
 ubnou2+Ayokbbs4kA+K1f+LStlqlVnGSVurqEqPm/Z+Arx8cz9tK4smHLbNQcJ8DJlHw
 xCwl+1FLVX3v9s+gWWVNTsZBPLagK4t8kaDD0DqyCsi+83TJHE7ch2QpWunLB0y0XdiY
 gJ57QgGJyNhxzWtmzHO+7UqzhE93EDyTMYu49uGxz8KTyLkFqZIqXbq/8cHSPHVhlFXD
 z4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793949452; x=1794554252;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=23tdgrbhdEj0Ew1yGHRUaEBBGufmw96pkWF7xHJ9Y+w=;
 b=LMvCTSyrk1cNgcUnyBAXCZ4v75BmrlkqAK9WklzazAbti+p2T3JwnKqXGcP+wpmANP
 in6KQtbID7ddjRa6Il0GdWKB74rdUm3sxJD21I+Cf/b2e9R5m9gvBV+38tVRqxF68LqJ
 VJtxQ/FwiAl4zO3bjSmvdmcw1hjYVExU+BXJo5MKDoKnHzLYgZ+bOOHxh0b4si17SRJg
 zroa96p7mMHZ76+uvxK3TIVmdMWo50AyTDrydHqGCvIyCuoPFK0CC6l9jGBVbXkO100n
 TkZyVwyUC2ueOyK0Lt0T2ygyoEm8nnYvDqngKpzbHujNd/Hb1mkypAcXqn8folERh6kP
 Bk8A==
X-Forwarded-Encrypted: i=1;
 AL+hErGcW/6Nce3h3U9/YOrNI4tTsI6C6yWRzrpD0qxaB/yn0A66HV5Rb5ET9VD/yX+BF3RKOB161Fg7e7g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9kB+vWUfBAAsdi95YSYOAphDBWnH2Ol3qJZctxrcCCX58QfeI3
 vbHpMH4ozLTnFMNnIXwKCLqfi2ULJPHX5rHNvTPc51Fa0ShpPI9IxjtX1e91Xjq3qZqZ7w==
X-Gm-Gg: AYBFou0HCZr/WphDwmfW4VRqEwfasyKkU96asO5wPM0F9eUgELaluCL3TD4O1e++27v
 lXBVOBMKrRexompsUiKARClrc8vkaX1E2w0YoXlUpCvcH3RAJYmKtWfYqWLXxIbs3krGenPKOod
 hg5fIRKFzSQzxKtHAR+cBRbn6AP3c8DWgr/UJOpKd7AjtmTTOvW638HLWC0pqJjPmRaGbxTPqbu
 SvWPVTPyUgfjp3LjYFhjNFzd76vrxtJxGYCMzG65ZX6+2EVs3ZIFXQiyXS5cpgz7U9V2LXyBvxL
 hdlmuNX+9a4bybxXS+ppYfBavYS1ZoqMwcq3cihFZ4XZ38ZAWXBNLv4P5GNL+nORHyyKNF5HVSA
 7WZJ8nR6NNzC9KUNg7rlhQOk9IroI/PIrOD3W4DQuBDWf2CPlUdf+rB6lYmX+3bTRUYgGkamACR
 saj9h6VWorgpeTESNbg7XRNCPftWW2ytJkSO8vfGlff2O+yJ8tgnGVOp6hQGfbVWL7Xd7X1LVdx
 reTYohnG6XOWsqZbWrkBjdo8oSEEWQNaxNGXgL+SR6fOnirvZbkN+quPUDuXB4Zfh1PHBYV9owX
 B3W3Yb1CtH2SU8cKvhoc7eokIaQuC4XMqQYwX7+FozrSzCpC/In65pk=
X-Received: by 2002:a05:7301:18ac:b0:36c:a084:30a4 with SMTP id
 5a478bee46e88-36f75b1f65dmr2455761eec.21.1793949451683; 
 Thu, 05 Nov 2026 23:17:31 -0800 (PST)
Received: from pop-os.lan ([2409:4090:1015:ce03:1984:1655:89e8:63d2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36faa4b7404sm3569864eec.24.2026.11.05.23.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 23:17:30 -0800 (PST)
From: saad <primecoder8@gmail.com>
Date: Fri, 06 Nov 2026 12:47:25 +0530
Subject: [PATCH v2] drm/amdgpu: use drm_gem_ttm_dumb_map_offset() for
 dumb_map_offset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-amdgpu-dumb-map-offset-v2-1-0abfb77a84b8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAR/7WoC/4WNQQ6CMBBFr0Jm7RimAoor72FYFDqFSSwlLRAN4
 e5WLuDyveS/v0HkIBzhnm0QeJUofkygThl0gx57RjGJQeWqIspL1M7004JmcS06PaG3NvKMldU
 F8c1cbFtCGk+BrbyP8LNJPEicffgcPyv97N/kSkh4VXVt6oINEz16p+V17ryDZt/3L5G7E9K8A
 AAA
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, saad <primecoder8@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793949447; l=5657;
 i=primecoder8@gmail.com; s=20261105; h=from:subject:message-id;
 bh=dr8+/Sh4e/4pnQunAQ4Dj++/sRRoqxW/WWM80cur6MU=;
 b=TedmxAlnlxjfdYO/u+QTmaiR83q5DTtntTAUn114+cmoB2aARCreQ6QbwbreQHpu+/BHKg47M
 gVbE/KB/AEOBDy2m2D6u0TJARJv09JvdJ7Jl2quDy2hWdUk3t/HfuuQ
X-Developer-Key: i=primecoder8@gmail.com; a=ed25519;
 pk=vJlTVYISGHXXppWzVCeFm0dcME82FTjmVlWBQkyLiKg=
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As part of the DRM TODO item "Remove custom dumb_map_offset
implementations", switch amdgpu's &drm_driver.dumb_map_offset callback
from the driver-specific amdgpu_mode_dumb_mmap() to the generic TTM
helper drm_gem_ttm_dumb_map_offset(), for both amdgpu_kms_driver and
amdgpu_partition_driver.

amdgpu_mode_dumb_mmap() additionally rejected userptr BOs and BOs
created with AMDGPU_GEM_CREATE_NO_CPU_ACCESS with -EPERM. Dropping
those checks from the dumb path does not allow such BOs to be mapped:
returning an offset does not create a mapping, and the actual mmap()
goes through drm_gem_mmap() -> amdgpu_gem_object_mmap(), which performs
the same two checks and still returns -EPERM. The only user-visible
difference is that DRM_IOCTL_MODE_MAP_DUMB on such a handle now succeeds
and the subsequent mmap() fails, instead of the ioctl failing. Dumb
buffers created by amdgpu_mode_dumb_create() are never userptr BOs and
always have AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED set, so they are not
affected.

With that, amdgpu_gem_mmap_ioctl() is the only remaining user of
amdgpu_mode_dumb_mmap(), so fold it into the ioctl and drop its
prototype from amdgpu_gem.h. DRM_IOCTL_AMDGPU_GEM_MMAP, used by
libdrm_amdgpu and Mesa, keeps the userptr and NO_CPU_ACCESS checks
and behaves as before.

Build-tested with CONFIG_DRM_AMDGPU=m (W=1 for amdgpu_drv.o and
amdgpu_gem.o), no new warnings. Not runtime tested.

The code change was written by hand and reviewed with the help of
Claude (AI coding assistant); the commit message was written by Claude.

Signed-off-by: saad <primecoder8@gmail.com>
---
Changes in v2:
- Fold amdgpu_mode_dumb_mmap() into amdgpu_gem_mmap_ioctl() and drop its
  prototype, as it has no other users (Sashiko)
- Link to v1: https://lore.kernel.org/r/20261105-amdgpu-dumb-map-offset-v1-1-7299d94ede11@gmail.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 23 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  3 ---
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 731fe8f9e..134d2fe4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -27,6 +27,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_ttm.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_pciids.h>
 #include <drm/drm_probe_helper.h>
@@ -3151,7 +3152,7 @@ static const struct drm_driver amdgpu_kms_driver = {
 	.ioctls = amdgpu_ioctls_kms,
 	.num_ioctls = ARRAY_SIZE(amdgpu_ioctls_kms),
 	.dumb_create = amdgpu_mode_dumb_create,
-	.dumb_map_offset = amdgpu_mode_dumb_mmap,
+	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
 	DRM_FBDEV_TTM_DRIVER_OPS,
 	.fops = &amdgpu_driver_kms_fops,
 	.release = &amdgpu_driver_release_kms,
@@ -3177,7 +3178,7 @@ const struct drm_driver amdgpu_partition_driver = {
 	.ioctls = amdgpu_ioctls_kms,
 	.num_ioctls = ARRAY_SIZE(amdgpu_ioctls_kms),
 	.dumb_create = amdgpu_mode_dumb_create,
-	.dumb_map_offset = amdgpu_mode_dumb_mmap,
+	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
 	DRM_FBDEV_TTM_DRIVER_OPS,
 	.fops = &amdgpu_driver_kms_fops,
 	.release = &amdgpu_driver_release_kms,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 4ed1706d8..2a72bdf2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -644,13 +644,16 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
-int amdgpu_mode_dumb_mmap(struct drm_file *filp,
-			  struct drm_device *dev,
-			  uint32_t handle, uint64_t *offset_p)
+int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
+			  struct drm_file *filp)
 {
+	union drm_amdgpu_gem_mmap *args = data;
+	uint32_t handle = args->in.handle;
 	struct drm_gem_object *gobj;
 	struct amdgpu_bo *robj;
 
+	memset(args, 0, sizeof(*args));
+
 	gobj = drm_gem_object_lookup(filp, handle);
 	if (!gobj)
 		return -ENOENT;
@@ -661,19 +664,11 @@ int amdgpu_mode_dumb_mmap(struct drm_file *filp,
 		drm_gem_object_put(gobj);
 		return -EPERM;
 	}
-	*offset_p = amdgpu_bo_mmap_offset(robj);
-	drm_gem_object_put(gobj);
-	return 0;
-}
 
-int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
-			  struct drm_file *filp)
-{
-	union drm_amdgpu_gem_mmap *args = data;
-	uint32_t handle = args->in.handle;
+	args->out.addr_ptr = amdgpu_bo_mmap_offset(robj);
+	drm_gem_object_put(gobj);
 
-	memset(args, 0, sizeof(*args));
-	return amdgpu_mode_dumb_mmap(filp, dev, handle, &args->out.addr_ptr);
+	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index b558336bc..718ffe229 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -49,9 +49,6 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *dev,
 			    struct drm_mode_create_dumb *args);
-int amdgpu_mode_dumb_mmap(struct drm_file *filp,
-			  struct drm_device *dev,
-			  uint32_t handle, uint64_t *offset_p);
 
 int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp);

---
base-commit: 279235273fc6c0a33df863b4a1cc52ec1e73aba5
change-id: 20261105-amdgpu-dumb-map-offset-6fa41e8d3fb5

Best regards,
-- 
saad <primecoder8@gmail.com>

