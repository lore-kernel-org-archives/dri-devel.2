Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D56CD37B9
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EE8F10E17B;
	Sun, 10 May 2026 10:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g+RY1sAJ";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1076910F566
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 16:29:00 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8b59772d441so19645166d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778257739; x=1778862539; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VJ1nt1raVmWGZpEel8fILUUX9Nl0Zn9ZJYTC5Z/rJck=;
 b=g+RY1sAJGHu7iKf5JW5IcP+zjKzYOwAaUe2PJIYUjjwdlenthKdJe68OSPliygxdYh
 nwJOY6fi2iOGwF13SJYT9AFglF7GdSjFEcN3nnY5ZR1yHepqsimEcGBJ1+bN3FmftQSl
 FLx2dnhyEWIB1Fq4xmFB1LuuX+mjcVQk7CybFEo0lV8SFPrKFyiwiyhCiGm8ILUSUhZn
 f10Yk/rUWOhYLaOEzUSxtDVWDJJQyFz1Y2UhB7sHmqr1LTJqGGFzvmSE5+YQXpfonpKs
 A1f+Yv4nPbXGI2GW7W9SmaLGJmmRmexvlmx/1CVBP29z1gcmfbPBt7euWtwZ6cK/mG8F
 HjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778257739; x=1778862539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJ1nt1raVmWGZpEel8fILUUX9Nl0Zn9ZJYTC5Z/rJck=;
 b=f3VMVPuiLkVYBGATl2b5gD/ke9Qi/ZeITq5BCRzXZpgaK48oXUCRyJN8CxB5PrWz5V
 iJjd2OwmFXSoeJxSjHvWQDX/8ddshVTJjpkCQImQcC6Q2hUTP47RpHC28WRFhi4C8fxL
 ddB82dHOkjTeyI9Mlw9LD+NTDw7brxVv4m/t8vdTndRFJ010M9yEpvONqr7zOTYmOgDK
 K3AsZjvMuZ0sQ64SEeleskQXAcH9YTo4F5TvPKX0fJxWsNAeVAI24Ttm9ERABrwQl91m
 FclJkFf/7vS8rhoA3eRhWUNkBTX7knSDjEgyV0JEtgOJVumfhw7aDvr+gaEUVKw5b6yB
 dn5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HsZkqDBjw447jEfTZhzSeL0k0bg/J4hr6TVHnZh9F/6Bnfv4tXyDxnU/YRyaQ+5bkQVOaR7uLs54=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCsrbCqdgL+4HDKDn/xN1aJN9y/eRFTKpoyMigxjgDOei5KIop
 LCStr6VZtVetfLnYi/QDeYWU9bGT/OpymVhn7NHmiWRNClxfn7uy3Wn4
X-Gm-Gg: Acq92OGaUE7X5gbNrw7FcmJO29n5MUHII6OvWtq3GW8WOjX2LTxEgdtb7oQhS3dEVhA
 TqtDg6QSRw/vOoi36JcIWlxPZ6/sayBXSsFoCcP7EgRg3WlO+kSX6pO/p+kTOmI19cm+ChGnPzp
 wOwVXI+QBDwhdQB4JZ2HCdYDB4uA5Or1KUKd0MML9bIlnvojQmxWTF/G3ez+TmUEbWCm5SmgIs/
 9oESZJRRqf0kCCQHZrW5l/AeV2bV3BoaVzOt6XsMMSoVWVHPTX7Qp6Sa7Lt0ZcZtsY7/NdTMkKx
 8nY1TNl8I7hfl+Lo9dp3eGaO6vj07ZvCy2jkIxARyagBMervbEcpL80zA10DcCx/7Ot1t+LItmm
 wiqqey328Sx406MeNGNUzMwuhNHLbXyVHyM9Gvw/ceRqjMaLHZTMTis96M0bxa9EZ6YUN6VemZo
 oU2lMDNcEoANUycliHjfQ8q773TJ3jn633Z7spfe9sYCXf6DnlK6/JrOP6uuDZWr9CdS/VDQsQw
 ajBewK47ablfl+vbckRK/JfxEuFaI1N2y9UJQfox5Q=
X-Received: by 2002:a05:6214:3f81:b0:89c:a2b2:8d44 with SMTP id
 6a1803df08f44-8bc451770demr211625746d6.39.1778257738686; 
 Fri, 08 May 2026 09:28:58 -0700 (PDT)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu.
 [165.124.184.136]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf3b0c4db9sm21343796d6.4.2026.05.08.09.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 09:28:58 -0700 (PDT)
From: Ziyi Guo <guoziyi114@gmail.com>
X-Google-Original-From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: maciej.falkowski@linux.intel.com,
	karol.wachowski@linux.intel.com
