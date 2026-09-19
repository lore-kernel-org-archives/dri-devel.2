Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A55C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B09E10E399;
	Mon, 21 Sep 2026 07:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KZn1lPwK";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4883110E53F
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:34:43 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d93ff61046so18674495ad.3
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789857283; x=1790462083; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7hePZhOSnen3stmEQKdmfJfV/rWkem/5+3T/F6pvXcQ=;
 b=KZn1lPwKAh+/xTNjUthkJGNXPrKd3wE9rBQFVZ3GXmB9JlgzTI0GNWXWc+g1rnMHlT
 YjnkiJYNqw4NwWCmeBx2ibmM6dUpwTuUzZp4g1f/QkyZ+q69IsgcUDQsuRL/6xRvnZLm
 dOrG6E9+VrTWY7jUSVcD/9KVFT8e+7HPs/HLhHqRdROr3SA+piy3EHn+V3uIjo2wL7zi
 2E3yAExyZN1igZBwFEY4gTZnRF8Om6aLoPLGaY6jUvGdTXJup0spGVeGW9r4vNUJaHa6
 N5ZHfffzFRv1aAFs1W/neYLDJ2UOG8+CgFAdc/94rr3ohkgK9BmcQuaoQYueUcf9jXGX
 sYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789857283; x=1790462083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7hePZhOSnen3stmEQKdmfJfV/rWkem/5+3T/F6pvXcQ=;
 b=nvMALQMTE0rfgPNEAXj7LvcADFjZY/mBLrzHV8ruyCmOyCxXTBZg5f6tI1BMir5Kl1
 shCy64kN2QE57yP146EY5ccGjFs/beGiKWSk/9SO0VIz/nURm3Tg58vta6oI1w6aomCn
 Ct1kVanONvrP3FnPqYsYsOctkEgaxIM/HSNwTYWYHv4hBg6bZEu/LQLw6/y81WFsvXjZ
 9Y8yHm1tIYSrg27PPl1u0PhU44KzrZphLNtbQUSPO5DorVdeUgZ47j6J/awJS5DuqIg+
 t3TAwkgJW9OaFYte/SJ404Jlksn9Wd8Uwa43pJFPSALVEBT1W/1x5Vka4lXY8iM3NHqQ
 2efQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByCpB6cFk6lP0F6YfuEO1s0bWKlbGeFo8WKC3vJO1++fEYIThSootJCfRUaIpLPZrAgWuH47wOzgdw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ngKmo8kBhD34oAPMB7+oWIvcChCztdvV/PPvX0slb3fHocNMiK
 IbNEFIiA86jg08NbjHxpOSIzkMlmJXBehGmahB0UFuGqLORBJ+DWEtmj
X-Gm-Gg: AYBFou2jfgKjy7vnQ/hDyliEJfg8SVzOQt6Q85vdQ8ahCrc8DAXMrghGvd9weSTs9OD
 nhLfLi0OiPwp0Kw7VYHmXlgQGTYxLqvHvvjFDOhVWH/CMbLOdFJ+Wjkw2xEgh6fy9pJaXPhy14/
 H9Q49B0HCzw+ADzYBtJ3adG1uqnwCEOQA0lWVzxJQ6hYuczuZiIVX6AxPoMVfdIv5HSGOCMgiaI
 rhQDUyW5DGB0lcM0G5rvW9N3jl2pbhqdeXeOMYc9wD6y4AaHY09tLIah9Qe89QPDA0NQuXo6/rG
 /Igd0kKU6wmtYB0ZnIf7mHVd7WMooQfWKNQmC6jXiwKWGimEr//2UVgMlX+BvhER3bLYmypzH6n
 mmONBHe4xOoMPfZO4mI3yfDlzXPRXT2PAkXA4EOxNi8N33dx8QYnRS949ApwMKBB6aNU0UZeDNc
 hHTgK2pATkMe9aLzsuCSBqKxE41lsgccSO/4Eki/ajViTH8vvg03u56bQ6yYMfWKy3UaqpfC0aH
 nWY0cI0KFz+UVObmKv41Ue9zEbCMVEIvLxtlsc/H7cNmHd1WdyEroMsSklA8cbxJ1Fva9blslV6
 vDts8p+AGQ==
