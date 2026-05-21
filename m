Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277FDCD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 16:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8036310E534;
	Thu, 21 May 2026 16:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PTKpwlI7";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB67F10E534
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 16:57:45 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so4280949f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779382664; x=1779987464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnTEuExknFrPGgWWGDi9bf26Y2IsV884az7JaaVS2Oc=;
 b=PTKpwlI7loany9RfNKhVsF8nttp25sDihw5+hkCARaTTKcB0a3dWsYsahy7btWUiBj
 gCwcNa4vrx4p75qKaz/hSy5HnSwwGMIS0xsA9rKnCQIDVbvDntFhXp8NiHU4FxRiUt1E
 aubD4lhTTz9BIfHP90cjE1aLYKvZmXCKXmd6ZJ1rzrnLo7qSQhAShUeHMMk6wcmbGgG5
 Ms1nDeamfVQfqwWZ5c7Lp3iiNeZZJc5PsaKMdZWq2ewOZ0X0Yd0DHL/06kbk5P5anI2F
 xkx4w2kwaXBY3uhHdJ6jnhrKWiLwVn3BvqbwKtyvOULJeZAjruBlA5S7JgsU5IQMq6HZ
 Y+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779382664; x=1779987464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnTEuExknFrPGgWWGDi9bf26Y2IsV884az7JaaVS2Oc=;
 b=h+yJ4RneUHeYUy81CUatvCO3YfPI5ec/4TEiAE11NGx915faNy71rod3U+737msIYd
 jgv/wPNmCmOOJDIWW2oBOU6CmOLmM8LayAJ5G1MsCaCtHIG9YwtRnyD7ImT0hpzgcZti
 PBDlnlh89cn77omGx5+z+qbIVHU6oR37OWD20YcPqkbrDk137llM+KtCAvL1RHkbUTxg
 VaKOEGS2BqkWbipYsEV4z/iSnCEW0TrFLHGoB0Nb67571pCNlMjYuPmSztSJ1v0Gz38/
 rGH3bGZ8jI62WO8/DM5csttc7tSnHP4ihIVfp3OfWNHtiRg3dwdQiaQasPqiSsXsy5rZ
 CSUw==
X-Gm-Message-State: AOJu0YzgP3kro1A3JzfUSEAIEOGFjdpjqj11xQ3U2e/wGhfCd8oPkU9F
 4xyjg5P94wqiQlP2hCl0/mGYor1CJUaj0xZW6ke6OhuA01N7JyfU94As6uRyy2wb
X-Gm-Gg: Acq92OFcf0ePrgh8piGhgEZcIbzLu0GYHRO+FhZYGyRD/vqALlN7FNpgc26UPQU86Vp
 /WawhZ5m8Ljcv8X4BHP73JWBXFexre9HKK1W5gshczo9l1/byRsx5Np1IgPo/Xi9W5z9q7+n7ob
 r18dyXYV9pVUdw8hRGijapCMQ5sbbsLGDXFU6QFnT0CgKHGX0KOJ9dyDIqu1jhlbNtu4QsA5WW+
 tUV0PI+Avw/VftyLG8cdjO9QUMCoX3i1w4YdSrESChogD1l7aOAHq4O+L0HIL35hiQDMSUbWjGx
 ZeEQfenh+vzAJv0oF0aDraRAoYezvfWvmoZxrZOAReGTN1fbzM0d7IWqB4K9jPuqiSFpSHkIpBI
 u8ezNomrBBI5uc6zOCJor+ZvFodCJEBtmLqa5MyIWhPxSmlnuZUNk292eTnjkMWVdOItIiASqHo
 2Y2h7JZDRUWwdukk4rHmtFmzKfjXnNG2oiaw1NdE2UkvsDPYo9AI0ssC2zzx19FbpG0AxKgIo8b
 d1jiv4AV1XQ0SswD4r8qHS8Xg6TKTSwiYZ725iPm6566Q7xDQ==
X-Received: by 2002:a05:6000:468e:b0:45d:2efc:dc6e with SMTP id
 ffacd0b85a97d-45ea37be4aamr4055967f8f.20.1779382664110; 
 Thu, 21 May 2026 09:57:44 -0700 (PDT)
Received: from alcachofa (84.red-88-21-69.staticip.rima-tde.net. [88.21.69.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7d0bf6sm4341957f8f.7.2026.05.21.09.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 09:57:42 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: dri-devel@lists.freedesktop.org
Cc: security@kernel.org, dhabal123@gmail.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Subject: [PATCH] accel/rocket: fix UAF via dangling GEM handle in create_bo
Date: Thu, 21 May 2026 18:57:18 +0200
Message-ID: <20260521165720.2113571-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Dhabaleshwar Das <dhabal123@gmail.com>

rocket_ioctl_create_bo() inserts a GEM handle into the file's IDR via
drm_gem_handle_create() early on, then performs several operations that
can fail (sgt allocation, drm_mm insert, iommu_map). If any fail after
the handle is live, the error path calls drm_gem_shmem_object_free()
which kfree's the object without removing the handle from the IDR.

This leaves a dangling handle pointing to freed slab memory. Any
subsequent ioctl using that handle (PREP_BO, FINI_BO, SUBMIT) calls
drm_gem_object_lookup() and dereferences freed memory (UAF).

Fix by moving drm_gem_handle_create() to after all fallible operations
succeed, matching the pattern used by panfrost, lima, and etnaviv.

Also fix drm_mm_insert_node_generic() whose return value was silently
overwritten by iommu_map_sgtable() on the next line. Add the missing
error check.

[tomeu: Move handle creation to the very end]

Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
Reported-by: Dhabaleshwar Das <dhabal123@gmail.com>
Signed-off-by: Dhabaleshwar Das <dhabal123@gmail.com>
Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 drivers/accel/rocket/rocket_gem.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index c8084719208a..a5fffa51ff35 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -79,11 +79,6 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	rkt_obj->size = args->size;
 	rkt_obj->offset = 0;
 
-	ret = drm_gem_handle_create(file, gem_obj, &args->handle);
-	drm_gem_object_put(gem_obj);
-	if (ret)
-		goto err;
-
 	sgt = drm_gem_shmem_get_pages_sgt(shmem_obj);
 	if (IS_ERR(sgt)) {
 		ret = PTR_ERR(sgt);
@@ -95,6 +90,8 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 					 rkt_obj->size, PAGE_SIZE,
 					 0, 0);
 	mutex_unlock(&rocket_priv->mm_lock);
+	if (ret)
+		goto err;
 
 	ret = iommu_map_sgtable(rocket_priv->domain->domain,
 				rkt_obj->mm.start,
@@ -112,8 +109,18 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
 	args->dma_address = rkt_obj->mm.start;
 
+	ret = drm_gem_handle_create(file, gem_obj, &args->handle);
+	if (ret)
+		goto err_unmap;
+
+	drm_gem_object_put(gem_obj);
+
 	return 0;
 
+err_unmap:
+	iommu_unmap(rocket_priv->domain->domain,
+		    rkt_obj->mm.start, rkt_obj->size);
+
 err_remove_node:
 	mutex_lock(&rocket_priv->mm_lock);
 	drm_mm_remove_node(&rkt_obj->mm);
-- 
2.54.0

