Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CBCC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BF510E3F2;
	Mon, 21 Sep 2026 07:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LnlVByz8";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9926110E1B6
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 21:52:33 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747f05ffdso13640025ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 14:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789854753; x=1790459553; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4UB+obLd5sZwu+zoy2b+DbkHvLbMMvfZd67jH6/qC/s=;
 b=LnlVByz80t1q4HqqYgbATtq5jh8RWeSI65Sl46wi8auga2Ao4snJylvoM0FJKQHe8G
 MtrvNCeHoAIjF+ls1WLMTE7ySMN3z3iQIEtlWROOJ+j7iqjsmRSARCKHgeXERqYyWnhx
 83snVmzsKysIuiTuvejNhkdoUCzfPpyByDsvjXrWgxTLA5ahE9FYCuvlnglY8+u0UP42
 MkhtvteTCeNQNWmw8fKV0FoI5q1tsBmxtwR/mfxfFKQPocGAK9IV4OXoQe9eUMyw3kx8
 4WMwEvInwGjOEJsRxFGXoZ2zq+Scf+O6ibpX7rfYWIhE7Z4vwEROLvSULRLfpZYddC4E
 xVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789854753; x=1790459553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4UB+obLd5sZwu+zoy2b+DbkHvLbMMvfZd67jH6/qC/s=;
 b=EAS7zOU7Enj4J/dK7xCVVoYWO0FSpQzPOxJW5ohEOCoR/rJrguO9mClMdQiUo9prsk
 EgR6hqJMtfpmW5BM61NyaTVoMpToHWOghbCMAOgJWjBrI8lFJNlpMZyFesG5x8UMg9n0
 EqjVB2yPRUTPev06MSyx6GhZTwiLWZWCdEl0SqmkilmuJOODpWFe9nOxGBMwvi0+IGNp
 hH+hns0/OP/prMFqqf7sDiJnHqklXzqnlas8lbWQYzvP8Q/d/yfI9V4NQ4rIKBgsL57U
 ykEQw+uA0EEbdy7iaatZMLnyVTJOFm1z0/0dkVUffrntPvDGFBmXt2uBiWSNLne40sl7
 No9A==
X-Gm-Message-State: AFuF++nFmYGR89gNSKqDLWRBPYRPn1gEICTCL/UAKuyZ1hVIbrkOfe96
 6wXyikZAiOrOpG/HhcdqkpBdKvH7S70ds9fTdYWsYYi5dWHnQ2Rui5Sc
X-Gm-Gg: AYBFou35U/umi/CXe1CGraJ0Cd90We5J3nkdmyiF6lYk+zPLDw98xf1jy/fEhppvKu/
 tUsq/A5wPorVz3XHpI7PQsTztc9S7JKsYNaXT7iyL++zFKpuCxzJ8LfQ7hum7O5scGoC41tMPaI
 Yq7cu0R9CXRdfqR+m7RrmLZoMN/uyVrn17q04hD8ciWHkDFhQlwkaxAPBof6N9d+XbWgXP/Dj5m
 jEbShCSHrH0Ln25sFGvUkTjoXyP7b9uuIukE32JfT7A13OUl2mzV/DCvXkOSjj1XxDN+OX9HAhf
 ZjbN4fBvJnMYN3UIZdo8sZiq74avafNVDJ94qptw6U97qFJr51+7LL2aMIS/mFJM4KSJzAkikel
 WahJo6Vi7Wo0ubpRBQ26KuRIUE7Mlf/XkmhHEFJX+qFjcsNtJIUEtClHbgXr9+FBK7xo11dtbXG
 +RLbIDKdwupmnSV9SY/hod7nyPYNkY6xiqkufV7wB7rSFQ0j4h9YKoyTHlKIAu6p1Gnu76bQtg1
 45P9bI/bpRqbJ1tU1p+LX6gNGrF2zTjiCLGn5u0I8sygEfC5gKKURi1SveOEbTHMNN2U+NU08hm
 qb5J1Vstkw==