X-Received: by 2002:a17:902:d4cb:b0:2dd:278c:5eb with SMTP id
 d9443c01a7336-2ddb1b7ac4amr110121625ad.14.1789857282637; 
 Sat, 19 Sep 2026 15:34:42 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddc1788da5sm13265185ad.24.2026.09.19.15.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 15:34:42 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: zack.rusin@broadcom.com, airlied@redhat.com, tzimmermann@suse.de,
 simona@ffwll.ch
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: fix surface size overflow, execbuf bounds,
 and cursor/msg leaks
Date: Sat, 19 Sep 2026 22:34:41 +0000
Message-ID: <20260919223441.3884374-1-benquike@gmail.com>
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

Fix multiple integer overflows, out-of-bounds accesses, and resource
leaks across drivers/gpu/drm/vmwgfx/ (vmwgfx_surface.c,
vmwgfx_execbuf.c, vmwgfx_msg.c, vmwgfx_fence.c, vmwgfx_cursor_plane.c,
vmwgfx_cotable.c, vmwgfx_bo.c, and vmw_surface_cache.h).

Fixes: fb1d9738ca05 ("drm/vmwgfx: Add DRM driver for VMware Virtual GPU")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/vmwgfx/vmw_surface_cache.h b/drivers/gpu/drm/vmwgfx/vmw_surface_cache.h
index 1ac3cb151b11..bc5f7facf728 100644
--- a/drivers/gpu/drm/vmwgfx/vmw_surface_cache.h
+++ b/drivers/gpu/drm/vmwgfx/vmw_surface_cache.h
@@ -100,7 +100,7 @@ vmw_surface_calculate_pitch(const SVGA3dSurfaceDesc *desc,
 
 	vmw_surface_get_size_in_blocks(desc, size, &blocks);
 
-	pitch = blocks.width * desc->pitchBytesPerBlock;
+	pitch = clamped_umul32(blocks.width, desc->pitchBytesPerBlock);
 
 	return pitch;
 }