Cc: ogabbay@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] accel/ivpu: Reject PRIME export of userptr BOs
Date: Fri,  8 May 2026 16:28:56 +0000
Message-Id: <20260508162856.1131843-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

  Userptr BOs wrap pinned user pages in a private dma-buf solely for
  internal use by the NPU driver. Allowing userspace to re-export such a
  BO via DRM_IOCTL_PRIME_HANDLE_TO_FD would expose those pages to other
  drivers through an interface that was never intended to be shared.

  Override the driver's prime_handle_to_fd callback to detect dma-bufs
  backed by ivpu_gem_userptr_dmabuf_ops and reject the export with
  -EINVAL.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/accel/ivpu/ivpu_drv.c         |  1 +
 drivers/accel/ivpu/ivpu_gem.c         | 28 +++++++++++++++++++++++++++
 drivers/accel/ivpu/ivpu_gem.h         |  3 +++
 drivers/accel/ivpu/ivpu_gem_userptr.c |  5 +++++
 4 files changed, 37 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 2801378e3e19..086d4c769b33 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -545,6 +545,7 @@ static const struct drm_driver driver = {
 
 	.gem_create_object = ivpu_gem_create_object,
 	.gem_prime_import = ivpu_gem_prime_import,
+	.prime_handle_to_fd = ivpu_gem_prime_handle_to_fd,
 
 	.ioctls = ivpu_drm_ioctls,
 	.num_ioctls = ARRAY_SIZE(ivpu_drm_ioctls),
diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index 4f2005a8d496..82079f372b39 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -12,6 +12,7 @@
 #include <drm/drm_cache.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_file.h>
+#include <drm/drm_prime.h>
 #include <drm/drm_utils.h>
 
 #include "ivpu_drv.h"
@@ -249,6 +250,33 @@ struct drm_gem_object *ivpu_gem_prime_import(struct drm_device *dev,
 	return ERR_PTR(ret);
 }
 
+int ivpu_gem_prime_handle_to_fd(struct drm_device *dev, struct drm_file *file_priv,
+				u32 handle, u32 flags, int *prime_fd)
+{
+	struct ivpu_device *vdev = to_ivpu_device(dev);
+	struct dma_buf *dmabuf;
+	int fd;
+
+	dmabuf = drm_gem_prime_handle_to_dmabuf(dev, file_priv, handle, flags);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	if (ivpu_gem_is_userptr_dma_buf(dmabuf)) {
+		ivpu_dbg(vdev, IOCTL, "Exporting userptr BO is not allowed\n");
+		dma_buf_put(dmabuf);
+		return -EINVAL;
+	}
+
+	fd = dma_buf_fd(dmabuf, flags);
+	if (fd < 0) {
+		dma_buf_put(dmabuf);
+		return fd;
+	}
+
+	*prime_fd = fd;
+	return 0;
+}
+
 static struct ivpu_bo *ivpu_bo_alloc(struct ivpu_device *vdev, u64 size, u32 flags)
 {
 	struct drm_gem_shmem_object *shmem;
diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
index 0c3350f22b55..bfd15ce02354 100644
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -29,6 +29,9 @@ void ivpu_bo_unbind_all_bos_from_context(struct ivpu_device *vdev, struct ivpu_m
 
 struct drm_gem_object *ivpu_gem_create_object(struct drm_device *dev, size_t size);
 struct drm_gem_object *ivpu_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf);
+int ivpu_gem_prime_handle_to_fd(struct drm_device *dev, struct drm_file *file_priv,
+				u32 handle, u32 flags, int *prime_fd);
+bool ivpu_gem_is_userptr_dma_buf(struct dma_buf *dma_buf);
 struct ivpu_bo *ivpu_bo_create(struct ivpu_device *vdev, struct ivpu_mmu_context *ctx,
 			       struct ivpu_addr_range *range, u64 size, u32 flags);
 struct ivpu_bo *ivpu_bo_create_runtime(struct ivpu_device *vdev, u64 addr, u64 size, u32 flags);
diff --git a/drivers/accel/ivpu/ivpu_gem_userptr.c b/drivers/accel/ivpu/ivpu_gem_userptr.c
index 7cbf3a4cdc73..45eabea5961e 100644
--- a/drivers/accel/ivpu/ivpu_gem_userptr.c
+++ b/drivers/accel/ivpu/ivpu_gem_userptr.c
@@ -61,6 +61,11 @@ static const struct dma_buf_ops ivpu_gem_userptr_dmabuf_ops = {
 	.release = ivpu_gem_userptr_dmabuf_release,
 };
 
+bool ivpu_gem_is_userptr_dma_buf(struct dma_buf *dma_buf)
+{
+	return dma_buf->ops == &ivpu_gem_userptr_dmabuf_ops;
+}
+
 static struct dma_buf *
 ivpu_create_userptr_dmabuf(struct ivpu_device *vdev, void __user *user_ptr,
 			   size_t size, uint32_t flags)
-- 
2.34.1