X-Received: by 2002:a17:902:fc45:b0:2dd:c100:80b1 with SMTP id
 d9443c01a7336-2ddc100811dmr48563035ad.44.1789854753097; 
 Sat, 19 Sep 2026 14:52:33 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddc180395fsm12881915ad.81.2026.09.19.14.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 14:52:32 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: airlied@redhat.com, kraxel@redhat.com, dmitry.osipenko@collabora.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com, tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: fix 0-byte blob ZERO_SIZE_PTR, GEM leak,
 and context_init rollback
Date: Sat, 19 Sep 2026 21:52:32 +0000
Message-ID: <20260919215232.3470178-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

Fix multiple issues in virtio-gpu VRAM mapping, blob creation, and context
initialization:

1. In virtio_gpu_vram_mmap(), set vram->map_state = STATE_ERR if deferred
   virtio_gpu_vram_map() fails so callers do not treat an unmapped VRAM
   node as valid.
2. In verify_blob(), reject rc_blob->size == 0 or size values that wrap
   PAGE_ALIGN() to prevent kvmalloc_array(0, ...) from returning
   ZERO_SIZE_PTR.
3. In virtio_gpu_gem_create(), virtio_gpu_resource_create_ioctl(), and
   virtio_gpu_resource_create_blob_ioctl(), use drm_gem_object_put()
   instead of drm_gem_object_release() on error so the BO's free callback
   is properly invoked.
4. In virtio_gpu_context_init_ioctl(), stage context parameters into local
   variables and only commit them to vfpriv after all parameters and
   ring_idx_mask have been validated.

Fixes: 16845c5d5409 ("drm/virtio: implement blob resources: implement vram object")
Fixes: 85c83ea915ed ("drm/virtio: implement context init: allocate an array of fence contexts")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 66c3f6f74e9c..d2f0b8a3f172 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -45,7 +45,7 @@ static int virtio_gpu_gem_create(struct drm_file *file,
 
 	ret = drm_gem_handle_create(file, &obj->base.base, &handle);
 	if (ret) {
-		drm_gem_object_release(&obj->base.base);
+		drm_gem_object_put(&obj->base.base);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3d8e4ccdb7c1..fb7225d91752 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -185,7 +185,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 
 	ret = drm_gem_handle_create(file, obj, &handle);
 	if (ret) {
-		drm_gem_object_release(obj);
+		drm_gem_object_put(obj);
 		return ret;
 	}
 
@@ -490,6 +490,9 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 			return -EINVAL;
 	}
 
+	if (rc_blob->size == 0 || rc_blob->size > ULONG_MAX - PAGE_SIZE + 1)
+		return -EINVAL;
+
 	params->blob_mem = rc_blob->blob_mem;
 	params->size = rc_blob->size;
 	params->blob = true;
@@ -557,14 +560,14 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 	if (params.blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
 		ret = virtio_gpu_resource_assign_uuid(vgdev, bo);
 		if (ret) {
-			drm_gem_object_release(obj);
+			drm_gem_object_put(obj);
 			return ret;
 		}
 	}
 
 	ret = drm_gem_handle_create(file, obj, &handle);
 	if (ret) {
-		drm_gem_object_release(obj);
+		drm_gem_object_put(obj);
 		return ret;
 	}
 
@@ -616,6 +619,15 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
 		goto out_unlock;
 	}
 
+	u32 context_init = vfpriv->context_init;
+	u32 num_rings = vfpriv->num_rings;
+	u64 ring_idx_mask = vfpriv->ring_idx_mask;
+	bool explicit_debug_name = vfpriv->explicit_debug_name;
+	bool num_rings_set = (vfpriv->base_fence_ctx != 0);
+	char debug_name[DEBUG_NAME_MAX_LEN];
+
+	memcpy(debug_name, vfpriv->debug_name, sizeof(debug_name));
+
 	for (i = 0; i < num_params; i++) {
 		param = ctx_set_params[i].param;
 		value = ctx_set_params[i].value;
@@ -633,16 +645,16 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
 			}
 
 			/* Context capset ID already set */