@@ -159,11 +159,13 @@ vmw_surface_get_serialized_size(SVGA3dSurfaceFormat format,
 	for (mip = 0; mip < num_mip_levels; mip++) {
 		struct drm_vmw_size size =
 			vmw_surface_get_mip_size(base_level_size, mip);
-		total_size += vmw_surface_get_image_buffer_size(desc,
-								  &size, 0);
+		total_size = min_t(u64,
+			(u64)total_size +
+			vmw_surface_get_image_buffer_size(desc, &size, 0),
+			U32_MAX);
 	}
 
-	return total_size * num_layers;
+	return clamped_umul32(total_size, num_layers);
 }
 
 /**
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 9c7a73c0b0dc..53b3ecfc476b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -535,7 +535,8 @@ static int vmw_user_bo_synccpu_release(struct drm_file *filp,
 
 	if (!ret) {
 		if (!(flags & drm_vmw_synccpu_allow_cs)) {
-			atomic_dec(&vmw_bo->cpu_writers);
+			if (!atomic_add_unless(&vmw_bo->cpu_writers, -1, 0))
+				ret = -EINVAL;
 		}
 		vmw_user_bo_unref(&vmw_bo);
 	}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
index 091f1039a052..4273be7ac1ac 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
@@ -481,6 +481,10 @@ static int vmw_cotable_resize(struct vmw_resource *res, size_t new_size)
 		goto out_wait;
 	}
 
+	ret = dma_resv_reserve_fences(bo->base.resv, 1);
+	if (unlikely(ret))
+		goto out_wait;
+
 	vmw_resource_mob_detach(res);
 	res->guest_memory_bo = buf;
 	res->guest_memory_size = new_size;
@@ -505,10 +509,6 @@ static int vmw_cotable_resize(struct vmw_resource *res, size_t new_size)
 	vmw_user_bo_unref(&old_buf);
 	res->id = vcotbl->type;
 
-	ret = dma_resv_reserve_fences(bo->base.resv, 1);
-	if (unlikely(ret))
-		goto out_wait;
-
 	/* Release the pin acquired in vmw_bo_create */
 	ttm_bo_unpin(bo);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index d1e7df500190..e6776ed6cfd4 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -116,6 +116,12 @@ static void vmw_cursor_update_mob(struct vmw_private *vmw,
 	u32 *image = vmw_bo_map_and_cache(bo);
 	const u32 image_size = vps->base.crtc_w * vps->base.crtc_h * sizeof(*image);
 
+	if (!bo || !vps->cursor.mob)
+		return;
+	if (image_size > bo->tbo.base.size ||
+	    sizeof(*header) + image_size > vps->cursor.mob->tbo.base.size)
+		return;
+
 	header = vmw_bo_map_and_cache(vps->cursor.mob);
 	alpha_header = &header->header.alphaHeader;
 
@@ -359,7 +365,9 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	    box->x != 0    || box->y != 0    || box->z != 0    ||
 	    box->srcx != 0 || box->srcy != 0 || box->srcz != 0 ||
 	    box->d != 1    || box_count != 1 ||
-	    box->w > VMW_CURSOR_SNOOP_WIDTH || box->h > VMW_CURSOR_SNOOP_HEIGHT) {
+	    box->w == 0    || box->h == 0    ||
+	    box->w > VMW_CURSOR_SNOOP_WIDTH || box->h > VMW_CURSOR_SNOOP_HEIGHT ||
+	    cmd->dma.guest.pitch > image_pitch) {
 		/* TODO handle none page aligned offsets */
 		/* TODO handle more dst & src != 0 */
 		/* TODO handle more then one copy */
@@ -375,6 +383,9 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	kmap_offset = cmd->dma.guest.ptr.offset >> PAGE_SHIFT;
 	kmap_num = (VMW_CURSOR_SNOOP_HEIGHT * image_pitch) >> PAGE_SHIFT;
 
+	if (bo->base.size < ((kmap_offset + kmap_num) << PAGE_SHIFT))
+		return;
+
 	ret = ttm_bo_reserve(bo, true, false, NULL);
 	if (unlikely(ret != 0)) {
 		DRM_ERROR("reserve failed\n");
@@ -393,7 +404,7 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	} else {
 		/* Image is unsigned pointer. */
 		for (i = 0; i < box->h; i++)
-			memcpy(srf->snooper.image + i * image_pitch,
+			memcpy((u8 *)srf->snooper.image + i * image_pitch,
 			       virtual + i * cmd->dma.guest.pitch,
 			       box->w * desc->pitchBytesPerBlock);
 	}
@@ -548,7 +559,9 @@ vmw_cursor_buffer_changed(struct vmw_plane_state *new_vps,
 			old_image = vmw_bo_map_and_cache(old_bo);
 			new_image = vmw_bo_map_and_cache(new_bo);
 
-			if (old_image && new_image && old_image != new_image)
+			if (old_image && new_image && old_image != new_image &&
+			    size <= old_bo->tbo.base.size &&
+			    size <= new_bo->tbo.base.size)
 				changed = memcmp(old_image, new_image, size) !=
 					  0;
 
@@ -728,6 +741,14 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 	if (!fb)
 		return 0;
 
+	if (new_state->crtc_w <= 0 || new_state->crtc_h <= 0 ||
+	    new_state->crtc_w > vmw->fb_max_width ||
+	    new_state->crtc_h > vmw->fb_max_height) {
+		drm_warn(&vmw->drm, "Invalid cursor dimensions (%d, %d)\n",
+			 new_state->crtc_w, new_state->crtc_h);
+		return -EINVAL;
+	}
+
 	update_type = vmw_cursor_update_type(vmw, vps);
 	if (update_type == VMW_CURSOR_UPDATE_LEGACY) {
 		if (new_state->crtc_w != VMW_CURSOR_SNOOP_WIDTH ||
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index a9136a6523cb..92c12d6e98d6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1511,6 +1511,10 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,
 
 	cmd = container_of(header, typeof(*cmd), header);
 
+	if (unlikely(header->size < sizeof(cmd->body) + sizeof(*suffix))) {
+		VMW_DEBUG_USER("Invalid DMA command size.\n");
+		return -EINVAL;
+	}
 	if (unlikely(header->size < sizeof(cmd->body) + sizeof(*suffix))) {
 		VMW_DEBUG_USER("Illegal SVGA_3D_CMD_SURFACE_DMA size.\n");
 		return -EINVAL;
@@ -1572,6 +1576,10 @@ static int vmw_cmd_draw(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDrawPrimitives);
 	SVGA3dVertexDecl *decl = (SVGA3dVertexDecl *)(
 		(unsigned long)header + sizeof(*cmd));
+	if (unlikely(header->size < sizeof(cmd->body))) {
+		VMW_DEBUG_USER("Draw command size too small.\n");
+		return -EINVAL;
+	}
 	SVGA3dPrimitiveRange *range;
 	uint32_t i;
 	uint32_t maxnum;
@@ -1931,6 +1939,11 @@ static int vmw_cmd_shader_define(struct vmw_private *dev_priv,
 	if (unlikely(!dev_priv->has_mob))
 		return 0;
 
+	if (unlikely(cmd->header.size < sizeof(cmd->body))) {
+		VMW_DEBUG_USER("Invalid shader define command size.\n");
+		return -EINVAL;
+	}
+
 	size = cmd->header.size - sizeof(cmd->body);
 	ret = vmw_compat_shader_add(dev_priv, vmw_context_res_man(ctx),
 				    cmd->body.shid, cmd + 1, cmd->body.type,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 384c6736cf6b..f8cabbe9868a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -703,6 +703,7 @@ int vmw_fence_event_ioctl(struct drm_device *dev, void *data,
 			if (unlikely(ret != 0)) {
 				DRM_ERROR("Failed to reference a fence "
 					  "object.\n");
+				ttm_base_object_unref(&base);
 				goto out_no_ref_obj;
 			}
 			handle = base->handle;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index fd77ab6568cb..f0f2dbb66cdc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -431,7 +431,7 @@ int vmw_host_get_guestinfo(const char *guest_info_param,
 		/* Remove reply code, which are the first 2 characters of
 		 * the reply
 		 */
-		reply_len = max(reply_len - 2, (size_t) 0);
+		reply_len = reply_len > 2 ? reply_len - 2 : 0;
 		reply_len = min(reply_len, *length);
 
 		if (reply_len > 0)
@@ -572,7 +572,8 @@ int vmw_msg_ioctl(struct drm_device *dev, void *data,
 			goto out_msg;
 		}
 		if (reply && reply_len > 0) {
-			if (copy_to_user((void __user *)((unsigned long)arg->receive),
+			if (reply_len > arg->receive_len ||
+			    copy_to_user((void __user *)((unsigned long)arg->receive),
 					 reply, reply_len)) {
 				DRM_ERROR("Failed to copy message to userspace.\n");
 				kfree(reply);
@@ -1045,7 +1046,7 @@ int vmw_mksstat_add_ioctl(struct drm_device *dev, void *data,
 	hypervisor_ppn_add((PPN64)page_to_pfn(page));
 
 	dev_priv->mksstat_user_pages[slot] = page;
-	atomic_set(&dev_priv->mksstat_user_pids[slot], task_pgrp_vnr(current));
+	atomic_set(&dev_priv->mksstat_user_pids[slot], pid_nr(task_pgrp(current)));
 
 	arg->id = slot;
 
@@ -1104,7 +1105,7 @@ int vmw_mksstat_remove_ioctl(struct drm_device *dev, void *data,
 
 	DRM_DEV_INFO(dev->dev, "pid=%d arg.id=%zu\n", current->pid, slot);
 
-	pgid = task_pgrp_vnr(current);
+	pgid = pid_nr(task_pgrp(current));
 	pid = atomic_cmpxchg(&dev_priv->mksstat_user_pids[slot], pgid, MKSSTAT_PID_RESERVED);
 
 	if (!pid)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd0563741e89..0104e73b69de 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -785,14 +785,26 @@ int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
 
 	for (i = 0; i < DRM_VMW_MAX_SURFACE_FACES; ++i) {
 		for (j = 0; j < metadata->mip_levels[i]; ++j) {
-			uint32_t stride = vmw_surface_calculate_pitch(
-						  desc, cur_size);
+			uint32_t stride;
 
+			if (unlikely(cur_size->width == 0 ||
+				     cur_size->height == 0 ||
+				     cur_size->depth == 0)) {
+				ret = -EINVAL;
+				goto out_no_copy;
+			}
+			stride = vmw_surface_calculate_pitch(desc, cur_size);
 			cur_offset->face = i;
 			cur_offset->mip = j;
 			cur_offset->bo_offset = cur_bo_offset;
-			cur_bo_offset += vmw_surface_get_image_buffer_size
-				(desc, cur_size, stride);
+			if (unlikely(check_add_overflow(cur_bo_offset,
+							vmw_surface_get_image_buffer_size(desc,
+											  cur_size,
+											  stride),
+							&cur_bo_offset))) {
+				ret = -EINVAL;
+				goto out_no_copy;
+			}
 			++cur_offset;
 			++cur_size;
 		}
@@ -967,12 +979,14 @@ static int vmw_buffer_prime_to_surface_base(struct vmw_private *dev_priv,
 	if (ret) {
 		drm_warn(&dev_priv->drm,
 			 "Couldn't add an object ref for the buffer (%d).\n", *handle);
+		ttm_base_object_unref(&base);
 		goto out;
 	}
 
 	*base_p = base;
 out:
 	vmw_user_bo_unref(&bo);
+	drm_gem_handle_delete(file_priv, *handle);
 
 	return ret;
 }
@@ -1440,7 +1454,7 @@ int vmw_gb_surface_reference_ioctl(struct drm_device *dev, void *data,
 	    (union drm_vmw_gb_surface_reference_arg *)data;
 	struct drm_vmw_surface_arg *req = &arg->req;
 	struct drm_vmw_gb_surface_ref_rep *rep = &arg->rep;
-	struct drm_vmw_gb_surface_ref_ext_rep rep_ext;
+	struct drm_vmw_gb_surface_ref_ext_rep rep_ext = {};
 	int ret;
 
 	ret = vmw_gb_surface_reference_internal(dev, req, &rep_ext, file_priv);
@@ -1720,6 +1734,7 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	srf = &user_srf->srf;
 	if (!srf->res.guest_memory_bo) {
 		DRM_ERROR("Shared GB surface is missing a backup buffer.\n");
+		ret = -EINVAL;
 		goto out_bad_resource;
 	}
 	metadata = &srf->metadata;
@@ -1755,9 +1770,13 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 		SVGA3D_FLAGS_UPPER_32(metadata->flags);
 	rep->creq.multisample_pattern = metadata->multisample_pattern;
 	rep->creq.quality_level = metadata->quality_level;
+	rep->creq.buffer_byte_stride = metadata->buffer_byte_stride;
 	rep->creq.must_be_zero = 0;
 
 out_bad_resource:
+	if (unlikely(ret != 0))
+		ttm_ref_object_base_unref(vmw_fpriv(file_priv)->tfile,
+					  base->handle);
 	ttm_base_object_unref(&base);
 
 	return ret;