-			if (vfpriv->context_init &
+			if (context_init &
 			    VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) {
 				ret = -EINVAL;
 				goto out_unlock;
 			}
 
-			vfpriv->context_init |= value;
+			context_init |= value;
 			break;
 		case VIRTGPU_CONTEXT_PARAM_NUM_RINGS:
-			if (vfpriv->base_fence_ctx) {
+			if (num_rings_set) {
 				ret = -EINVAL;
 				goto out_unlock;
 			}
@@ -652,30 +664,31 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
 				goto out_unlock;
 			}
 
-			vfpriv->base_fence_ctx = dma_fence_context_alloc(value);
-			vfpriv->num_rings = value;
+			num_rings = value;
+			num_rings_set = true;
 			break;
 		case VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK:
-			if (vfpriv->ring_idx_mask) {
+			if (ring_idx_mask) {
 				ret = -EINVAL;
 				goto out_unlock;
 			}
 
-			vfpriv->ring_idx_mask = value;
+			ring_idx_mask = value;
 			break;
 		case VIRTGPU_CONTEXT_PARAM_DEBUG_NAME:
-			if (vfpriv->explicit_debug_name) {
+			if (explicit_debug_name) {
 				ret = -EINVAL;
 				goto out_unlock;
 			}
 
-			ret = strncpy_from_user(vfpriv->debug_name,
+			memset(debug_name, 0, sizeof(debug_name));
+			ret = strncpy_from_user(debug_name,
 						u64_to_user_ptr(value),
 						DEBUG_NAME_MAX_LEN - 1);
 			if (ret < 0)
 				goto out_unlock;
 
-			vfpriv->explicit_debug_name = true;
+			explicit_debug_name = true;
 			ret = 0;
 			break;
 		default:
@@ -684,17 +697,28 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
 		}
 	}
 
-	if (vfpriv->ring_idx_mask) {
+	if (ring_idx_mask) {
 		valid_ring_mask = 0;
-		for (i = 0; i < vfpriv->num_rings; i++)
+		for (i = 0; i < num_rings; i++)
 			valid_ring_mask |= 1ULL << i;
 
-		if (~valid_ring_mask & vfpriv->ring_idx_mask) {
+		if (~valid_ring_mask & ring_idx_mask) {
 			ret = -EINVAL;
 			goto out_unlock;
 		}
 	}
 
+	vfpriv->context_init = context_init;
+	if (num_rings_set && !vfpriv->base_fence_ctx) {
+		vfpriv->base_fence_ctx = dma_fence_context_alloc(num_rings);
+		vfpriv->num_rings = num_rings;
+	}
+	vfpriv->ring_idx_mask = ring_idx_mask;
+	if (explicit_debug_name && !vfpriv->explicit_debug_name) {
+		memcpy(vfpriv->debug_name, debug_name, sizeof(vfpriv->debug_name));
+		vfpriv->explicit_debug_name = true;
+	}
+
 	virtio_gpu_create_context_locked(vgdev, vfpriv);
 	virtio_gpu_notify(vgdev);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
index 5b4a3ab81cd5..aaeae38afc0e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vram.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -248,7 +248,10 @@ void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)
 		return;
 
 	mutex_lock(&map_lock);
-	if (!drm_mm_node_allocated(&vram->vram_node))
-		virtio_gpu_vram_map(&vram->base);
+	if (!drm_mm_node_allocated(&vram->vram_node)) {
+		vram->map_state = STATE_INITIALIZING;
+		if (virtio_gpu_vram_map(&vram->base))
+			vram->map_state = STATE_ERR;
+	}
 	mutex_unlock(&map_lock);
 }
